<template>
    <div class="container ">
        <center><h4 class="header">แก้ไขวีดีโอ</h4></center>
        <div class="row mt-5" v-if="thisVideoNow && the_user">
            <div class="col-lg-3 col-xs-12"></div>
            <div class="col-lg-6 col-xs-12">
                <form @submit.prevent="submitEditVideo">
                    <h5>ชื่อวีดีโอ</h5>
                    <input v-model="thisvideo.v_title" type="text" placeholder="ชื่อวีดีโอ" class="form-control">
                    <br>
                    <h5>รายละเอียด</h5>
                    <textarea v-model="thisvideo.v_description" class="form-control textarea" placeholder="รายละเอียด" rows="6" ></textarea>
                    <br>
                    <h5>ลิ้งค์วีดีโอ</h5>
                    <input v-model="thisvideo.v_link" type="text" class="form-control" placeholder="www.ลิ้งค์วีดีโอ.com">
                    <br>
                    <div class="row">
                        <div class="col-lg-6 col-xs-6"></div>
                        <div class="col-lg-6 col-xs-6">
                            <button class="form-control btn-primary" type="submit">ดำเนินการต่อ</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-3 col-xs-12"></div>
        </div>
    </div>
</template>
<script>
export default {
    data(){
        return{
            thisvideo:''
        }
    },
    methods:{
        submitEditVideo(){
            // console.log(this.thisvideo)
            var jsonV = JSON.stringify(this.thisvideo)
                var FD  = new FormData()
                    FD.append('video',jsonV)            
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$store.dispatch("Edit_Video",FD)
                    setTimeout(()=>{
                        this.$router.go(-1)
                    },2000)  
                this.$swal("Edit Video Success .", "", "success")
        }
    },
    computed : {
        thisVideoNow(){
            var videoall = this.$store.getters.getVideos
            var video_now
            for(var i=0; i<videoall.length; i++){
                if(videoall[i].v_id == this.$route.params.VideoID){
                    video_now = videoall[i]
                }
            }
            this.thisvideo = video_now 
            return video_now
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                this.$router.go(-1)
            }
            return user
        }
    }
}
</script>

