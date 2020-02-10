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
    <div class="row" v-if="Order && data_shipping_address && data_order_status.os_id == '2'">
      <div class="col-lg-12 col-xs-12">
        <table class="table" style="width:100%; text-align: center;" v-if="Order">
          <tr>
            <th>สินค้า</th>
            <th>ราคา</th>
            <th>จำนวน</th>
            <th>ยอดรวมชำระ</th>
          </tr>
          <tr v-for="order_item in data_order_items">
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
          <div>สถานะใบสั่งซื้อ : {{data_order_status.os_title}}</div>
          <!-- Order Create Date : {{ Order.o_create_date }}<br> -->
        </center>
        <br />
        <div class="row" v-if="data_moneytransfer && data_payment">
          <div class="col-lg-4 col-xs-12">
            <img :src="getImgUrl(data_moneytransfer.mtf_slip)" width="100%" />
          </div>
          <div class="col-lg-4 col-xs-12">
            <h5 class="header">การชำระเงิน</h5>
            หัวข้อการชำระเงิน : {{data_moneytransfer.mtf_title}}
            <br />
            ชำระด้วย : {{data_payment.pm_title}}
            <br />
            <div v-if="data_banking">ธนาคาร : {{data_banking.b_name}}</div>
            วันที่ชำระเงิน : {{data_moneytransfer.mtf_date}}
            <br />
            ความคิดเห็น : {{data_moneytransfer.mtf_comment}}
            <br />
          </div>
          <div class="col-lg-4 col-xs-12" v-if="data_shipping_address">
            <h5 class="header">ที่อยู่สำหรับจัดส่ง</h5>
            หัวข้อที่อยู่จัดส่ง : {{data_shipping_address.sa_title}}
            <br />
            ที่อยู่ : {{data_shipping_address.sa_address}}
            <br />
            รหัสไปรษณีย์ : {{data_shipping_address.sa_postcode}}
            <br />
            บริษัท : {{data_shipping_address.sa_company}}
            <br />
            อีเมลล์ : {{data_shipping_address.sa_email}}
            <br />
            เบอร์โทรศัพท์ : {{data_shipping_address.sa_phone}}
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
          <center> {{text_alert}} </center>
        </h5>
      </div>
    </div>
    <div class="row" v-if="data_moneytransfer && data_order_status.os_id == 2">
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
import axios from "axios";
export default {
  data() {
    return {
        data_order:'',
        data_order_status:'',
        data_order_items:'',
        data_shipping_address:'',
        data_moneytransfer:'',
        data_payment:'',
        data_banking:'',
        data_load:false,

        text_alert:'',
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
      var order_code = this.$route.params.CodeOrder
      if(this.data_load==false){
        var FD = new FormData();
        FD.append("order_code", JSON.stringify(order_code));
          axios.post(this.$store.getters.getBase_Url+'Order/get_order_by_code',FD)
          .then(response => {
            // console.log(response.data)
            this.data_order = response.data[0],
            this.data_order_items = response.data[1],
            this.data_order_status = response.data[2],
            this.data_shipping_address = response.data[3],
            this.data_moneytransfer = response.data[4],
            this.data_payment = response.data[5],
            this.data_banking = response.data[6]
          })
          setTimeout(() => {
            this.text_alert = 'ใบสั่งซื้อขัดข้อง : ไม่มีใบสั่งซื้อนี้ หรือ status ของใบสั่งซื้ออาจจะผ่านการตรวจเรียบร้อย'
          },1000);
          
        this.data_load = true
      }
      return this.data_order
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>
