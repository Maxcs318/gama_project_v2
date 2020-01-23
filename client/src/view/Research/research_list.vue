<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12 col-xs-12">
        <h4>
          <center class="head1">ผลงานวิจัย</center>
        </h4>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <th style="width:5%; text-align:center">#</th>
            <th style="width:55%">หัวข้องานวิจัย</th>
            <th style="width:15%">วันที่สร้าง</th>
            <th style="width:15%">วันที่แก้ไข</th>
            <th style="width:10%">ดูเพิ่มเติม</th>
          </tr>
          <tr
            v-for="(research,index) in the_research.slice().reverse().slice((page*data_in_page),(page+1)*data_in_page)"
            :key="index"
          >
            <td style="text-align:center">{{ (page*data_in_page)+ index+1 }}</td>
            <td>{{research.r_title.slice(0,35)}}</td>
            <td>{{research.r_create_date.slice(0,-13)}}</td>
            <td>{{research.r_update_date.slice(0,-13)}}</td>
            <td>
              <button class="form-control btn-warning" @click="seeResearch(research.r_id)">ดูเพิ่มเติม</button>
            </td>
          </tr>
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
      isActive: []
    };
  },
  methods: {
    seenextPage(num_page) {
      this.$router.push({
        name: "research_list",
        params: { Page: num_page }
      });
    },
    seeResearch(thisresearch) {
      this.$router.push({
        name: "research",
        params: { ResearchID: thisresearch }
      });
    }
  },
  computed: {
    the_research() {
      var setpage = this.$route.params.Page;
      var research_All = this.$store.getters.getResearch;
      var p_conpute = 2;
      var p_start = setpage;
      var p_end = Math.ceil(setpage / 1 + p_conpute);

      this.page = setpage - 1;
      this.length_page = Math.ceil(research_All.length / this.data_in_page); // set page all
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
      return research_All;
    }
  },
  created() {
    this.$store.dispatch("initDataResearch");
    this.$store.dispatch("initDataFiles");
  }
};
</script>

<style scoped>
.head1 {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
}
</style>