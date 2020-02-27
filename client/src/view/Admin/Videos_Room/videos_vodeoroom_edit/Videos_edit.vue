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
                    <h5>ลิ้งค์วีดีโอ</h5>
                    <input v-model="thisvideo.v_link" type="text" class="form-control" placeholder="www.ลิ้งค์วีดีโอ.com">
                    <br>
                    <h5>รายละเอียด</h5>
                    <textarea v-model="thisvideo.v_description" class="form-control textarea" placeholder="รายละเอียด" rows="6" ></textarea>
                    <br>
                    <div class="row">
                        <div class="col-lg-6 col-xs-6"></div>
                        <div class="col-lg-6 col-xs-6">
                            <button class="form-control btn-primary" type="submit">ดำเนินการต่อ</button> <br>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-lg-3 col-xs-12"></div>
        </div>
        <div class="row" v-else>
            <div class="col-12">
                <center> <h4> {{text_alert}} </h4> </center>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return{
            thisvideo:'',
            data_video:'',
            data_load:false,

            text_alert:''
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
            var videoID = this.$route.params.VideoID
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+'Videos_Room/get_this_video/'+videoID)
                .then(response => {
                    // console.log(response.data[0]),
                    this.data_video= response.data[0]
                })
                this.data_load = true
            }
            if(this.data_video =='' || this.data_video == null){
                setTimeout(() => {
                    this.text_alert = 'This Page No Data.'
                },1000);
            }
            this.thisvideo = this.data_video
            var thisvideo_now = this.data_video
            return thisvideo_now
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

