<template>
    <div class="container" v-if="ListVideos">
        <h4><center> {{data_video_room[0].vr_title}} </center></h4>
        <div class="row">
            <div class="col-lg-12 col-xs-12" v-for="( listv,index ) in data_videos" :key="index">
                <div class="row">
                    <div class="col-lg-4 col-12" @click="seethisVideo(listv.v_id)">
                        <div v-if="listv.v_link.slice(0,23) == 'https://www.youtube.com'">
                            <b-embed type="iframe" aspect="16by9" :src="listv.v_link" allowfullscreen style="z-index: 1;">
                                
                            </b-embed>
                            <div style="z-index: 2; position: absolute; padding-top: 52.0%;right:1;
                                bottom: 0px; width:93%; background-color: gray; opacity: 0.0;"> 
                            </div>
                        </div>
                        
                    </div>
                    <div class="col-lg-8 col-12">
                        <!-- Video Name: -->
                        <!-- Description: -->
                         <b @click="seethisVideo(listv.v_id)" class="video-name"> {{listv.v_title}} </b> <br>
                         {{listv.v_description.slice(0,250)}} ...
                    </div>
                </div> <hr>
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
