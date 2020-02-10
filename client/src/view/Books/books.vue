<template>
  <div>
    <div class="container">
      <h4><center> หนังสือ </center></h4> <br>
      <div class="row">
        <div class="col-lg-6 col-12"></div>
        <div class="col-lg-6 col-12">
            <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากสินค้า ประเภทหนังสือ ทั้งหมด">
            <p v-if="searching!=''" style="text-align: right;"> <br>
            เจอทั้งหมด {{find}} รายการ
            </p>    
            <br>
        </div>
      </div>
      <div class="row">
        <div
          class="col-lg-3 col-6"
          v-for="(product,index) in book"
          :key="index"
        >
          <img width="100%"
            class=""
            :src="getImgUrlProduct(product.p_image)"
            @click="seethisPage(product.p_id)"
          />
          <h5 class="book-name">{{product.p_name}}</h5>
          <p class="book-price">{{product.p_price}} ฿</p>
        </div>
      </div>
      <div class="row" v-if="length_page > 0">
        <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
          <div class="btn-group" role="group" aria-label="Second group">
            <button
              type="button"
              class="btn btn-light"
              @click="seenextPage(1)"
              title="First page"
            ><<</button>
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
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      data_product:'',
      data_size:'',
      product_category:1,
      data_load:false,
      page: 0,
      data_in_page: 12,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      searching:'',
      find:null
    };
  },
  methods: {
    getImgUrlProduct(pic) {
      return this.path_files + "Product/" + pic;
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "books",
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
  watch:{
      $route (to, from){
        this.data_load = false;
      },
      searching(){
        this.do_search
      }
    },
  computed: {
    book() {
      var setpage = this.$route.params.Page;
      var setcategory = this.product_category;
      if(this.data_load==false && this.searching == ''){
        axios.get(this.$store.getters.getBase_Url+'Product/get_product/'+this.data_in_page+'/'+this.product_category+'/'+setpage)
        .then(response => {
        // console.log(response.data),
        this.data_size = response.data[0],
        this.data_product = response.data[1]
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
      return this.data_product;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    do_search(){
      if(this.searching[0] == ' '){
        this.searching = ''
      }
      if(this.searching.length>0){
          var search = encodeURI(this.searching);
          axios.get(this.$store.getters.getBase_Url+'Product/get_all_product_like/'+this.product_category+'/'+search)
          .then(response => {
            // console.log(response.data)
            this.data_size = 0,
            this.find = response.data[0],
            this.data_product = response.data[1]
        })
        this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
  }
};
</script>
<style scoped>
.book-img {
  width: auto;
  height: 240px;
  display: block;
  margin: 0 auto;
}
.book-name {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  text-align: center;
}
.book-price {
  font-style: normal;
  padding-top: 7px;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  text-align: center;
  /* text-align: right; */
  color: #f56b6b;
}
@media only screen and (max-width: 600px) {
  .book-img {
    width: 100%;
    height: 195px;
  }
}

@media only screen and (max-width: 370px) {
  .book-img {
    width: 100%;
    height: 135px;
  }
}
</style>