<template>
  <div>
    <div v-if="this.$store.state.statusPage == 'none' ">
      <loadingpage></loadingpage>
    </div>

    <div v-else-if="this.$store.state.statusPage != 'none' && read_background" :style="BG">
      <navbar v-if="this.$store.state.the_user == ''"></navbar>
      <navbarmember v-else-if="this.$store.state.the_user.m_status != ''"></navbarmember>
      <!-- <navbaradmin v-else-if="this.$store.state.the_user.m_status == 'admin'"></navbaradmin> -->
      <sidebar v-if="this.$store.state.the_user.m_status == 'admin'"></sidebar>

      <div style="padding-top: 120px;">
        
        <!-- <div> -->
          <!-- slide-fade -->
          <!-- page -->
          <!-- mode="out-in" -->
          <transition :name="transitionName" >
            <router-view ></router-view>
          </transition>
        <!-- </div> -->
        
      </div>
      <foot></foot>
    </div>
  </div>
</template>

<script>
import Nav from "./components/Navbar/nav";
import Nav_Member from "./components/Navbar/nav_member.vue";
// import Nav_Admin from "./components/Navbar/nav_admin.vue";
import Footer from "./components/Footer/foot.vue";
import Loadingpage from "./components/loadingpage/loadingData";
import sidebar from "./components/Sidebar/sidebar";

export default {
  data() {
    return {
      BG: "",
      userBG: {
        backgroundColor: "#01152E"
      },
      adminBG: {
        backgroundColor: "#01152E"
      },
      transitionName:"slide-fade"
    };
  },
  mounted(){

  },
  computed: {
    read_background() {
      var user = this.$store.state.the_user;
      if (user.m_status == "admin") {
        this.BG = this.adminBG;
      } else {
        this.BG = this.userBG;
      }
      return true;
    }
  },
  watch:{
    '$route' (to, from){
      // console.log(to.path)
      // console.log(from.path)
      const toDepth = to.path
      const fromDepth = from.path
      this.transitionName = toDepth != fromDepth ? 'slide-fade' : 'slide-fade'

      if(this.$route.path=='/'){
        setTimeout(() => {
          window.scrollTo(0,0);    
        }, 10)
      }
    },
  },
  components: {
    navbar: Nav,
    navbarmember: Nav_Member,
    // navbaradmin: Nav_Admin,
    foot: Footer,
    loadingpage: Loadingpage,
    Sidebar: sidebar
  },
  created() {
    this.$store.dispatch("initApp");
  }
};
</script>
<style>
/* page */
.page-enter,
.page-leave-active {
  opacity: 0;
}
.page-enter-active,
.page-leave-active {
  transition: all 0.5s;
}

/*  slide-fade */
.slide-fade-enter-active {
  transition: all .3s ease;
}
.slide-fade-leave-active {
  transition: all .6s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to
/* .slide-fade-leave-active below version 2.1.8 */ {
  transform: translateX(10px);
  opacity: 0;
}

.header {
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  margin-bottom: 24px;
  text-align: center;
}

.table {
  margin: 24px auto;
}

.table th {
  color: #fff;
  padding: 7px 0;
  font-weight: 600;
  font-size: 15px;
  line-height: 150%;
  border-top: none;
  border-bottom: 3px solid #3f4d63;
}
.table td {
  color: #bdbdbd;
  border-bottom: 1px solid #3f4d63;
  padding: 7px 0;
}

input[type="text"],
input[type="text"]:focus,
input[type="email"],
input[type="email"]:focus,
input[type="password"],
input[type="password"]:focus {
  background-color: #1a2a3e;
  color: #e0e0e0;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}

.textarea,
.textarea:focus {
  background-color: #1a2a3e;
  color: #e0e0e0;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}

.admin-img {
  max-width: 250px;
  height: 250px;
  display: block;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 12px;
  margin-top: 12px;
}

.block-center {
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.event-img {
  width: auto;
  height: 170px;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.btn-circle {
  border-radius: 24px;
}

.select,
.option {
  background-color: #1a2a3e;
  color: #e0e0e0;
  border: 1px solid #3f4d63;
  box-sizing: border-box;
  border-radius: 5px;
}
.select:focus {
  background-color: #1a2a3e;
  color: #e0e0e0;
}
.about-order {
  cursor: pointer;
  color: #eecd02;
}
.about-order:hover {
  opacity: 0.7;
}
.alert-required{
  color: red;
}
.hv-eff:hover{
  cursor: pointer;
  transition: 0.25s;
  opacity: 0.7;
}
.complete-text{
  color: #4cd137;
}
.wait-text{
  color: #eecd02;
}
.video-name:hover{
  cursor: pointer;
  transition: 0.25s;
  color: #eecd02;
}
</style>