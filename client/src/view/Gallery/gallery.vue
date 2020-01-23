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
        วันที่สร้าง : {{thisGallery.g_create_date}}
        <br />
        แก้ไขล่าสุด : {{thisGallery.g_update_date}}
        <br />
        <div class="row">
          <div class="col-lg-3 col-lg-xs-12" v-for="(gi,index) in thisGallery_image" :key="index">
            <img class="event-img" :src="getImgUrlGallery(gi.gi_image)" />
            <br />
            <br />
          </div>
        </div>
        <!-- <div class="row">
                    <div class="col-12">
                        <b-carousel id="carousel1"
                            style="text-shadow: 1px 1px 2px #333;"
                            controls
                            indicators
                            :interval="1500"
                            img-width="100%"
                            v-model="slide"
                            @sliding-start="onSlideStart"
                            @sliding-end="onSlideEnd"
                        >
                            <b-carousel-slide caption="Blank Image" img-blank v-for=" (gallery_slide,index) in thisGallery_image " :key="index">
                                <img :src="getImgUrlGallery(gallery_slide.gi_image)" width="100%"/>
                            </b-carousel-slide>
                        </b-carousel>
                    </div>
        </div>-->
      </div>
    </div>
    <div class="row" v-else-if="!thisGallery">
      <div class="col-lg-12 col-xs-12">
        <center>
          <h4>this Gallery No Have.</h4>
        </center>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      slide: 0,
      sliding: null
    };
  },
  methods: {
    getImgUrlGallery(pic) {
      return this.path_files + "Gallery/" + pic;
    },
    onSlideStart(slide) {
      this.sliding = true;
    },
    onSlideEnd(slide) {
      this.sliding = false;
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisGallery() {
      var galleryall = this.$store.getters.getGallery;
      var gallery;
      for (var i = 0; i < galleryall.length; i++) {
        if (galleryall[i].g_id == this.$route.params.GalleryID) {
          gallery = galleryall[i];
        }
      }
      return gallery;
    },
    thisGallery_image() {
      var gallery_imageall = this.$store.getters.getGallery_Image;
      var gallery_image = [];
      // set first image
      var first_image = { gi_image: this.thisGallery.g_image };
      gallery_image.push(first_image);
      // ===============
      for (var i = 0; i < gallery_imageall.length; i++) {
        if (gallery_imageall[i].gi_gallery_id == this.$route.params.GalleryID) {
          gallery_image.push(gallery_imageall[i]);
        }
      }
      return gallery_image;
    }
  },
  created() {
    this.$store.dispatch("initDataGallery");
    this.$store.dispatch("initDataGallery_Image");
  }
};
</script>
