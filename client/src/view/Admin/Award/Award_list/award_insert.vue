<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>เพิ่มรายชื่อ ผู้ได้รับรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAward_List">
          ผู้ได้รับรางวัล ( ชื่อเต็ม *** ชื่อจริง + นามสกุล )
          <br />
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
                <option class="option" selected disabled value>เลือก บริษัท</option>
                <option class="option" v-for="comp in Company" :value="comp.c_id">{{ comp.c_title }}</option>
              </select>
              <br />
            </div>
            <div class="col-lg-6 col-12">
              ประเภทรางวัล
              <select v-model="award_list.al_award_type_id" class="form-control select" required>
                <option class="option" selected disabled value>เลือก ประเภทรางวัล</option>
                <option class="option" v-for="at in Award_type" :value="at.at_id">{{ at.at_title }}</option>
              </select>
              <br />
            </div>
            <div class="col-lg-6 col-12">
              ปีที่รับรางวัล
              <select v-model="award_list.al_year_id" class="form-control select" required>
                <option class="option" selected disabled value>เลือก ปีที่รับรางวัล</option>
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
export default {
  data() {
    return {
      award_list: {
        al_recipient: "",
        al_company_id: "",
        al_year_id: "",
        al_award_type_id: ""
      }
    };
  },
  methods: {
    submitAward_List() {
      var jsonAward_list = JSON.stringify(this.award_list);
      var FD = new FormData();
      FD.append("award_list", jsonAward_list);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Add_Award_list", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Award Recipient Success .", "", "success");
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
    Award_type() {
      return this.$store.getters.getAward_Type;
    },
    Award_year() {
      return this.$store.getters.getAward_Years;
    },
    Company() {
      return this.$store.getters.getCompany;
    }
  }
};
</script>
