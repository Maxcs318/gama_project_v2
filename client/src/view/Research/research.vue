<template>
  <div class="container" >
    <div class="row">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12" v-if="the_user && thisResearch">
        <h4>
          <center>งานวิจัย : {{research_data.r_title}}</center>
        </h4><br>
        <p>หัวข้อ : {{research_data.r_title}}</p>
        <br />
        <p>หัวข้อทางเลือก : {{research_data.r_titlealternative}}</p>
        <br />
        <!-- Creator : {{research_data.r_creator}}
        <br>-->
        <p>เรื่อง : {{research_data.r_subject}}</p>
        <br />
        <p>รายละเอียด : {{research_data.r_description}}</p>
        <br />
        <p>ผู้เผยแพร่ : {{research_data.r_publisher}}</p>
        <br />
        <p>วันที่เผยแพร่ : {{research_data.r_createddate}}</p>
        <br />
        <p>วันที่แก้ไข : {{research_data.r_modifieddate}}</p>
        <br />
        <p>วันที่ตีพิมพ์ : {{research_data.r_issueddate}}</p>
        <br />
        <p>ประเภท : {{research_data.r_type}}</p>
        <br />
        <p>ขนาด : {{research_data.r_format}}</p>
        <br />
        <p>แหล่งข้อมูล : {{research_data.r_source}}</p>
        <br />
        <p>ภาษา : {{research_data.r_language}}</p>
        <br />
        <p>สิทธิประโยชน์ : {{research_data.r_rights}}</p>
        <br />
        <hr />
        <center>
          <h4 v-if="research_data_file.length>0">ไฟล์</h4>
        </center>
        <div v-if="research_data_file != null" v-for="(file,run) in research_data_file">
          <a :href="loadFile(file.f_name)" download>Dowload File</a>
          {{file.f_title}}
          <br />
          <br />
        </div>
        <br />
      </div>
      <div class="col-lg-8 col-xs-12" v-if="the_user && !thisResearch">
        <center> <h2> {{text_alert}} </h2> </center> <br><br> 
      </div>
      <div class="col-lg-8 col-xs-12" v-if="!the_user">
        <center> <h2> {{text_alert}} </h2> </center> <br><br> 
      </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>
    <!-- //  -->
    <!-- //  -->
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      data_load:false,
      text_alert:'',
      research_data:'',
      research_data_file:'',
    };
  },
  methods: {
    loadFile(fi) {
      return this.path_files + "Research_Files_Upload/" + fi;
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
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
    thisResearch() {
      var researchID = this.$route.params.ResearchID;
      var permission = this.the_user.m_type; //permission
      if(this.the_user == '' || this.the_user == undefined || this.the_user == null){
        permission = 0;
      }
      if(this.the_user.m_status == 'admin'){
        permission = 9;
      }
      if(this.data_load == false){
        axios.get(this.$store.getters.getBase_Url+'Research/get_this_research/'+permission+'/'+researchID)
        .then(response => {
          // console.log(response.data),
          this.research_data = response.data[0][0],
          this.research_data_file = response.data[1]
        })
        this.data_load = true
        if(this.research_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var research_show = this.research_data
      return research_show; 
    }
  }
};
</script>
<style scoped>
.head1 {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  margin-bottom: 53px;
}
p {
  font-size: 17px;
  line-height: 120%;
}
hr {
  border: 2px solid #3f4d63;
}
</style>