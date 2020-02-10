<template>
    <div class="container" v-if="the_user">
        <h4 class="header">ประเภท บทความ</h4> <br>
        <div class="row">
            <div class="col-lg-9 col-xs-12"></div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="add_article_category">เพิ่มประเภท ของบทความ</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">หัวข้อประเภทบทความ</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(article,index) in article_category" :key="index" >
                        <td>{{article.ac_id}}</td>
                        <td>{{article.ac_title.slice(0,35)}}</td>
                        <td>{{article.ac_create_date}}</td>
                        <td>{{article.ac_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editArticle_Category(article.ac_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger"  @click="deleteArticle_Category(article.ac_id)">ลบ</button> </td>
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
            data_load:false,
            data_article_category:'',

            data_check_article_category:0,
            check_article_category:null
        };
    },
    methods:{
        add_article_category(){
            this.$router.push('/addarticle_category')
        },
        editArticle_Category(this_article){
            this.$router.push({name:'editarticle_category',params:{Article_CategoryID:this_article}});
        },
        deleteArticle_Category(this_article){
            // console.log(this_article)
            axios.get(this.$store.getters.getBase_Url+'Article/check_article_and_article_category/'+this_article)
            .then(response => {
                // console.log(response.data)
                this.data_check_article_category = response.data,   
                this.check_article_category = 'success'
            })
            setTimeout(() => {
                if(this.data_check_article_category == 0 && this.check_article_category == 'success'){
                    var FD  = new FormData()
                    FD.append('article_categoryID',JSON.stringify(this_article))
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$swal({
                        title: "Are you sure?",
                        text: "You want delete this Article Category ID "+this_article,
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        if (willDelete) {
                            this.$store.dispatch("Delete_Article_Category",FD)
                            swal({title: "Delete Success.",icon: "success",});
                            setTimeout(() => {
                                this.data_load=false
                            },100);
                        } else {
                            // swal("Your imaginary file is safe!");
                        }
                    })
                }else{
                    swal({title: "ประเภทบทความนี้ ไม่สามารถลบได้",text: "เนื่องจากมี บทความ บางรายการใช้ประเภทบทความนี้อยู่",icon: "warning",});
                }
            },100);
            this.data_check_article_category = 0   
            this.check_article_category = null
        }
    },
    computed:{
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }            
            return user
        },
        article_category(){
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+"Article/get_all_article_category")
                .then(response => {
                    // console.log(response)
                    this.data_article_category = response.data
                })
                this.data_load=true
            }
            var category_all = this.data_article_category
            return category_all
        }
    }
}
</script>