<template>
    <div class="container">
        <div class="row" v-if="Order">
            <div class="col-lg-4 col-xs-12"></div>
            <div class="col-lg-4 col-xs-12">
                <form @submit.prevent="submitPay">  
                    <h5><center>Order Code : {{Order.o_code_order}} <br> Price : {{Order.o_total_price}} ฿</center></h5>    
                    <br>
                    <h5>กรุณากรอกข้อมูลใน <b class="alert-required">( * )</b> ให้ครบถ้วน</h5>
                    <br>
                    Title <b class="alert-required"> * </b>
                    <input type="text" class="form-control" v-model="money_transfer.mtf_title" required ><br>
                    <div v-if="Payment!=''">
                        Payment <b class="alert-required"> * </b>
                        <select class="form-control" v-model="money_transfer.mtf_payments_id" required >
                            <option selected disabled value=""> - - No Select - - </option>
                            <option v-for="(pay ,index) in Payment" :key="index" :value="pay.pm_id" >
                                {{ pay.pm_title }}
                            </option>
                        </select>
                    </div>
                    <div v-if="money_transfer.mtf_payments_id==1">
                        <br>
                        Banking <b class="alert-required"> * </b>
                        <select class="form-control" v-model="money_transfer.mtf_banking_id" required>
                            <option disabled selected value=""> - - No Select - - </option>
                            <option v-for="(bk ,index) in Banking" :key="index" :value="bk.b_id"  @click="select_banking(bk)">
                                {{ bk.b_name }}
                            </option>
                        </select>
                        <br>
                        <div v-if="money_transfer.mtf_banking_id !=''" v-for="bk_show in Banking">
                            <div v-if="bk_show.b_id==money_transfer.mtf_banking_id">
                                Bank Name : {{bk_show.b_name}} <br>
                                Account Name : {{bk_show.b_account_name}} <br>
                                Account Number : {{bk_show.b_account_number}} <br>
                                Description : {{bk_show.b_description}}
                            </div>
                        </div>
                    </div>
                    <div v-if="money_transfer.mtf_payments_id==2">
                        <br>
                        <a :href="Payment[1].pm_description" target="_blank"> Paypal Account </a>
                    </div>
                            <br>
                            <center>                            
                                <img v-if="url"  :src="url" width="100%"/>
                            </center>
                            <br>
                            <center>
                                <button type="button" class="form-control btn-success col-lg-7" @click="ChooseFilesImage"> Choose Image Slip <b class="alert-required"> * </b></button>
                            <input id="chooseImage" ref="filesimage" style="display: none;" type="file" @change="handleFilesImage" >
                            </center>
                            <br>
                    <!-- <p v-if="date_now!=''"> -->
                    <p > Transfer Date : {{money_transfer.mtf_date}} </p>
                    <date-pick  
                                size="large" v-model="money_transfer.mtf_date" 
                                :pickTime="true" :format="'DD-MM-YYYY HH:mm'"
                                :inputAttributes="{readonly: true}"
                     ></date-pick> <b class="alert-required"> * </b>
                    <br><br>

                    Comment
                    <textarea class="form-control" rows="5" v-model="money_transfer.mtf_comment" ></textarea>
                    <br>
                    <div class="row">
                        <div class="col-lg-6 col-xs-12">
                            <button type="button" class="form-control btn-danger" @click="back_to_see_list">Back</button>
                            <br>
                        </div>
                        <div class="col-lg-6 col-xs-12">
                            <button type="submit" class="form-control btn-primary" >Confirm</button>
                            <br>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-4 col-xs-12"></div>
        </div>
    </div>
</template>
<style>
    input { font-size:14px; }
</style>

<script>
import DatePick from 'vue-date-pick';
import 'vue-date-pick/dist/vueDatePick.css';
import axios from "axios";

export default {
    data(){
        return{
            select_bk:[],
            money_transfer:{
                mtf_payments_id:'',
                mtf_banking_id:'',
                mtf_title:'',
                mtf_date:'',
                mtf_comment:'',
            },
            url: null,
            fileimage:'',
            check_image:null,
            data_load: false,

            data_order:'',
            data_order_status:'',
            data_order_items:'',
            data_shipping_address:'',
            data_moneytransfer:'',
            data_payment:'',
            data_banking:'',

            data_payment_all:'',
            data_load_payment_all:false,

            data_banking_all:'',
            data_load_banking_all:false
        }
    },
    components: {DatePick},
    methods:{
        // image slip
        ChooseFilesImage(){
            document.getElementById('chooseImage').click()
        },
        handleFilesImage(e){
            if(e.target.files[0]!=''||e.target.files[0]!=null){
                var fileimage = e.target.files[0]
                this.url = URL.createObjectURL(fileimage)
                let uploadedFiles = this.$refs.filesimage.files[0]
                this.fileimage = uploadedFiles
                if(this.fileimage.size>10000000){
                    this.fileimage = []
                    this.url = null
                    this.$swal('Your file is larger than 10 MB. Sorry Choose Again !!!')
                }
            }
        },
        // submit
        submitPay(){
            if(this.fileimage!=''){
                this.check_image=1
            }else{
                this.check_image=null
            }
            if(this.check_image != null){
                if(this.money_transfer.mtf_date != ''){
                    var FD  = new FormData()
                    FD.append('userfile',this.fileimage)
                    FD.append('money_transfer',JSON.stringify(this.money_transfer))
                    FD.append('order',JSON.stringify(this.Order))           
                    FD.append('own_id',JSON.stringify(this.$store.state.log_on))
                    this.$store.dispatch("Money_Transfer_Insert",FD)
                    swal({title: "Confirm Success.",icon: "success",});

                    setTimeout(() => {
                        this.$router.push({name:'order',params:{CodeOrder:this.Order.o_code_order}})
                    },1000);
                }else{
                    this.$swal("กรุณากรอก วัน,เวลาโอน", "", "error")
                }
            }else{
                this.$swal("กรุณาแนบ สลิป เพื่อเป็นหลักฐาน", "", "error")
            }
        },
        back_to_see_list(){
            this.$router.go(-1)
        },
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
    },
    computed:{
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

                    if(response.data[0].o_status_id > 1){
                        this.$router.go(-1)
                        // this.$router.push({name:'order',params:{CodeOrder:this.data_order.o_code_order}})
                    }
                })
                this.data_load = true
            }
            return this.data_order
        },
        Payment(){
            if(this.data_load_payment_all==false){
                axios.get(this.$store.getters.getBase_Url+"Payment/get_all_payment")
                .then(response => {
                    // console.log(response.data)
                    this.data_payment_all = response.data
                })
                this.data_load_payment_all=true
            }
            var payment_all = this.data_payment_all
            return payment_all 
        },
        Banking(){
            if(this.data_load_banking_all==false){
                axios.get(this.$store.getters.getBase_Url+"Banking/get_all_banking")
                .then(response => {
                    // console.log(response.data)
                    this.data_banking_all = response.data
                })
                this.data_load_banking_all=true
            }
            var banking_all = this.data_banking_all
            return banking_all 
        },
        // date_now(){
        //     var today = new Date();
        //     var date = today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+' '+today.getHours() + ":" + today.getMinutes();
        //         this.money_transfer.mtf_date = date
        //     return date
        // }
    }
}
</script>

