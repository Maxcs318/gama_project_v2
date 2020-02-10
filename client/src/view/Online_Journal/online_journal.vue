<template>
    <div class="container ">
        <div class="row mt-5">
            <div class="col-lg-2 col-xs-12"></div>
            <div class="col-lg-8 col-xs-12" v-if="the_user && thisOnline_Journal">
                <center><h4>{{ thisOnline_Journal.oj_title }}</h4></center>
                Detail : {{thisOnline_Journal.oj_detail}} <br>     
                Description : {{thisOnline_Journal.oj_description}} <br> 
                <br>      
                <div style="text-align: right;">
                Create On : {{thisOnline_Journal.oj_create_date}} <br>       
                Last Update : {{thisOnline_Journal.oj_update_date}} <br>       
                </div>
                <br>
                <div v-if="online_journal_data_file != null" v-for="(file,run) in online_journal_data_file" :key="run" >
                     <a :href="loadFile(file.f_name)" download> Dowload File {{run+1}}</a> {{file.f_title}}
                    <br>
                </div>
                <br>
            </div> 
            <div class="col-lg-8 col-xs-12" v-if="the_user && !thisOnline_Journal">
                <center> <h2> {{text_alert}} </h2> </center> <br><br> 
            </div>
            <div class="col-lg-8 col-xs-12" v-if="!the_user">
                <center> <h2> {{text_alert}} </h2> </center> <br><br> 
            </div>
            <div class="col-lg-2 col-xs-12"></div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    data(){
        return {
            data_load:false,
            text_alert:'',
            online_journal_data:'',
            online_journal_data_file:'',

        }
    },
    methods:{
        loadFile(fi){
            return this.path_files+'Online_Journal_Files_Upload/'+fi
        },
    },
    watch:{
        $route (to, from){
            this.data_load = false;
        }
    },
    computed : {
        path_files(){
            return this.$store.getters.getPath_Files
        },
        the_user(){
            var user = this.$store.getters.getThe_User;
            if(user == ''|| user == null || user == undefined){
                setTimeout(() => {
                    this.text_alert = 'Please Login!'
                },1000);
            }
            return user
        },
        thisOnline_Journal(){
            var online_j_ID = this.$route.params.Online_JournalID;
            var permission = this.the_user.m_type; //permission
            if(this.the_user == '' || this.the_user == undefined || this.the_user == null){
                permission = 0;
            }
            if(this.the_user.m_status == 'admin'){
                permission = 9;
            }
            if(this.data_load == false && permission){
                axios.get(this.$store.getters.getBase_Url+'Online_journal/get_this_online_journal/'+permission+'/'+online_j_ID)
                .then(response => {
                    // console.log(response.data),
                    this.online_journal_data = response.data[0][0],
                    this.online_journal_data_file = response.data[1]
                })
                this.data_load = true
                if(this.online_journal_data.length == 0){
                    setTimeout(() => {
                        this.text_alert = 'This Page No Data.'
                    },1000);
                }
            }
            var online_journal_show = this.online_journal_data
            return online_journal_show;
        }
    }
}
</script>
