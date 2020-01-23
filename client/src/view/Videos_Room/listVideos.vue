<template>
    <div class="container ">
        <h4>List Videos</h4>
        <div class="row">
            <div class="col-lg-12 col-xs-12" v-for="( listv,index ) in ListVideos" :key="index">
                <div @click="seethisVideo(listv.v_id)">
                    Video Name: <b> {{listv.v_title}} </b> <br>
                    Description: {{listv.v_description}}
                    <hr>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    methods:{
        seethisVideo(thisvideo){
            this.$router.push({name:'roomvideo',params:{VideoID:thisvideo}});
        }
    },
    computed:{
        ListVideos(){
            var listvideosAll = this.$store.getters.getVideos
            var listvideos = []
            for(var i=0; i<listvideosAll.length; i++ ){
                if( listvideosAll[i].v_room == this.$route.params.RoomID ){
                    listvideos.push(listvideosAll[i])
                }
            }
            return listvideos
        }
    }
}
</script>
