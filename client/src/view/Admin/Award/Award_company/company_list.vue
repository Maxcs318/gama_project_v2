<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>รายชื่อ บริษัท</center>
    </h3>
    <div class="row">
      <div class="col-lg-9 col-xs-12"></div>
      <div class="col-lg-3 col-xs-12">
        <button class="form-control btn-primary" @click="addcompany">เพิ่มบริษัท</button>
        <br />
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%">ลำดับ</th>
            <th style="width:35%">ชื่อบริษัท</th>
            <th style="width:20%">วันที่สร้าง</th>
            <th style="width:20%">วันที่แก้ไข</th>
            <th style="width:10%"></th>
            <th style="width:10%"></th>
          </tr>
          <tr v-for="(comp,index) in Company" :key="index">
            <td>{{comp.c_id}}</td>
            <td>{{comp.c_title}}</td>
            <td>{{comp.c_create_date}}</td>
            <td>{{comp.c_update_date}}</td>
            <td>
              <button class="form-control btn-warning" @click="editCompany(comp.c_id)">แก้ไข</button>
            </td>
            <td>
              <button class="form-control btn-danger" @click="deleteCompany(comp.c_id)">ลบ</button>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data(){
    return{
      data_load:false,
      data_company:''
    }
  },
  methods: {
    addcompany() {
      this.$router.push("/addcompany");
    },
    editCompany(thiscompany) {
      this.$router.push({
        name: "editcompany",
        params: { CompanyID: thiscompany }
      });
    },
    deleteCompany(thiscompany) {
      // console.log(thiscompany)
      var FD = new FormData();
      FD.append("companyID", JSON.stringify(thiscompany));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure?",
        text: "You want delete this Company ID " + thiscompany,
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.$store.dispatch("Delete_Company", FD);
          swal({ title: "Delete Success.", icon: "success" });
          setTimeout(() => {
            this.data_load=false
          },100);
          // console.log(FD)
        } else {
          // swal("Your imaginary file is safe!");
        }
      });
    }
  },
  computed:{
    the_user() {
      var user = this.$store.getters.getThe_User;
      // if( user.m_status != 'admin' ){
      // this.$router.go(-1)
      // }
      this.userstatus = user.m_status;
      return user;
    },
    Company() {
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_company")
        .then(response => {
          // console.log(response)
          this.data_company = response.data
        })
      this.data_load = true
      }
      var company_all = this.data_company
      return company_all
    }
  }
};
</script>
