<template>
  <div>
    <div>
      <div class="container" v-if="the_user">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <h4 class="header">
              <center>เพิ่ม วารสารออนไลน์</center>
            </h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12">
            <form @submit.prevent="submitOnline_Journal">
              <input
                type="text"
                v-model="online_journal.oj_title"
                class="form-control"
                placeholder="หัวเรื่อง"
                required
              />
              <br />
              <textarea
                v-model="online_journal.oj_detail"
                class="form-control textarea"
                placeholder="รายละเอียด"
                rows="6"
              ></textarea>
              <br />
              <textarea
                v-model="online_journal.oj_description"
                class="form-control textarea"
                placeholder="ลักษณะเพิ่มเติม"
                rows="2"
              ></textarea>
              <br />สิทธิ์การเข้าถึง
              <div class="row">
                <div class="col-lg-6 col-xs-12">
                  <select
                    v-model="online_journal.oj_permission"
                    class="form-control select"
                    required
                  >
                    <option class="option" selected disabled value>กำหนดสิทธิ์การเข้าถึง</option>
                    <option
                      class="option"
                      v-for="(mt,index) in Member_Type"
                      :key="index"
                      :value="mt.mt_id"
                    >ตั้งแต่ {{ mt.mt_name }} ขึ้นไป</option>
                  </select>
                </div>
              </div>
              <br />
              <h5>Files [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
              <input
                type="file"
                ref="files"
                style="display: none;"
                id="FileUpload1"
                @change="handleFileUpload"
                multiple
              />
              <br />
              <div class="row" v-for="(f,index) in files" :key="index">
                <div class="col-lg-10">
                  <input
                    type="text"
                    class="form-control"
                    v-model="file_title[index]"
                    placeholder="File Title"
                    required
                  />
                  <b>{{index+1}}. File</b>
                  {{files[index].name }}
                  <b>Size</b>
                  {{files[index].size}} byte
                  <br />
                  <br />
                </div>
                <div class="col-lg-2">
                  <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
                  <br />
                </div>
              </div>
              <br />
              <div class="row">
                <div class="col-lg-6">
                  <button
                    type="button"
                    class="form-control btn-primary col-lg-12"
                    @click="ChooseFiles"
                  >เลือกไฟล์</button>
                  <br />
                </div>
                <div class="col-lg-6">
                  <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
                  <br />
                </div>
              </div>
            </form>
          </div>
          <div class="col-lg-3 col-xs-12"></div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      online_journal: {
        oj_title: "",
        oj_detail: "",
        oj_description: "",
        oj_permission: "",
        oj_create_date: ""
      },
      files: [],
      max_size_file: 0,
      file_title: []
    };
  },
  methods: {
    // files
    ChooseFiles() {
      document.getElementById("FileUpload1").click();
    },
    handleFileUpload(event) {
      this.files = [];
      this.file_title = [];

      var i = 0;
      let uploadedFiles = this.$refs.files.files;
      for (var i = 0; i < uploadedFiles.length; i++) {
        this.files.push(uploadedFiles[i]);
        this.max_size_file = this.max_size_file + uploadedFiles[i].size;
      }
      if (this.max_size_file > 10000000) {
        this.files = [];
        this.max_size_file = 0;
        // alert
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    RemoveRow: function(index) {
      this.max_size_file = this.max_size_file - this.files[index].size;
      this.files.splice(index, 1);
      this.file_title.splice(index, 1);
    },
    //submit
    submitOnline_Journal() {
      var jsonOnline_Journal = JSON.stringify(this.online_journal);
      var jsonFiles_Title = JSON.stringify(this.file_title);
      var FD = new FormData();
      if (this.files.length != 0) {
        for (var i = 0; i < this.files.length; i++) {
          FD.append("userfileupload" + i, this.files[i]);
        }
        FD.append("file_title", jsonFiles_Title);
      }
      FD.append("online_journal", jsonOnline_Journal);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Add_Online_Journal", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Online Journal Success .", "", "success");
    }
  },
  computed: {
    Member_Type() {
      return this.$store.getters.getMember_Type;
    },
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