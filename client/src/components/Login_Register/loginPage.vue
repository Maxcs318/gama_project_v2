<template>
  <div class="container">
    <div class="modal-content animate" v-if="log_on">
      <form @submit.prevent="onSubmitLogin">
        <div class="imgcontainer">
          <span @click="Close_Login" class="close">&times;</span>
        </div>

        <div class="container">
          <br />
          <input type="text" v-model="username" placeholder="ชื่อ" name="uname" required />
          <br />
          <input
            type="password"
            v-model="password_normal"
            placeholder="รหัสผ่าน"
            name="psw"
            required
          />
          <center class="alertlogin" v-if="UserLogin!=''">{{UserLogin}}</center>
          <br />
          <center>
            <button type="submit">เข้าสู่ระบบ</button>
            <!-- <br /> -->
            <!-- <a href="#" class="forgot-pass">ลืมรหัสผ่าน</a> -->
          </center>
        </div>
      </form>
    </div>

    <!-- <div class="row mt-5" v-if="log_on">
      {{log_on}}
      <div class="col-lg-4 col-xs-12">
        <form @submit.prevent="onSubmitLogin">
          <center>
            <h3>Login</h3>
          </center>
          <br />
          <input type="text" v-model="username" placeholder="ชื่อ" class="form-control" required />
          <br />
          <input
            type="password"
            v-model="password_normal"
            placeholder="อีเมล์"
            class="form-control"
            required
          />
          <br />
          <center v-if="UserLogin!=''">{{UserLogin}}</center>
          <br v-else />
          <br />
          <div class="row">
            <div class="col-lg-6">
              <button
                type="button"
                class="form-control col-12 btn-success"
                @click="back_register"
              >Register</button>
            </div>
            <br />
            <br />
            <div class="col-lg-6">
              <button type="submit" class="form-control col-12 btn-primary">Login</button>
            </div>
            <br />
            <br />
          </div>
        </form>
      </div>
    </div>-->
  </div>
</template>

<script>
import md5 from "js-md5";

export default {
  data() {
    return {
      user: {
        m_username: "",
        m_password: ""
      },
      password_normal: "",
      username: "",
      UserLogin: ""
    };
  },
  methods: {
    Close_Login() {
      document.getElementById("loginpopup").style.display = "none";
    },
    onSubmitLogin() {
      this.user.m_password = md5(this.password_normal);
      this.user.m_username = this.username;
      this.$store.dispatch("Logining_in", this.user).then(response => {
        //
        setTimeout(() => {
          if (this.$store.state.log_on != null) {
            this.$store.commit("LoadingPage", "none");
            setTimeout(() => {
              // this.$router.push("/");
              this.$store.commit("LoadingPage", "show");
            }, 3000);
          } else {
            this.UserLogin = "ชื่อ หรือ รหัสผ่าน ไม่ถูกต้อง";
          }
        }, 400);
        this.$store.dispatch("initApp");
      });
    },
    back_register() {
      this.$router.push("/register");
    }
  },
  watch: {
    password_normal: function() {
      if (this.password_normal == "") {
        this.UserLogin = "";
      }
    },
    username: function() {
      if (this.username == "") {
        this.UserLogin = "";
      }
    }
  },
  computed: {
    log_on() {
      var user = this.$store.getters.getThe_User;
      if (user == "" || user == null) {
        return "login";
      } else {
        this.$router.go(-1);
      }
    }
  }
};
</script>
<style scoped>
/* Full-width input fields */
input[type="text"],
input[type="password"] {
  width: 80%;
  padding: 8px 16px;
  margin: auto;
  display: block;
  border: 1px solid #ccc;
  border-radius: 5px;
  background: none;
  color: #e0e0e0;
  opacity: 0.7;
  font-size: 18px;
  box-sizing: border-box;
}
::placeholder {
  color: #e0e0e0;
  opacity: 0.7;
}

/* Set a style for all buttons */
button {
  background-color: #eecd02;
  border-radius: 14px;
  color: #093f84;
  padding: 9px 32px;
  font-size: 18px;
  font-weight: 600;
  line-height: 150%;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: auto;
}

button:hover {
  opacity: 0.7;
}

/* Extra styles for the cancel button */
.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0, 0, 0); /* Fallback color */
  background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  position: relative;
  z-index: 100;
  background-color: #1a2a3e;
  margin: 15% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  border-radius: 6px;
  width: 442px; /* Could be more or less, depending on screen size */
  height: 355px;
}

.forgot-pass {
  font-size: 18px;
  color: #6cadfd;
  font-weight: 600px;
  line-height: 150%;
  padding-top: 13px;
}
.forgot-pass:hover {
  color: #888;
  text-decoration: none;
}

/* The Close Button (x) */
.close {
  position: absolute;
  top: -20px;
  right: 20px;
  color: #fff;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  opacity: 0.7;
  cursor: pointer;
}

.alertlogin {
  color: #eb5757;
  font-size: 1.2em;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s;
}

@-webkit-keyframes animatezoom {
  from {
    -webkit-transform: scale(0);
  }
  to {
    -webkit-transform: scale(1);
  }
}

@keyframes animatezoom {
  from {
    transform: scale(0);
  }
  to {
    transform: scale(1);
  }
}

/* Change styles for span and cancel button on extra small screens */
@media only screen and (max-width: 600px) {
  .modal-content {
    position: fixed;
    left: 0;
    top: 0;
    border: none;
    border-radius: 0;
    overflow: hidden;
    width: 100%;
    height: 100%;
    margin: 0;
  }
  form{
    margin-top: 100px;
  }
  span.psw {
    display: block;
    float: none;
  }
  .cancelbtn {
    width: 100%;
  }
}
</style>