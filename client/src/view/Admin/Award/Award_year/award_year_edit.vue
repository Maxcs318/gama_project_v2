<template>
  <div class="container" v-if="the_user && thisAward_year">
    <h3 class="header">
      <center>แก้ไข ปีที่รับรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAward_year">
          ปีที่รับรางวัล
          <input type="text" class="form-control" placeholder="ปีที่รับรางวัล" v-model="award_year.ay_title" required />
          <br />รายละเอียด
          <textarea v-model="award_year.ay_detail" class="form-control textarea" placeholder="รายละเอียด" rows="6"></textarea>
          <br />
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
      data_load:false,
      award_year: ''
    };
  },
  methods: {
    submitAward_year() {
      var jsonAward_year = JSON.stringify(this.award_year);
      var FD = new FormData();
      FD.append("award_year", jsonAward_year);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Award_year", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Award Year Success .", "", "success");
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
    thisAward_year() {
      var award_year_id = this.$route.params.Award_yearID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Award/get_this_award_year/'+award_year_id)
        .then(response => {
          // console.log(response.data[0])
          this.award_year = response.data[0]
        })
        this.data_load = true
      }
      var this_award_year = this.award_year
      return this_award_year
    }
  }
};
</script>

