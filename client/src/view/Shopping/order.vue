<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <h5><center> Code Order : {{this.$route.params.CodeOrder}} </center></h5>
                <!-- {{Order_Status}} -->
            </div>
        </div>
        <div class="row" v-if="Order!=0 && Shipping_Address">
            <div class="col-lg-12 col-xs-12">
                <table class="table" style="width:100%; text-align: center;" v-if="Order">
                    <tr>
                        <th> Product </th>
                        <th> Price </th>
                        <th> Quantity </th>
                        <th> Total Price </th>
                    </tr>
                    <tr v-for="order_item in Order_Items">
                        <td>{{order_item.oi_product_id}}</td>
                        <td>{{order_item.oi_product_price}}</td>
                        <td>{{order_item.oi_quantity}}</td>
                        <td>{{order_item.oi_total_price}}</td>
                    </tr>
                </table>
                <br>
                <center>
                Total Price : {{ Order.o_total_price }} ฿ <br>
                <div v-for="os in Order_Status" v-if="os.os_id == Order.o_status_id">Status : {{os.os_title}} </div>
                <!-- Order Create Date : {{ Order.o_create_date }}<br> -->
                </center>
                <br>
                    <div class="row">
                        <div class="col-lg-4 col-xs-12" v-if="Moneytransfer && Banking && Payment">
                            <img :src="getImgUrl(Moneytransfer.mtf_slip)" width="100%"> 
                        </div>
                        <div class="col-lg-4 col-xs-12" v-if="Moneytransfer && Banking && Payment">
                            <h5>Money Transfer</h5>
                            TiTle : {{Moneytransfer.mtf_title}}<br>
                            Payment : {{Payment.pm_title}}<br>
                            <div v-if="Banking != 'No'"> Banking : {{Banking.b_name}} </div>
                            Payment Date : {{Moneytransfer.mtf_date}}<br>
                            Comment : {{Moneytransfer.mtf_comment}}<br>
                        </div>
                        <div class="col-lg-4 col-xs-12" v-if="Shipping_Address">
                            <h5>Shipping Address</h5>
                            Title : {{Shipping_Address.sa_title}} <br>
                            Address : {{Shipping_Address.sa_address}} <br>
                            Postcode : {{Shipping_Address.sa_postcode}} <br>
                            Company : {{Shipping_Address.sa_company}} <br>
                            E-mail : {{Shipping_Address.sa_email}} <br>
                            Phone : {{Shipping_Address.sa_phone}} <br>
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
export default {
    methods:{
        getImgUrl(pic) {
            return this.path_files+'Slip/'+pic
        },
        show_bill(){
            this.$router.push({name:'bill',params:{CodeOrder:this.$route.params.CodeOrder}});
        },
        
    },
    computed:{
        path_files(){
            return this.$store.getters.getPath_Files
        },
        Order(){
            var od = this.$store.getters.getOrder 
            var x
            for(var i=0; i<od.length; i++){
                if(od[i].o_code_order == this.$route.params.CodeOrder){
                    x = od[i]
                }
            }
            return x 
        },
        Order_Status(){
            return this.$store.getters.getOrder_Status 
        },
        Order_Items(){
            var odi = this.$store.getters.getOrder_Item
            var order_i=[]
            var product_all = this.$store.getters.getProduct
                for(var i=0;i<odi.length; i++){
                    if(odi[i].oi_order_id == this.Order.o_id){
                        // chang product id -> product name
                        for(var j=0; j<product_all.length; j++){
                            if(product_all[j].p_id == odi[i].oi_product_id){
                                odi[i].oi_product_id = product_all[j].p_name
                            }
                        }
                        order_i.push(odi[i])
                    }   
                }
            return order_i
        },
        Shipping_Address(){
            var my_sa = this.$store.getters.getShipping_Address
            var sa_this_order
            for(var i=0; i<my_sa.length; i++){
                if(my_sa[i].sa_id == this.Order.o_shipping_address_id){
                    sa_this_order = my_sa[i]
                }
            }
            return sa_this_order
        },
        Moneytransfer(){
            var money = this.$store.getters.getMoney_Transfer
            var this_money
                for(var i=0;i<money.length;i++){
                    if(money[i].mtf_id == this.Order.o_money_transfer_id){
                        this_money = money[i]
                    }
                }
            return this_money
        },
        Payment(){
            var pm = this.$store.getters.getPayments
            var mtf = this.Moneytransfer
            var this_pm
                for(var j=0;j<pm.length;j++){
                    if(mtf.mtf_payments_id == pm[j].pm_id){
                        this_pm = pm[j]
                    }
                }
            return this_pm
        },
        Banking(){
            var bk = this.$store.getters.getBanking
            var mtf = this.Moneytransfer
            var this_bk
            if(mtf.mtf_banking_id >0){
                for(var j=0;j<bk.length;j++){
                    if(mtf.mtf_banking_id == bk[j].b_id){
                        this_bk = bk[j]
                    }
                }
            }else{
                this_bk = 'No'
            }
            return this_bk
        }
    },
    created(){
        this.$store.dispatch("initDataShipping_Address")
        this.$store.dispatch("initDataPayment")
        this.$store.dispatch("initDataBanking")
        this.$store.dispatch("initDataMoney_Transfer")
    }
    
}
</script>
