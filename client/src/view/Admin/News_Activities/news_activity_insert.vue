<template>
  <div>
    <div>
      <div class="container" v-if="the_user">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <center>
              <header class="header">เพิ่ม ข่าวสารและกิจกรรม</header>
            </center>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12">
            <form @submit.prevent="submitNews">
              <center>
                <img v-if="url" :src="url" max-width="250px" height="250px" />
              </center>
              <br />
              <center>
                <button
                  type="button"
                  class="form-control btn-success col-lg-6"
                  @click="ChooseFilesImage"
                >เลือกรูปภาพ</button>
                <input
                  id="chooseImage"
                  ref="filesimage"
                  style="display: none;"
                  type="file"
                  @change="handleFilesImage"
                />
              </center>

              <br />
              <input
                type="text"
                v-model="news.n_title"
                class="form-control"
                placeholder="หัวเรื่อง"
                required
              />
              <br />
              <textarea
                v-model="news.n_detail"
                class="form-control textarea"
                rows="6"
                placeholder="รายละเอียด"
              ></textarea>
              <br />
              <h5>Files [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
              <input
                type="file"
                ref="files"
                style="display: none;"
                id="FileUpload1"
                @change="handleFileUpload"
                multiple
              />
              <br />
              <div class="row" v-for="(f,index) in files" :key="index">
                <div class="col-lg-10">
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
                <div class="col-lg-2">
                  <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
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
                  >เลือกไฟล์</button>
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
      news: {
        n_title: "",
        n_detail: "",
        n_image: "",
        n_create_date: ""
      },
      url: null,
      fileimage: "",
      files: [],
      max_size_file: 0,
      file_title: []
    };
  },
  methods: {
    //image
    ChooseFilesImage() {
      document.getElementById("chooseImage").click();
    },
    handleFilesImage(e) {
      if (e.target.files[0] != "" || e.target.files[0] != null) {
        var fileimage = e.target.files[0];
        this.url = URL.createObjectURL(fileimage);
        let uploadedFiles = this.$refs.filesimage.files[0];
        this.fileimage = uploadedFiles;
        if (this.fileimage.size > 10000000) {
          this.fileimage = [];
          this.url = null;
          this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
        }
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
    //submit
    submitNews() {
      if (this.fileimage.size < 10000000 && this.fileimage != "") {
        var jsonNews = JSON.stringify(this.news);
        var jsonFiles_Title = JSON.stringify(this.file_title);
        var FD = new FormData();
        FD.append("userfile", this.fileimage);
        if (this.files.length != 0) {
          for (var i = 0; i < this.files.length; i++) {
            FD.append("userfileupload" + i, this.files[i]);
          }
          FD.append("file_title", jsonFiles_Title);
        }
        FD.append("news", jsonNews);
        FD.append("creator", JSON.stringify(this.$store.state.log_on));
        this.$store.dispatch("Add_News", FD);
        setTimeout(() => {
          this.$router.go(-1);
        }, 2000);
        this.$swal("Save News Success .", "", "success");
      } else {
        this.$swal("Please Choose Image .", "", "error");
      }
    }
  },
  computed: {
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