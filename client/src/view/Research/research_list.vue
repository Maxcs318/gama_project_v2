<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h4>
          <center>ผลงานวิจัย</center>
        </h4>
      </div>
    </div>
    <div class="row" v-if="the_user">
      <div class="col-lg-6 col-12"></div>
      <div class="col-lg-6 col-12">
          <br>
          <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากผลงานวิจัยทั้งหมด ที่สามารถเข้าถึงได้">
          <p v-if="searching!=''" style="text-align: right;"> <br>
          เจอทั้งหมด {{find}} รายการ
          </p>    
      </div>
    </div>
    <div class="row" v-if="the_user">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%; text-align:center">#</th>
            <th style="width:55%">หัวข้องานวิจัย</th>
            <th style="width:15%">วันที่สร้าง</th>
            <th style="width:15%">วันที่แก้ไข</th>
            <th style="width:10%">ดูเพิ่มเติม</th>
          </tr>
          <tr
            v-for="(research,index) in the_research"
            :key="index"
          >
            <td style="text-align:center">{{ research.r_id }}</td>
            <td>{{research.r_title.slice(0,35)}}</td>
            <td>{{research.r_create_date.slice(0,-13)}}</td>
            <td>{{research.r_update_date.slice(0,-13)}}</td>
            <td>
              <button class="form-control btn-warning" @click="seeResearch(research.r_id)">ดูเพิ่มเติม</button>
            </td>
          </tr>
        </table>
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
          <button
            type="button"
            class="btn btn-light"
            @click="seenextPage(length_page)"
            title="Last page"
          >>></button>
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
      data_research:'',
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
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "research_list",
        params: { Page: num_page }
      });
    },
    seeResearch(thisresearch) {
      this.$router.push({
        name: "research",
        params: { ResearchID: thisresearch }
      });
    }
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
        axios.get(this.$store.getters.getBase_Url+'Research/get_all_research_like/'+this.permission+'/'+search)
          .then(response => {
          // console.log(response.data)
          this.data_size = 0,
          this.find = response.data[0],
          this.data_research = response.data[1]
        })
          this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
  },
  computed: {
    the_user(){
      var user = this.$store.getters.getThe_User
      if(user == ''|| user == null || user == undefined){
        setTimeout(() => {
          this.text_alert = 'ผลงานวิจัย จะไม่แสดงหากไม่มีการ Login เข้าสู่ระบบ'
        },1000);
      }
      return user;
    },
    the_research() {
      var setpage = this.$route.params.Page;
      this.permission = this.the_user.m_type; //permission
      if(this.the_user == '' || this.the_user == undefined || this.the_user == null){
        this.permission = 0;
      }
      if(this.the_user.m_status == 'admin'){
        this.permission = 9;
      }
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Research/get_research/'+this.data_in_page+'/'+this.permission+'/'+setpage)
        .then(response => {
          // console.log(response.data),
          // console.log(permission),
          this.data_size = response.data[0],
          this.data_research = response.data[1]
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
      return this.data_research;
    }
  }
};
</script>

<style scoped>
.head1 {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
}
</style>