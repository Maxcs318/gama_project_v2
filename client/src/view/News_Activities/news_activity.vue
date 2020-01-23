<template>
  <div class="container">
    <div class="row" style="padding-top: 70px;">
      <div class="col-lg-1 col-12"></div>
      <div class="col-lg-10 col-12" v-if="thisNews">
        <img :src="getImgUrl(thisNews.n_image)" width="100%" />
        <!-- <a :href="getImgUrl(thisNews.n_image)" download>File Dowload</a> -->
        <h5 class="activity-title mt-4">{{thisNews.n_title}}</h5>
        <p class="activity-date" style="text-align:left">{{thisNews.n_create_date.slice(0,-13)}}</p>
        <br />
        <p class="activity-detail" style="text-align:left">{{thisNews.n_detail}}</p>
        <div v-if="thisFiles != null" v-for="(file,index) in thisFiles" :key="index">
          <a :href="loadFile(file.f_name)" class="btn" download><i class="fa fa-download"></i>&nbsp; Download File :</a>
          {{file.f_title}}
          <br />
        </div>
      </div>
      <div class="col-lg-10 col-12" v-else>This Page No Data.</div>
      <div class="col-lg-1 col-12"></div>
    </div>

    <div class="activity2">
      <div class="row">
        <div class="col-lg-6 col-12" v-for="news in News_all.slice().reverse().slice(1,3)">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(news.n_image)"
              width="100%"
              height="360px"
              @click="seethisPageNews(news.n_id)"
            />
            <h5 class="activities-2-title" @click="seethisPageNews(news.n_id)">{{news.n_title.slice(0,50)+"..."}}</h5>
            <p
              class="activities-2-date"
              style="text-align: left;"
            >{{news.n_create_date.slice(0,-13)}}</p>
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
      return this.path_files + "News/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "News_Files_Upload/" + fi;
    },
    seethisPageNews(thisnews) {
      this.$router.push({
        name: "newsandactivity",
        params: { NewsID: thisnews }
      });
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    News_all() {
      return this.$store.getters.getNews;
    },
    thisNews() {
      var newsAll = this.$store.getters.getNews;
      var news;
      for (var i = 0; i < newsAll.length; i++) {
        if (newsAll[i].n_id == this.$route.params.NewsID) {
          news = newsAll[i];
        }
      }
      return news;
    },
    thisFiles() {
      var filesAll = this.$store.getters.getFiles;
      var files_news = [];
      for (var i = 0; i < filesAll.length; i++) {
        if (filesAll[i].f_key == this.thisNews.n_file_key) {
          files_news.push(filesAll[i]);
        }
      }
      if (files_news.length != 0) {
        return files_news;
      } else {
        return false;
      }
    }
  }
};
</script>
<style scoped>
.activity-title {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  letter-spacing: 0.75px;
}
.activity2 {
  margin-top: 102px;
  margin-bottom: 65px;
}

.activity2 img {
  cursor: pointer;
}

a {
  font-size: 1.2em;
  color: yellow;
  transition: 0.25s
}

a:hover{
  font-size: 1.4em;
  color: #48dbfb;
}

.activity-date {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  padding-top: 16px;
  line-height: 150%;
  color: #d8d8d8;
}

.activity-detail {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  padding-top: 24px;
  line-height: 150%;
  color: #e0e0e0;
}

.activities-2-title {
  position: absolute;
  top: 265px;
  left: 20px;
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

.activities-2-date {
  position: absolute;
  top: 330px;
  left: 20px;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}

@media only screen and (max-width: 600px) {
  .activities-img-mb {
    width: 100%;
    height: 271px;
  }

  .activities-2-title {
    top: 145px;
    padding-left: 21px;
    padding-right: 21px;
  }

  .activities-2-date {
    top: 235px;
    padding-left: 21px;
    padding-right: 21px;
  }
}
</style>