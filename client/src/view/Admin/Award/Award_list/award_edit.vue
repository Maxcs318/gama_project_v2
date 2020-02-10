<template>
  <div class="container" v-if="the_user && thisAward_list">
    <h3 class="header">
      <center>แก้ไขรายชื่อ ผู้รับรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAward_List">
          ผู้ได้รับรางวัล ( ชื่อเต็ม *** ชื่อจริง + นามสกุล )
          <input
            type="text"
            class="form-control"
            v-model="award_list.al_recipient"
            placeholder="ผู้ได้รับรางวัล"
            required
          />
          <br />
          <div class="row">
            <div class="col-lg-12 col-12">
              บริษัท
              <select v-model="award_list.al_company_id" class="form-control select" required>
                <!-- <option selected disabled value=''>Choose Company</option> -->
                <option class="option" v-for="comp in Company" :value="comp.c_id">{{ comp.c_title }}</option>
              </select>
              <br />
            </div>
            <div class="col-lg-6 col-12">
              ประเภทรางวัล
              <select v-model="award_list.al_award_type_id" class="form-control select" required>
                <!-- <option selected disabled value=''>Choose Award Type</option> -->
                <option class="option" v-for="at in Award_type" :value="at.at_id">{{ at.at_title }}</option>
              </select>
              <br />
            </div>
            <div class="col-lg-6 col-12">
              ปี
              <select v-model="award_list.al_year_id" class="form-control select" required>
                <!-- <option selected disabled value=''>Choose Year</option> -->
                <option class="option" v-for="ay in Award_year" :value="ay.ay_id">{{ ay.ay_title }}</option>
              </select>
              <br />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6"></div>
            <div class="col-lg-6">
              <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
              <br />
            </div>
          </div>
        </form>
        <br />
      </div>
      <div class="col-lg-3 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      award_list: null,
      data_load:false,

      data_award_year:'',
      data_load_award_year:false,

      data_award_type:'',
      data_load_award_type:false,

      data_company:'',
      data_load_company:false
    };
  },
  methods: {
    submitAward_List() {
      var jsonAward_list = JSON.stringify(this.award_list);
      var FD = new FormData();
      FD.append("award_list", jsonAward_list);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Award_list", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Award Recipient Success .", "", "success");
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
    thisAward_list() {
      var award_list_id = this.$route.params.Award_listID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Award/get_this_award/'+award_list_id)
        .then(response => {
          // console.log(response.data[0])
          this.award_list = response.data[0]
        })
        this.data_load = true
      }
      var this_award_list = this.award_list
      return this_award_list
    },
    Award_type() {
      if(this.data_load_award_type==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_award_type")
        .then(response => {
          // console.log(response)
          this.data_award_type = response.data
        })
      this.data_load_award_type = true
      }
      var award_type_all = this.data_award_type
      return award_type_all
    },
    Award_year() {
      if(this.data_load_award_year==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_award_years")
        .then(response => {
          // console.log(response)
          this.data_award_year = response.data
        })
      this.data_load_award_year = true
      }
      var award_year_all = this.data_award_year
      return award_year_all
    },
    Company() {
      if(this.data_load_company==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_company")
        .then(response => {
          // console.log(response)
          this.data_company = response.data
        })
      this.data_load_company = true
      }
      var company_all = this.data_company
      return company_all
    }
  }
};
</script>