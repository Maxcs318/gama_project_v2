<template>
    <div class="container ">
        <div class="row mt-5" v-if="thisOnline_Journal">
            <div class="col-lg-2 col-xs-12"></div>
            <div class="col-lg-8 col-xs-12">
                <center><h4>{{ thisOnline_Journal.oj_title }}</h4></center>
                Detail : {{thisOnline_Journal.oj_detail}} <br>     
                Description : {{thisOnline_Journal.oj_description}} <br> 
                <br>      
                <div style="text-align: right;">
                Create On : {{thisOnline_Journal.oj_create_date}} <br>       
                Last Update : {{thisOnline_Journal.oj_update_date}} <br>       
                </div>
                <br>
                <div v-if="thisFiles != null" v-for="(file,run) in thisFiles" :key="run" >
                     <a :href="loadFile(file.f_name)" download> Dowload File {{run+1}}</a> {{file.f_title}}
                    <br>
                </div>
                <br>
            </div> 
            <div class="col-lg-2 col-xs-12"></div>
        </div>
    </div>
</template>
<script>
export default {
    methods:{
        loadFile(fi){
            return this.path_files+'Online_Journal_Files_Upload/'+fi
        },
    },
    computed : {
        path_files(){
            return this.$store.getters.getPath_Files
        },
        thisOnline_Journal(){
            var online_journalAll = this.$store.getters.getOnline_Journal_For_User
            var online_journal 
            for(var i=0; i<online_journalAll.length; i++){
                if(online_journalAll[i].oj_id == this.$route.params.Online_JournalID){
                    online_journal = online_journalAll[i]
                }
            }
            return online_journal
        },
        thisFiles(){
            var filesAll = this.$store.getters.getFiles
            var files_online_journal = []
            for(var i=0; i<filesAll.length; i++){
                if(filesAll[i].f_key == this.thisOnline_Journal.oj_file_key){
                    files_online_journal.push(filesAll[i])
                }
            }
            if(files_online_journal.length != 0){
                return files_online_journal
            }else{
                return null
            }
        },

    
    }
}
</script>
