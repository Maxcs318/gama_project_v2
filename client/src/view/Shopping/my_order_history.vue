<template>
    <div class="container" v-if="this.the_user">
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
                        <th> รหัสใบสั่งซื้อ </th>
                        <th> ราคารวม </th>
                        <th> สถานะใบสั่งซ์้อ </th>
                        <th> วันที่เผยแพร่ </th>
                    </tr>
                    <tr v-for="(order,index) in Order" :key="index">
                        <td>{{(data_size- page*data_in_page) - index}}</td>
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
import axios from "axios";
export default {
    data() {
        return {
            data_order:'',
            data_size:'',
            data_load:false,
            page: 0,
            data_in_page: 10,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            
            searching:'',
            find:null,

            data_order_status:'',
            data_load_order_status:false
                    
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
    watch:{
        $route (to, from){
            this.data_load = false;
        },
        the_user(){
            this.data_load = false;
        }
    },
    computed:{
        the_user(){
            return this.$store.getters.getThe_User;
        },
        Order(){
            var setpage = this.$route.params.Page;
            if(this.data_load==false){
                var FD = new FormData();
                FD.append("myID", JSON.stringify(this.the_user.m_id));
                FD.append("number_of_row", JSON.stringify(this.data_in_page));
                FD.append("pagenow", JSON.stringify(setpage));
                FD.append("order_status_id", JSON.stringify(2));

                axios.post(this.$store.getters.getBase_Url+'Order/get_my_order',FD)
                .then(response => {
                    // console.log(response.data),
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
        Order_Status(){
            if(this.data_load_order_status==false){
                axios.get(this.$store.getters.getBase_Url+"Order/get_all_order_status")
                .then(response => {
                    // console.log(response.data)
                    this.data_order_status = response.data
                })
                this.data_load_order_status=true
            }
            var order_status_all = this.data_order_status
            return order_status_all         
        }
    }
}
</script>
