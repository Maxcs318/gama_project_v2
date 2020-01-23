<template>
    <div class="container ">
        <center><h4 class="header">แก้ไขห้องวีดีโอ</h4></center>
        <div class="row mt-5" v-if="thisVideo_Room && the_user">
            <div class="col-lg-3 col-xs-12"></div>
            <div class="col-lg-6 col-xs-12">
                <form @submit.prevent="submitEditRoom">
                    <h5>ชื่อห้อง</h5>
                    <input v-model="videoroom.vr_title" type="text" class="form-control" placeholder="ชื่อห้อง">
                    <br>
                    <h5>รายละเอียด</h5>
                    <textarea v-model="videoroom.vr_description" class="form-control textarea" placeholder="รายละเอียด" rows="6" ></textarea>
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
            videoroom:''
        }
    },
    methods:{
        submitEditRoom(){
            // console.log(this.videoroom)
            var jsonVR = JSON.stringify(this.videoroom)
                var FD  = new FormData()
                    FD.append('room',jsonVR)            
                    FD.append('creator',JSON.stringify(this.$store.state.log_on))
                    this.$store.dispatch("Edit_Video_Room",FD)
                    setTimeout(()=>{
                        this.$router.go(-1)
                    },2000)  
                this.$swal("Edit Video Room Success .", "", "success")
        }
    },
    computed : {
        thisVideo_Room(){
            var video_roomall = this.$store.getters.getVideo_Room
            var video_room
            for(var i=0; i<video_roomall.length; i++){
                if(video_roomall[i].vr_id == this.$route.params.RoomID){
                    video_room = video_roomall[i]
                }
            }
            this.videoroom = video_room 
            return video_room
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

