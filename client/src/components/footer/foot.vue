<template>
  <div>
    <footer>
      <!-- <p class="footer-line"></p> -->
      <br>
      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-2 col-12">
            <img class="footer-logo" :src="path_files+'footer_img/logo.jpg'">
          </div>
          <div class="col-lg-8 col-12 address">
            <br>
            <p>GAMA THAILAND</p>
            <br>
            <p>388 อาคารอามีโก้ ชั้น 19 โซนบี/1</p>
            <br>
            <p>ถนนสี่พระยา แขวงมหาพฤฒาราม</p>
            <br>
            <p>เขตบางรัก กรุงเทพมหานครฯ</p>
            <br>
            <p
              class="footer-address-telfax"
            >Tel: 02-6318908 &nbsp;&nbsp;&nbsp;&nbsp; Fax: 02-6318908</p>
            <div class="footer-address-telfax-mb-sm">
              <p>Tel: 02-6318908</p>
              <br>
              <p>Fax: 02-6318908</p>
            </div>
          </div>

          <div class="col-lg-2 social">
            <img :src="path_files+'footer_img/facebook-logo.png'" alt>
            <img :src="path_files+'footer_img/instagram-logo.png'" alt>
            <img :src="path_files+'footer_img/youtube-logo.png'" alt>
            <img :src="path_files+'footer_img/line-logo.png'" alt>
          </div>

          <div class="col-2 social-mb"></div>
          <div class="col-2 social-mb">
            <img :src="path_files+'footer_img/facebook-logo.png'" alt>
          </div>
          <div class="col-2 social-mb">
            <img :src="path_files+'footer_img/instagram-logo.png'" alt>
          </div>
          <div class="col-2 social-mb">
            <img :src="path_files+'footer_img/youtube-logo.png'" alt>
          </div>
          <div class="col-2 social-mb">
            <img :src="path_files+'footer_img/line-logo.png'" alt>
          </div>
          <div class="col-2 social-mb"></div>
        </div>

        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-10">
            <p class="contact">© 2019 GAMA Thailand, All Rights Reserved.</p>
          </div>
          <div class="col-lg-2"></div>
        </div>
      </div>
    </footer>
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
<style>
footer {
  z-index: 100;
  border-top: 1px solid rgba(142, 142, 142, 0.5);
  background-color: #fff;
}

.footer-line {
  height: 2px;
  margin-top: 100px;
  background: rgba(142, 142, 142, 0.5);
}

.footer-logo {
  width: 158px;
  display: block;
  margin-left: auto;
  margin-top: 12px;
}

footer .address {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  margin: 0;
  padding: 0;
  line-height: 30%;
  color: #6a6a6a;
}

footer .contact {
  font-style: normal;
  font-weight: 500;
  font-size: 13px;
  padding-top: 33px;
  margin-bottom: 38px;
  line-height: 18px;
  color: #6a6a6a;
}

.social img {
  margin-top: 23px;
  margin-left: 7%;
  width: 11%;
}
.social-mb {
  display: none;
}
.footer-address-telfax {
  display: block;
}
.footer-address-telfax-mb-sm {
  display: none;
}

@media only screen and (max-width: 600px) {
  .footer-logo {
    margin-left: auto;
    margin-right: auto;
  }

  footer p {
    text-align: center;
  }
  .social {
    display: none;
  }
  .social-mb {
    display: block;
    margin-top: 31px;
    margin-bottom: 0px;
  }
  .social-mb img {
    width: 100%;
    display: block;
    margin-left: auto;
    margin-right: auto;
  }
}

@media only screen and (max-width: 350px) {
  .footer-address-telfax {
    display: none;
  }
  .footer-address-telfax-mb-sm {
    display: block;
    text-align: center;
  }

}
</style>