<template>
  <div class="container">
    <div class="row" style="padding-top: 70px;">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12" v-if="thisArticle">
        <img :src="getImgUrl(thisArticle.a_image)" width="100%" />
        <div v-if="thisArticle.a_video_link.slice(0,23) == 'https://www.youtube.com'">
          <br>
          <b-embed type="iframe" aspect="16by9" :src="thisArticle.a_video_link" allowfullscreen ></b-embed>
        </div>
        <h5 class="head">{{thisArticle.a_title}}</h5>
        <p class="date" style="text-align:right">{{thisArticle.a_create_date}}</p>
        <!-- <p style="text-align:right"> ประเภท : {{thisArticle.a_category}}</p> -->
        <p class="detail">{{thisArticle.a_detail}}</p>
        <div v-if="article_data_file != null" v-for="(file,index) in article_data_file" :key="index">
          <a :href="loadFile(file.f_name)" class="btn" download>
            <i class="fa fa-download"></i>&nbsp; Download File :
          </a>
          {{file.f_title}}
          <br />
        </div>
      </div>
      <div class="col-lg-8 col-12" v-else><center> <h2> {{text_alert}} </h2> </center> <br><br> </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>

    <div class="article2">
      <a-interesting></a-interesting>
    <!--   <div class="row">
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
              @click="seethisPageArticle(article.a_id)"
            >{{article.a_title.slice(0,50)+"..."}}</h5>
            <p class="article-date" style="text-align: left;">{{article.a_create_date.slice(0,-13)}}</p>
          </div>
        </div>
      </div>-->
    </div> 
  </div>
</template>
<script>
import axios from "axios";
import articleinteresting from "./../../components/Other_interesting/article_interesting";
export default {
  data(){
    return {
      data_load:false,
      text_alert:'',
      article_data:'',
      article_data_file:''
    }
  },
  components: {
    AInteresting: articleinteresting,
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Article/" + pic;
    },
    loadFile(fi) {
      return this.path_files + "Article_Files_Upload/" + fi;
    },
    seethisPageArticle(thisarticle) {
      this.$router.push({ name: "article",params: { ArticleID: thisarticle } });
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    },
    searching(){
      this.do_search
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisArticle() {
      var articleID = this.$route.params.ArticleID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Article/get_this_article/'+articleID)
        .then(response => {
            // console.log(response.data),
            this.article_data = response.data[0][0],
            this.article_data_file = response.data[1]
        })
        this.data_load = true
        if(this.article_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var article_show = this.article_data
      return article_show;
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