<template>
  <div class="container" v-if="the_user">
    <h3 class="header">
      <center>ประเภทรางวัล</center>
    </h3>
    <div class="row">
      <div class="col-lg-9 col-xs-12"></div>
      <div class="col-lg-3 col-xs-12">
        <button class="form-control btn-primary" @click="addaward_type">เพิ่มประเภทรางวัล</button>
        <br />
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%">ลำดับ</th>
            <th style="width:35%">ชื่อ ประเภทรางวัล</th>
            <th style="width:20%">วันที่เผยแพร่</th>
            <th style="width:20%">วันที่แก้ไข</th>
            <th style="width:10%"></th>
            <th style="width:10%"></th>
          </tr>
          <tr v-for="(type,index) in Award_type" :key="index">
            <td>{{type.at_id}}</td>
            <td>{{type.at_title}}</td>
            <td>{{type.at_create_date}}</td>
            <td>{{type.at_update_date}}</td>
            <td>
              <button class="form-control btn-warning" @click="editAward_type(type.at_id)">แก้ไข</button>
            </td>
            <td>
              <button class="form-control btn-danger" @click="deleteAward_type(type.at_id)">ลบ</button>
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
      data_award_type:''
    }
  },
  methods: {
    addaward_type() {
      this.$router.push("/addaward_type");
    },
    editAward_type(thisaward_type) {
      this.$router.push({
        name: "editaward_type",
        params: { Award_typeID: thisaward_type }
      });
    },
    deleteAward_type(thisaward_type) {
      // console.log(thisaward_type)
      var FD = new FormData();
      FD.append("award_typeID", JSON.stringify(thisaward_type));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure?",
        text: "You want delete this Award type ID " + thisaward_type,
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.$store.dispatch("Delete_Award_type", FD);
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
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      // if( user.m_status != 'admin' ){
      // this.$router.go(-1)
      // }
      this.userstatus = user.m_status;
      return user;
    },
    Award_type() {
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_award_type")
        .then(response => {
          // console.log(response)
          this.data_award_type = response.data
        })
      this.data_load = true
      }
      var award_type_all = this.data_award_type
      return award_type_all
    }
  }
};
</script>
