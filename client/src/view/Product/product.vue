<template>
  <div class="container" v-if="thisProduct">
    <div class="row" v-if="thisProduct">
      <div class="col-lg-3 col-12">
        <img :src="getImgUrl(show_pic)" width="100%" />
        <br />
        <br />
        <div class="row">
          <div class="col-lg-3 col-4">
            <img
              :src="getImgUrl(thisProduct.p_image)"
              width="100%"
              @click="see_this_pic(thisProduct.p_image)"
            />
          </div>
          <div
            class="col-lg-3 col-4"
            v-if="thisProduct_Image"
            v-for="(pi,index) in thisProduct_Image"
            :key="index"
          >
            <img :src="getImgUrl(pi.pi_name)" width="100%" @click="see_this_pic(pi.pi_name)" />
            <br />
            <br />
          </div>
        </div>
      </div>
      <div class="col-lg-7 col-xs-12" v-if="thisProduct">
        <p class="course-name">Name : {{thisProduct.p_name}}</p>
        <!-- <p class="course-category">Category : {{thisProduct.p_category}}</p> -->
        <p class="course-price">฿{{thisProduct.p_price}}</p>
        <p class="course-member-price">ราคาพิเศษสำหรับสมาชิก : ฿{{thisProduct.p_price2}}</p>
        <!-- <p class="course-date">{{thisProduct.p_date}}</p> -->
        <hr />
        
        <div class="row">
          <!-- <div class="minus-btn col-lg-2 col-2">
            <input type="button" value="-" class="form-control btn-danger" @click="removeproduct" />
            <br />
          </div>
          <div class="col-lg-8 col-8">
            <input type="text" class="form-control" v-model="amount" style="text-align:center" />
            <br />
          </div>

          <div class="add-btn col-lg-2 col-2">
            <input type="button" value="+" class="form-control btn-success" @click="addproduct" />
            <br />
          </div> -->
          <div class="col-lg-4 col-12">
            <button
              class="form-control btn-primary"
              @click="add_to_cart(thisProduct.p_id)"
            >เพิ่มลงตะกร้า</button>
            <br />
          </div>
          <div class="col-lg-12 col-12">
            <h3>รายละเอียด</h3>
            <p class="course-detail">Description : {{thisProduct.p_description}}</p>
          </div>
        </div>

        <div v-if="total!=0">
          <p>ราคารวมทั้งหมด {{total}} บาท</p>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="clo-lg-12">
        <book-interesting v-if="thisProduct.p_category == 1"></book-interesting>
        <training-courses-interesting v-if="thisProduct.p_category == 2"></training-courses-interesting>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import bookinteresting from "./../../components/Other_interesting/book_interesting";
import traningcoursesinteresting from "./../../components/Other_interesting/traning_courses_interesting";

export default {
  data() {
    return {
      amount: 1,
      total: 0,
      nowcart: [],
      show_pic: ""
    };
  },
  methods: {
    see_this_pic(select_pic) {
      this.show_pic = select_pic;
    },
    getImgUrl(pic) {
      return this.path_files + "Product/" + pic;
    },
    addproduct() {
      this.amount = this.amount + 1;
    },
    removeproduct() {
      if (this.amount > 0) {
        this.amount = this.amount - 1;
      }
    },
    add_to_cart(p_id) {
      var productAdd = { p_id: p_id, quantity: this.amount };
      this.$store.dispatch("Add_Cart", productAdd);
      this.$swal(
        "Add " +
          this.thisProduct.p_name +
          " to Cart " +
          this.amount +
          " pieces",
        "",
        "success"
      );
    }
  },
  watch: {
    amount: function() {
      if (this.amount > 0) {
        if (this.amount == "" || this.amount == null) {
          this.amount = 0;
        }

        if (this.$store.state.the_user.m_status == "admin") {
          this.total = this.amount * this.thisProduct.p_price2;
        } else {
          this.total = this.amount * this.thisProduct.p_price;
        }
      } else {
        this.total = 0;
      }
    }
  },
  computed: {
    thisProduct() {
      var ProductAll = this.$store.getters.getProduct;
      var product;
      for (var i = 0; i < ProductAll.length; i++) {
        if (ProductAll[i].p_id == this.$route.params.ProductID) {
          product = ProductAll[i];
        }
      }
      return product;
    },
    thisProduct_Image() {
      var product_imageAll = this.$store.getters.getProduct_Image;
      var product_image = [];
      for (var i = 0; i < product_imageAll.length; i++) {
        if (product_imageAll[i].pi_image_key == this.thisProduct.p_image_key) {
          product_image.push(product_imageAll[i]);
        }
      }
      if (product_image.length != 0) {
        return product_image;
      } else {
        return false;
      }
    },
    path_files() {
      this.show_pic = this.thisProduct.p_image;
      return this.$store.getters.getPath_Files;
    }
  },
  components: {
    BookInteresting: bookinteresting,
    TrainingCoursesInteresting: traningcoursesinteresting
  }
};
</script>
<style scoped>
.course-name {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  letter-spacing: 0.75px;
}
</style>