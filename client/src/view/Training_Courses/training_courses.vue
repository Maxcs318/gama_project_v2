<template>
  <div class="container">
    <!-- <div class="row">
      <div
        class="col-lg-6 col-12"
        v-for="(product,index) in trainingC.slice().reverse().slice(0,2)"
        :key="index"
      >
        <img
          :src="getImgUrl(product.p_image)"
          width="100%"
          height="370px"
          @click="seethisPage(product.p_id)"
        />
        <h5 class="course-name" style="text-align:left;">{{product.p_name}}</h5>
        <p class="course-date" style="text-align:left;">{{product.p_create_date.slice(0,-13)}}</p>
        <br />
        <br />
        <br />
      </div>
    </div>-->
    <div class="row">
      <div
        class="col-lg-4 col-12"
        v-for="(product,index) in trainingC.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)"
        :key="index"
      >
        <img
          :src="getImgUrl(product.p_image)"
          width="100%"
          height="230px"
          @click="seethisPage(product.p_id)"
        />
        <h5 class="course-name2">{{product.p_name.slice(0,35)+"..."}}</h5>
        <p class="course-date2">{{product.p_create_date.slice(0,-13)}}</p>
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
export default {
  data() {
    return {
      page: 0,
      data_in_page: 9,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: []
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Product/" + pic;
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "training_courses",
        params: { Page: num_page }
      });
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
      var setpage = this.$route.params.Page;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(training_course.length / this.data_in_page); // set page all
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
img,
.course-name,
.course-name2,
.course-date,
.course-date2 {
  cursor: pointer;
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
  top: 45%;
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
  top: 77%;
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
</style>