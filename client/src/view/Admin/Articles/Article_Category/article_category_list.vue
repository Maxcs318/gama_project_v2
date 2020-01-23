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
export default {
    data() {
        return {
            
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
                } else {
                    // swal("Your imaginary file is safe!");
                }
            })
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
            return this.$store.getters.getArticle_Category
        }
    },
    created(){
        this.$store.dispatch("initDataArticle_Category");
    }
}
</script>