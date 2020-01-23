<template>
  <div class="container" style="margin-top: 109px">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h5 class="head">หลักสูตรและอบรมอื่น ๆ ที่หน้าสนใจ</h5>
        <br />
      </div>
    </div>
    <div class="row">
      <div
        class="col-lg-4 col-12"
        v-for="(product,index) in trainingC.slice().reverse().slice(0,3)"
        :key="index"
      >
        <img
          :src="getImgUrl(product.p_image)"
          width="100%"
          height="230px"
          @click="seethisPage(product.p_id)"
        />
        <h5 class="course-name2">{{product.p_name.slice(0,40)+"..."}}</h5>
        <p class="course-date2">{{product.p_create_date.slice(0,-13)}}</p>
        <br />
        <br />
        <br />
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Product/" + pic;
    },
    seethisPage(thisproduct) {
      this.$router.push({
        name: "product",
        params: { ProductID: thisproduct }
      });
    }
  },
  computed: {
    trainingC() {
      var productAll = this.$store.getters.getProduct;
      var training_course = [];
      for (var i = 0; i < productAll.length; i++) {
        if (productAll[i].p_category == 2) {
          training_course.push(productAll[i]);
        }
      }
      return training_course;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  created() {
    this.$store.dispatch("initDataProduct");
  }
};
</script>
<style scoped>
.head {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  margin-top: 102px;
  color: rgba(255, 255, 255, 0.3);
}
img,
.course-name,
.course-name2,
.course-date,
.course-date2 {
  cursor: pointer;
}
img:hover {
  transition: 0.25s;
  opacity: 0.7;
}
.course-name {
  position: absolute;
  top: 70%;
  padding-left: 21px;
  padding-right: 21px;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
}
.course-date {
  position: absolute;
  top: 90%;
  padding-left: 21px;
  padding-right: 21px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}
.course-name2 {
  position: absolute;
  top: 50%;
  padding-left: 21px;
  padding-right: 21px;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 100%;
  display: flex;
  align-items: flex-end;
  letter-spacing: 0.75px;
}
.course-date2 {
  position: absolute;
  top: 70%;
  padding-left: 21px;
  padding-right: 21px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}
.course-name:hover,
.course-name2:hover,
.course-date:hover,
.course-date2:hover {
  transition: 0.25s;
}

@media only screen and (max-width: 370px) {
  .course-name2 {
    top: 35%;
  }
}
</style>