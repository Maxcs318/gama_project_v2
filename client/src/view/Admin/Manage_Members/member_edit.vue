<template>
  <div class="container" v-if="the_user">
    <center>
      <h4 class="header">แก้ไขโปรไฟล์</h4>
    </center>
    <br />
    <div class="row" v-if="this_user_edit">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <img
          class=" "
          v-if="this_user_edit.m_imageprofile != '' && url == null"
          :src="getImgUrl(this_user_edit.m_imageprofile)"
          width="100%"
        />
        <img
          class=" "
          v-if="this_user_edit.m_imageprofile == '' && url== null"
          :src=" this.path_files+'Profile_Image/default_profile.jpg'"
          width="100%"
        />
        <img class=" " v-if="url" :src="url" width="100%" />
        <br />
        <br />
        <button type="button" class="btn form-control col-6 btn-success block-center" @click="ChooseFiles">เปลี่ยนรูป</button>
        <br />
        <br />
        <form @submit.prevent="submitEditProfile">
          <input
            id="chooseImage"
            ref="files"
            style="display: none;"
            type="file"
            @change="handleFiles"
          />
          ชื่อจริง (ไทย)
          <input
            type="text"
            v-model="E_member.m_firstname"
            class="form-control"
            required
          />
          <br />นามสกุล (ไทย)
          <input type="text" v-model="E_member.m_lastname" class="form-control" required/>
          <br />ชื่อจริง (อังกฤษ)
          <input
            type="text"
            v-model="E_member.m_firstname_eng"
            class="form-control" required
          />
          <br />นามสกุล (อังกฤษ)
          <input type="text" v-model="E_member.m_lastname_eng" class="form-control" required/>
          <br />Username
          <input type="text" v-model="E_member.m_username" class="form-control" required/>
          <br />

          <!-- Status 
          <input type="text" v-model="E_member.m_status" class="form-control " ><br>-->
          บริษัท
          <input type="text" v-model="E_member.m_company" class="form-control" required/>
          <br />เบอร์โทรศัพท์
          <input type="text" v-model="E_member.m_phone" class="form-control" required/>
          <br />อีเมลล์
          <input type="email" v-model="E_member.m_email" class="form-control" required/>
          <br />สถาบัน
          <input type="text" v-model="E_member.m_institute" class="form-control" required/>
          <br />ที่อยู่
          <input type="text" v-model="E_member.m_address" class="form-control" required/>
          <br />

          <!-- <div
            v-for="m_up in Member_Upgrade_Date"
          >
            <div v-for="m_up_type in Member_Type" v-if="m_up.mud_member_type_id == m_up_type.mt_id">
              ระดับสมาชิกตอนนี้ : {{m_up_type.mt_name}}
              <br />
              หมดอายุ : {{m_up.mud_date_end}}
            </div>
            <br />
          </div> -->
          <div class="row" v-if="Member_Upgrade_Date">
            <!-- {{Member_Upgrade_Date}} -->
            <div class="col-12" v-for="type in Member_Type">
              <p style="text-align: center;" v-if="type.mt_id == data_upgrade_date.mud_member_type_id">
              ระดับสมาชิกตอนนี้ :   {{ type.mt_name }}
              </p>
            </div>
            <div class="col-12">
              <p style="text-align: center;"> หมดอายุ : {{data_upgrade_date.mud_date_end}} </p>
            </div>
            
          </div>
          <div class="row">
            <div class="col-lg-6">
              ระดับสมาชิก
              <select v-model="E_member.m_type" class="form-control select" required>
                <option
                class="option"
                  v-for="(mt,index) in Member_Type"
                  :key="index"
                  :value="mt.mt_id"
                >{{ mt.mt_name }}</option>
              </select>
              <br />
            </div>
            <!-- ต่อแบบ Full -->
            <div class="col-lg-6" v-if="E_member.m_type == 2">
              ระยะเวลาต่ออายุ 
              <!-- {{upgrade_time}} -->
              <select v-model="upgrade_time" class="form-control select">
                <option class="option" selected value=''>Choose Time</option>
                <option class="option" v-for="u_time in 3" :value="(u_time*2-1)*12">{{u_time*2-1}} Year</option>
              </select>
            </div>
            <!-- ต่อแบบ Gold -->
            <div class="col-lg-6" v-if="E_member.m_type == 3">
              ระยะเวลาต่ออายุ 
              <!-- {{upgrade_time}} -->
              <select v-model="upgrade_time" class="form-control select">
                <option class="option" selected value=''>Choose Time</option>
                <option class="option" v-for="u_time in 1" :value="u_time*12">{{u_time}} Year</option>
              </select>
            </div>
          </div>ยืนยันรหัสของแอดมิน เพื่อทำการเปลี่ยนแปลงผู้ใช้
          <input
            type="password"
            v-model="passwordCheck"
            class="form-control"
            placeholder="รหัสผ่าน แอดมิน ของคุณ"
            required
          />
          <br />

          <!-- <hr> -->
          <!-- ID : {{this_user_edit.m_id}}<br>
                ID number : {{this_user_edit.m_id_number}}<br>
                Status : {{this_user_edit.m_status}}<br>
                Member Type : {{this_user_edit.m_type}}<br>
                Upgrade Date ID : {{this_user_edit.m_upgrade_date_id}}<br>
                Join in : {{this_user_edit.m_create_date}}<br>
                Last Edit : {{this_user_edit.m_update_date}}<br>
          Password : {{this_user_edit.m_password}}-->
          <div class="row">
            <div class="col-lg-8 col-xs-12"></div>
            <div class="col-lg-4 col-xs-12">
              <button class="form-control btn-primary">ดำเนินการต่อ</button>
            </div>
          </div>
          <br />
        </form>
      </div>
      <div class="col-lg-3 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
import md5 from "js-md5";
import axios from "axios";
export default {
  data() {
    return {
      E_member: "",
      upgrade_time: "",
      password_admin: "",
      passwordCheck: "",
      url: null,
      fileimage: "",

      data_member:'',
      data_load_member:false,

      data_load_member_type:false,
      data_member_type:'',

      data_upgrade_date:'',
      data_load_upgrade_date:false,

      chk_username:'YES',
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Profile_Image/" + pic;
    },
    ChooseFiles() {
      document.getElementById("chooseImage").click();
    },
    handleFiles(e) {
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.files.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    submitEditProfile() {
      var chk = md5(this.passwordCheck);
      
        ///////////////////////////////////////////////
    
            var FD = new FormData();
            FD.append("username", JSON.stringify(this.E_member.m_username));
            FD.append("id", JSON.stringify(this.E_member.m_id));

            axios.post(this.$store.getters.getBase_Url+'User/check_user_already',FD)
            .then(response => {
                console.log(response.data)
                this.chk_username = response.data
            })

        ///////////////////////////////////////////////

      if (chk != this.password_admin) {
        this.$swal(" Confirm Password Incorrect .", "", "error");
        this.passwordCheck = "";
      } else {
        if (this.E_member.m_type == 1) {
          this.upgrade_time = "";
        }
        setTimeout(() => {
          if (this.chk_username == "YES") {
            var jsonProfile = JSON.stringify(this.E_member);
            var FD = new FormData();

            if (this.url != null || this.url != "") {
              FD.append("userfile", this.fileimage);
            }
            FD.append("profile", jsonProfile);
            FD.append("own_id", JSON.stringify(this.$store.state.log_on));
            FD.append("upgrade_time", this.upgrade_time); // time use for upgrade
            this.$store.dispatch("Edit_Profile_BY_Admin", FD);

            setTimeout(() => {
              this.$router.go(-1);
            }, 2000);
            this.$swal("Edit Profile Success .", "", "success");
            this.passwordCheck = "";
          } else {
            this.$swal("This Username Is Already Taken. .", "", "error");
            this.passwordCheck = "";
          }
        },100);
      }
    }
  },
  watch: {
    $route (to, from){
      this.data_load = false;
    },
    the_user(){
      this.data_load = false;
      this.searching = ''
    },
    type_chang(){
      this.upgrade_time=''
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1);
      }
      return user;
    },
    this_user_edit() {
      var this_member_id = this.$route.params.MemberID
      if(this.data_load_member==false){
          axios.get(this.$store.getters.getBase_Url+'User/get_this_member/'+this_member_id)
          .then(response => {
              // console.log(response.data)
              this.data_member = response.data
          })
          this.data_load_member = true
      }
      var member_all = this.data_member

      this.E_member = this.data_member
      this.password_admin = this.the_user.m_password;
      return member_all;
    },
    Member_Type() {
      if(this.data_load_member_type==false){
          axios.get(this.$store.getters.getBase_Url+'User/get_all_member_type')
          .then(response => {
              // console.log(response.data)
              this.data_member_type = response.data
          })
          this.data_load_member_type = true
      }
      var member_type_all = this.data_member_type
      return member_type_all
    },
    Member_Upgrade_Date() {
      var upgrade_date_last = this.this_user_edit.m_upgrade_date_id
      if(this.data_load_upgrade_date==false){
          axios.get(this.$store.getters.getBase_Url+'User/get_member_upgrade_date_by_id/'+upgrade_date_last)
          .then(response => {
              // console.log(response.data)
              this.data_upgrade_date = response.data
          })
          this.data_load_upgrade_date = true
      }
      var upgrade_date = this.data_upgrade_date
      return upgrade_date
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    type_chang(){
      return this.E_member.m_type
    }
  }
};
</script>