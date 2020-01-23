<template>
    <div class="container" v-if="the_user">
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <h4 class="header"><center>ผลงานวิจัย</center></h4> 
            </div>
        </div>
        <div class="row">
            <div class="col-lg-9 col-xs-12"></div>
            <div class="col-lg-3 col-xs-12">
                <button class="form-control btn-primary" @click="addresearch">เพิ่มงานวิจัย</button>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">ลำดับ</th>
                        <th style="width:35%">หัวข้องานวิจัย</th>
                        <th style="width:20%">วันที่สร้าง</th>
                        <th style="width:20%">วันที่แก้ไข</th>
                        <th style="width:10%">  </th>
                        <th style="width:10%">  </th>
                    </tr>
                    <tr v-for="(research,index) in the_research.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)" :key="index" >
                        <td>{{ research.r_id }}</td>
                        <td>{{research.r_title.slice(0,35)}}</td>
                        <td>{{research.r_create_date}}</td>
                        <td>{{research.r_update_date}}</td>
                        <td> <button class="form-control btn-warning" @click="editResearch(research.r_id)">แก้ไข</button> </td>
                        <td> <button class="form-control btn-danger"  @click="deleteResearch(research.r_id)">ลบ</button> </td>
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
export default {
    data() {
        return {
            page: 0,
            data_in_page: 20,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            userstatus:''
        };
    },
    methods:{
        addresearch(){
            this.$router.push('/addresearch')
        },
        seenextPage(num_page) {
            this.$router.push({
                name: "AdminR",
                params: { Page: num_page }
            });
        },
        editResearch(thisresearch){
            this.$router.push({name:'editresearch',params:{ResearchID:thisresearch}});
        },
        deleteResearch(thisresearch){
            // console.log(thisresearch)
            var FD  = new FormData()
            FD.append('researchID',JSON.stringify(thisresearch))
            FD.append('creator',JSON.stringify(this.$store.state.log_on))
            this.$swal({
                title: "Are you sure?",
                text: "You want delete this Research ID "+thisresearch,
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    this.$store.dispatch("Delete_Research",FD)
                    swal({title: "Delete Success.",icon: "success",});
                    // console.log(FD)
                } else {
                    // swal("Your imaginary file is safe!");
                }
            })
        }
    },
    computed:{
        the_research(){
            var setpage = this.$route.params.Page;
            var research_All = this.$store.getters.getResearch;
            var p_conpute = 2;
            var p_start = setpage;
            var p_end = Math.ceil(setpage / 1 + p_conpute);

            this.page = setpage - 1;
            this.length_page = Math.ceil(research_All.length / this.data_in_page); // set page all
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
            return research_All
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            if( user.m_status != 'admin' ){
                // this.$router.go(-1)
            }
            return user
        },
    },
    created(){
        this.$store.dispatch("initDataResearch")
        this.$store.dispatch("initDataFiles")
    }
}
</script>
