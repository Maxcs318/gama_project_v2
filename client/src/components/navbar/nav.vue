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
          <b-nav-item>
            <button class="nav-cart">
              <img
                :src="path_files+'logo_img/nav-Cart.png'"
                @click="my_cart"
              />
            </button>
          </b-nav-item>
        </b-navbar-nav>

        <b-navbar-nav>
          <button
            class="form-control login-btn"
            v-if="this.$store.state.the_user == '' "
            @click="PopupLogin1"
          >เข้าสู่ระบบ</button>

          <div id="loginpopup" class="modal">
            <loginpop></loginpop>
          </div>

          <!-- <b-nav-item-dropdown style="color:red;" right v-if="this.$store.state.the_user != '' ">
            <template slot="button-content">{{this.$store.state.the_user.m_username}}</template>
            <b-dropdown-item
              @click="admin"
              v-if="this.$store.state.the_user.m_status == 'admin' "
            >แอดมิน</b-dropdown-item>
            <b-dropdown-item @click="profile">โปรไฟล์</b-dropdown-item>
            <b-dropdown-item @click="videosroom">วีดีโอ</b-dropdown-item>
            <b-dropdown-item @click="productall">สินค้าทั้งหมด</b-dropdown-item>
            <b-dropdown-item @click="my_cart">ตะกร้าของฉัน</b-dropdown-item>
            <b-dropdown-divider></b-dropdown-divider>
            <b-dropdown-item @click="Log_Out">ออกจากระบบ</b-dropdown-item>
          </b-nav-item-dropdown>-->
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
function myFunction() {
  var element = document.getElementById("myDIV");
  element.classList.add("active");
}
</script>

<script>
import logintest from "../Login_Register/loginPage";

export default {
  components: {
    loginpop: logintest
  },
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
    PopupLogin1() {
      document.getElementById("loginpopup").style.display = "block";
    },
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
    admin() {
      this.$router.push("/Admin");
    },
    my_cart() {
      this.$router.push("/my_cart");
    }
  }
};
</script>
<style>
.navbar-dark .navbar-nav .nav-link {
  color: white;
}

.navbar {
  border-top: 4px solid #eecd02;
  background: none;
  position: absolute;
  z-index: 100;
  width: 100%;
}

#nav-collapse {
  margin-left: 2%;
}

.navbar .nav-menu {
  font-style: normal;
  font-weight: 600;
  font-size: 1em;
  line-height: 27px;
  padding-right: 10px;
  text-transform: uppercase;
  color: #fff;
}

.navbar .nav-menu:hover {
  color: #eecd02;
  text-decoration: none;
}

.nav-cart {
  background: none;
  border: none;
  margin-right: 14px;
  width: 20px;
}

.nav-cart:hover {
  opacity: 0.7;
}

.nav-cart img {
  width: 20px;
}

.navbar .text-test:hover {
  color: #eecd02;
}

.nav-logo {
  width: 130px;
  margin-left: 26px;
}

.btn-outline-primary {
  background: none;
}

button.login-btn {
  background-color: #eecd02;
  border-radius: 2px;
  color: #093f84;
  font-size: 18px;
  font-weight: 600;
  line-height: 150%;
  margin: 14px 0;
  border: none;
  cursor: pointer;
  width: 100px;
}

button.login-btn:hover {
  opacity: 0.7;
}

a.router-link-exact-active.router-link-active {
  color: #eecd02;
}

@media only screen and (max-width: 600px) {
  .navbar {
    text-align: center;
    padding: 0;
    padding-top: 10px;
  }

  .nav-logo {
    width: 150px;
    padding-left: 17px;
  }

  .navbar-toggler {
    margin-right: 17px;
  }

  .navbar-brand {
    margin-right: 0;
  }

  #nav-collapse {
    width: 100%;
    margin: 0;
    padding: 0;
    background-color: #1a2a3e;
  }

  .nav-cart {
    width: 50px;
    padding: 0;
    margin: 0px auto;
  }

  .nav-cart img {
    width: 25px;
  }

  .nav-logo {
    width: 150px;
    margin-left: 0px;
  }

  .btn {
    margin: 0px;
    margin-top: 7px;
  }

  .navbar .nav-menu {
    padding-right: 0;
  }
  .navbar .nav-item {
    padding: 16px 0px;
  }

  button.login-btn {
    width: 129px;
    margin: 24px auto;
  }
}
</style>






