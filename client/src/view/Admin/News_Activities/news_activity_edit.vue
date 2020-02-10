<template>
  <div class="container">
    <center>
      <header class="header">แก้ไข ข่าว</header>
    </center>
    <div class="row mt-5" v-if="thisNews && the_user">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12">
        <img v-if="url" :src="url" class=" " width="100%"/>
        <img v-else :src="getImgUrl(thisNews.n_image)" width="100%" class=" " />
        <br />
        <br />
        <button
          type="button"
          class="form-control btn-success col-lg-8 block-center"
          @click="ChooseFilesImage"
        >เปลี่ยนรูปภาพ</button>
        <br />
        <form @submit.prevent="submitNews">
          <input
            id="chooseImage"
            ref="filesimage"
            style="display: none;"
            type="file"
            @change="handleFilesImage"
          />
          หัวเรื่อง
          <input
            type="text"
            v-model="newsE.n_title"
            class="form-control"
            placeholder="หัวเรื่อง"
            required
          />
          <br />
          วิดีโอที่เกี่ยวข้อง
          <input
            type="text"
            v-model="newsE.n_video_link"
            class="form-control"
            placeholder="วิดีโอที่เกี่ยวข้อง #หากไม่มีไม่ต้องใส่"
          />
          <br />
          รายละเอียด
          <textarea
            v-model="newsE.n_detail"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="6"
          ></textarea>
          <br />
          <div v-if="news_data_file != null" v-for="(file,run) in news_data_file">
            <button type="button" class="btn btn-danger" @click="RemoveFile(file.f_id,file.f_title)">delete</button>
            <a :href="loadFile(file.f_name)" download>Dowload File {{run+1}}</a>
            {{file.f_title}}
            <br />
            <br />
          </div>
          <br />
          <h5>Files [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
          <br />
          <div class="row" v-for="(f,index) in files" :key="index">
            <div class="col-lg-10 col-xs-12">
              <input
                type="text"
                class="form-control"
                v-model="file_title[index]"
                placeholder="File Title"
                required
              />
              <b>{{index+1}}. File</b>
              {{files[index].name }}
              <b>Size</b>
              {{files[index].size}} byte
              <br />
              <br />
            </div>
            <div class="col-lg-2 col-xs-12">
              <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
              <br />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6">
              <input
                type="file"
                ref="files"
                style="display: none;"
                id="FileUpload1"
                @change="handleFileUpload"
                multiple
              />
              <button
                type="button"
                class="form-control btn-primary col-lg-12"
                @click="ChooseFiles"
              >เลือกไฟล์</button>
              <br />
            </div>
            <div class="col-lg-6">
              <button type="submit" class="form-control btn-primary col-lg-12">ดำเนินการต่อ</button>
              <br />
            </div>
          </div>
        </form>
      </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      newsE: "",
      file_title: [],
      url: null,
      fileimage: "",
      files: [],
      max_size_file: 0,

      data_load:false,
      text_alert:'',
      news_data:'',
      news_data_file:'',
      check_delete_file:false
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "News/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "News_Files_Upload/" + fi;
    },
    // choose image
    ChooseFilesImage() {
      document.getElementById("chooseImage").click();
    },
    handleFilesImage(e) {
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.filesimage.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    // choose files
    ChooseFiles() {
      document.getElementById("FileUpload1").click();
    },
    handleFileUpload(event) {
      this.files = [];
      this.file_title = [];

      var i = 0;
      let uploadedFiles = this.$refs.files.files;
      for (var i = 0; i < uploadedFiles.length; i++) {
        this.files.push(uploadedFiles[i]);
        this.max_size_file = this.max_size_file + uploadedFiles[i].size;
      }
      if (this.max_size_file > 10000000) {
        this.files = [];
        this.max_size_file = 0;
        // alert
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    RemoveRow: function(index) {
      this.max_size_file = this.max_size_file - this.files[index].size;
      this.files.splice(index, 1);
      this.file_title.splice(index, 1);
    },
    //delete file
    RemoveFile: function(fileID,fileName) {
      var FD_delete = new FormData();
      FD_delete.append("fileID", fileID);
      FD_delete.append("creator", JSON.stringify(this.$store.state.log_on));

      this.$swal({
          title: "Are you sure?",
          text: "You want delete this Filse Name "+fileName,
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
        if (willDelete) {
          this.$store.dispatch("Delete_File", FD_delete);
          setTimeout(() => {
            this.check_delete_file=true
            this.data_load=false
          },100);
          swal({title: "Delete Success.",icon: "success",});
        } else {
          //
        }
      })
      
      
    },
    //submit
    submitNews() {
      var jsonNews = JSON.stringify(this.newsE);
      var jsonFiles_Title = JSON.stringify(this.file_title);
      var FD = new FormData();
      if (this.url != null || this.url != "") {
        FD.append("userfile", this.fileimage);
      }
      if (this.files.length != 0) {
        for (var i = 0; i < this.files.length; i++) {
          FD.append("userfileupload" + i, this.files[i]);
        }
        FD.append("file_title", jsonFiles_Title);
      }
      FD.append("news", jsonNews);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_News", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit News Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisNews() {
      var newsID = this.$route.params.NewsID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'News/get_this_news/'+newsID)
        .then(response => {
            // console.log(response.data),
            this.news_data = response.data[0][0],
            this.news_data_file = response.data[1]
        })
        this.data_load = true
        if(this.news_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var news_show = this.news_data
      if(this.check_delete_file == false){
        this.newsE = this.news_data
      }
      return news_show;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>