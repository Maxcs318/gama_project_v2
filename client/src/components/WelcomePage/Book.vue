<template>
  <div>
    <div class="book">
      <div class="container">
        <div class="row">
          <label class="col-lg-10 col-xs-12 header">หนังสือ</label>
          <div class="col-lg-2">
            <router-link to="/books/1">
              <button class="btn-viewall" type="button">ดูทั้งหมด></button>
            </router-link>
          </div>
        </div>
        <div class="row justify-content-around">
          <div
            class="col-lg-3 col-md-6 col-6"
            v-for="(product,index) in book.slice().reverse().slice(0,4)"
            :key="index"
          >
            <img
              class="mx-auto d-block book-img"
              :src="getImgUrlProduct(product.p_image)"
              @click="seethisPageBook(product.p_id)"
            />
            <h5 class="book-detail">{{product.p_name.slice(0,50)+"..."}}</h5>
            <p class="price" style="text-align: center;">฿ {{product.p_price}}</p>
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
    seethisPageBook(thisproduct) {
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
.book {
  position: relative;
  margin-top: 126px;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0) 0%,
    rgba(255, 255, 255, 0.1) 48.44%,
    rgba(242, 242, 242, 0) 100%
  );
}

.book-img {
  cursor: pointer;
  background: #d8d8d8;
  box-shadow: 0px 4px 30px rgba(0, 0, 0, 0.5);
  width: auto;
  height: 244px;
}
.book-img:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.header {
  font-style: normal;
  margin-bottom: 34px;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  color: rgba(255, 255, 255, 0.3);
}

.book-detail {
  text-align: center;
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  margin-top: 20px;
  line-height: 150%;
  text-align: center;
  color: #fff;
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

.price {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  margin-bottom: 95px;
  color: #eb1010;
}

@media only screen and (max-width: 600px) {
  .book {
    margin-top: 66px;
  }
  .header {
    margin-bottom: 16px;
  }
  .btn-viewall {
    margin-left: 0;
    margin-top: 0;
    margin-bottom: 34px;
  }
  .book-img {
    width: 100%;
    height: 192px;
  }
}
</style>