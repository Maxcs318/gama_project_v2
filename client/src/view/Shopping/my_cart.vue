<template>
  <div class="container" style="margin-bottom: 143px;">
    <!-- // -->
    <div v-if="address_show == 'OFF'">
      <div class="row">
        <div class="col-lg-10 col-7">
          <header>รายการในตะกร้า</header>
        </div>
        <div class="col-lg-2 col-5">
          <button type="button" class="form-control btn-warning" @click="page_order">Order</button>
          <br />
        </div>
      </div>
      <div class="empty-cart" v-if="thisMyCart.length==0">
        <div class="row">
          <!-- <i class="fas fa-shopping-basket"></i> -->
          <img :src="path_files+'logo_img/Cart.png'" />
          <h5 class="empty-text">ยังไม่มีของในตะกร้าของคุณ</h5>
        </div>
        <br />
        <br />
        <center>
          <a href="#" class="empty-link">เลือกซื้อหลักสูตร & อบรม ></a>
          <br />
          <br />
          <a href="#" class="empty-link">เลือกซื้อหนังสือ ></a>
        </center>
      </div>

      <!-- ------------|---------------------|------------------ -->
      <!-- ------------|---------- order ----|------------------ -->
      <!-- ------------V---------------------V------------------ -->
      <div v-if="MyCart.length>0 && Compute_Total && thisMyCart.length!=0">
        <div
          v-for=" (MC,index) in thisMyCart"
          :key="index"
          style="background:#1A2A3E; border-radius:6px; margin-bottom: 8px"
        >
          <div class="row">
            <div class="col-lg-12 col-12">
              <button
                @click="remove_all(index,MC.p_id)"
                type="button"
                class="close"
                aria-label="Close"
              >
                <span aria-hidden="true">&#10006;</span>
              </button>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-6 col-12">
              <img
                class="cart-img"
                :src="getImgUrl(MC.p_image)"
                @click="seethisPageProduct(MC.p_id)"
              />
              <!-- {{MC.p_image}} -->
              <br />
              <div @click="seethisPageProduct(MC.p_id)" style="text-align:center">{{MC.p_name}}</div>
            </div>
            <div class="col-lg-5">
              <br />
              <table width="100%">
                <tr>
                  <td class="td-padding">ราคาต่อชิ้น</td>
                  <td style="text-align:center">{{MC.p_price}} ฿</td>
                </tr>
                <tr>
                  <td class="td-padding">จำนวน</td>
                  <td style="text-align:center">
                    <button class="btn btn-quantity" @click="remove_product(index,MC.p_id)">-</button>
                    {{MC.quantity}}
                    <button
                      class="btn btn-quantity"
                      @click="add_product(index,MC.p_id)"
                    >+</button>
                  </td>
                </tr>
                <tr>
                  <td class="td-padding">รวม</td>
                  <td style="text-align:center">{{computePrice( index,MC.p_price,MC.quantity )}} ฿</td>
                </tr>
              </table>
            </div>
          </div>
          <br />
        </div>
      </div>

      <!-- ราคารวมสินค้าทั้งหมด -->
      <hr />
      <div class="row">
        <div class="col-lg-6 col-xs-6"></div>
        <div class="col-lg-6 col-xs-6">
          <table width="100%">
            <tr>
              <td>รวมทั้งหมด</td>
              <td style="text-align: right">{{total_Price}} ฿</td>
            </tr>
          </table>
          <br />
          <button
            type="button"
            class="col-lg-5 form-control btn-danger clear-cart float-right"
            @click="clear_cart"
          >ล้างตะกร้า</button>
          <br />
          <br />

          <button
            type="button"
            class="col-lg-5 form-control btn-warning float-right"
            @click="check_out"
          >ดำเนินการต่อ</button>
        </div>
      </div>
      <!-- ************** -->
    </div>
    <!-- // -->
    <div v-else>
      <div class="row">
        <div class="col-lg-4 col-xs-12"></div>
        <div class="col-lg-4 col-xs-12">
          <form @submit.prevent="submitCart_To_Order">
            <h5>
              <center>Shipping Address</center>
            </h5>
            <div v-if="My_Shipping_Address!=''">
              Select Old Shipping Address
              <select class="form-control" v-model="select_sa">
                <option value>- - No Select - -</option>
                <option
                  v-for="(shipping ,index) in My_Shipping_Address"
                  :key="index"
                  :value="shipping.sa_id"
                >{{ shipping.sa_title }}</option>
              </select>
            </div>Title
            <input
              type="text"
              v-model="shipping_address.sa_title"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            Name
            <input
              type="text"
              v-model="shipping_address.sa_first_name"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            Address
            <textarea
              class="form-control"
              rows="5"
              v-model="shipping_address.sa_address"
              :disabled="click_select_sa()"
              required
            ></textarea>
            Postcode
            <input
              type="text"
              v-model="shipping_address.sa_postcode"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            Phone
            <input
              type="text"
              v-model="shipping_address.sa_phone"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            E-mail
            <input
              type="text"
              v-model="shipping_address.sa_email"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            Company
            <input
              type="text"
              v-model="shipping_address.sa_company"
              class="form-control"
              :disabled="click_select_sa()"
              required
            />
            <br />
            <div class="row">
              <div class="col-lg-6 col-xs-6">
                <button type="button" class="form-control btn-danger" @click="check_out">Back.</button>
                <br />
              </div>
              <div class="col-lg-6 col-xs-6">
                <button type="submit" class="form-control btn-primary">Save.</button>
                <br />
              </div>
            </div>
            <br />
          </form>
        </div>
        <div class="col-lg-4 col-xs-12"></div>
      </div>
    </div>
  </div>
</template>
<script>
import logintest from "../../components/Login_Register/loginPage";

export default {
  components: {
    loginpop: logintest
  },
  data() {
    return {
      select_sa: "",
      address_show: "OFF",
      shipping_address: {
        sa_title: "",
        sa_first_name:'',
        sa_address: "",
        sa_postcode: "",
        sa_phone: "",
        sa_email: "",
        sa_company: ""
      },
      thisMyCart: "",
      total_Price: 0
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Product/" + pic;
    },
    check_out() {
      if (
        this.$store.state.the_user == "" ||
        this.$store.state.the_user == null
      ) {
        document.getElementById("loginpopup").style.display = "block";
      } else {
        if (this.address_show == "OFF") {
          this.address_show = "ON";
        } else {
          this.address_show = "OFF";
        }
      }
    },
    click_select_sa() {
      if (this.select_sa == "") {
        return false;
      } else {
        return true;
      }
    },
    page_order() {
      this.$router.push("my_order");
    },
    seethisPageProduct(thisproduct) {
      this.$router.push({
        name: "product",
        params: { ProductID: thisproduct }
      });
    },
    submitCart_To_Order() {
      var my_order = [];
      for (var f = 0; f < this.thisMyCart.length; f++) {
        if (this.thisMyCart[f].quantity > 0) {
          my_order.push(this.thisMyCart[f]);
        }
      }
      var FD = new FormData();
      FD.append("order", JSON.stringify(my_order));
      if (this.select_sa == "") {
        FD.append("shipping_address", JSON.stringify(this.shipping_address));
      } else {
        FD.append("shipping_address_id", JSON.stringify(this.select_sa));
      }
      FD.append("own_id", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Create_Order", FD);
      swal({ title: "Create Order Success.", icon: "success" });

      setTimeout(() => {
        this.$router.push("/my_order");
      }, 2000);
    },
    computePrice(index, price, quantity) {
      var ptt = price * quantity;
      this.thisMyCart[index].price_total = ptt;
      return this.thisMyCart[index].price_total;
    },
    add_product(index, productID) {
      this.thisMyCart[index].quantity = this.thisMyCart[index].quantity + 1;
      this.$store.dispatch("Add_Cart_ProductAdd", productID);
    },
    remove_product(index, productID) {
      if (this.thisMyCart[index].quantity > 1) {
        this.thisMyCart[index].quantity = this.thisMyCart[index].quantity - 1;
        this.$store.dispatch("Remove_Cart_ProductRemove", productID);
      }
    },
    remove_all(index, productID) {
      this.$swal({
        title: "Are you sure?",
        text: "You want Remove This Product",
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.thisMyCart.splice(index, 1);
          this.$store.dispatch("Remove_Product_In_Cart", productID);
          swal({ title: "Remove Product Success.", icon: "success" });
        }
      });
    },
    clear_cart() {
      this.$swal({
        title: "Are you sure?",
        text: "You want Remove all Product in Cart ",
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.thisMyCart = [];
          this.$store.dispatch("Remove_Cart");
          swal({ title: "Clear Cart Success.", icon: "success" });
        }
      });
    }
  },
  watch: {
    select_sa: function() {
      if (this.select_sa == "") {
        this.shipping_address = {
          sa_title: "",
          sa_address: "",
          sa_postcode: "",
          sa_phone: "",
          sa_email: "",
          sa_company: ""
        };
      } else {
        for (var i = 0; i < this.My_Shipping_Address.length; i++) {
          if (this.select_sa == this.My_Shipping_Address[i].sa_id) {
            this.shipping_address = this.My_Shipping_Address[i];
          }
        }
      }
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Compute_Total() {
      this.total_Price = 0;
      for (var i = 0; i < this.thisMyCart.length; i++) {
        if (this.thisMyCart[i].quantity > 0) {
          this.total_Price = this.total_Price + this.thisMyCart[i].price_total;
        }
      }
      return true;
    },
    MyCart() {
      var cart = JSON.parse(localStorage.getItem("Cart"));
      if (cart == null) {
        cart = [];
      }
      var now_cart = [];
      var product_all = this.$store.getters.getProduct;
      var user = this.$store.getters.getThe_User;
      var the_price = null; // set price for user
      for (var i = 0; i < cart.length; i++) {
        for (var j = 0; j < product_all.length; j++) {
          if (cart[i].p_id == product_all[j].p_id) {
            if (user.m_type == "2" || user.m_type == "3") {
              the_price = product_all[j].p_price2;
            } else {
              the_price = product_all[j].p_price;
            }
            now_cart.push({
              p_id: product_all[j].p_id,
              p_name: product_all[j].p_name,
              p_image: product_all[j].p_image,
              quantity: cart[i].quantity,
              p_price: the_price,
              price_total: null
            });
          }
        }
      }
      this.thisMyCart = now_cart;
      return cart;
    },
    My_Shipping_Address() {
      return this.$store.getters.getMy_Shipping_Address;
    }
  },
  created() {
    this.$store.dispatch("initDataShipping_Address");
  }
};
</script>
 <style scoped>
header {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  letter-spacing: 0.75px;
}
.empty-cart {
  margin-bottom: 119px;
}
.empty-cart img {
  display: block;
  margin: 36px auto;
  width: 15%;
  height: 15%;
}
.fa-shopping-basket {
  font-size: 130px;
  margin: 64px auto 35px auto;
  opacity: 0.3;
}
.empty-text {
  width: 100%;
  text-align: center;
  opacity: 0.3;
  font-weight: 600;
  font-size: 29px;
}
a.empty-link {
  cursor: pointer;
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  color: #6cadfd;
  text-align: center;
  text-decoration: none;
}
a.empty-link:hover {
  transition: 0.25s;
  /* font-size: 23px; */
  color: #fff;
}
.btn-quantity {
  font-weight: 600px;
  color: #fff;
}
td,
tr {
  font-size: 1.1em;
  padding-top: 7px;
  line-height: 150%;
}
.close {
  background-color: #fff;
  width: 24px;
  height: 24px;
  font-size: 1em;
  font-weight: 700;
  margin-top: 14px;
  margin-right: 14px;
  opacity: 0.6;
  border: none;
  text-align: center;
  border-radius: 50%;
  color: black;
}
.close:hover {
  background-color: #000;
  color: #fff;
}
.cart-img {
  max-height: 258px;
  max-width: 258px;
  display: block;
  margin-left: auto;
  margin-right: auto;
}
.clear-cart {
  color: #fff;
  background-color: #ff3838;
  font-size: 18px;
  line-height: 150%;
  border-radius: 24px;
  border: none;
}

.btn-warning {
  color: #093f84;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  border-radius: 24px;
  border: none;
}

.btn-danger:hover,
.btn-warning:hover {
  opacity: 0.7;
}

hr {
  background-color: #fff;
  height: 2px;
  opacity: 0.1;
}

@media only screen and (max-width: 600px) {
  .td-padding {
    padding-left: 13%;
  }

  .empty-cart img {
    width: 35%;
    height: 35%;
  }
}
</style>