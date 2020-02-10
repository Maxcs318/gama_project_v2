<template>
    <div class="container" style="margin-top: 25px">
      <div class="row">
        <div class="col-lg-12 col-xs-12">
          <h5 class="head">หนังสือเล่มอื่นที่หน้าสนใจ</h5>
          <br />
        </div>
      </div>
      <div class="row">
        <div
          class="col-lg-3 col-6"
          v-for="(product,index) in book"
          :key="index"
        >
          <img
            class=""
            :src="getImgUrlProduct(product.p_image)"
            @click="seethisPage(product.p_id)"
            width="100%"
          />
          <h5 class="book-name" @click="seethisPage(product.p_id)">{{product.p_name}}</h5>
          <p class="book-price" @click="seethisPage(product.p_id)">{{product.p_price}} ฿</p>
          <br />
        </div>
      </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
  data(){
    return{
      data_pcs:4,
      product_category:1,
      data_product:'',
      data_load:false
    }
  },
  methods: {
    getImgUrlProduct(pic) {
      return this.path_files + "Product/" + pic;
    },
    seethisPage(thisproduct) {
      this.$router.push({
        name: "product",
        params: { ProductID: thisproduct }
      });
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    },
  },
  computed: {
    book() {
      if(this.data_load == false){
        axios.get(this.$store.getters.getBase_Url+'Product/get_random_product/'+this.product_category+'/'+this.data_pcs)
        .then(response => {
          this.data_product = response.data
        })
          this.data_load = true
      }
      
        var book = this.data_product
      return book;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  }
};
</script>
<style scoped>
.book-img {
  width: 70%;
  height: 244px;
  display: block;
  margin-left: auto;
  margin-right: auto;
}
.book-name {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  text-align: center;
  margin-top: 22px;
}
.book-price {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  text-align: center;
  color: #f56b6b;
}
.head {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  padding-bottom: 37px;
  color: rgba(255, 255, 255, 0.3);
}

@media only screen and (max-width: 600px) {
  .book-img {
    width: auto;
    height: 195px;
  }
}

@media only screen and (max-width: 370px) {
  .book-img {
    width: auto;
    height: 175px;
  }
}
</style>