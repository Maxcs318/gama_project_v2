<template>
    <div class="container ">
        <div class="row">
            <div class="col-lg-8 col-xs-12"></div>
            <div class="col-lg-2 col-xs-12"> 
                <button type="button" class="form-control btn-primary" @click="page_order_history"> ประวัติใบสั่งซื้อ </button> <br>
            </div>
            <div class="col-lg-2 col-xs-12"> 
                <button type="button" class="form-control btn-success" @click="page_cart"> ตะกร้า </button> <br>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <center><h5 class="header">ใบสั่งซื้อของฉัน</h5></center>
                <br>
                <table class="table" style="width:100%; text-align: center;">
                    <tr>
                        <th> ลำดับ </th>
                        <th> รหัสใบสั่งซื้อ </th>
                        <th> ราคารวม </th>
                        <th> สถานะใบสั่งซื้อ </th>
                        <th> วันที่สร้าง </th>
                        <th></th>
                        <th></th>
                    </tr>
                    <tr v-for="(order,index) in Order " :key="index">
                        <td>{{index+1}}</td>
                        <td>{{order.o_code_order}} <br> <b class="about-order" @click="seethisOrder(order.o_code_order)">ดูเพิ่มเติม</b> </td>
                        <td>{{order.o_total_price}}</td>
                        <td>
                            <div v-for=" os in Order_Status " v-if="os.os_id == order.o_status_id">
                                {{os.os_title}}
                            </div>
                        </td>
                        <td>{{order.o_create_date}}</td>
                        <td> 
                            <button type="button" class="form-control btn-primary" @click="Pay_This(order.o_id,order.o_code_order)"> ชำระเงิน </button> 
                        </td>
                        <td> 
                            <button type="button" class="form-control btn-danger" @click="Delete_Order(order.o_id,order.o_code_order)"> ละทิ้ง </button> 
                        </td>        
                    </tr>
                </table> <br><br>
            </div>            
        </div>
    </div>
</template>
<script>
export default {
    methods:{
        page_cart(){
            this.$router.push('my_cart')
        },
        page_order_history(){
            this.$router.push('my_order_history/1')
        },
        seethisOrder(this_order){
            this.$router.push({name:'order',params:{CodeOrder:this_order}});
        },
        Pay_This(order_id,order_code){
            this.$router.push({name:'payment',params:{CodeOrder:order_code}});
        },
        Delete_Order(order_id,order_code){
            this.$swal({
                title: "Are you sure?",
                text: "You want Delete This Order Code : "+order_code,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    // console.log('delete',order_id)
                    var FD  = new FormData()
                    FD.append('orderID',order_id)            
                    FD.append('own_id',JSON.stringify(this.$store.state.log_on))
                    this.$store.dispatch("Delete_My_Order",FD)
                    swal({title: "Delete Order Success.",icon: "success",});
                }
            })
            
        }
    },
    computed:{
        Order(){
            return this.$store.getters.getMy_Order[0]          
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

