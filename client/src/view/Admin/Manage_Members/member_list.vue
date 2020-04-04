<template>
  <div class="container" v-if="the_user && the_user.m_status=='admin'">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h4 class="header">
          <center>การจัดการสมาชิก</center>
        </h4>
        <div class="row">
          <div class="col-lg-6 col-12">
          </div>
          <div class="col-lg-6 col-12">
            <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จาก Username (ชื่อผู้ใช้) ทั้งหมด">
            <p v-if="searching!=''" style="text-align: right;"> <br>
            เจอทั้งหมด {{find}} รายการ
            </p>    
          </div>
        </div>
        <table class="table" style="width:100%" v-if="Members">
          <tr style="width:100%">
            <th style="width:5%">ID</th>
            <th style="width:10%">Username</th>
            <th style="width:15%">ชื่อจริง</th>
            <th style="width:15%">นามสกุล</th>
            <th style="width:15%">ชื่อจริง (Eng)</th>
            <th style="width:15%">นามสกุล (Eng)</th>
            <th style="width:15%">ระดับสมาชิก</th>
            <th style="width:10%"></th>
          </tr>
          <tr
            v-for="(member,index) in data_member"
            :key="index"
          >
            <td>{{member.m_id}}</td>            
            <td>{{member.m_username}}</td>
            <td>{{member.m_firstname.slice(0,35)}}</td>
            <td>{{member.m_lastname}}</td>
            <td>{{member.m_firstname_eng}}</td>
            <td>{{member.m_lastname_eng}}</td>
            <td>
              <div v-for="mt in Member_Type" v-if="mt.mt_id == member.m_type">{{mt.mt_name}}</div>
            </td>
            <td>
              <button class="form-control btn-warning" @click="editMember(member.m_id)">แก้ไข</button>
            </td>
          </tr>
        </table>
        <!-- {{Member_Type}} -->
        <br />
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

      data_member:'',
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


      data_load_member_type:false,
      data_member_type:''
    };
  },
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "AdminM",
        params: { Page: num_page }
      });
    },
    editMember(thismemberID) {
      // console.log(thismemberID)
      this.$router.push({
        name: "editmember_by_admin",
        params: { MemberID: thismemberID }
      });
    }
  },
  watch: {
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
        axios.get(this.$store.getters.getBase_Url+'User/get_all_username_like/'+search)
        .then(response => {
            // console.log(response.data)
            this.data_size = 0,
            this.find = response.data[0],
            this.data_member = response.data[1]
        })
        this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    },
    Member_Type() {
      if(this.data_load_member_type==false){
          axios.get(this.$store.getters.getBase_Url+'User/get_all_member_type')
          .then(response => {
              // console.log(response.data)
              this.data_member_type = response.data
          })
          this.data_load_member_type = true
      }
      var member_type_all = this.data_member_type
      return member_type_all
    },
    Members() {
      var setpage = this.$route.params.Page;
      if(this.data_load==false && this.data_in_page){
          var FD = new FormData();
          FD.append("number_of_row", JSON.stringify(this.data_in_page));
          FD.append("pagenow", JSON.stringify(setpage));

          axios.post(this.$store.getters.getBase_Url+'User/get_member_all_by_admin',FD)
          .then(response => {
              // console.log(response.data)
              this.data_size = response.data[0],
              this.data_member = response.data[1]
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
      return this.data_member;
    }
  }
};
</script>