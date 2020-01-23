<template>
  <div>
    <div class="container">
      <div class="training">
        <div class="row">
          <header class="col-lg-10 col-xs-12 header">หลักสูตรอบรม</header>
          <div class="col-lg-2 col-xs-12">
            <router-link to="/training_courses">
              <button class="btn-viewall">ดูทั้งหมด></button>
            </router-link>
          </div>
        </div>
        <div class="row">
          <div
            class="col-lg-6 col-md-6"
            v-for="(product,index) in trainingCourse.slice().reverse().slice(0,4)"
            :key="index"
          >
            <div class="training-img">
              <img
                :src="getImgUrlProduct(product.p_image)"
                @click="seethisPageCourse(product.p_id)"
                caption="First slide"
              />
              <h5
                class="course-text"
                @click="seethisPageCourse(product.p_id)"
              >{{product.p_name.slice(0,70)+"..."}}</h5>
              <p
                class="course-date"
                style="text-align: left;"
              >{{product.p_create_date.slice(0,-13)}}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    getImgUrlProduct(picP) {
      return this.path_files + "Product/" + picP;
    },
    seethisPageCourse(thisproduct) {
      this.$router.push({
        name: "product",
        params: { ProductID: thisproduct }
      });
    }
  },
  computed: {
    trainingCourse() {
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
.training {
  position: relative;
}

.header {
  font-style: normal;
  margin-bottom: 34px;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  color: rgba(255, 255, 255, 0.3);
}

.training-img {
  /* position: absolute; */
  top: 12px;
  margin-top: 34px;
  cursor: pointer;
}
.training-img img {
  width: 100%;
  height: 370px;
}
.training-img:hover {
  transition: 0.25s;
  opacity: 0.7;
}

/* .training-img2 {
  position: absolute;
  top: 408px;
  margin: 0 auto;
} */

.course-text {
  position: absolute;
  top: 295px;
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
  color: #fff;
}

.course-date {
  position: absolute;
  top: 367px;
  left: 20px;
  padding-left: 19px;
  padding-right: 19px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #d8d8d8;
}
.btn-viewall {
  background: #576574;
  border: none;
  border-radius: 14px;
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  padding: 2px 14px;
  line-height: 150%;
  margin-left: 63px;
  text-align: right;
  color: #fff;
}

@media only screen and (max-width: 600px) {
  .training {
    margin-top: 0;
  }
  .training-img {
    margin-top: 18px;
  }
  .training-img img {
    height: 230px;
  }
  .course-text {
    top: 125px;
  }
  .course-date {
    top: 217px;
  }
  .header {
    margin-bottom: 16px;
  }
  .btn-viewall {
    margin-left: 0;
    margin-top: 0;
    margin-bottom: 14px;
  }
}
</style>