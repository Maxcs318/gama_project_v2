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
          class="admin-img"
          v-if="this_user_edit.m_imageprofile != '' && url == null"
          :src="getImgUrl(this_user_edit.m_imageprofile)"
          width="100%"
        />
        <img
          class="admin-img"
          v-if="this_user_edit.m_imageprofile == '' && url== null"
          :src=" this.path_files+'Profile_Image/default_profile.jpg'"
          width="100%"
        />
        <img class="admin-img" v-if="url" :src="url" width="100%" />
        <br />
        <br />
        <button type="button" class="btn btn-success block-center" @click="ChooseFiles">เปลี่ยนรูป</button>
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
          />
          <br />นามสกุล (ไทย)
          <input type="text" v-model="E_member.m_lastname" class="form-control" />
          <br />ชื่อจริง (อังกฤษ)
          <input
            type="text"
            v-model="E_member.m_firstname_eng"
            class="form-control"
          />
          <br />นามสกุล (อังกฤษ)
          <input type="text" v-model="E_member.m_lastname_eng" class="form-control" />
          <br />Username
          <input type="text" v-model="E_member.m_username" class="form-control" />
          <br />

          <!-- Status 
          <input type="text" v-model="E_member.m_status" class="form-control " ><br>-->
          บริษัท
          <input type="text" v-model="E_member.m_company" class="form-control" />
          <br />เบอร์โทรศัพท์
          <input type="text" v-model="E_member.m_phone" class="form-control" />
          <br />อีเมลล์
          <input type="email" v-model="E_member.m_email" class="form-control" />
          <br />สถาบัน
          <input type="text" v-model="E_member.m_institute" class="form-control" />
          <br />ที่อยู่
          <input type="text" v-model="E_member.m_address" class="form-control" />
          <br />

          <div
            v-for="m_up in Member_Upgrade_Date"
            v-if="m_up.mud_id == this_user_edit.m_upgrade_date_id"
          >
            <div v-for="m_up_type in Member_Type" v-if="m_up.mud_member_type_id == m_up_type.mt_id">
              ระดับสมาชิกตอนนี้ : {{m_up_type.mt_name}}
              <br />
              หมดอายุ : {{m_up.mud_date_end}}
            </div>
            <br />
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
            <div class="col-lg-6" v-if="E_member.m_type != 1">
              ระยะเวลาต่ออายุ {{upgrade_time}}
              <select v-model="upgrade_time" class="form-control select">
                <option class="option" selected value>Choose Time</option>
                <option class="option" v-for="u_time in 12" :value="u_time">{{u_time}} Month</option>
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
export default {
  data() {
    return {
      E_member: "",
      upgrade_time: "",
      password_admin: "",
      passwordCheck: "",
      url: null,
      fileimage: ""
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
      var chk_username = "YES";
      for (var i = 0; i < this.MemberAll.length; i++) {
        if (
          this.E_member.m_username == this.MemberAll[i].m_username &&
          this.E_member.m_id != this.MemberAll[i].m_id
        ) {
          chk_username = "NO";
        }
        // console.log(chk_username,this.E_member.m_id,this.MemberAll[i].m_id)
      }
      if (chk != this.password_admin) {
        this.$swal(" Confirm Password Incorrect .", "", "error");
        this.passwordCheck = "";
      } else {
        if (this.E_member.m_type == 1) {
          this.upgrade_time = "";
        }
        if (chk_username == "YES") {
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
      }
    }
  },
  computed: {
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    },
    MemberAll() {
      return this.$store.getters.getMembers;
    },
    this_user_edit() {
      var memberAll = this.$store.getters.getMembers;
      var user;
      var admin = this.$store.getters.getThe_User;
      for (var i = 0; i < memberAll.length; i++) {
        if (memberAll[i].m_id == this.$route.params.MemberID) {
          user = memberAll[i];
        }
      }
      this.E_member = user;
      this.password_admin = admin.m_password;
      return user;
    },
    Member_Type() {
      return this.$store.getters.getMember_Type;
    },
    Member_Upgrade_Date() {
      return this.$store.getters.getMember_Upgrade_Date;
    },
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  created() {
    this.$store.dispatch("initApp");
    this.$store.dispatch("initDataMember_Upgrade_Date");
  }
};
</script>