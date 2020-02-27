<template>
    <div class="container">
        <h4 style="text-align:center"> วารสารออนไลน์ </h4>
        <div class="row" v-if="the_user">
            <div class="col-lg-6 col-12"></div>
            <div class="col-lg-6 col-12">
                <br>
                <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากวารสารออนไลน์ทั้งหมด ที่สามารถเข้าถึงได้">
                <p v-if="searching!=''" style="text-align: right;"> <br>
                เจอทั้งหมด {{find}} รายการ
                </p>    
            </div>
        </div>
        <div class="row" v-if="the_user">
            <div class="col-lg-12 col-xs-12">
                <table class="table" style="width:100%" >
                    <tr style="width:100%">
                        <th style="width:5%">No</th>
                        <th style="width:35%">Online Journal Title</th>
                        <th style="width:20%">Create Date</th>
                        <th style="width:20%">Update Date</th>
                        <th style="width:20%">  </th>
                    </tr>
                    <tr v-for="(online_journal,index) in the_online_journal" :key="index">
                        <td>{{online_journal.oj_id}}</td>
                        <td>{{online_journal.oj_title.slice(0,35)}}</td>
                        <td>{{online_journal.oj_create_date}}</td>
                        <td>{{online_journal.oj_update_date}}</td>
                        <td> <button class="form-control btn-primary" @click="seethis_online_journal(online_journal.oj_id)">See</button> </td>
                    </tr>
                </table>
                <br>
            </div>
        </div>
        <div class="row" v-if="!the_user">
            <div class="col-lg-12 col-xs-12">
                <br><br>
                <h4><center> {{text_alert}} </center></h4>
                <br>
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
            data_online_journal:'',
            data_size:'',
            data_load:false,
            page: 0,
            data_in_page: 10,
            length_page: 0,
            page_start: 0,
            page_end: 0,
            isActive: [],
            searching:'',
            find:null,
            
            permission:'',
            text_alert:''
        };
    },
    methods:{
        seenextPage(num_page) {
            this.$router.push({
                name: "online_journals",
                params: { Page: num_page }
            });
        },
        seethis_online_journal(this_online_journal){
            this.$router.push({name:'online_journal',params:{Online_JournalID:this_online_journal}});
        },
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        },
        the_user(){
            this.data_load = false;
            this.searching = ''
        },
        searching(){
            if(this.searching[0] == ' '){
                this.searching = ''
            }
            if(this.searching.length>0){
                var search = encodeURI(this.searching);
                axios.get(this.$store.getters.getBase_Url+'Online_Journal/get_all_online_journal_like/'+this.permission+'/'+search)
                .then(response => {
                    // console.log(response.data)
                    this.data_size = 0,
                    this.find = response.data[0],
                    this.data_online_journal = response.data[1]
                })
                this.length_page = 0;
            }else{
                this.data_load = false;
                this.find = null;
            }
        }
    },
    computed:{
        the_user(){
            var user = this.$store.getters.getThe_User
            if(user == ''|| user == null || user == undefined){
                setTimeout(() => {
                    this.text_alert = 'วารสารออนไลน์ จะไม่แสดงหากไม่มีการ Login เข้าสู่ระบบ'
                },1000);
            }
            return user;
        },
        the_online_journal(){
            var setpage = this.$route.params.Page;
            this.permission = this.the_user.m_type; //permission
            if(this.the_user == '' || this.the_user == undefined || this.the_user == null){
                this.permission = 0;
            }
            if(this.the_user.m_status == 'admin'){
                this.permission = 9;
            }
            if(this.data_load==false){
                axios.get(this.$store.getters.getBase_Url+'Online_Journal/get_online_journal/'+this.data_in_page+'/'+this.permission+'/'+setpage)
                .then(response => {
                    // console.log(response.data),
                    // console.log(permission),
                    this.data_size = response.data[0],
                    this.data_online_journal = response.data[1]
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
            return this.data_online_journal;
        }
    }
}
</script>
