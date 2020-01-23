<template>
  <div class="container" v-if="the_user">
    <center>
      <h4 class="header">เพิ่มห้องวีดีโอ</h4>
    </center>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitCreateRoom">
          <h5>ชื่อห้อง</h5>
          <input v-model="createR.vr_title" type="text" class="form-control" placeholder="ชื่อห้อง" />
          <br />
          <h5>รายละเอียด</h5>
          <textarea
            v-model="createR.vr_description"
            class="form-control textarea"
            rows="6"
            placeholder="รายละเอียด"
          ></textarea>
          <br />
          <div class="row">
            <div class="col-lg-6 col-xs-6"></div>
            <div class="col-lg-6 col-xs-6">
              <button class="form-control btn-primary" type="submit">ดำเนินการต่อ</button>
            </div>
          </div>
        </form>
      </div>
      <div class="col-lg-3 col-xs-12"></div>
      <!-- Name : {{createR.vr_title}} <br> Des  : {{createR.vr_description}} <br> -->
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      createR: {
        vr_title: "",
        vr_description: ""
      }
    };
  },
  methods: {
    submitCreateRoom() {
      var FD = new FormData();
      FD.append("room", JSON.stringify(this.createR));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("CreateRoom", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 1000);
      this.$swal("Create Room Success .", "", "success");
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>
