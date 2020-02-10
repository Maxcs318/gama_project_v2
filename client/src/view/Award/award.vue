<template>
  <div class="container" >
    <h3>
      <center class="head1">GAMA AWARD {{award_year_title}} WINNERS</center>
    </h3>
    <center class="head2">ประกาศรายชื่อผู้ที่ได้รับรางวัล Gama Awards</center>
    <center class="head2">ประจำปี {{award_year_title}}</center>
    <br />
    <div class="row">
      <div class="col-lg-1"></div>
      <div class="col-lg-5">
        <!-- ค้นหาชื่อ : {{search}} -->
        <input
          type="text"
          class="form-control select"
          v-model="searching"
          placeholder="ค้นหารายชื่อ..."
        />
      </div>
      <div class="col-lg-3">
        <!-- ประเภทรางวัล : {{type_show}} -->
        <select v-model="award_type" class="form-control select-award"  @click="changeType(award_type)">
          <option class="option-award" selected value='all'>รางวัลทุกประเภท</option>
          <option class="option-award" v-for=" at in Award_type_All " :value="at.at_id">{{at.at_title}}</option>
        </select>
        <br />
      </div>
      <div class="col-lg-2">
        <!-- ประจำปี : {{award_year.ay_title}} -->
        <select v-model="award_year" class="form-control select-award" @click="changeYear(award_year)">
          <option class="option-award" v-for=" ay in Award_year_All " :value="ay.ay_id">{{ay.ay_title}}</option>
        </select>
        <br />
      </div>
      <div class="col-lg-1">
        <br />
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <center v-if="searching!=''"> ผลการค้นหา : {{find}} รายชื่อ</center>
        <center v-else-if="searching==''"> ผู้รับรางวัล : {{data_size}} รายชื่อ</center>
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
              v-for="(award,index) in the_award_list"
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
                  v-for="at in Award_type_All"
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
import axios from "axios";
export default {
  data() {
    return {
      data_award:'',
      data_size:'',
      award_type:'',
      award_year:'',
      award_year_title:'',
      data_load:false,
      page: 0,
      data_in_page: 20,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      userstatus: "",
      // search data
      searching:'',
      find:null,
      
      data_load_award_type:false,
      data_award_type:'',

      data_load_company:false,
      data_company:'',

      data_load_award_year:false,
      data_award_year:'',
    };
  },
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "Awards",
        params: { Page: num_page }
      });
    },
    changeType(selected_type){
      if(this.award_type != this.$route.params.AwardType ){
        this.$router.push({
          name: "Awards",
          params: { AwardType: selected_type,Page: 1 }
        });
      }
    },
    changeYear(selected_year){
      if(this.award_year != this.$route.params.AwardYear ){
        this.$router.push({
          name: "Awards",
          params: { AwardYear: selected_year,Page: 1 }
        });
      }
    },
  },
  watch: {
    $route (to, from){
        this.data_load = false;
        // this.searching = ''
    },
    searching(){
      this.do_search
    },
    award_type(){
      this.do_search
    },
    award_year(){
      this.do_search
    },
    
  },
  computed: {
    the_award_list() {
      var setpage = this.$route.params.Page;
      var settype = this.$route.params.AwardType;
      var setyear = this.$route.params.AwardYear;
      this.award_type = settype;
      this.award_year = setyear;
      var this_year;

      var year_all = this.Award_year_All;
      if(this.$route.params.AwardYear =='now' && this.Award_year_All){
        var find_last_year = (year_all.length)-1 ;
        var now_year = null;
        now_year = this.Award_year_All[find_last_year]

        this_year = now_year.ay_title
        this.award_year = now_year.ay_id ;
                
      }else{
        for(var i=0;i<year_all.length;i++){
          if(setyear == year_all[i].ay_id){
            this_year = year_all[i].ay_title
          }
        }
      }
      this.award_year_title = this_year ;
      if(this.data_load==false && this.searching == '' && this.award_year !='now'){
        axios.get(this.$store.getters.getBase_Url+
        'Award/get_award/'+this.data_in_page+'/'+this.award_type+'/'+this.award_year+'/'+setpage)
        .then(response => {
            // console.log(response.data),
            this.data_size = response.data[0],
            this.data_award = response.data[1]
        })
        this.data_load = true
      }
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);
      this.page = setpage - 1;
      this.length_page = Math.ceil(this.data_size / this.data_in_page); // set page all
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
      return this.data_award;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      this.userstatus = user.m_status;
      return user;
    },
    Award_type_All() {
      if(this.data_load_award_type==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_award_type")
        .then(response => {
          // console.log(response)
          this.data_award_type = response.data
        })
      this.data_load_award_type = true
      }
      var award_type_all = this.data_award_type
      return award_type_all
    },
    Award_year_All() {
      if(this.data_load_award_year==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_award_years")
        .then(response => {
          // console.log(response)
          this.data_award_year = response.data
        })
      this.data_load_award_year = true
      }
      var award_year_all = this.data_award_year
      return award_year_all
    },
    Company() {
      if(this.data_load_company==false){
        axios.get(this.$store.getters.getBase_Url+"Award/get_all_company")
        .then(response => {
          // console.log(response)
          this.data_company = response.data
        })
      this.data_load_company = true
      }
      var company_all = this.data_company
      return company_all
    },
    do_search(){
      if(this.searching[0] == ' '){
        this.searching = ''
      }if(this.searching.length>0){
        var search = encodeURI(this.searching);
        axios.get(this.$store.getters.getBase_Url+'Award/get_all_award_like/'+this.award_type+'/'+this.award_year+'/'+search)
        .then(response => {
            // console.log(responsse.data)
            this.data_size = 0,
            this.find = response.data[0],
            this.data_award = response.data[1]
        })
        this.length_page = 0;
      }else{
        this.data_load = false;
        this.find = null;
      }
    }
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