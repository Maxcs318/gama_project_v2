<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>เพิ่มบริษัท</center>
    </h3>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitCompany">
          ชื่อ บริษัท
          <input
            type="text"
            class="form-control"
            placeholder="ชื่อ บริษัท"
            v-model="company.c_title"
            required
          />
          <br />รายละเอียด
          <textarea
            v-model="company.c_detail"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="6"
          ></textarea>
          <br />
          <!-- <input type="text" class="form-control" v-model="company.c_detail" required> <br> -->
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
      company: {
        c_title: "",
        c_detail: ""
      }
    };
  },
  methods: {
    submitCompany() {
      var jsonCompany = JSON.stringify(this.company);
      var FD = new FormData();
      FD.append("company", jsonCompany);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Add_Company", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Company Success .", "", "success");
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

