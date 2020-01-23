<template>
  <div class="container" v-if="thisResearch">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h4 class="head1">
          <center>งานวิจัย : {{researchE.r_title}}</center>
        </h4>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-2 col-xs-12"></div>
      <div class="col-lg-8 col-xs-12">
        <p>หัวข้อ : {{researchE.r_title}}</p>
        <br />
        <p>หัวข้อทางเลือก : {{researchE.r_titlealternative}}</p>
        <br />
        <!-- Creator : {{researchE.r_creator}}
        <br>-->
        <p>เรื่อง : {{researchE.r_subject}}</p>
        <br />
        <p>รายละเอียด : {{researchE.r_description}}</p>
        <br />
        <p>ผู้เผยแพร่ : {{researchE.r_publisher}}</p>
        <br />
        <p>วันที่เผยแพร่ : {{researchE.r_createddate}}</p>
        <br />
        <p>วันที่แก้ไข : {{researchE.r_modifieddate}}</p>
        <br />
        <p>วันที่ตีพิมพ์ : {{researchE.r_issueddate}}</p>
        <br />
        <p>ประเภท : {{researchE.r_type}}</p>
        <br />
        <p>ขนาด : {{researchE.r_format}}</p>
        <br />
        <p>แหล่งข้อมูล : {{researchE.r_source}}</p>
        <br />
        <p>ภาษา : {{researchE.r_language}}</p>
        <br />
        <p>สิทธิประโยชน์ : {{researchE.r_rights}}</p>
        <br />
        <hr />
        <center>
          <h4 class="head1">ไฟล์</h4>
        </center>
        <div v-if="thisFiles != null" v-for="(file,run) in thisFiles">
          <a :href="loadFile(file.f_name)" download>Dowload File</a>
          {{file.f_title}}
          <br />
          <br />
        </div>
        <br />
      </div>
      <div class="col-lg-2 col-xs-12"></div>
    </div>
    <!-- //  -->
    <!-- //  -->
  </div>
</template>
<script>
export default {
  data() {
    return {
      researchE: []
    };
  },
  methods: {
    loadFile(fi) {
      return this.path_files + "Research_Files_Upload/" + fi;
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisResearch() {
      var researchAll = this.$store.getters.getResearch;
      var research;
      for (var i = 0; i < researchAll.length; i++) {
        if (researchAll[i].r_id == this.$route.params.ResearchID) {
          research = researchAll[i];
        }
      }
      this.researchE = research;
      return research;
    },
    thisFiles() {
      var filesAll = this.$store.getters.getFiles;
      var files_research = [];
      for (var i = 0; i < filesAll.length; i++) {
        if (filesAll[i].f_key == this.thisResearch.r_file_key) {
          files_research.push(filesAll[i]);
        }
      }
      if (files_research.length != 0) {
        return files_research;
      } else {
        return false;
      }
    },
    Member_Type() {
      return this.$store.getters.getMember_Type;
    }
  }
};
</script>
<style scoped>
.head1 {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  margin-bottom: 53px;
}
p {
  font-size: 17px;
  line-height: 120%;
}
hr {
  border: 2px solid #3f4d63;
}
</style>