<template>
    <div class="container" v-if="the_user">
        <h5 class="header">กิจกรรมทั้งหมด</h5> <br>
        
        <div class="row">
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="addgallery">เพิ่มกิจกรรม</button> <br>
            </div>
            <div class="col-lg-9 col-12">
                <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากภาพกิจกรรมทั้งหมด">
                <br> 
                <p v-if="searching!=''" style="text-align: right;">
                เจอทั้งหมด {{find}} รายการ
                </p>   
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">ID</th>
                        <th style="width:35%">ชื่อกิจกรรม</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(gallery,index) in Gallery" :key="index">
                        <td>{{ gallery.g_id }}</td>
                        <td>{{gallery.g_name.slice(0,35)}}</td>
                        <td>{{gallery.g_create_date}}</td>
                        <td>{{gallery.g_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editGallery(gallery.g_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger"  @click="deleteGallery(gallery.g_id)">ลบ</button> </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row" v-if="length_page > 0">
            <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
                <div class="btn-group" role="group" aria-label="Second group">
                    <button type="button" class="btn btn-light" @click="seenextPage(1)" title="First page"><<</button>
                    <button
                    type="button"
                    class="btn btn-light"
                    v-for=" (run_page,index) in length_page "
                    @click="seenextPage(run_page)"
                    v-bind:class="{ active: isActive[index+1] }"
                    v-if=" run_page >= page_start && run_page <= page_end "
                    >{{run_page}}</button>
                    <button type="button" class="btn btn-light" @click="seenextPage(length_page)" title="Last page">>></button>
                </div>
            </div>
        </div>
        
    </div>
</template>
<script>
import axios from "axios";
export default {
    data() {
        return {
            page: 0,
            data_in_page: 20,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            data_gallery:'',
            data_size:'',
            data_load:false,
            searching:'',
            find:null
        };
    },
    methods:{
        addgallery(){
            this.$router.push('/addgallery')
        },
        seenextPage(num_page) {
            this.$router.push({
                name: "AdminListGallery",
                params: { Page: num_page }
            });
        },
        editGallery(this_Gallery){
            this.$router.push({name:'editgallery',params:{GalleryID:this_Gallery}});
        },
        deleteGallery(this_Gallery){
            // console.log(thisproduct)
            var FD  = new FormData()
            FD.append('galleryID',JSON.stringify(this_Gallery))
            FD.append('creator',JSON.stringify(this.$store.state.log_on))
            this.$swal({
                title: "Are you sure?",
                text: "You want delete this Gallery ID "+this_Gallery,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    this.$store.dispatch("Delete_Gallery",FD)
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
        searching(){
        if(this.searching[0] == ' '){
            this.searching = ''
        }
        if(this.searching.length>0){
            var search = encodeURI(this.searching);
            axios.get(this.$store.getters.getBase_Url+'Gallery/get_all_gallery_like/'+search)
            .then(response => {
                // console.log(response.data)
                this.data_size = 0,
                this.find = response.data[0],
                this.data_gallery = response.data[1]
            })
            this.length_page = 0;
        }else{
            this.data_load = false;
            this.find = null;
        }
        }
    },
    computed:{
        Gallery(){
            var setpage = this.$route.params.Page;
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+'Gallery/get_gallery/'+this.data_in_page+'/'+setpage)
                .then(response => {
                    // console.log(response.data),
                    this.data_size = response.data[0],
                    this.data_gallery = response.data[1]
                })
                this.data_load = true
            }
            var p_conpute = 2;
            var p_start = setpage;
            var p_end = Math.ceil(setpage / 1 + p_conpute);
            this.page = setpage - 1;
            this.length_page = Math.ceil(this.data_size / this.data_in_page); // set page all
            // set start && end paging
            if (setpage > p_conpute) {
                p_start = setpage - p_conpute;
            } else {
                p_start = -(setpage - p_conpute) - p_conpute;
                p_end = p_end + p_start + p_conpute + 1;
            }
            if (p_end >= this.length_page) {
                p_start = p_start + (this.length_page - setpage - p_conpute);
            }
            this.page_start = p_start;
            this.page_end = p_end;
            this.isActive = [];
            for (var i = 0; i <= this.length_page; i++) {
                if (i == this.$route.params.Page) {
                this.isActive.push(true);
                } else {
                this.isActive.push(false);
                }
            }
            return this.data_gallery;
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

