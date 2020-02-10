<template>
    <div class="container" style="margin-top: 25px">
      <!-- <h4><center> ข่าวอื่นๆ ที่น่าสนใจ </center></h4> -->
      <div class="row">
        <div class="col-lg-6 col-12" v-for="news in News_all">
          <div>
            <img
              class="activities-img-mb"
              :src="getImgUrl(news.n_image)"
              width="100%"
              @click="seethisPageNews(news.n_id)"
            />
            <h5 class="activities-2-title" @click="seethisPageNews(news.n_id)">{{news.n_title.slice(0,50)+"..."}}</h5>
            <p @click="seethisPageNews(news.n_id)"
              class="activities-2-date"
              style="text-align: left;"
            >{{news.n_create_date.slice(0,-13)}}</p>
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
      data_news:'',
      data_load:false
    }
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "News/" + pic;
    },
    seethisPageNews(thisnews) {
      this.$router.push({
        name: "newsandactivity",
        params: { NewsID: thisnews }
      });
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    },
  },
  computed: {
    News_all() {
      if(this.data_load == false){
        axios.get(this.$store.getters.getBase_Url+'News/get_random_news/'+this.data_pcs)
        .then(response => {
          this.data_news = response.data
        })
          this.data_load = true
      }
      
        var book = this.data_news
      return book;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
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