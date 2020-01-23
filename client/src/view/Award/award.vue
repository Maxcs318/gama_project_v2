<template>
  <div class="container" v-if="year_preview">
    <h3>
      <center class="head1">GAMA AWARD {{year_show.ay_title}} WINNERS</center>
    </h3>
    <center class="head2">ประกาศรายชื่อผู้ที่ได้รับรางวัล Gama Awards</center>
    <center class="head2">ประจำปี {{year_show.ay_title}}</center>
    <br />
    <div class="row">
      <div class="col-lg-1"></div>
      <div class="col-lg-5">
        <!-- ค้นหาชื่อ : {{search}} -->
        <input
          type="text"
          class="form-control select"
          v-model="search"
          placeholder="ค้นหารายชื่อ..."
        />
      </div>
      <div class="col-lg-3">
        <!-- ประเภทรางวัล : {{selected}} -->
        <select v-model="selected" class="form-control select-award">
          <option class="option-award" selected value>รางวัลทุกประเภท</option>
          <option class="option-award" v-for=" at in Award_type " :value="at.at_id">{{at.at_title}}</option>
        </select>
        <br />
      </div>
      <div class="col-lg-2">
        <!-- ประจำปี : {{year_show.ay_title}} -->
        <select v-model="year_show" class="form-control select-award">
          <option class="option-award" v-for=" ay in year_preview " :value="ay">{{ay.ay_title}}</option>
        </select>
        <br />
      </div>
      <div class="col-lg-1">
        <br />
        <center v-if="search!=''">R : {{the_award_list.length}}</center>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-12">
        <table class="table" style="width:85%">
          <tr style="width:100%">
            <th style="width:5%; text-align:center;">#</th>
            <th style="width:35%">รายชื่อ</th>
            <th style="width:20%">บริษัท</th>
            <th style="width:20%">ประเภทรางวัล</th>
          </tr>
          <tbody>
            <tr
              v-for="(award,index) in the_award_list.slice((page*data_in_page),(page+1)*data_in_page)"
              :key="index"
            >
              <td style="text-align:center;">{{ (data_in_page*page)+ index+1 }}</td>
              <td>{{award.al_recipient}}</td>
              <td>
                <div
                  v-for="company in Company"
                  v-if="company.c_id == award.al_company_id"
                >{{company.c_title}}</div>
              </td>
              <td>
                <div
                  v-for="at in Award_type"
                  v-if="at.at_id == award.al_award_type_id"
                >{{at.at_title}}</div>
              </td>
            </tr>
          </tbody>
        </table>
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
      page: 0,
      data_in_page: 20,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      userstatus: "",
      // search data
      selected: "",
      search: "",

      year_show: []
    };
  },
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "Awards",
        params: { Page: num_page }
      });
    }
  },
  watch: {
    selected: function(val) {
      this.search = "";
      // back to page 1
      this.$router.push({
        name: "Awards",
        params: { Page: 1 }
      });
    },
    search: function(val) {
      this.$router.push({
        name: "Awards",
        params: { Page: 1 }
      });
    }
  },
  computed: {
    year_preview() {
      var year_all = this.$store.getters.getAward_Years;
      var today = new Date();
      var year_now = today.getFullYear();
      for (var i = 0; i < year_all.length; i++) {
        if (year_all[i].ay_title == year_now) {
          this.year_show = year_all[i];
        }
      }
      return year_all;
    },
    award_list_All() {
      var year_id = this.year_show;
      var all_award = this.$store.getters.getAward_List;
      return all_award.filter(item => {
        return item.al_year_id.indexOf(year_id.ay_id) > -1;
      });
    },
    listFilter() {
      let text = this.search.trim();
      if (this.search == "" && this.selected == "") {
        return this.award_list_All;
      } else {
        if (this.selected == "") {
          return this.award_list_All.filter(item => {
            return item.al_recipient.indexOf(text) > -1;
          });
        } else {
          if (this.search == "") {
            return this.award_list_All.filter(item => {
              return item.al_award_type_id.indexOf(this.selected) > -1;
            });
          } else {
            return this.award_list_All.filter(item => {
              return (
                item.al_award_type_id.indexOf(this.selected) > -1 &&
                item.al_recipient.indexOf(text) > -1
              );
            });
          }
        }
      }
    },
    the_award_list() {
      var setpage = this.$route.params.Page;
      var award_list = this.listFilter;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(award_list.length / this.data_in_page); // set page all
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
      return award_list;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      this.userstatus = user.m_status;
      return user;
    },
    Award_type() {
      return this.$store.getters.getAward_Type;
    },
    Company() {
      return this.$store.getters.getCompany;
    }
  },
  created() {
    this.$store.dispatch("initDataAward_List");
    this.$store.dispatch("initDataAward_Type");
    this.$store.dispatch("initDataAward_years");
    this.$store.dispatch("initDataCompany");
  }
};
</script>

<style scoped>
.head1 {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
}
.head2 {
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #e0e0e0;
}
input[type="text"] {
  background-color: #1a2a3e;
  color: #e0e0e0;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}

.select-award,
.option-award {
  background-color: #1a2a3e;
  color: #eecd02;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}
.select-award:focus {
  background-color: #1a2a3e;
  color: #eecd02;
}

/* 
table {
  margin: 0 auto;
}

th {
  padding: 7px 0;
  font-weight: 600;
  font-size: 15px;
  line-height: 150%;
  border-bottom: 3px solid #3f4d63;
}
td {
  color: #bdbdbd;
  border-bottom: 1px solid #3f4d63;
  padding: 7px 0;
} */

@media only screen and (max-width: 600px) {
  input[type="text"] {
    margin-bottom: 24px;
  }
}
</style>