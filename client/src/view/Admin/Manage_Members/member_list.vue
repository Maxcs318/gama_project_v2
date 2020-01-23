<template>
  <div class="container" v-if="the_user">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h4 class="header">
          <center>การจัดการสมาชิก</center>
        </h4>
        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-4">
            เรียงโดย : {{selected}}
            <select v-model="selected" class="form-control select">
              <option class="option" selected value>ทั้งหมด</option>
              <option class="option" v-for="sl in select" :value="sl.file">{{sl.file}}</option>
            </select>
            <br />
          </div>
          <div class="col-lg-4">
            ค้นหา : {{search}}
            <input
              type="text"
              class="form-control"
              placeholder="ค้นหา"
              v-model="search"
              v-if="this.selected!='member_type'"
            />
            <select v-model="search" class="form-control select" v-if="this.selected == 'member_type'">
              <option class="option" selected value>เลือกประเภท</option>
              <option class="option" v-for="mt in Member_Type" :value="mt.mt_id">{{mt.mt_name}}</option>
            </select>
            <br />
          </div>
          <div class="col-lg-2">
            <center v-if="search!=''">Result : {{listFilter.length}}</center>
          </div>
        </div>
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%">ลำดับ</th>
            <th style="width:15%">ชื่อจริง</th>
            <th style="width:15%">นามสกุล</th>
            <th style="width:15%">ชื่อจริง (Eng)</th>
            <th style="width:15%">นามสกุล (Eng)</th>
            <th style="width:10%">ชื่อผู้ใช้</th>
            <th style="width:15%">ระดับสมาชิก</th>
            <th style="width:10%"></th>
          </tr>
          <tr
            v-for="(member,index) in listFilter_Paging.slice((page*data_in_page),(page+1)*data_in_page)"
            :key="index"
          >
            <td>{{member.m_id}}</td>
            <td>{{member.m_firstname.slice(0,35)}}</td>
            <td>{{member.m_lastname}}</td>
            <td>{{member.m_firstname_eng}}</td>
            <td>{{member.m_lastname_eng}}</td>
            <td>{{member.m_username}}</td>
            <td>
              <div v-for="mt in Member_Type" v-if="mt.mt_id == member.m_type">{{mt.mt_name}}</div>
            </td>
            <td>
              <button class="form-control btn-warning" @click="editMember(member.m_id)">แก้ไข</button>
            </td>
          </tr>
        </table>
        <!-- {{Member_Type}} -->
        <br />
      </div>
    </div>
    <div class="row" v-if="length_page > 0">
      <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
        <div class="btn-group" role="group" aria-label="Second group">
          <button type="button" class="btn btn-light" @click="seenextPage(1)" title="First page"><<</button>
          <button
            type="button"
            class="btn btn-light"
            v-for=" (run_page,index) in length_page "
            @click="seenextPage(run_page)"
            v-bind:class="{ active: isActive[index+1] }"
            v-if=" run_page >= page_start && run_page <= page_end "
          >{{run_page}}</button>
          <button
            type="button"
            class="btn btn-light"
            @click="seenextPage(length_page)"
            title="Last page"
          >>></button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      select: [
        { file: "firstname" },
        { file: "lastname" },
        { file: "firstname ENG" },
        { file: "lastname ENG" },
        { file: "username" },
        { file: "member_type" }
      ],
      selected: "",
      search: "",
      // paging //
      page: 0,
      data_in_page: 10,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: []
    };
  },
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "AdminM",
        params: { Page: num_page }
      });
    },
    editMember(thismemberID) {
      // console.log(thismemberID)
      this.$router.push({
        name: "editmember_by_admin",
        params: { MemberID: thismemberID }
      });
    }
  },
  watch: {
    selected: function(val) {
      this.search = "";
      // back to page 1
      this.$router.push({
        name: "AdminM",
        params: { Page: 1 }
      });
    },
    search: function(val) {
      this.$router.push({
        name: "AdminM",
        params: { Page: 1 }
      });
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
    Member_Type() {
      return this.$store.getters.getMember_Type;
    },
    Members() {
      return this.$store.getters.getMembers;
    },
    listFilter() {
      let text = this.search.trim();
      if (this.selected == "username") {
        return this.Members.filter(item => {
          return item.m_username.indexOf(text) > -1;
        });
      } else if (this.selected == "firstname") {
        return this.Members.filter(item => {
          return item.m_firstname.indexOf(text) > -1;
        });
      } else if (this.selected == "lastname") {
        return this.Members.filter(item => {
          return item.m_lastname.indexOf(text) > -1;
        });
      } else if (this.selected == "member_type") {
        return this.Members.filter(item => {
          return item.m_type.indexOf(text) > -1;
        });
      } else if (this.selected == "firstname ENG") {
        return this.Members.filter(item => {
          return item.m_firstname_eng.indexOf(text) > -1;
        });
      } else if (this.selected == "lastname ENG") {
        return this.Members.filter(item => {
          return item.m_lastname_eng.indexOf(text) > -1;
        });
      } else if (this.selected == "") {
        return this.Members.filter(item => {
          return (
            item.m_username.indexOf(text) > -1 ||
            item.m_firstname.indexOf(text) > -1 ||
            item.m_lastname.indexOf(text) > -1 ||
            item.m_firstname_eng.indexOf(text) > -1 ||
            item.m_lastname_eng.indexOf(text) > -1
          );
          // || item.m_type.indexOf(text) > - 1
        });
      }
    },
    listFilter_Paging() {
      var setpage = this.$route.params.Page;
      var memberlist = this.listFilter;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(memberlist.length / this.data_in_page); // set page all
      // set start && end paging
      if (setpage > p_conpute) {
        p_start = setpage - p_conpute;
      } else {
        p_start = -(setpage - p_conpute) - p_conpute;
        p_end = p_end + p_start + p_conpute + 1;
      }
      if (p_end >= this.length_page) {
        p_start = p_start + (this.length_page - setpage - p_conpute);
      }
      this.page_start = p_start;
      this.page_end = p_end;

      this.isActive = [];
      for (var i = 0; i <= this.length_page; i++) {
        if (i == this.$route.params.Page) {
          this.isActive.push(true);
        } else {
          this.isActive.push(false);
        }
      }
      return memberlist;
    }
  },
  created() {
    this.$store.dispatch("initMembers");
    this.$store.dispatch("initDataMember_Type");
  }
};
</script>