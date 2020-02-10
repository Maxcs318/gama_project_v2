<template>
  <div class="container" v-if="thisOnline_Journal && the_user">
    <center>
      <h4 class="header">
        แก้ไขวารสารออนไลน์
        <br />
        ID : {{ this.$route.params.Online_JournalID }}
      </h4>
    </center>
    <div class="row mt-5">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12">
        <form @submit.prevent="submitOnline_Journal">
          หัวเรื่อง
          <input
            type="text"
            v-model="online_journalE.oj_title"
            class="form-control"
            placeholder="หัวเรื่อง"
            required
          />
          <br />รายละเอียด
          <textarea
            v-model="online_journalE.oj_detail"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="6"
          ></textarea>
          <br />ลักษณะเพิ่มเติม
          <textarea
            v-model="online_journalE.oj_description"
            class="form-control textarea"
            placeholder="ลักษณะเพิ่มเติม"
            rows="2"
          ></textarea>
          <br />สิทธิ์การเข้าถึง
          <div class="row">
            <div class="col-lg-6 col-xs-12">
              <select v-model="online_journalE.oj_permission" class="form-control select" required>
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
          <div v-if="online_journal_data_file != null" v-for="(file,run) in online_journal_data_file">
            <a :href="loadFile(file.f_name)" download>Dowload File {{run+1}}</a>
            {{file.f_title}}
            <button
              type="button"
              class="btn btn-danger col-lg-1"
              @click="RemoveFile(file.f_id,file.f_title)"
            >ลบ</button>
            <br />
            <br />
          </div>
          <br />
          <h5>Files [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
          <br />
          <div class="row" v-for="(f,index) in files" :key="index">
            <div class="col-lg-10 col-xs-12">
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
            <div class="col-lg-2 col-xs-12">
              <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
              <br />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6">
              <input
                type="file"
                ref="files"
                style="display: none;"
                id="FileUpload1"
                @change="handleFileUpload"
                multiple
              />
              <button
                type="button"
                class="form-control btn-primary col-lg-12"
                @click="ChooseFiles"
              >เลือกไฟล์</button>
              <br />
            </div>
            <div class="col-lg-6">
              <button type="submit" class="form-control btn-primary col-lg-12">ดำเนินการต่อ</button>
              <br />
            </div>
          </div>
        </form>
      </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      online_journalE: "",
      file_title: [],
      files: [],
      max_size_file: 0,

      text_alert:'',
      mem_type_all:'',
      data_load:false,

      online_journal_data:'',
      online_journal_data_file:'',
      data_load_oj:false,

      check_delete_file:false
    };
  },
  methods: {
    loadFile(fi) {
      return this.path_files + "Online_Journal_Files_Upload/" + fi;
    },
    // choose files
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
    //delete file
    RemoveFile: function(fileID,fileName) {
      
      var FD_delete = new FormData();
      FD_delete.append("fileID", fileID);
      FD_delete.append("creator", JSON.stringify(this.$store.state.log_on));
      
      this.$swal({
          title: "Are you sure?",
          text: "You want delete this Filse Name "+fileName,
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
        if (willDelete) {
          this.$store.dispatch("Delete_File", FD_delete);
          setTimeout(() => {
            this.check_delete_file=true
            this.data_load_oj=false
          },100);
          swal({title: "Delete Success.",icon: "success",});
        } else {
          //
        }
      })

    },
    //submit
    submitOnline_Journal() {
      var jsonOnline_Journal = JSON.stringify(this.online_journalE);
      var jsonFiles_Title = JSON.stringify(this.file_title);
      var FD = new FormData();
      if (this.url != null || this.url != "") {
        FD.append("userfile", this.fileimage);
      }
      if (this.files.length != 0) {
        for (var i = 0; i < this.files.length; i++) {
          FD.append("userfileupload" + i, this.files[i]);
        }
        FD.append("file_title", jsonFiles_Title);
      }
      FD.append("online_journal", jsonOnline_Journal);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Online_Journal", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Online_Journal Success .", "", "success");
    }
  },
  watch:{
    $route (to, from){
      this.data_load = false;
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisOnline_Journal() {
      var online_j_ID = this.$route.params.Online_JournalID;
      var permission = this.the_user.m_type; //permission
      if(this.the_user == '' || this.the_user == undefined || this.the_user == null){
          permission = 0;
      }
      if(this.the_user.m_status == 'admin'){
        permission = 9;
      }
      if(this.data_load_oj == false && permission){
        axios.get(this.$store.getters.getBase_Url+'Online_journal/get_this_online_journal/'+permission+'/'+online_j_ID)
        .then(response => {
            // console.log(response.data)
            this.online_journal_data = response.data[0][0],
            this.online_journal_data_file = response.data[1]
        })
        this.data_load_oj = true
        if(this.online_journal_data.length == 0){
            setTimeout(() => {
                this.text_alert = 'This Page No Data.'
            },1000);
        }
      }

      if(this.check_delete_file == false){
        this.online_journalE = this.online_journal_data
      }
      
      var online_journal_show = this.online_journal_data
      return online_journal_show;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1);
      }
      return user;
    },
    Member_Type() {
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'User/get_all_member_type')
        .then(response => {
            // console.log(response.data) 
            this.mem_type_all = response.data
        })
        this.data_load = true
      }
      var member_type_all = this.mem_type_all
      return member_type_all
    }
  }
};
</script>