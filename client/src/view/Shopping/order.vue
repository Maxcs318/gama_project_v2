<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <h5><center> Code Order : {{this.$route.params.CodeOrder}} </center></h5>
            </div>
        </div>
        <div class="row" v-if="Order">
            <div class="col-lg-12 col-xs-12">
                <table class="table" style="width:100%; text-align: center;" v-if="Order">
                    <tr>
                        <th> Product </th>
                        <th> Price </th>
                        <th> Quantity </th>
                        <th> Total Price </th>
                    </tr>
                    <tr v-for="order_item in data_order_items">
                        <td>{{order_item.oi_product_id}}</td>
                        <td>{{order_item.oi_product_price}}</td>
                        <td>{{order_item.oi_quantity}}</td>
                        <td>{{order_item.oi_total_price}}</td>
                    </tr>
                </table>
                <br>
                <center>
                Total Price : {{ Order.o_total_price }} ฿ <br>
                Status : {{data_order_status.os_title}}
                <!-- Order Create Date : {{ Order.o_create_date }}<br> -->
                </center>
                <br>
                    <div class="row">
                        <div class="col-lg-4 col-xs-12" v-if="data_moneytransfer">
                            <img :src="getImgUrl(data_moneytransfer.mtf_slip)" width="100%"> 
                        </div>
                        <div class="col-lg-4 col-xs-12" v-if="data_moneytransfer">
                            <h5>Money Transfer</h5>
                            TiTle : {{data_moneytransfer.mtf_title}}<br>
                            Payment : {{data_payment.pm_title}}<br>
                            <div v-if="data_banking != false"> Banking : {{data_banking.b_name}} </div>
                            Payment Date : {{data_moneytransfer.mtf_date}}<br>
                            Comment : {{data_moneytransfer.mtf_comment}}<br>
                        </div>
                        <div class="col-lg-4 col-xs-12">
                            <h5>Shipping Address</h5>
                            Title : {{data_shipping_address.sa_title}} <br>
                            Address : {{data_shipping_address.sa_address}} <br>
                            Postcode : {{data_shipping_address.sa_postcode}} <br>
                            Company : {{data_shipping_address.sa_company}} <br>
                            E-mail : {{data_shipping_address.sa_email}} <br>
                            Phone : {{data_shipping_address.sa_phone}} <br>
                        </div>
                        <div class="col-lg-12 col-xs-12">   <br>
                            Order Create On : {{Order.o_create_date}}<br>
                            Status Order Last Update : {{Order.o_update_date}}
                        </div>
                    </div>
                <br>
            </div>
            <div class="col-lg-12 col-xs-12" v-if="Order && Order.o_status_id >=3">
                <div class="row">
                    <div class="col-lg-9"></div>
                    <div class="col-lg-3">
                        <button class="form-control btn-primary" @click="show_bill"> Bill </button> <br>
                    </div>
                </div>
            </div>

        </div>
        <div class="row" v-else>
            <div class="col-lg-12 col-xs-12">
                <br>
                <h5><center> Order Error. Order May Not Have .  </center></h5>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return{
            data_order:'',
            data_order_status:'',
            data_order_items:'',
            data_shipping_address:'',
            data_moneytransfer:'',
            data_payment:'',
            data_banking:'',

            data_load:false
      }
    },
    methods:{
        getImgUrl(pic) {
            return this.path_files+'Slip/'+pic
        },
        show_bill(){
            this.$router.push({name:'bill',params:{CodeOrder:this.$route.params.CodeOrder}});
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
        path_files(){
            return this.$store.getters.getPath_Files
        },
        Order(){
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
                this.data_load = true
            }
            return this.data_order
        }
    }
    
}
</script>
