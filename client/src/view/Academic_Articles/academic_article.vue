<template>
  <div class="container">
    <div class="row" style="padding-top: 70px;">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12" v-if="thisAcademic_Article">
        <img :src="getImgUrl(thisAcademic_Article.aa_image)" width="100%" />
        <h5 class="head">{{thisAcademic_Article.aa_title}}</h5>
        <p class="date" style="text-align:right">{{thisAcademic_Article.aa_create_date}}</p>
        <!-- <p style="text-align:right"> ประเภท : {{thisAcademic_Article.aa_category}}</p> -->
        <p class="detail">{{thisAcademic_Article.aa_detail}}</p>
        <div v-if="academic_article_data_file != null" v-for="(file,index) in academic_article_data_file" :key="index">
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
       <a-a-interesting></a-a-interesting>
      <!--<div class="row">
        <div class="col-lg-6 col-12" v-for="article in Academic_Article_all.slice().reverse().slice(0,2)">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(article.aa_image)"
              width="100%"
              height="360px"
              @click="seethisPageArticle(article.aa_id)"
            />
            <h5 class="article-title" @click="seethisPageArticle(article.aa_id)">{{article.aa_title}}</h5>
            <p class="article-date" style="text-align: left;">{{article.aa_create_date}}</p>
          </div>
        </div>
      </div>-->
    </div> 
  </div>
</template>
<script>
import axios from "axios";
import academicarticleinteresting from "./../../components/Other_interesting/academic_article_interesting";

export default {
  data(){
    return {
      data_load:false,
      text_alert:'',
      academic_article_data:'',
      academic_article_data_file:''
    }
  },
  components: {
    AAInteresting: academicarticleinteresting,
  },
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
    thisAcademic_Article() {
      var academic_articleID = this.$route.params.AcademicArticleID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Academic_article/get_this_academic_article/'+academic_articleID)
        .then(response => {
            // console.log(response.data),
            this.academic_article_data = response.data[0][0],
            this.academic_article_data_file = response.data[1]
        })
        this.data_load = true
        if(this.academic_article_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var academic_article_show = this.academic_article_data
      return academic_article_show;
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