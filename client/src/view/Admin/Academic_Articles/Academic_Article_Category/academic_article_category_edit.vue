<template>
    <div>
        <div>
            <div class="container " v-if="the_user && Academic_Article_Category">
                <div class="row">
                    <div class="col-lg-12 col-xs-12">
                        <h4 class="header"><center>แก้ไขประเภท ของบทความวิชาการ</center></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-xs-12"></div>
                    <div class="col-lg-6 col-xs-12">
                        <form @submit.prevent="submitAcademicArticle_Category">
                            <center>                            
                            <img class="admin-img" v-if="url"  :src="url" width="100%"/>
                            <img class="admin-img" v-else :src="getImgUrl(academic_article.aac_image)" width="100%">
                            </center>
                            <br>
                            <button type="button" class="form-control btn-success block-center col-lg-6" @click="ChooseFilesFirst">เลือกรูป</button>
                            <input id="chooseImage" ref="filesfirst" style="display: none;" type="file" @change="handleFilesFirst">
                            <br>
                            ชื่อประเภท ของบทความวิชาการ
                            <input type="text" v-model="academic_article.aac_title" class="form-control" placeholder="ชื่อ ประเภท ของบทความวิชาการ" required>
                            <br>
                            รายละเอียด
                            <textarea v-model="academic_article.aac_description" class="form-control textarea" placeholder="รายละเอียด" rows="6" ></textarea>
                            <br>
            
                            <br>
                            <div class="row">
                                <div class="col-lg-6"></div>
                                <div class="col-lg-6">
                                    <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
                                    <br>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-3 col-xs-12"></div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>

export default {
    data(){
        return{
            academic_article:{
                aac_title:'',
                aac_description:''
            },
            url: null,
            fileimage:'',

        }
    },
    methods:{
        getImgUrl(pic) {
            return this.path_files+'Academic_Article_Category/'+pic
        },
        // first image 
        ChooseFilesFirst(){
            document.getElementById('chooseImage').click()
        },
        handleFilesFirst(e){
            // console.log(e.target.files[0])
            const file = e.target.files[0]
            this.url = URL.createObjectURL(file)
            let uploadedFiles = this.$refs.filesfirst.files[0]
            this.fileimage = uploadedFiles
            if(this.fileimage.size>10000000){
                this.fileimage = []
                this.url = null
                this.$swal('Your file is larger than 10 MB. Sorry Choose Again !!!')
            }
        },
        submitAcademicArticle_Category(){
            var jsonAAC = JSON.stringify(this.academic_article)
            var FD  = new FormData()
                if(this.url != null){
                    FD.append('userfile',this.fileimage)
                }
                FD.append('academic_article_category',jsonAAC)
                FD.append('creator',JSON.stringify(this.$store.state.log_on))
                this.$store.dispatch("Edit_Academic_Article_Category",FD)
                setTimeout(()=>{
                    this.$router.go(-1)
                },2000)
            this.$swal("Save Academic Article Category Success .", "", "success")
        }
    },
    computed:{
        path_files(){
            return this.$store.getters.getPath_Files
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }
            return user
        },
        Academic_Article_Category(){
            var AAC_All = this.$store.getters.getAcademic_Article_Category
            var AAC 
            for(var i=0; i<AAC_All.length; i++){
                if(AAC_All[i].aac_id == this.$route.params.AcademicArticle_CategoryID){
                    AAC = AAC_All[i]
                }
            }
            this.academic_article = AAC 
            return AAC
        },
    },
}
</script>
