<template>
  <div class="container">
    <center>
      <h4 class="header">แก้ไข บทความวิชาการ</h4>
    </center>
    <div class="row mt-5" v-if="thisAcademic_Article && the_user">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12">
        <img class=" " v-if="url" :src="url"  width="100%"/>
        <img class=" " v-else :src="getImgUrl(thisAcademic_Article.aa_image)" width="100%"/>
        <br />
        <br />
        <button
          type="button"
          class="form-control btn-success btn col-lg-6 block-center"
          @click="ChooseFilesImage"
        >เลือกรูป</button>
        <br />
        <form @submit.prevent="submitArticle">
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
            v-model="academic_articleE.aa_title"
            class="form-control"
            placeholder="หัวเรื่อง"
            required
          />
          <br />ประเภทของบทความ
          <select
            v-model="academic_articleE.aa_category"
            class="form-control select"
            required
          >
            <option
              class="option"
              v-for="aac in academic_article_category"
              :value="aac.aac_id"
            >{{ aac.aac_title }}</option>
          </select>
          <br />รายละเอียด
          <textarea
            v-model="academic_articleE.aa_detail"
            class="form-control textarea"
            rows="6"
          ></textarea>
          <br />
          <div v-if="academic_article_data_file != null" v-for="(file,run) in academic_article_data_file">
            <a :href="loadFile(file.f_name)" download>Dowload File</a>
            {{file.f_title}}
            <button
              type="button"
              class="btn btn-danger col-lg-1"
              @click="RemoveFile(file.f_id,file.f_title)"
            >ลบ</button>
            <br />
            <br />
          </div>
          <br />
          <h5>Files [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
          <br />
          <div class="row" v-for="(files_Add,index) in files" :key="index">
            <div class="col-lg-10 clo-xs-12">
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
      academic_articleE: "",
      file_title: [],
      url: null,
      fileimage: "",
      files: [],
      max_size_file: 0,

      academic_article_category_all:'',
      data_load_category:false,
      
      academic_article_data:'',
      academic_article_data_file:'',
      data_load:false,
      check_delete_file:false

    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Academic_Article/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "Academic_Article_Files_Upload/" + fi;
    },
    // image
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
    // files
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
    // delete file
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
    // submit
    submitArticle() {
      var jsonArticle = JSON.stringify(this.academic_articleE);
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
      FD.append("academic_article", jsonArticle);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Academic_Article", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Article Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisAcademic_Article() {
      var academic_articleID = this.$route.params.AcademicArticleID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Academic_article/get_this_academic_article/'+academic_articleID)
        .then(response => {
            // console.log(response.data)
            this.academic_article_data = response.data[0][0],
            this.academic_article_data_file = response.data[1]
        })
        this.data_load = true
      }
      var academic_article_show = this.academic_article_data
      if(this.check_delete_file == false){
        this.academic_articleE = this.academic_article_data
      }
      return academic_article_show;
    },
    academic_article_category() {
      if(this.data_load_category==false){
        axios.get(this.$store.getters.getBase_Url+"Academic_article/get_all_academic_article_category")
        .then(response => {
            // console.log(response)
            this.academic_article_category_all = response.data
        })
        this.data_load_category=true
      }
        var category_all = this.academic_article_category_all
      return category_all
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>

<style scoped>
.select,
.option {
  background-color: #1a2a3e;
  color: #e0e0e0;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}
.select:focus {
  background-color: #1a2a3e;
  color: #e0e0e0;
}
</style>