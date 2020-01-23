<template>
    <div class="container ">
        <h4>Product</h4> 
        <div class="row">
            <div class="col-lg-12">
                <select v-model="selected" class="form-control">
                    <option selected value>สินค้าทั้งหมด</option>
                    <option v-for=" pc in Product_Category " :value="pc.pc_id">{{pc.pc_title}}</option>
                </select>
                <br />
            </div>
        </div>
        <div class="row">
            <div class="col-lg-3 col-xs-12" v-for="(product,index) in ProductAll.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)" :key="index">
                <img :src="getImgUrlProduct(product.p_image)" width="100%" @click="seethisPageProduct(product.p_id)">
                <h5 @click="seethisPageProduct(product.p_id)">{{product.p_name}}</h5>
                <p style="text-align: center;">{{product.p_price}} ฿</p>
                    <div v-for="PC in Product_Category">
                        <p style="text-align: right;" v-if="product.p_category == PC.pc_id">
                            {{PC.pc_title}}
                        </p>
                    </div>
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
export default {
    data() {
        return {
            page: 0,
            data_in_page: 12,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],

            selected:''
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
    },
    computed:{
        Product_Category(){
            return this.$store.getters.getProduct_Category;
        },
        ProductSelected(){
            var products = this.$store.getters.getProduct
            var product_selected = products
                if (this.selected == '') {
                    return products
                } else {
                    return products.filter(item => {
                        return item.p_category.indexOf(this.selected) > -1;
                    });                
                }
        },
        ProductAll(){
            var setpage = this.$route.params.Page;
            var product_all = this.ProductSelected
            var p_conpute = 2;
            var p_start = setpage;
            var p_end = Math.ceil(setpage / 1 + p_conpute);

            this.page = setpage - 1;
            this.length_page = Math.ceil(product_all.length / this.data_in_page); // set page all
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
            return product_all
        },
        path_files(){
            return this.$store.getters.getPath_Files
        }
    },
    created(){
        this.$store.dispatch("initDataProduct")
        this.$store.dispatch("initDataProduct_Category")
        this.$store.dispatch("initDataProduct_Image")
    }
}
</script>

