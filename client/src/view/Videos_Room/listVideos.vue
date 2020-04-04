<template>
    <div class="container" v-if="ListVideos">
        <h4><center> {{data_video_room[0].vr_title}} </center></h4>
        <div class="row">
            <div class="col-lg-9 col-xs-12" v-for="( listv,index ) in data_videos" :key="index">
                <div >
                    Video Name: <b @click="seethisVideo(listv.v_id)" class="video-name"> {{listv.v_title}} </b> <br>
                    Description: {{listv.v_description}}
                    <hr>
                </div>
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
        seethisVideo(thisvideo){
            this.$router.push({name:'roomvideo',params:{VideoID:thisvideo}});
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
                    // console.log(response.data[0]),
                    this.data_video_room = response.data[0],
                    this.data_videos= response.data[1]
                })
                this.data_load = true
            }
            var video = this.data_video_room
            return video
        }
    }
}
</script>
