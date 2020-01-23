<template>
  <div class="container">
    <div class="row" style="padding-top: 70px;">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12" v-if="thisArticle != null">
        <img :src="getImgUrl(thisArticle.a_image)" width="100%" />
        <h5 class="head">{{thisArticle.a_title}}</h5>
        <p class="date">{{thisArticle.a_create_date.slice(0,-13)}}</p>
        <p class="detail">{{thisArticle.a_detail}}</p>
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
        <div class="col-lg-6 col-12" v-for="article in Article_all.slice().reverse().slice(1,3)">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(article.a_image)"
              width="100%"
              height="360px"
              @click="seethisPageArticle(article.a_id)"
            />
            <h5
              class="article-title"
              @click="seethisPageNews(article.a_id)"
            >{{article.a_title.slice(0,50)+"..."}}</h5>
            <p class="article-date" style="text-align: left;">{{article.a_create_date.slice(0,-13)}}</p>
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
      return this.path_files + "Article/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "Article_Files_Upload/" + fi;
    },
    seethisPageArticle(thisarticle) {
      this.$router.push({
        name: "article",
        params: { ArticleID: thisarticle }
      });
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Article_all() {
      return this.$store.getters.getArticle;
    },
    thisArticle() {
      var articleAll = this.$store.getters.getArticle_Set_Category;
      var article = null;
      for (var i = 0; i < articleAll.length; i++) {
        if (articleAll[i].a_id == this.$route.params.ArticleID) {
          article = articleAll[i];
        }
      }
      return article;
    },
    thisFiles() {
      var filesAll = this.$store.getters.getFiles;
      var files_article = [];
      for (var i = 0; i < filesAll.length; i++) {
        if (filesAll[i].f_key == this.thisArticle.a_file_key) {
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
  z-index: 0;
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
  z-index: 0;
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
    top: 45%;
  }
  .article-date {
    top: 77%;
  }
}

@media only screen and (max-width: 370px) {
  .article-title {
    top: 35%;
  }
  .article-date {
    top: 72%;
  }
}
</style>