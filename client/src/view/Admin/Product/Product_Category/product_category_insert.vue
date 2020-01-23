<template>
    <div>
        <div>
            <div class="container " v-if="the_user">
                <div class="row">
                    <div class="col-lg-12 col-xs-12">
                        <h4 class="header"><center>เพิ่ม ประเภท ของสินค้า</center></h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-xs-12"></div>
                    <div class="col-lg-6 col-xs-12">
                        <form @submit.prevent="submitProduct_Category">
                            <center>                            
                                <img v-if="url"  :src="url" class="admin-img" />
                            </center>
                            <br>
                            <button type="button" class="block-center form-control btn-success col-lg-6" @click="ChooseFilesFirst">เลือกรูป</button>
                            <input id="chooseImage" ref="filesfirst" style="display: none;" type="file" @change="handleFilesFirst">
                            <br>
                            ชื่อ ประเภท ของสินค้า
                            <input type="text" v-model="productC.pc_title" class="form-control" placeholder="ชื่อ ประเภท ของสินค้า" required>
                            <br>
                            รายละเอียด
                            <textarea v-model="productC.pc_description" class="form-control textarea" rows="6" placeholder="รายละเอียด" ></textarea>
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
            productC:{
                pc_title:'',
                pc_description:''
            },
            url: null,
            fileimage:'',

        }
    },
    methods:{
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
        submitProduct_Category(){
            if(this.fileimage.size<10000000 && this.fileimage !=''){
                var jsonPC = JSON.stringify(this.productC)
                var FD  = new FormData()
                    FD.append('userfile',this.fileimage)
                    FD.append('product_category',jsonPC)
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$store.dispatch("Add_Product_Category",FD)
                    setTimeout(()=>{
                        this.$router.go(-1)
                    },2000)
                this.$swal("Save Product Category Success .", "", "success")
            }else{
                this.$swal("Please Choose Image .", "", "error")
            }
        }
    },
    computed:{
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }
            return user
        }
    },
}
</script>
