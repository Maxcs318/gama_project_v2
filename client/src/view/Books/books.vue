<template>
  <div>
    <div class="container">
      <div class="row">
        <div
          class="col-lg-3 col-6"
          v-for="(product,index) in book.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)"
          :key="index"
        >
          <img
            class="book-img"
            :src="getImgUrlProduct(product.p_image)"
            @click="seethisPage(product.p_id)"
          />
          <h5 class="book-name">{{product.p_name}}</h5>
          <p class="book-price">{{product.p_price}} ฿</p>

          <!-- <div class="row">
            <div class="col-lg-4">
              <p class="book-price">{{product.p_price}} ฿</p>
            </div>
            <div class="col-lg-8 col-12">
              <button class="form-control btn-primary">เพิ่มลงตะกร้า</button>
              <br />
            </div>
          </div>-->
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
export default {
  data() {
    return {
      page: 0,
      data_in_page: 12,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: []
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
  computed: {
    book() {
      var productAll = this.$store.getters.getProduct;
      var book = [];
      for (var i = 0; i < productAll.length; i++) {
        if (productAll[i].p_category == 1) {
          book.push(productAll[i]);
        }
      }
      var setpage = this.$route.params.Page;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(book.length / this.data_in_page); // set page all
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
      return book;
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