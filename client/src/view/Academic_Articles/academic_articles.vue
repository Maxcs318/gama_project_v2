<template>
  <div class="container">
    <h4 style="text-align:center">บทความวิชาการ </h4>
    <div class="row">
      <div class="col-lg-6 col-12">
        <br>
        <select class="form-control select" v-model="academic_article_category" required @click="changeCategory(academic_article_category)">
          <option class="option" value="all" > ทั้งหมด </option>
          <option class="option" v-for="aac in Academic_Article_Category" :value="aac.aac_id">
            {{ aac.aac_title }}
          </option>
        </select>
      </div>
      <div class="col-lg-6 col-12">
        <br>
        <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากบทความวิชาการทั้งหมด">
        <p v-if="searching!=''" style="text-align: right;"> <br>
         เจอทั้งหมด {{find}} รายการ
        </p>    
      </div>
    </div>
    <br>
    <div class="row">
      <div
        class="col-lg-6 col-12 hv-eff"
        v-for="(academic_article,index) in the_academic_article"
        :key="index"
        @click="seethisPage(academic_article.aa_id)"
        style="margin-bottom: 32px;"
      >
        <img :src="getImgUrlArticle(academic_article.aa_image)" width="100%" height="370px" />
        <h5 class="head">{{academic_article.aa_title}}</h5>
        <p class="date">{{academic_article.aa_create_date.slice(0,-13)}}</p>
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
            <button type="button" class="btn btn-light" @click="seenextPage(length_page)" title="Last page">>></button>
          </div>
        </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      data_academic_articles:'',
      data_size:'',
      academic_article_category:'',
      data_load:false,
      page: 0,
      data_in_page: 6,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      searching:'',
      find:null,

      academic_article_category_all:'',
      data_load_category:false,
    };
  },
  methods: {
    getImgUrlArticle(pic) {
      return this.path_files + "Academic_Article/" + pic;
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "academic_articles",
        params: { Page: num_page }
      });
    },
    changeCategory(selected_category){
      if(this.academic_article_category != this.$route.params.AcademicArticleCategory ){
        this.searching=""
        this.$router.push({
          name: "academic_articles",
          params: { AcademicArticleCategory: selected_category,Page: 1 }
        });
      }
    },
    seethisPage(thisarticle) {
      this.$router.push({name: "academic_article",params: { AcademicArticleID: thisarticle }});
    }
  },
  watch:{
    $route (to, from){
        this.data_load = false;
    },
    searching(){
      if(this.searching[0] == ' '){
        this.searching = ''
      }
      if(this.searching.length>0){
        var search = encodeURI(this.searching);
        axios.get(this.$store.getters.getBase_Url+'Academic_article/get_all_academic_article_like/'+search)
        .then(response => {
            // console.log(response.data),
            this.data_size = 0,
            this.find = response.data[0],
            this.data_academic_articles = response.data[1]
        })
        this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
  },
  computed: {
    the_academic_article() {
      var setpage = this.$route.params.Page;
      var setcategory = this.$route.params.AcademicArticleCategory;
      this.academic_article_category = setcategory;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Academic_article/get_academic_article/'+this.data_in_page+'/'+this.academic_article_category+'/'+setpage)
        .then(response => {
            // console.log(response.data),
            this.data_size = response.data[0],
            this.data_academic_articles = response.data[1]
        })
        this.data_load = true
      }
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);
      this.page = setpage - 1;
      this.length_page = Math.ceil(this.data_size / this.data_in_page); // set page all
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
      return this.data_academic_articles;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Academic_Article_Category(){
      if(this.data_load_category==false){
        axios.get(this.$store.getters.getBase_Url+"Academic_article/get_all_academic_article_category")
        .then(response => {
            // console.log(response)
            this.academic_article_category_all = response.data
        })
        this.data_load_category=true
      }
        var category_all = this.academic_article_category_all
      return category_all
    }
  }
};
</script>
<style scoped>
.head {
  position: absolute;
  z-index: 1;
  top: 70%;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: 600;
  font-size: 2em;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
}
.date {
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
  img {
    height: auto;
  }
  .head {
    top: 45%;
  }
  .date {
    top: 85%;
  }
}
</style>