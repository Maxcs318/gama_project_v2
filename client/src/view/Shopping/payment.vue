<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-xs-12"></div>
            <div class="col-lg-4 col-xs-12">
                <form @submit.prevent="submitPay">  
                    <h5><center>Order Code : {{Order.o_code_order}} <br> Price : {{Order.o_total_price}} ฿</center></h5>                    
                    Title
                    <input type="text" class="form-control" v-model="money_transfer.mtf_title" ><br>
                    <div v-if="Payment!=''">
                        Payment
                        <select class="form-control" v-model="money_transfer.mtf_payments_id" >
                            <option selected disabled value=""> - - No Select - - </option>
                            <option v-for="(pay ,index) in Payment" :key="index" :value="pay.pm_id" >
                                {{ pay.pm_title }}
                            </option>
                        </select>
                    </div>
                    <div v-if="money_transfer.mtf_payments_id==1">
                        <br>
                        Banking
                        <select class="form-control" v-model="money_transfer.mtf_banking_id" >
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
                            <button type="button" class="form-control btn-success col-lg-6" @click="ChooseFilesImage"> Choose Image Slip </button>
                            <input id="chooseImage" ref="filesimage" style="display: none;" type="file" @change="handleFilesImage">
                            <br>
                    <p v-if="date_now!=''"> Transfer Date : {{money_transfer.mtf_date}} </p>
                    <date-pick  
                                size="large" v-model="money_transfer.mtf_date" 
                                :pickTime="true" :format="'DD-MM-YYYY HH:mm'"
                                :inputAttributes="{readonly: true}"
                     ></date-pick>
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
            var FD  = new FormData()
            FD.append('userfile',this.fileimage)
            FD.append('money_transfer',JSON.stringify(this.money_transfer))
            FD.append('order',JSON.stringify(this.Order))           
            FD.append('own_id',JSON.stringify(this.$store.state.log_on))
            this.$store.dispatch("Money_Transfer_Insert",FD)
            swal({title: "Confirm Success.",icon: "success",});
            this.$router.push({name:'order',params:{CodeOrder:this.Order.o_code_order}})
        },
        back_to_see_list(){
            this.$router.go(-1)
        },
    },
    computed:{
        Order(){
            var od = this.$store.getters.getMy_Order[0] 
            for(var i=0; i<od.length; i++){
                if(od[i].o_code_order == this.$route.params.CodeOrder){
                    return od[i]
                }
            }
            // return this.$router.go(-1)
        },
        Payment(){
            return this.$store.getters.getPayments
        },
        Banking(){
            return this.$store.getters.getBanking
        },
        date_now(){
            var today = new Date();
            var date = today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+' '+today.getHours() + ":" + today.getMinutes();
                this.money_transfer.mtf_date = date
            return date
        }
    },
    created(){
      this.$store.dispatch("initDataPayment")
      this.$store.dispatch("initDataBanking")
    }
}
</script>

