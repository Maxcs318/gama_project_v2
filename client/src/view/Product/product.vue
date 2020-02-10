<template>
  <div class="container" v-if="thisProduct">
    <div class="row" v-if="thisProduct">
      <div class="col-lg-3 col-12">
        <img :src="getImgUrl(show_pic)" width="100%" />
        <br />
        <br />
        <div class="row">
          <div class="col-lg-4 col-4">
            <img
              :src="getImgUrl(thisProduct.p_image)"
              width="100%"
              @click="see_this_pic(thisProduct.p_image)"
            />
          </div>
          <div
            class="col-lg-4 col-4"
            v-if="product_data_file"
            v-for="(pi,index) in product_data_file"
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
        <p class="course-price">ราคาปกติ : ฿{{thisProduct.p_price}}</p>
        <p class="course-member-price">ราคาพิเศษสำหรับสมาชิก : ฿{{thisProduct.p_price2}}</p>
        <!-- <p class="course-date">{{thisProduct.p_date}}</p> -->
        <hr />
        
        <div class="row">
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
      show_pic: "",

      data_load:false,
      text_alert:'',
      product_data:'',
      product_data_file:'',
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
    },
    $route (to, from){
      this.data_load = false;
    },
  },
  computed: {
    thisProduct() {
      var productID = this.$route.params.ProductID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Product/get_this_product/'+productID)
        .then(response => {
            // console.log(response.data),
            this.product_data = response.data[0][0],
            this.product_data_file = response.data[1]
        })
        this.data_load = true
        if(this.product_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var product_show = this.product_data
      return product_show;
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