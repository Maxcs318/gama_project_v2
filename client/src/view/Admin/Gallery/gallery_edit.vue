<template>
  <div class="container" v-if="the_user">
    <center>
      <h4 class="header">แก้ไขกิจกรรม</h4>
    </center>
    <div class="row" v-if="thisGallery">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <img class=" " v-if="url" :src="url" width="100%"/>
        <img class=" " v-else :src="getImgUrl(thisGallery.g_image)" width="100%"/>
        <br />
        <br />
        <p><center> รูปภาพ สำหรับ preview </center></p>
        <button
          type="button"
          class="form-control btn-success col-lg-12"
          @click="ChooseFilesImage"
        >เปลี่ยนรูป</button>
        <br />
        <form @submit.prevent="submitGallery">
          <input
            id="chooseImage"
            ref="filesimage"
            style="display: none;"
            type="file"
            @change="handleFilesImage"
          />
          ชื่อภาพกิจกรรม
          <input
            type="text"
            v-model="galleryE.g_name"
            class="form-control"
            placeholder="ชื่อ ภาพกิจกรรม"
            required
          />
          <br />รายละเอียด
          <textarea
            v-model="galleryE.g_description"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="5"
          ></textarea>
          <br />

          <div class="row" v-if="gallery_data_file">
            <h5 class="col-lg-12">รูปกิจกรรมอื่นๆ</h5>
            <div class="col-lg-6 block-center" v-for="(gi,run) in gallery_data_file" :key="run">
              <img class=" " :src="getImgUrl(gi.gi_image)" width="100%"/>
              <button
                type="button"
                class="form-control btn-danger"
                @click="DeleteGallery_Image(gi.gi_id)"
              >ลบ</button>
              <br />
              <br />
            </div>
          </div>
          <br />
          <!--  -->
          <h5>New Another Image [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
          <input
            type="file"
            ref="files"
            style="display: none;"
            id="anotherImage"
            @change="handleFileUpload"
            multiple
          />
          <br />
          <div class="row">
            <div class="col-6 block-center" v-for="(f,index) in files" :key="index">
              <img class=" " :src="another_image_pre[index]" width="100%"/>
              <h5></h5>
              <b>{{index+1}}.</b>
              {{files[index].name }}
              <!-- <b> Size </b>{{files[index].size}} byte -->
              <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
              <br />
            </div>
          </div>
          <!--  -->
          <div class="row">
            <div class="col-lg-6">
              <button
                type="button"
                class="form-control btn-success col-lg-12"
                @click="ChooseFiles"
              >เพิ่มรูปอื่น</button>
              <br />
            </div>
            <div class="col-lg-6">
              <button type="submit" class="form-control btn-primary col-lg-12">ดำเนินการต่อ</button>
              <br />
            </div>
          </div>
        </form>
      </div>
      <div class="col-lg-3 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      galleryE: "",
      url: null,
      another_image_pre: [],
      fileimage: "",
      files: [],
      max_size_file: 0,
      data_load:false,
      text_alert:'',
      gallery_data:'',
      gallery_data_file:'',
      check_delete_file:false
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Gallery/" + pic;
    },
    // preview image
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
    DeleteGallery_Image(gallery_imageID) {
      // console.log(gallery_imageID)
      var FD_delete = new FormData();
      FD_delete.append("gallery_imageID", gallery_imageID);
      FD_delete.append("creator", JSON.stringify(this.$store.state.log_on));
      
      this.$swal({
          title: "Are you sure?",
          text: "You want delete this Image ?",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
        if (willDelete) {
          this.$store.dispatch("Delete_Gallery_Image", FD_delete);
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
    // another image
    ChooseFiles() {
      document.getElementById("anotherImage").click();
    },
    handleFileUpload(event) {
      this.files = [];
      this.another_image_pre = [];

      var i = 0;
      let uploadedFiles = this.$refs.files.files;
      for (var i = 0; i < uploadedFiles.length; i++) {
        this.files.push(uploadedFiles[i]);
        this.another_image_pre.push(URL.createObjectURL(uploadedFiles[i]));
        this.max_size_file = this.max_size_file + uploadedFiles[i].size;
      }
      if (this.max_size_file > 10000000) {
        this.files = [];
        this.another_image_pre = [];
        this.max_size_file = 0;
        // alert
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    RemoveRow: function(index) {
      this.max_size_file = this.max_size_file - this.files[index].size;
      this.files.splice(index, 1);
      this.another_image_pre.splice(index, 1);
    },
    // submit
    submitGallery() {
      var jsonGallery = JSON.stringify(this.galleryE);
      var FD = new FormData();
      if (this.url != null || this.url != "") {
        FD.append("userfile", this.fileimage);
      }
      if (this.files.length != 0) {
        for (var i = 0; i < this.files.length; i++) {
          FD.append("userfileupload" + i, this.files[i]);
        }
      }
      FD.append("gallery", jsonGallery);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Gallery", FD);
      setTimeout(() => {
        // this.$router.push('/AdminListGallery')
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Gallery Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisGallery() {
      var galleryID = this.$route.params.GalleryID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Gallery/get_this_gallery/'+galleryID)
        .then(response => {
            // console.log(response.data)
            this.gallery_data = response.data[0][0],
            this.gallery_data_file = response.data[1]
        })
        this.data_load = true
        // if(this.gallery_data.length == 0){
        //   setTimeout(() => {
        //     this.text_alert = 'This Page No Data.'
        //   },1000);
        // }
      }
      if(this.check_delete_file == false){
        this.galleryE = this.gallery_data
      }
      var gallery_show = this.gallery_data
      return gallery_show;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    }
  }
};
</script>
