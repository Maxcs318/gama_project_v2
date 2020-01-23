<template>
  <div class="container" v-if="the_user && thisAward_type">
    <h3 class="header">
      <center>แก้ไขประเภทรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAward_type">
          ชื่อประเภทรางวัล
          <input
            type="text"
            class="form-control"
            v-model="award_type.at_title"
            placeholder="ชื่อประเภทรางวัล"
            required
          />
          <br />รายละเอียด
          <textarea v-model="award_type.at_detail" class="form-control textarea" placeholder="รายละเอียด" rows="6"></textarea>
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
      award_type: []
    };
  },
  methods: {
    submitAward_type() {
      var jsonAward_type = JSON.stringify(this.award_type);
      var FD = new FormData();
      FD.append("award_type", jsonAward_type);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Award_type", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Award Type Success .", "", "success");
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
    thisAward_type() {
      var award_typeAll = this.$store.getters.getAward_Type;
      var this_award_type;
      for (var i = 0; i < award_typeAll.length; i++) {
        if (award_typeAll[i].at_id == this.$route.params.Award_typeID) {
          this_award_type = award_typeAll[i];
        }
      }
      this.award_type = this_award_type;
      return this_award_type;
    }
  }
};
</script>

