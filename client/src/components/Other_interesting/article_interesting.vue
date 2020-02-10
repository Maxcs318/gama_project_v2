<template>
    <div class="container" >
      <!-- <h4><center> ข่าวอื่นๆ ที่น่าสนใจ </center></h4> -->
      <div class="row">
        <div class="col-lg-6 col-12" v-for="article in Article_all">
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
            <p class="article-date" style="text-align: left;" @click="seethisPageArticle(article.a_id)">{{article.a_create_date.slice(0,-13)}}</p>
          </div>
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
      data_article:'',
      data_load:false
    }
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Article/" + pic;
    },
    seethisPageArticle(thisarticle) {
      this.$router.push({ name: "article",params: { ArticleID: thisarticle } });
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    },
  },
  computed: {
    Article_all() {
      if(this.data_load == false){
        axios.get(this.$store.getters.getBase_Url+'Article/get_random_article/'+this.data_pcs)
        .then(response => {
          this.data_article = response.data
        })
          this.data_load = true
      }
      
        var book = this.data_article
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