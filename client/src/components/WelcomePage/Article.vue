<template>
  <div>
    <div class="article">
      <div class="container">
        <div class="row">
          <header class="col-lg-10 col-xs-12 header">บทความ GAMA Thailand</header>
          <div class="col-lg-2">
            <router-link to="/articles/1">
              <button type="button" class="btn-viewall">ดูทั้งหมด></button>
            </router-link>
          </div>
        </div>
        <div class="row">
          <div
            class="col-lg-4 col-md-6 article-img"
            style="padding:0;"
            v-for="(article,index) in the_article.slice().reverse().slice(0,3)"
            :key="index"
          >
            <div class="article-col">
              <img
                :src="getImgUrlArticle(article.a_image)"
                width="100%"
                height="250px"
                @click="seethisPageArticle(article.a_id)"
              />
              <h5 class="text">{{article.a_title.slice(0,50)+"..."}}</h5>
              <p class="date" style="text-align: left;">{{article.a_create_date.slice(0,-13)}}</p>
              <!-- <p style="text-indent: 2em;">{{article.a_detail.slice(0,60)}}</p> -->
              <!-- <p style="text-align: right;">อ่านเพิ่มเติม</p> -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    getImgUrlArticle(picA) {
      return this.path_files + "Article/" + picA;
    },
    seethisPageArticle(thisarticle) {
      this.$router.push({
        name: "article",
        params: { ArticleID: thisarticle }
      });
    }
  },
  computed: {
    the_article() {
      return this.$store.getters.getArticle;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  created() {
    this.$store.dispatch("initDataArticle");
  }
};
</script>
<style scoped>
.article {
  position: relative;
}
.article img,
.text,
.date {
  cursor: pointer;
}
.article-img:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.header {
  font-style: normal;
  margin-bottom: 34px;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  color: rgba(255, 255, 255, 0.3);
}

.text {
  position: absolute;
  top: 135px;
  padding-left: 9px;
  padding-right: 9px;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
  color: #fff;
}

.date {
  position: absolute;
  top: 215px;
  padding-left: 9px;
  padding-right: 9px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}

.btn-viewall {
  background: #576574;
  border: none;
  border-radius: 14px;
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  padding: 2px 14px;
  line-height: 150%;
  margin-left: 63px;
  text-align: right;
  color: #fff;
}

/* @media only screen and (max-width: 1440px) {
  .article {
    margin-top: 170px;
  }
} */

@media only screen and (max-width: 600px) {
  .article {
    margin-top: 497px;
  }
  .header {
    margin-bottom: 16px;
  }
  .btn-viewall {
    margin-left: 0px;
    margin-bottom: 36px;
  }
  .mb-margin {
    margin-top: 244px;
  }
  .text {
    top: 120px;
    padding-left: 9px;
    padding-right: 9px;
  }
  .date {
    top: 215px;
    padding-left: 9px;
    padding-right: 9px;
  }
}
</style>