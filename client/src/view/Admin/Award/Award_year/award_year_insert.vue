<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>เพิ่ม ปีที่รับรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAward_year">
          ปีที่รับรางวัล
          <input
            type="text"
            class="form-control"
            v-model="award_year.ay_title"
            placeholder="ปีที่รับรางวัล"
            required
          />
          <br />รายละเอียด
          <textarea
            v-model="award_year.ay_detail"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="6"
          ></textarea>
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
export default {
  data() {
    return {
      award_year: {
        ay_title: "",
        ay_detail: ""
      }
    };
  },
  methods: {
    submitAward_year() {
      var jsonAward_year = JSON.stringify(this.award_year);
      var FD = new FormData();
      FD.append("award_year", jsonAward_year);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Add_Award_year", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Award Year Success .", "", "success");
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    }
  }
};
</script>

