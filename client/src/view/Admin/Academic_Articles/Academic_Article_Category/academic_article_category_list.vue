<template>
    <div class="container" v-if="the_user">
        <h4 class="header">ประเภท บทความวิชาการ</h4> <br>
        <div class="row">
            <div class="col-lg-9 col-xs-12"></div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="add_academicarticle_category">เพิ่มประเภท บทความวิชาการ</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%">
                    <tr style="width:100%">
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">ชื่อประเภท บทความวิชาการ</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(AA,index) in academic_article_category" :key="index" >
                        <td>{{AA.aac_id}}</td>
                        <td>{{AA.aac_title.slice(0,35)}}</td>
                        <td>{{AA.aac_create_date}}</td>
                        <td>{{AA.aac_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editAcademicArticle_Category(AA.aac_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger"  @click="deleteAcademicArticle_Category(AA.aac_id)">ลบ</button> </td>
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
    data(){
        return {
            data_academic_article_category:'',
            data_load:false,

            data_check_academic_article_category:0,
            check_academic_article_category:null
        }
    },
    methods:{
        add_academicarticle_category(){
            this.$router.push('/addacademicarticle_category')
        },
        editAcademicArticle_Category(this_academicarticle){
            this.$router.push({name:'editacademicarticle_category',params:{AcademicArticle_CategoryID:this_academicarticle}});
        },
        deleteAcademicArticle_Category(this_academicarticle){
            // console.log(this_academicarticle)
            // this.data_check_academic_article_category = null,this.check_academic_article_category = null
            axios.get(this.$store.getters.getBase_Url+'Academic_article/check_academic_article_and_article_academic_category/'+this_academicarticle)
            .then(response => {
                // console.log(response.data)
                this.data_check_academic_article_category = response.data,   
                this.check_academic_article_category = 'success'
                // console.log(this.data_check_academic_article_category)
                // console.log(this.check_academic_article_category)
                if(this.data_check_academic_article_category == 0 && this.check_academic_article_category == 'success'){
                    // -----
                    var FD  = new FormData()
                    FD.append('academic_article_categoryID',JSON.stringify(this_academicarticle))
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$swal({
                        title: "Are you sure?",
                        text: "You want delete this Academic Article Category ID "+this_academicarticle,
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                    .then((willDelete) => {
                        if (willDelete) {
                            this.$store.dispatch("Delete_Academic_Article_Category",FD)
                            swal({title: "Delete Success.",icon: "success",});
                            setTimeout(() => {
                                this.data_load=false
                            },100);
                        } else {
                            // swal("Your imaginary file is safe!");
                        }
                    })
                }else{
                    swal({title: "ประเภทบทความวิชาการนี้ ไม่สามารถลบได้",text: "เนื่องจากมี บทความวิชาการ บางรายการใช้ประเภทบทความวิชาการนี้อยู่",icon: "warning",});
                }
            })
            // this.data_check_academic_article_category = 0   
            // this.check_academic_article_category = null
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
        academic_article_category(){
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+"Academic_article/get_all_academic_article_category")
                .then(response => {
                    // console.log(response)
                    this.data_academic_article_category = response.data
                })
                this.data_load=true
            }
            var category_all = this.data_academic_article_category
            return category_all
        }
    }
}
</script>