<template>
  <div>
    <div>
      <div class="container" v-if="the_user && Article_Category">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <h4 class="header">
              <center>แก้ไข ประเภท ของบทความวิชาการ</center>
            </h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12">
            <form @submit.prevent="submitArticle_Category">
              <center>
                <img v-if="url" :src="url" max-width="250px" height="250px" />
                <img v-else :src="getImgUrl(article.ac_image)" max-width="250px" height="250px" />
              </center>
              <br />
              <center>
                <button
                  type="button"
                  class="form-control btn-success col-lg-6"
                  @click="ChooseFilesFirst"
                >เลือกรูป</button>
              </center>

              <input
                id="chooseImage"
                ref="filesfirst"
                style="display: none;"
                type="file"
                @change="handleFilesFirst"
              />
              <br />
              <input
                type="text"
                v-model="article.ac_title"
                class="form-control"
                placeholder="ชื่อ ประเภท ของบทความ"
                required
              />
              <br />
              <textarea v-model="article.ac_description" class="form-control textarea" placeholder="รายละเอียด" rows="6"></textarea>
              <br />

              <br />
              <div class="row">
                <div class="col-lg-6"></div>
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
      article: {
        ac_title: "",
        ac_description: ""
      },
      url: null,
      fileimage: ""
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Article_Category/" + pic;
    },
    // first image
    ChooseFilesFirst() {
      document.getElementById("chooseImage").click();
    },
    handleFilesFirst(e) {
      // console.log(e.target.files[0])
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.filesfirst.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    submitArticle_Category() {
      var jsonAC = JSON.stringify(this.article);
      var FD = new FormData();
      if (this.url != null) {
        FD.append("userfile", this.fileimage);
      }
      FD.append("article_category", jsonAC);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Article_Category", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Article Category Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    },
    Article_Category() {
      var AC_All = this.$store.getters.getArticle_Category;
      var AC;
      for (var i = 0; i < AC_All.length; i++) {
        if (AC_All[i].ac_id == this.$route.params.Article_CategoryID) {
          AC = AC_All[i];
        }
      }
      this.article = AC;
      return AC;
    }
  }
};
</script>
