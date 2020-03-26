<template>
  <div>
    <div class="news" v-if="the_news">
      <div class="container">
        <!-- pc page -->
        <div class="news-pc">
          <div class="col-lg-12 col-12" v-for="(news,index) in the_news.slice(0,1)">
            <router-link style="text-decoration: none; color:white;"  :to="'/newsandactivity/'+news.n_id">
              <div class="row" >
                <div class="col-lg-2 col-12">
                  <hr />
                </div>
                <div class="col-lg-4">
                  <h5 class="head">{{news.n_title}}</h5>
                  <p class="detail" style="text-align: left;">{{news.n_detail.slice(0,158)}}</p>
                  <p class="news-date1" style="text-align: left;">{{news.n_create_date.slice(0,-13)}}</p>
                </div>
                <div class="col-lg-6">
                  <div class="news1"></div>
                  <div class="news2"></div>
                  <img
                    class="img-news"
                    :src="getImgUrl(news.n_image)"
                    style="width:100%"
                  />
                </div>
              </div>
            </router-link>
          </div>
        </div>
        <!-- mb page -->
        <div class="news-mb">
          <div class="col-lg-12 col-12" v-for="(news,index2) in the_news.slice(0,1)">
            <router-link style="text-decoration: none; color:white;"  :to="'/newsandactivity/'+news.n_id">
            <div class="row">
              <div class="col-xs-12">
                <div class="news1"></div>
                <div class="news2"></div>
                <img
                  class="img-news"
                  :src="getImgUrl(news.n_image)"
                  width="100%"
                />
              </div>
              <div class="col-12">
                <h5 class="head">{{news.n_title}}</h5>
                <hr style="width:100%" />
                <p class="detail" style="text-align: left;">{{news.n_detail.slice(0,158)}}</p>
                <p class="news-date1" style="text-align: left;">{{news.n_create_date.slice(0,-13)}}</p>
              </div>
            </div>
            </router-link>
          </div>
        </div>

        <!-- row page -->
        <div class="row">
          <div
            class="col-lg-6 col-md-6 col-12"
            v-for="(news,index3) in the_news.slice(1,3)" 
          >
            <router-link style="text-decoration: none; color:white;"  :to="'/newsandactivity/'+news.n_id">
              <div class="news-2">
                <img :src="getImgUrl(news.n_image)" width="100%" height="360px" />
                <h5
                  class="news-text"
                >{{news.n_title.slice(0,50)+"..."}}</h5>
                <p class="news-date" style="text-align: left;">{{news.n_create_date.slice(0,-13)}}</p>
              </div>
            </router-link>
          </div>
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
      data_news:'',
      data_size:'',
      data_load:false,
      data_in_page: 3,
    }
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "News/" + pic;
    },
    // seethisPageNews(thisnews) {
    //   this.$router.push({
    //     name: "newsandactivity",
    //     params: { NewsID: thisnews }
    //   });
    // }
  },
  computed: {
    the_news() {
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'News/get_news/'+this.data_in_page+'/1')
        .then(response => {
            // console.log(response.data),
            this.data_size = response.data[0],
            this.data_news = response.data[1]
        })
        this.data_load = true
      }
      var news_show = this.data_news
      return news_show
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  }
};
</script>
<style scoped>
.news {
  position: relative;
}

.news-pc {
  display: block;
}

.news-mb {
  display: none;
}

.news hr {
  background-color: #fff;
}

.head {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  padding-left: 19px;
  padding-right: 19px;
  letter-spacing: 0.75px;
}

.detail {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  margin-top: 12px;
  padding-left: 19px;
  padding-right: 19px;
  line-height: 150%;
}

.news-date1 {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  padding-left: 19px;
  padding-right: 19px;
  line-height: 150%;
  margin-top: 32px;
  color: #d8d8d8;
}

.img-news {
  width: 100%;
  height: 360px;
  cursor: pointer;
  position: relative;
  z-index: 0;
}

.img-news:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.news1 {
  position: absolute;
  z-index: 0;
  opacity: 0.2;
  border: 2px solid #ffffff;
  box-sizing: border-box;
  left: 0%;
  top: 86px;
  width: 80%;
  height: 80%;
}

.news2 {
  position: absolute;
  z-index: 0;
  opacity: 0.2;
  border: 2px solid #ffffff;
  box-sizing: border-box;
  left: -3%;
  top: 105px;
  width: 80%;
  height: 80%;
}

.news-2 {
  margin-top: 59px;
  cursor: pointer;
}

.news-2 img {
  width: 100%;
}
.news-2:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.news-text {
  position: absolute;
  top: 318px;
  left: 20px;
  padding-left: 9px;
  padding-right: 9px;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
}

.news-date {
  position: absolute;
  top: 386px;
  left: 20px;
  padding-left: 9px;
  padding-right: 9px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}

/* @media only screen and (max-width: 1440px) {
  .news {
    top: 77px;
  }
} */

@media only screen and (max-width: 600px) {
  .news {
    top: 507px;
  }

  .news-pc {
    display: none;
  }

  .news-mb {
    display: block;
    margin: 0;
  }

  .img-news {
    left: 0;
    width: 100%;
    height: 230px;
  }

  .news1 {
    /* width: 90%;
    height: 180px;
    left: -2%;
    top: 12%; */
    display: none;
  }

  .news2 {
    /* width: 90%;
    height: 180px;
    left: -4%;
    top: 14%; */
    display: none;
  }

  .head {
    /* position: absolute; */
    z-index: 1;
    margin-top: 20px;
    padding-right: 0;
    padding-left: 0;
  }

  hr {
    margin-top: 30px;
    margin-left: 0px;
    width: 100%;
  }

  .detail {
    margin-top: 0px;
    padding-left: 0;
    padding-right: 0;
  }

  .news-date1 {
    margin-top: 0px;
    padding-left: 0px;
  }

  .mb-margin {
    margin-top: 290px;
  }

  .news-2 {
    margin-top: 32px;
  }

  .news-2 img {
    height: 230px;
  }

  .news-text {
    top: 140px;
    left: 19px;
    right: 19px;
  }

  .news-date {
    top: 230px;
    left: 19px;
  }
}
</style>