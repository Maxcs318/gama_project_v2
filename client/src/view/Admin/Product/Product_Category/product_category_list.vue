<template>
    <div class="container" v-if="the_user">
        <h4 class="header">ประเภท สินค้า</h4> <br>
        <div class="row">
            <div class="col-lg-9 col-xs-12"></div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="add_product_category">เพิ่มประเภทสินค้า</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">ชื่อประเภทสินค้า</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(product,index) in product_category" :key="index" >
                        <td>{{product.pc_id}}</td>
                        <td>{{product.pc_title.slice(0,35)}}</td>
                        <td>{{product.pc_create_date}}</td>
                        <td>{{product.pc_update_date}}</td>
                        <td> 
                            <button v-if="product.pc_id != 1 && product.pc_id != 2" class="form-control btn-warning" @click="editProduct_Category(product.pc_id)">แก้ไข</button> 
                            <button v-else class="form-control btn-dark">Don't edit</button> 
                        </td>
                        <td> 
                            <button v-if="product.pc_id != 1 && product.pc_id != 2" class="form-control btn-danger"  @click="deleteProduct_Category(product.pc_id)">ลบ</button> 
                            <button v-else class="form-control btn-dark"> Don't delete </button> 
                        </td>
                    </tr>
                </table>
                <br>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data() {
        return {
            data_product_category:'',
            data_load:false,

            data_check_product_category:0,
            check_product_category:null
        };
    },
    methods:{
        add_product_category(){
            this.$router.push('/addproduct_category')
        },
        editProduct_Category(this_product_category){
            this.$router.push({name:'editproduct_category',params:{Product_CategoryID:this_product_category}});
        },
        deleteProduct_Category(this_product_category){

            axios.get(this.$store.getters.getBase_Url+'Product/check_product_and_product_category/'+this_product_category)
            .then(response => {
                // console.log(response.data)
                this.data_check_product_category = response.data,   
                this.check_product_category = 'success'
            })
            setTimeout(() => {
                if(this.data_check_product_category == 0 && this.check_product_category == 'success'){
                    var FD  = new FormData()
                    FD.append('product_categoryID',JSON.stringify(this_product_category))
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$swal({
                        title: "Are you sure?",
                        text: "You want delete this Product Category ID "+this_product_category,
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        if (willDelete) {
                            this.$store.dispatch("Delete_Product_Category",FD)
                            swal({title: "Delete Success.",icon: "success",});
                            setTimeout(() => {
                                this.data_load=false
                            },100);
                        } else {
                            // swal("Your imaginary file is safe!");
                        }
                    })
                }else{
                    swal({title: "ประเภทสินค้านี้ ไม่สามารถลบได้",text: "เนื่องจากมี สินค้า บางรายการใช้ประเภทสินค้านี้อยู่",icon: "warning",});
                }
            },100);
            this.data_check_product_category = 0   
            this.check_product_category = null
        }
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
    },
    computed:{
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }            
            return user
        },
        product_category(){
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+'Product/get_all_product_category')
                .then(response => {
                    // console.log(response.data)
                    this.data_product_category = response.data
                })
                this.data_load = true
            }
            var product_category_all = this.data_product_category
            return product_category_all
        }
    }
}
</script>