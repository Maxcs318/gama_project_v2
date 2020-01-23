<template>
        <div class="container" v-if="the_user">
        <h4 class="header" v-if="thisRoom">วีดีโอทั้งหมดของ : {{thisRoom.vr_title}}</h4> <br>
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
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">ชื่อวีดีโอ</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(list,index) in ListVideos" :key="index" >
                        <td>{{list.v_id}}</td>
                        <td>{{list.v_title.slice(0,25)}}</td>
                        <td>{{list.v_create_date}}</td>
                        <td>{{list.v_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editVideo(list.v_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger" @click="deleteVideo(list.v_id)">ลบ</button> </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</template>
<script>
export default {
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
        deleteVideo(thisvideo){
            var FD  = new FormData()
            FD.append('videoID',JSON.stringify(thisvideo))
            FD.append('creator',JSON.stringify(this.$store.state.log_on))
            this.$swal({
                title: "Are you sure?",
                text: "You want delete this Video Room ID "+thisvideo,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    // console.log(thisvideo)
                    this.$store.dispatch("Delete_Video",FD)
                    swal({title: "Delete Success.",icon: "success",});
                } else {
                    // swal("Your imaginary file is safe!");
                }
            })
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
        },
        thisRoom(){
            var roomall = this.$store.getters.getVideo_Room 
            var room_now    
            for(var i=0;i<roomall.length;i++){
                if(roomall[i].vr_id == this.$route.params.RoomID){
                    room_now = roomall[i]
                }
            }
            return room_now
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
