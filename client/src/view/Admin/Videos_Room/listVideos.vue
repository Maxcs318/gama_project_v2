<template>
        <div class="container" v-if="the_user&&the_user.m_status=='admin'">
        <h4 class="header" v-if="ListVideos">วีดีโอทั้งหมดของ : {{data_video_room.vr_title}}</h4> <br>
        <div class="row">
            <div class="col-lg-9 col-xs-12"></div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="addvideos">เพิ่มวีดีโอ</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <!-- <th style="width:5%">ลำดับ</th> -->
                        <th style="width:35%">ชื่อวีดีโอ</th>
                        <th style="width:20%">วันที่เผยแพร่</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(list,index) in data_videos" :key="index" >
                        <!-- <td>{{index+1}}</td> -->
                        <td>{{list.v_title.slice(0,25)}}</td>
                        <td>{{list.v_create_date}}</td>
                        <td>{{list.v_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editVideo(list.v_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger" @click="deleteVideo(list.v_id,list.v_title)">ลบ</button> </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return{
            data_video_room:'',
            data_videos:'',
            data_load:false,
        }
    },
    methods:{
        addvideos(){
            this.$router.push('/addvideos')
        },
        editVideo(thisvideo){
            this.$router.push({name:'editvideo',params:{VideoID:thisvideo}})
        },
        seethisVideo(thisvideo){
            this.$router.push({name:'roomvideo',params:{VideoID:thisvideo}})
        },
        deleteVideo(thisvideo,thisvideoName){
            var FD  = new FormData()
            FD.append('videoID',JSON.stringify(thisvideo))
            FD.append('creator',JSON.stringify(this.$store.state.log_on))
            this.$swal({
                title: "Are you sure?",
                text: "You want delete this Video Name "+thisvideoName,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    // console.log(thisvideo)
                    this.$store.dispatch("Delete_Video",FD)
                    swal({title: "Delete Success.",icon: "success",});
                    setTimeout(() => {
                        this.data_load=false
                        this.searching = ''
                    },100);
                } else {
                    // swal("Your imaginary file is safe!");
                }
            })
        }
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
    },
    computed:{
        ListVideos(){
            var roomID = this.$route.params.RoomID
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+'Videos_Room/get_this_video_room/'+roomID)
                .then(response => {
                    // console.log(response.data)
                    this.data_video_room = response.data[0][0],
                    this.data_videos= response.data[1]
                })
                this.data_load = true
            }
            var video = this.data_video_room
            return video
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }
            return user
        }
    }
}
</script>
