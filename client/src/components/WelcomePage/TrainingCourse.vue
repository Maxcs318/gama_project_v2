<template>
  <div>
    <div class="container">
      <div class="training">
        <div class="row">
          <header class="col-lg-10 col-xs-12 header">หลักสูตรอบรม</header>
          <div class="col-lg-2 col-xs-12">
            <router-link to="/training_courses/1">
              <button class="btn-viewall">ดูทั้งหมด></button>
            </router-link>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-6 col-md-6" v-for="(product,index) in trainingCourse" :key="index">
            <router-link style="text-decoration: none;" :to="'/product/'+product.p_id">
              <div class="training-img">
                <img :src="getImgUrlProduct(product.p_image)" caption="First slide" />
                <h5 class="course-text">{{product.p_name.slice(0,70)+"..."}}</h5>
                <p
                  class="course-date"
                  style="text-align: left;"
                >{{product.p_create_date.slice(0,-13)}}</p>
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
  data() {
    return {
      data_product: "",
      data_size: "",
      data_load: false,
      data_in_page: 4
    };
  },
  methods: {
    getImgUrlProduct(picP) {
      return this.path_files + "Product/" + picP;
    }
    // seethisPageCourse(thisproduct) {
    //   this.$router.push({
    //     name: "product",
    //     params: { ProductID: thisproduct }
    //   });
    // }
  },
  computed: {
    trainingCourse() {
      if (this.data_load == false) {
        axios
          .get(
            this.$store.getters.getBase_Url +
              "Product/get_product/" +
              this.data_in_page +
              "/2/1"
          )
          .then(response => {
            // console.log(response.data),
            (this.data_size = response.data[0]),
              (this.data_product = response.data[1]);
          });
        this.data_load = true;
      }
      var training_course = this.data_product;
      return training_course;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  }
};
</script>
<style scoped>
.training {
  position: relative;
}

.header {
  text-align: left;
  font-style: normal;
  font-weight: 600;
  margin-bottom: 0px;
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