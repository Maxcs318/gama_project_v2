<template>
  <div>
    <div class="invite">
      <img :src="path_files+'background_img/register-bg.png'" />
      <div class="container">
        <div class="row">
          <label class="invite-text">สมัครสมาชิก GAMA Thailand</label>
          <br />
          <label
            class="invite-text2"
          >สมัครสมาชิกสมาคมผู้จัดการและเจ้าของสำนักงานตัวแทนประกันชีวิต (GAMA)</label>
          <br />
          <router-link to="/register">
            <button type="button">สมัครสมาชิก</button>
          </router-link>
          <br />
          <label class="invite-text3">ตรวจสอบสถานะสมาชิก</label>
          <br />
          <label class="invite-text4">ขอรหัสผ่านเข้าใช้งานเว็บไซต์ (สำหรับสมาชิก GAMA เดิม)</label>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  }
};
</script>
<style scoped>
.invite {
  position: relative;
  height: 383px;
  text-align: center;
}

.invite img {
  width: 100%;
  height: 383px;
  margin: 0;
  padding: 0;
}

.invite label {
  position: absolute;
  top: 0%;
  left: 50%;
  margin-right: -50%;
  transform: translate(-50%, -50%);
}

.invite .invite-text {
  text-align: center;
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  margin-top: 88px;
  line-height: 120%;
  letter-spacing: 0.75px;
  color: #fff;
}

.invite .invite-text2 {
  font-style: normal;
  font-weight: normal;
  margin-top: 136px;
  font-size: 18px;
  line-height: 150%;
  color: #fff;
}

.invite button {
  position: absolute;
  left: 50%;
  margin-right: -50%;
  transform: translate(-50%);
  background: #eecd02;
  border-radius: 29px;
  border: none;
  width: 222px;
  height: 48px;
  margin-top: -200px;
  font-weight: 600;
  font-size: 18px;
  color: #093f84;
  text-align: center;
}

.invite button:hover {
  transition: 0.25s;
  opacity: 0.7;
}

.invite .invite-text3 {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  margin-top: 273px;
  color: #6cadfd;
}

.invite .invite-text4 {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  margin-top: 312px;
  color: #6cadfd;
}
@media only screen and (max-width: 600px) {
  .invite .invite-text {
    padding-bottom: 44px;
    padding-left: 21px;
    padding-right: 21px;
  }
  .invite .invite-text2 {
    padding-left: 9px;
    padding-right: 9px;
  }
}
</style>