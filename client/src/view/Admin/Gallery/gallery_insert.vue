<template>
  <div>
    <div>
      <div class="container" v-if="the_user">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <h4 class="header">
              <center>เพิ่มกิจกรรม</center>
            </h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12">
            <form @submit.prevent="submitGallery">
              <center>
                <img class="admin-img" v-if="url" :src="url" />
              </center>
              <br />
              <button
                type="button"
                class="form-control btn-success block-center col-lg-6"
                @click="ChooseFilesFirst"
              >เลือกรูป</button>
              <input
                id="chooseImage"
                ref="filesfirst"
                style="display: none;"
                type="file"
                @change="handleFilesFirst"
              />
              <br />
              <input type="text" v-model="gallery.g_name" class="form-control" placeholder="ชื่อกิจกรรม" required />
              <br />
              <textarea v-model="gallery.g_description" class="form-control textarea" placeholder="รายละเอียด" rows="6"></textarea>
              <br />
              <h5>Another Image [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
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
                  <img class="admin-img" :src="another_image_pre[index]" />
                  <h5></h5>
                  <b>{{index+1}}.</b>
                  {{files[index].name }}
                  <!-- <b> Size </b>{{files[index].size}} byte -->
                  <button
                    type="button"
                    class="form-control btn-danger"
                    @click="RemoveRow(index)"
                  >ลบ</button>
                  <br />
                </div>
              </div>
              <br />
              <div class="row">
                <div class="col-lg-6">
                  <button
                    type="button"
                    class="form-control btn-primary col-lg-12"
                    @click="ChooseFiles"
                  >เพิ่มรูปอื่น</button>
                  <br />
                </div>
                <div class="col-lg-6">
                  <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
                  <br />
                </div>
              </div>
            </form>
          </div>
          <div class="col-lg-3 col-xs-12"></div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      gallery: {
        g_name: "",
        g_description: ""
      },
      url: null,
      another_image_pre: [],
      fileimage: "",
      files: [],
      max_size_file: 0
    };
  },
  methods: {
    // first image
    ChooseFilesFirst() {
      document.getElementById("chooseImage").click();
    },
    handleFilesFirst(e) {
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.filesfirst.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your image is larger than 10 MB. Sorry Choose Again !!!");
      }
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
        this.$swal(
          "Your image all is larger than 10 MB. Sorry Choose Again !!!"
        );
      }
    },
    RemoveRow: function(index) {
      this.max_size_file = this.max_size_file - this.files[index].size;
      this.files.splice(index, 1);
      this.another_image_pre.splice(index, 1);
    },
    submitGallery() {
      if (this.fileimage.size < 10000000 && this.fileimage != "") {
        var jsonGallery = JSON.stringify(this.gallery);
        var FD = new FormData();
        FD.append("userfile", this.fileimage);
        if (this.files.length != 0) {
          for (var i = 0; i < this.files.length; i++) {
            FD.append("userfileupload" + i, this.files[i]);
          }
        }
        FD.append("gallery", jsonGallery);
        FD.append("creator", JSON.stringify(this.$store.state.log_on));
        this.$store.dispatch("Add_Gallery", FD);
        setTimeout(() => {
          this.$router.go(-1);
        }, 2000);
        this.$swal("Save Gallery Success .", "", "success");
      } else {
        this.$swal("Please Choose Image .", "", "error");
      }
    }
  },
  computed: {
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
