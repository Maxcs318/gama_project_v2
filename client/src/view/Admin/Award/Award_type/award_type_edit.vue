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
import axios from "axios";
export default {
  data() {
    return {
      data_load:false,
      award_type: ''
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
      var award_type_id = this.$route.params.Award_typeID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Award/get_this_award_type/'+award_type_id)
        .then(response => {
          // console.log(response.data[0])
          this.award_type = response.data[0]
        })
        this.data_load = true
      }
      var this_award_type = this.award_type
      return this_award_type
    }
  }
};
</script>

