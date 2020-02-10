<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <h5 @click="show_bill"><center> Bill : {{this.$route.params.CodeOrder}} </center></h5>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4"></div>
            <div class="col-lg-4" v-if="Order && Order.o_status_id >= 3">
                <br>
                <button class="form-control btn-primary" @click="show_bill"> Print Bill </button> 
                <br>
            </div>
            <div class="col-lg-4"></div>
        </div>
        <div id="print" v-if="Order!=0 && data_shipping_address && data_moneytransfer && data_payment"
        style="
                width: 21cm;
                min-height: 0.01cm;
                background-color: white; color:black;
                margin: auto;
            ">
<!-- ================================================================================= -->
<!-- ================================================================================= -->
       <div class="">
            <div class="col-12">
                <br>
                <center><h3> Gama Thailand </h3></center>
                <div class="row">
                    <div class="col-1"></div>
                    <div class="col-5">
                        388 อาคารอามีโก้ ชั้น 19 โซนบี/1 ถนนสี่พระยา <br>
                        แขวงมหาพฤฒาราม เขตบางรัก <br>
                        จังหวัด กรุงเทพมหานครฯ
                    </div>
                    <div class="col-1"></div>
                    <div class="col-5">
                        <!-- เบอร์โทรติดต่อ<br> -->
                        โทรศัพท์: 02-6318908<br>
                        โทรสาร: 02-6318908<br>
                        E-mail : gamathaiinfo@yahoo.com 
                    </div>
                </div>
                <br>
                <h4 style="padding-left:13.2em"> ใบเสร็จรับเงิน </h4>
                <div class="row">
                    <div class="col-8"></div>
                    <div class="col-4">
                        Order Code : {{this.$route.params.CodeOrder}}   <br>
                        วันที่จ่าย : {{data_moneytransfer.mtf_date}}   <br>
                        ชำระผ่าน : {{data_payment.pm_title}}  <br>
                        <div v-if=" data_banking != false"> Banking : {{data_banking.b_name}} </div>
                    </div>
                </div>
                <div class="row" v-if="data_shipping_address">
                    <div class="col-6 ">
                        ชื่อ : {{data_shipping_address.sa_first_name}} <br>
                        ที่อยู่ : {{data_shipping_address.sa_address}} <br>
                        รหัสไปรษณีย์ : {{data_shipping_address.sa_postcode}} <br>
                    </div>
                    <div class="col-6">
                        บริษัท : {{data_shipping_address.sa_company}} <br>
                        เบอร์โทร : {{data_shipping_address.sa_phone}} <br>
                        E-mail : {{data_shipping_address.sa_email}} <br>
                    </div>
                </div>
                <br>
                <!-- <div class="row">
                    <div class="col-1"> # </div>
                    <div class="col-5"> รายการ </div>
                    <div class="col-2"> ราคา </div>
                    <div class="col-2"> จำนวน </div>
                    <div class="col-2"> เป็นเงิน </div>      
                </div>
                <div class="row" v-for="(order_item,index) in Order_Items" :key="index">
                    <div class="col-1">{{index+1}}</div>
                    <div class="col-5"> {{order_item.oi_product_id}} </div>
                    <div class="col-2"> {{order_item.oi_product_price}} </div>
                    <div class="col-2"> {{order_item.oi_quantity}} </div>
                    <div class="col-2"> {{order_item.oi_total_price}} </div>
                </div> -->
                <div class="row">
                    <div class="col-12">
                        <table style="width:100%;">
                            <tr>
                                <th style="width:5%;"> # </th>
                                <th style="width:50%;"> รายการ </th>
                                <th style="width:15%;"> ราคา </th>
                                <th style="width:15%;"> จำนวน </th>
                                <th style="width:15%;"> เป็นเงิน </th>                            
                            </tr>
                            <tr v-for="(order_item,index) in data_order_items" :key="index">
                                <td>{{index+1}}</td>
                                <td> {{order_item.oi_product_id}} </td>
                                <td> {{order_item.oi_product_price}} </td>
                                <td> {{order_item.oi_quantity}} </td>
                                <td> {{order_item.oi_total_price}} </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-12">
                        <br>
                        <p style="padding-left:19.2em"> รวมทั้งสิ้น  {{ Order.o_total_price }} บาท</p>                        
                        <br> 
                    </div>
                </div>
            </div>
        </div>
<!-- ================================================================================= -->
<!-- ================================================================================= -->
        </div>
        
        <div class="row" v-else>
            <div class="col-lg-12 col-xs-12">
                <br>
                <h5><center> Order Error. Order May Not Have .  </center></h5>
            </div>
        </div>
        <br>
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
            // let pdfName = this.$route.params.CodeOrder; 
            // var doc = new jsPDF('p', 'mm', 'a4');
            // doc.fromHTML(document.getElementById('print'), 15, 15);
            // doc.save(pdfName + '.pdf');

            // ===========================================================

            html2canvas(document.getElementById("print"), {
                useCORS: true,
                onrendered: function(canvas) {
                    var imgData = canvas.toDataURL('image/jpeg');
                    // console.log('Report Image URL: '+imgData);
                    var doc = new jsPDF('p', 'mm', 'a4');
                    doc.addImage(imgData, 'jpeg', 0, 0);
                    doc.save('Gama_bill.pdf');
                }
            });

            // ===========================================================
        
            // const filename  = 'ThisIsYourPDFFilename.pdf';
            // html2canvas(document.querySelector('#print'),{
            //     onrendered: function(canvas) {
            //         let pdf = new jsPDF('p', 'mm', 'a4');
            //         pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, 0, 0);
            //         pdf.save(filename);
            //     }
            // });
         
        },
        
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        }
    },
    computed:{
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
<style>
    /* #print{
        font-family: Arial;
    } */
</style>
