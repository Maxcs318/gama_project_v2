<template>
  <div>
    <b-navbar toggleable="lg" type="dark" class="navbar float-right">
      <router-link to="/">
        <b-navbar-brand>
          <img :src="path_files+'logo_img/logo-white.png'" class="nav-logo" />
        </b-navbar-brand>
      </router-link>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/" class="nav-menu">หน้าหลัก</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/aboutmember" class="nav-menu">เกี่ยวกับสมาชิก</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/newsandactivities/1" class="nav-menu">ข่าวกิจกรรม</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/articles/1" class="nav-menu">บทความ</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/training_courses/1" class="nav-menu">หลักสูตร & อบรม</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/books/1" class="nav-menu">หนังสือ</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/Awards/1" class="nav-menu">รางวัล</router-link>
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav>
          <b-nav-item>
            <router-link to="/contact" class="nav-menu">ติดต่อเรา</router-link>
          </b-nav-item>
        </b-navbar-nav>

        <b-navbar-nav class="ml-auto">
          <button class="nav-cart">
            <img :src="path_files+'logo_img/nav-Cart.png'" @click="my_cart" />
          </button>
        </b-navbar-nav>

        <b-navbar-nav>
          <!-- <button class="form-control btn-light" v-if="this.$store.state.the_user == '' " @click="register"> Register </button> -->
          <button
            v-if="this.$store.state.the_user == '' "
            class="form-control btn-outline-primary"
            @click="Log_in"
          >Log in</button>
          <b-nav-item-dropdown style="color:red;" right v-if="this.$store.state.the_user != '' ">
            <template
              slot="button-content"
              v-if="this.$store.state.the_user.m_status == 'user'"
            >User : {{this.$store.state.the_user.m_username}}</template>
            <template
              slot="button-content"
              v-else-if="this.$store.state.the_user.m_status == 'admin'"
            >Admin : {{this.$store.state.the_user.m_username}}</template>
            <b-dropdown-item @click="profile">Profile</b-dropdown-item>
            <b-dropdown-item @click="my_cart">My Cart</b-dropdown-item>
            <b-dropdown-divider></b-dropdown-divider>
            <b-dropdown-item @click="videosroom">Video Room</b-dropdown-item>
            <b-dropdown-item @click="productall">Product All</b-dropdown-item>
            <b-dropdown-item @click="academic_articles">Academic Article</b-dropdown-item>
            <b-dropdown-item @click="online_journals">Online Journal</b-dropdown-item>
            <b-dropdown-item @click="research">Research</b-dropdown-item>
            <b-dropdown-item @click="awards">Awards Winners</b-dropdown-item>
            <b-dropdown-divider></b-dropdown-divider>
            <b-dropdown-item @click="Log_Out">Log Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>
<script>
export default {
  data() {
    return {
      active: false
    };
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  methods: {
    Log_Out() {
      this.$store.dispatch("Log_Out").then(() => {
        // this.$router.go()
      });
    },
    Log_in() {
      this.$router.push("/login");
    },
    register() {
      this.$router.push("/register");
    },
    profile() {
      this.$router.push("/myProfile");
    },
    videosroom() {
      this.$router.push("/listroom/1");
    },
    productall() {
      this.$router.push("/productall/1");
    },
    my_cart() {
      this.$router.push("/my_cart");
    },
    academic_articles() {
      this.$router.push("/academic_articles/1");
    },
    online_journals() {
      this.$router.push("/online_journals/1");
    },
    research() {
      this.$router.push("/research_list/1");
    },
    awards() {
      this.$router.push("/Awards/1");
    }
  }
};
</script>
<style>
.dropdown-menu,
.dropdown-item {
  background-color: #1a2a3e;
  color: #fff;
  text-align: center;
}
.dropdown-item:hover {
  color: #eecd02;
  background: none;
}
</style>
