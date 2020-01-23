<template>
  <div>
    <!-- <div class="row"> -->
    <div class="box1">
      <div class="col-lg-5 col-xs-12">
        <label class="text1">WE”RE GAMA THAILAND</label>
        <br />
        <label
          class="text2"
        >เราคือองค์กรแหล่งนำความรู้ แลกเปลี่ยนประสบการณ์หลักสูตรบริหาร การขายระดับสูง</label>
        <br />
        <label class="text3">สมัครสมาชิกสมาคมผู้จัดการและเจ้าของสำนักงานตัวแทนประกันชีวิต (GAMA)</label>
        <br />
        <router-link to="/register">
          <button class="btn register-btn" @click="go_register">สมัครสมาชิก</button>
        </router-link>
      </div>
    </div>
    <img class="img-box" :src="path_files+'background_img/Backgroundbox.png'" />
    <img class="mb-bg" :src="path_files+'background_img/mb-bg.png'" />
  </div>
</template>

<script>
export default {
  name: "carousel",
  data() {
    return {};
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  },
  methods: {
    onSlideStart(slide) {
      this.sliding = true;
    },
    onSlideEnd(slide) {
      this.sliding = true;
    },
    go_register() {
      this.$router.push("/register");
    }
  }
};
</script>
<!-- carousel-1.vue -->
<style scoped>
.box1 {
  position: absolute;
  z-index: 1;
  padding-left: 106px;
  margin-top: 90px;
}

.img-box {
  position: relative;
  width: 100%;
  margin-top: -120px;
  padding: 0;
}

.box1 .text1 {
  font-style: normal;
  font-weight: normal;
  font-size: 29px;
  line-height: 100%;
  letter-spacing: 0.75px;
  color: #fff;
}

.box1 .text2 {
  margin-top: 7px;
  font-style: normal;
  font-weight: 600;
  font-size: 47px;
  line-height: 100%;
  letter-spacing: -0.25px;
  color: #fff;
}

.box1 .text3 {
  margin-top: 24px;
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #fff;
}

.register-btn {
  background: #eecd02;
  border-radius: 29px;
  border: none;
  margin-top: 22px;
  padding: 9px 31px;
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  text-align: center;
  color: #093f84;
  border-radius: 29px;
}

.register-btn:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.mb-bg {
  display: none;
}

@media only screen and (max-width: 600px) {
  .img-box {
    display: none;
  }

  .mb-bg {
    position: absolute;
    display: block;
    width: 100%;
    margin-top: -175px;
  }

  .box1 {
    margin-top: 0%;
    padding-left: 10px;
    padding-top: 24px;
  }
  .box1 .text1 {
    margin-top: 0;
  }
  .box1 .text2 {
    font-size: 33px;
  }
}
</style>