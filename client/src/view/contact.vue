<template>
  <div class="container" style="margin-bottom:210px;">
    <br>
    <div class="row address">
      <div class="col-lg-6 col-12">
        <h4>GAMA THAILAND</h4>
        <p>
          388 อาคารอามีโก้ ชั้น 19 โซนบี/1 ถนนสี่พระยา แขวงมหาพฤฒาราม
          <br>เขตบางรัก กรุงเทพมหานครฯ
        </p>
        <br>
        <label>อีเมล์</label>
        <p>gamathaiinfo@yahoo.com</p>
        <br>
        <label>เบอร์โทรติดต่อ</label>
        <p>
          โทรศัพท์: 02-6318908
          <br>โทรสาร: 02-6318908
        </p>
      </div>

      <div class="col-lg-6 col-12" style="padding:0">
        <div class="mapouter">
          <div class="gmap_canvas">
            <iframe
              width="100%"
              height="100%"
              id="gmap_canvas"
              src="https://maps.google.com/maps?q=%20%20GAMA%20THAILAND%20%20%20388%20%E0%B8%AD%E0%B8%B2%E0%B8%84%E0%B8%B2%E0%B8%A3%E0%B8%AD%E0%B8%B2%E0%B8%A1%E0%B8%B5%E0%B9%82%E0%B8%81%E0%B9%89%20%E0%B8%8A%E0%B8%B1%E0%B9%89%E0%B8%99%2019%20%E0%B9%82%E0%B8%8B%E0%B8%99%E0%B8%9A%E0%B8%B5%2F1%20%20%20%E0%B8%96%E0%B8%99%E0%B8%99%E0%B8%AA%E0%B8%B5%E0%B9%88%E0%B8%9E%E0%B8%A3%E0%B8%B0%E0%B8%A2%E0%B8%B2%20%E0%B9%81%E0%B8%82%E0%B8%A7%E0%B8%87%E0%B8%A1%E0%B8%AB%E0%B8%B2%E0%B8%9E%E0%B8%A4%E0%B8%92%E0%B8%B2%E0%B8%A3%E0%B8%B2%E0%B8%A1%20%20%20%E0%B9%80%E0%B8%82%E0%B8%95%E0%B8%9A%E0%B8%B2%E0%B8%87%E0%B8%A3%E0%B8%B1%E0%B8%81%20%E0%B8%81%E0%B8%A3%E0%B8%B8%E0%B8%87%E0%B9%80%E0%B8%97%E0%B8%9E%E0%B8%A1%E0%B8%AB%E0%B8%B2%E0%B8%99%E0%B8%84%E0%B8%A3%E0%B8%AF&t=&z=19&ie=UTF8&iwloc=&output=embed"
              frameborder="0"
              scrolling="no"
              marginheight="0"
              marginwidth="0"
            ></iframe>
            <a href="https://www.divi-discounts.com"></a>
          </div>
        </div>
      </div>
    </div>

    <div class="row" style="display:none;">
      <div class="col-lg-6">
        <input type="text" class="col-12" placeholder="ชื่อ">
        <input type="text" class="col-12" placeholder="อีเมล์">
        <input type="text" class="col-12" placeholder="หัวเรื่อง">
        <textarea class="col-12" cols="30" rows="5" placeholder="ข้อความ"></textarea>
        <br>
        <input type="submit" value="ติดต่อเรา" class="btn btn-warning">
      </div>
    </div>
  </div>
</template>

<style scoped>
.gmap_canvas,
.mapouter {
  overflow: hidden;
  background: none !important;
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

h4 {
  font-style: normal;
  font-weight: 600;
  font-size: 29px;
  line-height: 120%;
  letter-spacing: 0.75px;
}

p {
  font-style: normal;
  font-weight: normal;
  font-size: 18px;
  line-height: 150%;
  color: #e0e0e0;
}

label {
  font-style: normal;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
}

.address {
  margin-bottom: 74px;
}

input[type="text"],
textarea {
  background: #1a2a3e;
  border: 1px solid #3f4d63;
  border-radius: 5px;
  font-size: 18px;
  padding: 7px 7px 5px 12px;
  margin-bottom: 16px;
}

input[type="submit"] {
  float: right;
  color: #093f84;
  padding: 8px 32px;
  font-weight: 600;
  font-size: 18px;
  line-height: 150%;
  border-radius: 29px;
}

@media only screen and (max-width: 600px) {
  .gmap_canvas,
  .mapouter {
    width: 100%;
    height: 279px;
    margin-top: 50px;
  }
}
</style>
