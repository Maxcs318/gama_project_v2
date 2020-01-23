<template>
  <div class="container">
    <div class="row" style="padding-top: 70px;">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12" v-if="thisAcademic_Article != null">
        <img :src="getImgUrl(thisAcademic_Article.aa_image)" width="100%" />
        <h5 class="head">{{thisAcademic_Article.aa_title}}</h5>
        <p class="date">{{thisAcademic_Article.aa_create_date.slice(0,-13)}}</p>
        <p > ประเภท : {{thisAcademic_Article.aa_category}}</p>
        <p class="detail">{{thisAcademic_Article.aa_detail}}</p>
        <div v-if="thisFiles != null" v-for="(file,index) in thisFiles" :key="index">
          <a :href="loadFile(file.f_name)" class="btn" download>
            <i class="fa fa-download"></i>&nbsp; Download File :
          </a>
          {{file.f_title}}
          <br />
        </div>
      </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>

    <div class="article2">
      <div class="row">
        <div class="col-lg-6 col-12" v-for="article in Academic_Article_all.slice().reverse().slice(0,2)">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(article.aa_image)"
              width="100%"
              height="360px"
              @click="seethisPageArticle(article.aa_id)"
            />
            <h5 class="article-title" @click="seethisPageNews(article.aa_id)">{{article.aa_title}}</h5>
            <p class="article-date" style="text-align: left;">{{article.aa_create_date}}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Academic_Article/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "Academic_Article_Files_Upload/" + fi;
    },
    seethisPageArticle(thisAcademic_Article) {
      this.$router.push({name: "academic_article",params: { AcademicArticleID: thisAcademic_Article }});
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Academic_Article_all() {
      return this.$store.getters.getAcademic_Article_Set_Category;
    },
    thisAcademic_Article() {
      var articleAll = this.$store.getters.getAcademic_Article_Set_Category;
      var article = null;
      for (var i = 0; i < articleAll.length; i++) {
        if (articleAll[i].aa_id == this.$route.params.AcademicArticleID) {
          article = articleAll[i];
        }
      }
      return article;
    },
    thisFiles() {
      var filesAll = this.$store.getters.getFiles;
      var files_article = [];
      for (var i = 0; i < filesAll.length; i++) {
        if (filesAll[i].f_key == this.thisAcademic_Article.aa_file_key) {
          files_article.push(filesAll[i]);
        }
      }
      if (files_article.length != 0) {
        return files_article;
      } else {
        return false;
      }
    }
  }
};
</script>
<style scoped>
.head {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  letter-spacing: 0.75px;
  padding-top: 24px;
}
.date {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
  padding-top: 36px;
}
.detail {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #e0e0e0;
  padding-top: 21px;
  padding-bottom: 30px;
}

a {
  font-size: 1.2em;
  color: yellow;
  transition: 0.25s;
}

a:hover {
  font-size: 1.4em;
  color: #48dbfb;
}

.article2 {
  margin-top: 102px;
  margin-bottom: 65px;
  cursor: pointer;
}
.article-title {
  position: absolute;
  z-index: 1;
  top: 70%;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
}
.article-date {
  position: absolute;
  z-index: 1;
  top: 90%;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}

@media only screen and (max-width: 600px) {
  .article2 img {
    height: auto;
    margin-top: 0;
    margin-bottom: 32px;
  }
  .article-title {
    top: 55%;
  }
  .article-date {
    top: 77%;
  }
}
</style>