<template>
  <div>
    <div class="sponsor">
      <div class="container">
        <h1>Sponsor</h1>
        <div class="row">
          <div class="col-lg-12">
            <p>Platinum</p>
          </div>
          <div class="col-lg-2 col-0"></div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat1.png'" />
          </div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat2.png'" />
          </div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat3.png'" />
          </div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat4.png'" />
          </div>
          <div class="col-lg-2 col-0"></div>

          <div class="col-lg-12">
            <p>Gold</p>
          </div>
          <div class="col-lg-4 col-0"></div>
          <div class="col-lg-4 col-12">
            <img class="sponsor-img2" :src="path_files+'sponsor_img/sponsor-plat5.png'"/>
          </div>
          <!-- <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat6.png'" alt />
          </div> -->
          <div class="col-lg-4 col-0"></div>

          <div class="col-lg-12">
            <p>Bronze</p>
          </div>
          <div class="col-lg-5 col-3"></div>
          <div class="col-lg-2 col-6">
            <center>
              <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat7.png'" alt />
            </center>
          </div>
          <div class="col-lg-5 col-3"></div>

          <div class="col-lg-12 col-xs-12">
            <p>Blue</p>
          </div>
          <div class="col-lg-4 col-0"></div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat8.png'" alt />
          </div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/sponsor-plat9.png'" alt />
          </div>
          <div class="col-lg-4 col-0"></div>
          <div class="col-lg-4 col-0"></div>

          <div class="col-lg-2 col-6">
            <img class="sponsor-img2" :src="path_files+'sponsor_img/phyathai_2.png'" alt />
          </div>
          <div class="col-lg-2 col-6">
            <img class="sponsor-img" :src="path_files+'sponsor_img/pro_active.jpg'" alt />
          </div>

          <div class="col-lg-4 col-0"></div>
        </div>
      </div>
      <br />
      <br />
      <br />
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
.sponsor {
  background-color: #fff;
}

.sponsor h1 {
  font-style: normal;
  font-weight: 600;
  padding-top: 96px;
  font-size: 47px;
  line-height: 120%;
  text-align: center;
  color: #4a4a4a;
}

.sponsor p {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 29px;
  margin-top: 24px;
  margin-bottom: 8px;
  text-align: center;
  color: #686868;
}

.sponsor-img {
  width: 158px;
  height: 158px;
  display: block;
  margin-right: auto;
  margin-left: auto;
}

.sponsor-img2 {
  width: 158px;
  height: auto;
  display: block;
  margin-right: auto;
  margin-left: auto;
  margin-top: 49px;

}

@media only screen and (max-width: 600px) {
  .sponsor-img {
    width: 100%;
    height: auto;
  }
  .sponsor-img2 {
    width: 100%;
    height: auto;
  }
}
</style>