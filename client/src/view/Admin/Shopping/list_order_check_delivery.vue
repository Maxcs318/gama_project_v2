<template>
  <div class="container" v-if="the_user">
    <h5 class="header">
      <center>การจัดส่ง</center>
    </h5>
    <br />
    <div class="row">
      <div class="col-lg-9 col-xs-12"></div>
      <div class="col-lg-3 col-xs-12">
        <button
          type="button"
          class="form-control btn-primary"
          @click="check_payment"
        >ตรวจสอบการชำระเงิน</button>
        <br />
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <table class="table" style="width:100%; text-align: center;">
          <tr>
            <th>ลำดับ</th>
            <!-- <th>ไอดีใบสั่งซ์้อ</th> -->
            <th>รหัสใบสั่งซื้อ</th>
            <th>ราคารวม</th>
            <th>สถานะออเดอร์</th>
            <th>วันที่เผยแพร่</th>
            <th></th>
          </tr>
          <tr
            v-for="(order,index) in Order.slice((page*data_in_page),(page+1)*data_in_page) "
            :key="index"
          >
            <td>{{ index+1+(page*data_in_page) }}</td>
            <!-- <td>{{order.o_id}}</td> -->
            <td>{{order.o_code_order}} <br><b class="about-order" @click="seethisOrder(order.o_code_order)">ดูเพิ่มเติม</b> </td>
            <td>{{order.o_total_price}}</td>
            <td>
              <div class="wait-text" v-for=" os in Order_Status " v-if="os.os_id == order.o_status_id">{{os.os_title}}</div>
            </td>
            <td>{{order.o_create_date}}</td>
            <td>
              <button
                type="button"
                class="form-control btn-primary"
                @click="Confirm_Order(order.o_code_order)"
              >ยืนยัน</button>
            </td>
          </tr>
        </table>
        <br />
        <br />
      </div>
    </div>
    <div class="row" v-if="length_page > 0">
      <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
        <div class="btn-group" role="group" aria-label="Second group">
          <button type="button" class="btn btn-light" @click="seenextPage(1)" title="First page"><<</button>
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
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      data_order:'',
      data_size:'',
      data_load:false,
      page: 0,
      data_in_page: 20,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
            
      searching:'',
      find:null,

      data_load_order_status:false,
      data_order_status:''
    };
  },
  methods: {
    check_payment() {
      this.$router.push("/AdminListOrder/1");
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "AdminListOrder_check_delivery",
        params: { Page: num_page }
      });
    },
    seethisOrder(this_order) {
      this.$router.push({ name: "order", params: { CodeOrder: this_order } });
    },
    Confirm_Order(this_order) {
      var FD = new FormData();
      FD.append("order_code", JSON.stringify(this_order));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure Confirm?",
        text: "This Order " + this_order + " Delivery ? ",
        icon: "warning",
        buttons: true,
        primaryMode: true
      }).then(Confirm_Success => {
        if (Confirm_Success) {
          // console.log('Confirm',this_order)
          this.$store.dispatch("Delivery_Order", FD);
          swal({ title: "Confirm Success.", icon: "success" });
          setTimeout(() => {
            this.data_load=false
          },100);
        }
      });
    }
  },
  computed: {
    Order() {
      var setpage = this.$route.params.Page;
      if(this.data_load==false && this.data_in_page){
          var FD = new FormData();
          FD.append("number_of_row", JSON.stringify(this.data_in_page));
          FD.append("pagenow", JSON.stringify(setpage));
          FD.append("order_status_id", JSON.stringify(3));

          axios.post(this.$store.getters.getBase_Url+'Order/get_order_for_admin',FD)
          .then(response => {
              // console.log(response.data)
              this.data_size = response.data[0],
              this.data_order = response.data[1]
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
      return this.data_order;
    },
    Order_Status() {
      if(this.data_load_order_status==false){
          axios.get(this.$store.getters.getBase_Url+'Order/get_all_order_status')
          .then(response => {
              // console.log(response.data)
              this.data_order_status = response.data
          })
          this.data_load_order_status = true
      }
      var order_status_all = this.data_order_status
      return order_status_all
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    }
  }
};
</script>
