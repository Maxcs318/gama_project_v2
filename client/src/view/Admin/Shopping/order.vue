<template>
  <div class="container" v-if="the_user">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h5 class="header">
          <center>รหัสใบสั่งซ์้อ : {{this.$route.params.CodeOrder}}</center>
        </h5>
        <!-- {{Order_Status}} -->
      </div>
    </div>
    <div class="row" v-if="Order!=0 && Shipping_Address">
      <div class="col-lg-12 col-xs-12">
        <table class="table" style="width:100%; text-align: center;" v-if="Order">
          <tr>
            <th>สินค้า</th>
            <th>ราคา</th>
            <th>จำนวน</th>
            <th>ยอดรวมชำระ</th>
          </tr>
          <tr v-for="order_item in Order_Items">
            <td>{{order_item.oi_product_id}}</td>
            <td>{{order_item.oi_product_price}}</td>
            <td>{{order_item.oi_quantity}}</td>
            <td>{{order_item.oi_total_price}}</td>
          </tr>
        </table>
        <br />
        <center>
          ยอดรวมชำระ : {{ Order.o_total_price }} ฿
          <br />
          <div
            v-for="os in Order_Status"
            v-if="os.os_id == Order.o_status_id"
          >สถานะใบสั่งซื้อ : {{os.os_title}}</div>
          <!-- Order Create Date : {{ Order.o_create_date }}<br> -->
        </center>
        <br />
        <div class="row" v-if="Moneytransfer && Banking && Payment">
          <div class="col-lg-4 col-xs-12">
            <img :src="getImgUrl(Moneytransfer.mtf_slip)" width="100%" />
          </div>
          <div class="col-lg-4 col-xs-12">
            <h5 class="header">การชำระเงิน</h5>
            ชื่อ : {{Moneytransfer.mtf_title}}
            <br />
            ชำระด้วย : {{Payment.pm_title}}
            <br />
            <div v-if="Banking != 'No'">ธนาคาร : {{Banking.b_name}}</div>
            วันที่ชำระเงิน : {{Moneytransfer.mtf_date}}
            <br />
            ความคิดเห็น : {{Moneytransfer.mtf_comment}}
            <br />
          </div>
          <div class="col-lg-4 col-xs-12" v-if="Shipping_Address">
            <h5 class="header">ที่อยู่สำหรับจัดส่ง</h5>
            ชื่อ : {{Shipping_Address.sa_title}}
            <br />
            ที่อยู่ : {{Shipping_Address.sa_address}}
            <br />
            รหัสไปรษณีย์ : {{Shipping_Address.sa_postcode}}
            <br />
            บริษัท : {{Shipping_Address.sa_company}}
            <br />
            อีเมลล์ : {{Shipping_Address.sa_email}}
            <br />
            เบอร์โทรศัพท์ : {{Shipping_Address.sa_phone}}
            <br />
          </div>
          <div class="col-lg-12 col-xs-12">
            <br />
            วันที่สั่งซื้อ : {{Order.o_create_date}}
            <br />
            อัพเดทสถานะการสั่งซื้อล่าสุด : {{Order.o_update_date}}
          </div>
        </div>
        <br />
      </div>
    </div>
    <div class="row" v-else>
      <div class="col-lg-12 col-xs-12">
        <br />
        <h5>
          <center>ใบสั่งซื้อขัดข้อง : ไม่มีใบสั่งซื้อนี้</center>
        </h5>
      </div>
    </div>
    <div class="row" v-if="Moneytransfer">
      <div class="col-lg-6 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <div class="row">
          <div class="col-lg-6 col-xs-12">
            <button type="button" class="form-control btn-primary" @click="Confirm_Order">ยืนยัน</button>
            <br />
          </div>
          <div class="col-lg-6 col-xs-12">
            <button type="button" class="form-control btn-danger" @click="No_Confirm_Order">ละทิ้ง</button>
            <br />
          </div>
        </div>
      </div>
      <br />
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      order_code: this.$route.params.CodeOrder
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Slip/" + pic;
    },
    Confirm_Order() {
      var FD = new FormData();
      FD.append("order_code", JSON.stringify(this.order_code));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure Confirm?",
        text: "This Order " + this.order_code + " Pay ? ",
        icon: "warning",
        buttons: true,
        primaryMode: true
      }).then(Confirm_Success => {
        if (Confirm_Success) {
          // console.log('Confirm',this.order_code)
          this.$store.dispatch("Confirm_Order", FD);
          swal({ title: "Confirm Success.", icon: "success" });
          this.$router.go(-1);
        }
      });
    },
    No_Confirm_Order() {
      var FD = new FormData();
      FD.append("order_code", JSON.stringify(this.order_code));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure Discard?",
        text: "This Order " + this.order_code + " ? ",
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(Discard_Success => {
        if (Discard_Success) {
          // console.log('Discard',this.order_code)
          this.$store.dispatch("Discard_Order", FD);
          swal({ title: "Discard Success.", icon: "success" });
          this.$router.go(-1);
        }
      });
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    Order() {
      var od = this.$store.getters.getOrder;
      var x = null;
      for (var i = 0; i < od.length; i++) {
        if (od[i].o_code_order == this.$route.params.CodeOrder) {
          x = od[i];
        }
      }
      return x;
    },
    Order_Status() {
      return this.$store.getters.getOrder_Status;
    },
    Order_Items() {
      var odi = this.$store.getters.getOrder_Item;
      var order_i = [];
      var product_all = this.$store.getters.getProduct;
      for (var i = 0; i < odi.length; i++) {
        if (odi[i].oi_order_id == this.Order.o_id) {
          // chang product id -> product name
          for (var j = 0; j < product_all.length; j++) {
            if (product_all[j].p_id == odi[i].oi_product_id) {
              odi[i].oi_product_id = product_all[j].p_name;
            }
          }
          order_i.push(odi[i]);
        }
      }
      return order_i;
    },
    Shipping_Address() {
      var my_sa = this.$store.getters.getShipping_Address;
      var sa_this_order = null;
      for (var i = 0; i < my_sa.length; i++) {
        if (my_sa[i].sa_id == this.Order.o_shipping_address_id) {
          sa_this_order = my_sa[i];
        }
      }
      return sa_this_order;
    },
    Moneytransfer() {
      var money = this.$store.getters.getMoney_Transfer;
      var this_money = null;
      for (var i = 0; i < money.length; i++) {
        if (money[i].mtf_id == this.Order.o_money_transfer_id) {
          this_money = money[i];
        }
      }
      return this_money;
    },
    Payment() {
      var pm = this.$store.getters.getPayments;
      var mtf = this.Moneytransfer;
      var this_pm;
      for (var j = 0; j < pm.length; j++) {
        if (mtf.mtf_payments_id == pm[j].pm_id) {
          this_pm = pm[j];
        }
      }
      return this_pm;
    },
    Banking() {
      var bk = this.$store.getters.getBanking;
      var mtf = this.Moneytransfer;
      var this_bk;
      if (mtf.mtf_banking_id > 0) {
        for (var j = 0; j < bk.length; j++) {
          if (mtf.mtf_banking_id == bk[j].b_id) {
            this_bk = bk[j];
          }
        }
      } else {
        this_bk = "No";
      }
      return this_bk;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>
