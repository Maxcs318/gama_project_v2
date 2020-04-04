<template>
    <div class="container ">
        <h4><center>สินค้า</center></h4> <br>
        <div class="row">
            <div class="col-lg-6 col-12">
                <select v-model="product_category" class="form-control select" @click="changeCategory(product_category)">
                    <option selected value='all'>สินค้าทั้งหมด</option>
                    <option v-for=" pc in Product_Category " :value="pc.pc_id">{{pc.pc_title}}</option>
                </select>
                <br />
            </div>
            <div class="col-lg-6 col-12">
                <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากสินค้าทั้งหมด">
                <p v-if="searching!=''" style="text-align: right;"> <br>
                เจอทั้งหมด {{find}} รายการ
                </p>    
                <br>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-xs-12" v-for="(product,index) in ProductAll" :key="index">
                <img :src="getImgUrlProduct(product.p_image)" width="100%" class="hv-eff" @click="seethisPageProduct(product.p_id)">
                <h5 @click="seethisPageProduct(product.p_id)">{{product.p_name}}</h5>
                <p style="text-align: center;">{{product.p_price}} ฿</p>
                    <!-- <div v-for="PC in Product_Category">
                        <p style="text-align: right;" v-if="product.p_category == PC.pc_id">
                            {{PC.pc_title}}
                        </p>
                    </div> -->
                <br>
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
            data_in_page: 12,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            searching:'',
            find:null,

            data_product_category:'',
            data_load_category:false
        };
    },
    methods:{
        getImgUrlProduct(picP) {
            return this.path_files+'Product/'+picP
        },
        seenextPage(num_page) {
            this.$router.push({
                name: "productall",
                params: { Page: num_page }
            });
        },
        seethisPageProduct(thisproduct){
            this.$router.push({name:'product',params:{ProductID:thisproduct}});
        },
        changeCategory(selected_category){
            if(this.product_category != this.$route.params.ProductCategory ){
                this.$router.push({
                name: "productall",
                params: { ProductCategory: selected_category,Page: 1 }
                });
            }
        },
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
            var setcategory = this.$route.params.ProductCategory;
            this.product_category = setcategory;
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
        path_files(){
            return this.$store.getters.getPath_Files
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

