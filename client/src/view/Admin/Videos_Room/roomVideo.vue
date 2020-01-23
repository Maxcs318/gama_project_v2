<template>
    <div class="container " v-if="the_user">
        <div class="row">
            <div class="col-lg-12 col-xs-12" v-for="(video,index) in thisVideo" :key="index">
                <h4>{{video.v_title}}</h4>    
                <div v-if="video.v_link.slice(0,23) == 'https://www.youtube.com'">
                    <b-embed type="iframe" aspect="16by9" :src="video.v_link" allowfullscreen ></b-embed>
                </div>
                <div v-else>
                    <center><h4> {{video.v_link}} </h4></center>
                </div>
                <h5>{{video.v_description}}</h5>
            </div>
        </div>
    </div>
</template>
<script>
export default {
   computed:{
        thisVideo(){
            var videosAll = this.$store.getters.getVideos
            var thisvideo = []
            for(var i=0; i<videosAll.length; i++ ){
                if( videosAll[i].v_id == this.$route.params.VideoID ){
                    thisvideo.push(videosAll[i])
                }
            }
            return thisvideo
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
