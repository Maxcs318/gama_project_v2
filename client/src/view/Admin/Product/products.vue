<template>
    <div class="container" v-if="the_user">
        <h4 class="header">สินค้าทั้งหมด</h4> <br>
        <div class="row">
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="go_product_category">ประเภทสินค้า</button><br>
            </div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="addproduct">เพิ่มสินค้า</button> <br>
            </div>
            <div class="col-lg-6 col-12">
                <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากสินค้าทั้งหมด">
                <p v-if="searching!=''" style="text-align: right;"> <br>
                เจอทั้งหมด {{find}} รายการ
                </p>    
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">ชื่อสินค้า</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:9%">  </th>
                        <th style="width:2%">  </th>
                        <th style="width:9%">  </th>
                    </tr>
                    <tr v-for="(product,index) in ProductAll" :key="index" >
                        <td>{{product.p_id}}</td>
                        <td>{{product.p_name.slice(0,35)}}</td>
                        <td>{{product.p_create_date}}</td>
                        <td>{{product.p_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editProduct(product.p_id)">แก้ไข</button> </td>
                        <td></td>
                        <td> <button class="form-control btn-danger" @click="deleteProduct(product.p_id)">ลบ</button> </td>
                    </tr>
                </table>
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
            data_product:'',
            data_size:'',
            product_category:'',
            data_load:false,
            page: 0,
            data_in_page: 10,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            searching:'',
            find:null,

            data_product_category:'',
            data_load_category:false,

            check_product:null,
            data_check_product:0
        };
    },
    methods:{
        go_product_category(){
            this.$router.push('/AdminPC');
        },
        addproduct(){
            this.$router.push('/addproduct');
        },
        seenextPage(num_page) {
            this.$router.push({
                name: "AdminP",
                params: { Page: num_page }
            });
        },
        editProduct(thisproduct){
            this.$router.push({name:'editproduct',params:{ProductID:thisproduct}});
        },
        deleteProduct(thisproduct){
            // console.log(thisproduct)
            axios.get(this.$store.getters.getBase_Url+'Product/check_product_and_order_item/'+thisproduct)
            .then(response => {
                // console.log(response.data)
                this.data_check_product = response.data,   
                this.check_product = 'success'
            })
    
            setTimeout(() => {
                if(this.data_check_product == 0 && this.check_product == 'success'){
                    var FD  = new FormData()
                    FD.append('productID',JSON.stringify(thisproduct))
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$swal({
                        title: "Are you sure?",
                        text: "You want delete this Product ID "+thisproduct,
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        
                        if (willDelete) {
                            this.$store.dispatch("Delete_Product",FD)
                            swal({title: "Delete Success.",icon: "success",});
                            setTimeout(() => {
                                this.searching=''
                                this.data_load=false
                            },100);
                        } else {
                            // swal("Your imaginary file is safe!");
                        }
                    })            
                }else{
                    swal({title: "สินค้านี้ ไม่สามารถลบได้",text: "เนื่องจากสินค้าถูกสั่งซื้อไปแล้ว การลบ อาจทำให้ข้อมูลเสียหาย",icon: "warning",});
                }
            },100);
            this.data_check_product = 0   
            this.check_product = null
        }
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
        searching(){
            this.do_search
        },
        product_category(){
            this.do_search
        }
    },
    computed:{
        Product_Category(){
            if(this.data_load_category==false){
                axios.get(this.$store.getters.getBase_Url+'Product/get_all_product_category')
                .then(response => {
                    // console.log(response.data)
                    this.data_product_category = response.data
                })
                this.data_load_category = true
            }
            var product_category_all = this.data_product_category
            return product_category_all
        },
        ProductAll(){
            var setpage = this.$route.params.Page;
            this.product_category = 'all';
            if(this.data_load==false && this.searching == ''){
                axios.get(this.$store.getters.getBase_Url+'Product/get_product/'+this.data_in_page+'/'+this.product_category+'/'+setpage)
                .then(response => {
                    // console.log(response.data),
                    this.data_size = response.data[0],
                    this.data_product = response.data[1]
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
            return this.data_product;
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }
            return user
        },
        do_search(){
            if(this.searching[0] == ' '){
                this.searching = ''
            }
            if(this.searching.length>0){
                var search = encodeURI(this.searching);
                axios.get(this.$store.getters.getBase_Url+'Product/get_all_product_like/'+this.product_category+'/'+search)
                .then(response => {
                    // console.log(response.data)
                    this.data_size = 0,
                    this.find = response.data[0],
                    this.data_product = response.data[1]
                })
                this.length_page = 0;
            }else{
                this.data_load = false;
                this.find = null;
            }
        }
    }
}
</script>

