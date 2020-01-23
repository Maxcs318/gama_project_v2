<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-xs-12"></div>
            <div class="col-lg-2 col-xs-12"> 
                <button type="button" class="form-control btn-primary" @click="page_order"> ใบสั่งซื้อ </button> <br>
            </div>
            <div class="col-lg-2 col-xs-12"> 
                <button type="button" class="form-control btn-success" @click="page_cart"> ตะกร้า </button> <br>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <center><h5 class="header">ประวัติใบสั่งซื้อของฉัน</h5></center>
                <br>
                <table class="table" style="width:100%; text-align: center;">
                    <tr>
                        <th> ลำดับ </th>
                        <th>รหัสใบสั่งซื้อ </th>
                        <th> ราคารวม </th>
                        <th> สถานะใบสั่งซ์้อ </th>
                        <th> วันที่สร้าง </th>
                    </tr>
                    <tr v-for="(order,index) in Order.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page) " :key="index">
                        <td>{{(Order.length - page*data_in_page) - index}}</td>
                        <td>{{order.o_code_order}} <br> <b class="about-order" @click="seethisOrder(order.o_code_order)">ดูเพิ่มเติม</b> </td>
                        <td>{{order.o_total_price}} ฿</td>
                        <td>
                            <div v-for=" os in Order_Status " v-if="os.os_id == order.o_status_id">
                                {{os.os_title}}
                            </div>
                        </td>
                        <td>{{order.o_create_date}}</td>            
                    </tr>
                </table> <br><br>
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
                    <button type="button" class="btn btn-light" @click="seenextPage(length_page)" title="Last page">>></button>
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
            data_in_page: 20,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: []
        };
    },
    methods:{
        seenextPage(num_page) {
            this.$router.push({
                name: "my_order_history",
                params: { Page: num_page }
            });
        },
        page_order(){
            this.$router.push('/my_order')
        },
        page_cart(){
            this.$router.push('/my_cart')
        },
        seethisOrder(this_order){
            this.$router.push({name:'order',params:{CodeOrder:this_order}});
        },
    },
    computed:{
        Order(){
            var setpage = this.$route.params.Page;
            var my_order_all = this.$store.getters.getMy_Order[1];
            var p_conpute = 2;
            var p_start = setpage;
            var p_end = Math.ceil(setpage / 1 + p_conpute);

            this.page = setpage - 1;
            this.length_page = Math.ceil(my_order_all.length / this.data_in_page); // set page all
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
            return my_order_all
        },
        Order_Status(){
            return this.$store.getters.getOrder_Status          
        }
    },
    created(){
      this.$store.dispatch("initDataOrders")    
      this.$store.dispatch("initDataOrder_Items")    
      this.$store.dispatch("initDataOrder_Status")    
    }
}
</script>
