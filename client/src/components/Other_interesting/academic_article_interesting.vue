<template>
    <div class="container" >
      <!-- <h4><center> ข่าวอื่นๆ ที่น่าสนใจ </center></h4> -->
      <div class="row">
        <div class="col-lg-6 col-12" v-for="article in Academic_Article_all">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(article.aa_image)"
              width="100%"
              @click="seethisPageArticle(article.aa_id)"
            />
            <h5 class="article-title" @click="seethisPageArticle(article.aa_id)">{{article.aa_title}}</h5>
            <p class="article-date" @click="seethisPageArticle(article.aa_id)" style="text-align: left;">{{article.aa_create_date}}</p>
          </div> 
          <br>
        </div>
      </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
  data(){
    return{
      data_pcs:2,
      data_academic_article:'',
      data_load:false
    }
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Academic_Article/" + pic;
    },
    seethisPageArticle(thisAcademic_Article) {
      this.$router.push({name: "academic_article",params: { AcademicArticleID: thisAcademic_Article }});
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    },
  },
  computed: {
    Academic_Article_all() {
      if(this.data_load == false){
        axios.get(this.$store.getters.getBase_Url+'Academic_article/get_random_academic_article/'+this.data_pcs)
        .then(response => {
          this.data_academic_article = response.data
        })
          this.data_load = true
      }
      
        var book = this.data_academic_article
      return book;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
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
.article-date {
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