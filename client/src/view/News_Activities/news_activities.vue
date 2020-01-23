<template>
  <div class="container">
    <!-- <div class="row">
      <div class="col-lg-6 col-12"> </div>
      <div 
        class="col-lg-6 col-12"
        @click="seethisPage(news.n_id)"
        v-for="(news,index) in the_news.slice().reverse().slice(0,1)"
        :key="index"
        >
          <img class="img-activities2" :src="getImgUrl(news.n_image)" />
          <h5 class="activitiesall-text2">{{news.n_title}}</h5>
          <p class="activitiesall-date2">{{news.n_create_date.slice(0,-13)}}</p>
      </div>
    </div>-->
    <div class="row">
      <!-- activities all pc-scale -->
      <!-- <div class="activities-pc">
        <div
          class="col-lg-12 col-12"
          style="padding-top: 70px;"
          v-for="(news,index) in the_news.slice().reverse().slice(0,1)"
          :key="index"
        >
          <div class="row">
            <div class="col-lg-2">
              <hr style="background: white" />
            </div>
            <div class="col-lg-4">
              <h5 class="head">{{news.n_title}}</h5>
              <p class="detail" style="text-align: left;">{{news.n_detail.slice(0,158)}}</p>
              <p class="date" style="text-align: left;">{{news.n_create_date.slice(0,-13)}}</p>
            </div>
            <div class="col-lg-6">
              <div class="shadow-news1"></div>
              <div class="shadow-news2"></div>
              <img
                class="img-activities"
                :src="getImgUrl(news.n_image)"
                @click="seethisPage(news.n_id)"
              />
            </div>
          </div>
        </div>
      </div>-->

      <!-- activities all mb-scale -->
      <!-- <div class="activities-mb">
        <div
          class="col-lg-12 col-12"
          v-for="(news,index) in the_news.slice().reverse().slice(0,1)"
          :key="index"
        >
          <div class="row">
            <div class="col-lg-6">
              <div class="shadow-news1"></div>
              <div class="shadow-news2"></div>
              <img
                class="img-activities"
                :src="getImgUrl(news.n_image)"
                @click="seethisPage(news.n_id)"
              />
            </div>
            <div class="col-12">
              <hr style="background: white" />
            </div>
            <div class="col-12">
              <h5 class="head">{{news.n_title}}</h5>
              <p class="detail" style="text-align: left;">{{news.n_detail.slice(0,158)}}</p>
              <p class="date" style="text-align: left;">{{news.n_create_date.slice(0,-13)}}</p>
            </div>
          </div>
        </div>
      </div>-->
      <div
        class="col-lg-6 col-12"
        @click="seethisPage(news.n_id)"
        v-for="(news,index) in the_news.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)"
        :key="index"
      >
        <img class="img-activities2" :src="getImgUrl(news.n_image)" />
        <h5 class="activitiesall-text2">{{news.n_title.slice(0,60)+"..."}}</h5>
        <p class="activitiesall-date2">{{news.n_create_date.slice(0,-13)}}</p>
      </div>
    </div>
    <div class="row" v-if="length_page > 0">
      <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
        <div class="btn-group" role="group" aria-label="Second group">
          <button type="button" class="btn btn-light" @click="seenextPage(1)" title="First page"><<</button>
          <button
            type="button"
            class="btn btn-light"
            v-for=" (run_page,index) in length_page "
            @click="seenextPage(run_page)"
            v-bind:class="{ active: isActive[index+1] }"
            v-if=" run_page >= page_start && run_page <= page_end "
          >{{run_page}}</button>
          <button
            type="button"
            class="btn btn-light"
            @click="seenextPage(length_page)"
            title="Last page"
          >>></button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      page: 0,
      data_in_page: 6,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: []
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "News/" + pic;
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "newsandactivities",
        params: { Page: num_page }
      });
    },
    seethisPage(thisnews) {
      this.$router.push({
        name: "newsandactivity",
        params: { NewsID: thisnews }
      });
    }
  },
  computed: {
    the_news() {
      var setpage = this.$route.params.Page;
      var news_All = this.$store.getters.getNews;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(news_All.length / this.data_in_page); // set page all
      // set start && end paging
      if (setpage > p_conpute) {
        p_start = setpage - p_conpute;
      } else {
        p_start = -(setpage - p_conpute) - p_conpute;
        p_end = p_end + p_start + p_conpute + 1;
      }
      if (p_end >= this.length_page) {
        p_start = p_start + (this.length_page - setpage - p_conpute);
      }
      this.page_start = p_start;
      this.page_end = p_end;

      this.isActive = [];
      for (var i = 0; i <= this.length_page; i++) {
        if (i == this.$route.params.Page) {
          this.isActive.push(true);
        } else {
          this.isActive.push(false);
        }
      }
      return news_All;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  created() {
    this.$store.dispatch("initDataNews");
    this.$store.dispatch("initDataFiles");
  }
};
</script>
<style scoped>
.head {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  letter-spacing: 0.75px;
}
.detail {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  margin-top: 12px;
  line-height: 150%;
}
.date {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  margin-top: 32px;
  color: #d8d8d8;
}
.img-activities {
  width: 100%;
  height: 370px;
  margin-bottom: 54px;
  cursor: pointer;
}
.shadow-news1 {
  position: absolute;
  z-index: -1;
  opacity: 0.2;
  border: 2px solid #ffffff;
  box-sizing: border-box;
  left: 0%;
  top: 106px;
  width: 418px;
  height: 279px;
}
.shadow-news2 {
  position: absolute;
  z-index: -1;
  opacity: 0.2;
  border: 2px solid #ffffff;
  box-sizing: border-box;
  left: -3%;
  top: 125px;
  width: 418px;
  height: 279px;
}
.img-activities2 {
  width: 100%;
  height: 370px;
  margin-bottom: 12px;
  cursor: pointer;
}
.activitiesall-text2 {
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
.activitiesall-date2 {
  position: absolute;
  z-index: 0;
  top: 87%;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}

.activities-pc {
  display: block;
}

.activities-mb {
  display: none;
}

@media only screen and (max-width: 600px) {
  .activities-pc {
    display: none;
  }
  .activities-mb {
    display: block;
    padding-top: 45px;
  }
  .img-activities {
    width: 100%;
    height: auto;
    margin-bottom: 24px;
  }
  .shadow-news1 {
    left: 1.75%;
    top: 103px;
    width: 80%;
    height: 60%;
  }
  .shadow-news2 {
    left: 0%;
    top: 113px;
    width: 80%;
    height: 60%;
  }
  .detail {
    margin-top: 18px;
  }
  .date {
    margin-top: 12px;
    margin-bottom: 40px;
  }
  .img-activities2 {
    width: 100%;
    height: auto;
    margin-bottom: 32px;
  }
  .activitiesall-text2 {
    top: 45%;
  }
  .activitiesall-date2 {
    top: 78%;
  }
}

@media only screen and (max-width: 370px) {

  .activitiesall-text2 {
    top: 23%;
  }

  .activitiesall-date2 {
    top: 73%;
  }

}
</style>