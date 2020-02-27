<template>
    <div class="container ">
        <div class="row" v-if="thisVideo">
            <div class="col-lg-12 col-xs-12" >
                <h4>{{data_video.v_title}}</h4>    
                <div v-if="data_video.v_link.slice(0,23) == 'https://www.youtube.com'">
                    <b-embed type="iframe" aspect="16by9" :src="data_video.v_link" allowfullscreen ></b-embed>
                </div>
                <div v-else>
                    <center><h4> {{data_video.v_link}} </h4></center>
                </div>
                <h5>{{data_video.v_description}}</h5>
            </div>
        </div>
        <div class="row" v-else>
            <div class="col-lg-12 col-xs-12" >
                <h2><center> {{text_alert}} </center></h2> <br><br>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return{
            data_video:'',
            data_load:false,

            text_alert:''
        }
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
    },
    computed:{
        thisVideo(){
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
            var thisvideo = this.data_video
            return thisvideo
        }
   } 
}
</script>
