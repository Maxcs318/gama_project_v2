<template>
  <div class="container" v-if="the_user">
    <h4 class="header">บทความต่างๆ</h4>
    <div class="row">
      <div class="col-lg-3 col-xs-12">
        <br>
        <button class="form-control btn-primary" @click="article_category_all">ประเภทบทความ</button>
      </div>
      <div class="col-lg-3 col-xs-12">
        <br>
        <button class="form-control btn-primary" @click="addarticle">เพิ่มบทความ</button>
      </div>
      <div class="col-lg-6 col-xs-12">
          <br>
          <input type="text" class="form-control" v-model="searching" placeholder="ค้นหา จากบทความทั้งหมด">
          <p v-if="searching!=''" style="text-align: right;"> <br>
          เจอทั้งหมด {{find}} รายการ
          </p>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 col-md-12">
        <table class="table" style="width:100%">
          <tr style="width:100%">
            <!-- <th style="width:5%">ลำดับ</th> -->
            <th style="width:35%">หัวข้อบทความ</th>
            <th style="width:20%">วันที่เผยแพร่</th>
            <th style="width:20%">วันที่แก้ไข</th>
            <th style="width:10%"></th>
            <th style="width:10%"></th>
          </tr>
          <tr
            v-for="(article,index) in the_article"
            :key="index"
          >
            <!-- <td>{{ article.a_id }}</td> -->
            <td>{{article.a_title.slice(0,35)}}</td>
            <td>{{article.a_create_date}}</td>
            <td>{{article.a_update_date}}</td>
            <td>
              <button class="form-control btn-warning" @click="editArticle(article.a_id)">แก้ไข</button>
            </td>
            <td>
              <button class="form-control btn-danger" @click="deleteArticle(article.a_id)">ลบ</button>
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
import axios from "axios";
export default {
  data() {
    return {
      data_articles:'',
      data_size:'',
      article_category:'',
      data_load:false,
      page: 0,
      data_in_page: 10,
      length_page: 0,
      page_start: 0,
      page_end: 0,
      isActive: [],
      searching:'',
      find:null
    };
  },
  methods: {
    article_category_all() {
      this.$router.push("/AdminAC");
    },
    addarticle() {
      this.$router.push("/addarticle");
    },
    seenextPage(num_page) {
      this.$router.push({
        name: "AdminA",
        params: { Page: num_page }
      });
    },
    editArticle(thisarticle) {
      this.$router.push({
        name: "editarticle",
        params: { ArticleID: thisarticle }
      });
    },
    deleteArticle(thisarticle) {
      // console.log(thisarticle)
      var FD = new FormData();
      FD.append("articleID", JSON.stringify(thisarticle));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$swal({
        title: "Are you sure?",
        text: "You want delete this Article ID " + thisarticle,
        icon: "warning",
        buttons: true,
        dangerMode: true
      }).then(willDelete => {
        if (willDelete) {
          this.$store.dispatch("Delete_Article", FD);
          swal({ title: "Delete Success.", icon: "success" });
          setTimeout(() => {
            this.data_load=false
            this.searching = ''
          },100);
          // console.log(FD)
        } else {
          // swal("Your imaginary file is safe!");
        }
      });
    }
  },
  watch:{
    // userstatus: function() {
    //   // console.log(this.userstatus)
    //   if (this.the_user.m_status != "admin") {
    //     // this.$router.go('/')
    //   }
    // },
    $route (to, from){
      this.data_load = false;
    },
    searching(){
        if(this.searching[0] == ' '){
            this.searching = ''
        }
        if(this.searching.length>0){
            var search = encodeURI(this.searching);
            axios.get(this.$store.getters.getBase_Url+'Article/get_all_article_like/'+search)
            .then(response => {
                // console.log(response.data),
                this.data_size = 0,
                this.find = response.data[0],
                this.data_articles = response.data[1]
            })
            this.length_page = 0;
        }else{
            this.data_load = false;
            this.find = null;
        }
    }
  },
  computed: {
    the_article() {
      var setpage = this.$route.params.Page;
      this.article_category = 'all'
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Article/get_article/'+this.data_in_page+'/'+this.article_category+'/'+setpage)
        .then(response => {
        // console.log(response.data)
          this.data_size = response.data[0],
          this.data_articles = response.data[1]
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
      return this.data_articles;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      // if( user.m_status != 'admin' ){
      // this.$router.go(-1)
      // }
      // this.userstatus = user.m_status;
      return user;
    }
  }
};
</script>
