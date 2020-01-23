<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>ปีที่รับรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-9 col-xs-12"></div>
      <div class="col-lg-3 col-xs-12">
        <button class="form-control btn-primary" @click="addaward_year">เพิ่มปีที่รับรางวัล</button>
        <br />
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%">ลำดับ</th>
            <th style="width:35%">ปีที่รับรางวัล</th>
            <th style="width:20%">วันที่สร้าง</th>
            <th style="width:20%">วันที่แก้ไข</th>
            <th style="width:10%"></th>
            <th style="width:10%"></th>
          </tr>
          <tr v-for="(Year,index) in Award_years" :key="index">
            <td>{{Year.ay_id}}</td>
            <td>{{Year.ay_title}}</td>
            <td>{{Year.ay_create_date}}</td>
            <td>{{Year.ay_update_date}}</td>
            <td>
              <button class="form-control btn-warning" @click="editAward_year(Year.ay_id)">แก้ไข</button>
            </td>
            <td>
              <button class="form-control btn-danger" @click="deleteAward_year(Year.ay_id)">ลบ</button>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    addaward_year() {
      this.$router.push("/addaward_year");
    },
    editAward_year(thisaward_year) {
      this.$router.push({
        name: "editaward_year",
        params: { Award_yearID: thisaward_year }
      });
    },
    deleteAward_year(thisaward_year) {
      // console.log(thisaward_year)
      var FD = new FormData();
      FD.append("award_yearID", JSON.stringify(thisaward_year));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure?",
        text: "You want delete this Award Year ID " + thisaward_year,
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.$store.dispatch("Delete_Award_year", FD);
          swal({ title: "Delete Success.", icon: "success" });
          // console.log(FD)
        } else {
          // swal("Your imaginary file is safe!");
        }
      });
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      // if( user.m_status != 'admin' ){
      // this.$router.go(-1)
      // }
      this.userstatus = user.m_status;
      return user;
    },
    Award_years() {
      return this.$store.getters.getAward_Years;
    }
  },
  created() {
    this.$store.dispatch("initDataAward_years");
  }
};
</script>
