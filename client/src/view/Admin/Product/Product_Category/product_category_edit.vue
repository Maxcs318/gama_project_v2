<template>
  <div>
    <div>
      <div class="container" v-if="the_user && Product_Category">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <h4 class="header">
              <center>แก้ไข ประเภทสินค้า</center>
            </h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12" v-if="productC">
            <form @submit.prevent="submitProduct_Category">
              <center>
                <img class=" " v-if="url" :src="url" width="100%"/>
                <img class=" " v-else :src="getImgUrl(productC.pc_image)" width="100%"/>
              </center>
              <br />
              <center>
                <button
                  type="button"
                  class="form-control btn-success col-lg-6"
                  @click="ChooseFilesFirst"
                >เลือกรูป</button>
              </center>

              <input
                id="chooseImage"
                ref="filesfirst"
                style="display: none;"
                type="file"
                @change="handleFilesFirst"
              />
              <br />ชื่อ ประเภท ของบทความวิชาการ
              <input
                type="text"
                v-model="productC.pc_title"
                class="form-control"
                placeholder="ชื่อ ประเภท ของบทความวิชาการ"
                required
              />
              <br />รายละเอียด
              <textarea
                v-model="productC.pc_description"
                class="form-control textarea"
                placeholder="รายละเอียด"
                rows="6"
              ></textarea>
              <br />

              <br />
              <div class="row">
                <div class="col-lg-6"></div>
                <div class="col-lg-6">
                  <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
                  <br />
                </div>
              </div>
            </form>
          </div>
          <div class="col-lg-3 col-xs-12"></div>
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
      data_load:false,
      productC:'',
      url: null,
      fileimage: ""
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Product_Category/" + pic;
    },
    // first image
    ChooseFilesFirst() {
      document.getElementById("chooseImage").click();
    },
    handleFilesFirst(e) {
      // console.log(e.target.files[0])
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.filesfirst.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    submitProduct_Category() {
      var jsonPC = JSON.stringify(this.productC);
      var FD = new FormData();
      if (this.url != null) {
        FD.append("userfile", this.fileimage);
      }
      FD.append("product_category", jsonPC);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Product_Category", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Save Product Category Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    },
    Product_Category() {      
      if (
        this.$route.params.Product_CategoryID == 1 ||
        this.$route.params.Product_CategoryID == 2
      ) {
        this.$router.go(-1);
      }
      var product_c_ID = this.$route.params.Product_CategoryID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Product/get_this_product_category/'+product_c_ID)
        .then(response => {
            // console.log(response.data)
            this.productC = response.data
        })
        this.data_load = true
      }
      
      var PC = this.productC;
      return PC;
    }
  }
};
</script>
