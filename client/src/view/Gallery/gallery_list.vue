<template>
  <div class="container">
    <h5 class="header">
      <center>รวมภาพกิจกรรม</center>
    </h5>
    <div class="row">
      <div class="col-lg-6 col-12"></div>
      <div class="col-lg-6 col-12">
        <br>
        <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากภาพกิจกรรมทั้งหมด">
        <p v-if="searching!=''" style="text-align: right;"> <br>
         เจอทั้งหมด {{find}} รายการ
        </p>   
        <br> 
      </div>
    </div>
    <div class="row">
      <div
        class="col-lg-3 col-xs-12"
        v-for="(gallery,index) in Gallery"
        :key="index"
        @click="seethisGallery(gallery.g_id)"
      >
        <img :src="getImgUrlGallery(gallery.g_image)" width="100%" height="160px" />
        {{gallery.g_name}}
        <br />
        <br />
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
import axios from "axios";
export default {
  data() {
    return {
      page: 0,
      data_in_page: 12,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      data_gallery:'',
      data_size:'',
      data_load:false,
      searching:'',
      find:null
    };
  },
  methods: {
    getImgUrlGallery(pic) {
      return this.path_files + "Gallery/" + pic;
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "gallerylist",
        params: { Page: num_page }
      });
    },
    seethisGallery(this_Gallery) {
      this.$router.push({
        name: "gallery",
        params: { GalleryID: this_Gallery }
      });
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
        axios.get(this.$store.getters.getBase_Url+'Gallery/get_all_gallery_like/'+search)
        .then(response => {
            // console.log(response.data)
            this.data_size = 0,
            this.find = response.data[0],
            this.data_gallery = response.data[1]
        })
        this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Gallery() {
      var setpage = this.$route.params.Page;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Gallery/get_gallery/'+this.data_in_page+'/'+setpage)
        .then(response => {
            // console.log(response.data),
            this.data_size = response.data[0],
            this.data_gallery = response.data[1]
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
      return this.data_gallery;
    }
  }
};
</script>
