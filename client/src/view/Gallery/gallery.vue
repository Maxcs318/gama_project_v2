<template>
  <div class="container">
    <div class="row" v-if="thisGallery">
      <div class="col-lg-12 col-xs-12">
        <h5 class="header">
          <center>
            ภาพกิจกรรม
            <br />
            {{thisGallery.g_name}}
          </center>
        </h5>
        <br />
        รายละเอียด : {{thisGallery.g_description}}
        <br />
        วันที่เผยแพร่ : {{thisGallery.g_create_date}}
        <br />
        แก้ไขล่าสุด : {{thisGallery.g_update_date}}
        <br /><br>
        <div class="row">
          <div class="col-lg-3 col-lg-xs-12" >
            <img class="event-img" :src="getImgUrlGallery(thisGallery.g_image)" />
            <br />
            <br />
          </div>
          <div class="col-lg-3 col-lg-xs-12" v-for="(gi,index) in gallery_data_file" :key="index">
            <img class="event-img" :src="getImgUrlGallery(gi.gi_image)" />
            <br />
            <br />
          </div>
        </div>
      </div>
    </div>
    <div class="row" v-else-if="!thisGallery">
      <div class="col-lg-12 col-xs-12">
        <center>
          <h4> {{text_alert}} </h4>
        </center>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data(){
    return {
      data_load:false,
      text_alert:'',
      gallery_data:'',
      gallery_data_file:'',
      
      // slide: 0,
      // sliding: null
    }
  },
  methods: {
    getImgUrlGallery(pic) {
      return this.path_files + "Gallery/" + pic;
    },
    // onSlideStart(slide) {
    //   this.sliding = true;
    // },
    // onSlideEnd(slide) {
    //   this.sliding = false;
    // }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisGallery() {
      var galleryID = this.$route.params.GalleryID;
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Gallery/get_this_gallery/'+galleryID)
        .then(response => {
            // console.log(response.data),
            this.gallery_data = response.data[0][0],
            this.gallery_data_file = response.data[1]
        })
        this.data_load = true
        if(this.gallery_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var gallery_show = this.gallery_data
      return gallery_show;
    },
  },
};
</script>
