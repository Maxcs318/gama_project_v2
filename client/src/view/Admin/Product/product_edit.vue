<template>
  <div class="container">
    <center>
      <h4 class="header">แก้ไขสินค้า</h4>
    </center>
    <div class="row mt-5" v-if="thisProduct && the_user">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <center>
          <img v-if="url" :src="url" max-width="250px" height="250px" />
          <img v-else :src="getImgUrl(thisProduct.p_image)" max-width="250px" height="250px" />
        </center>
        <br />
        <br />
        <button
          type="button"
          class="form-control btn-success col-lg-12"
          @click="ChooseFilesImage"
        >เปลี่ยนรูป</button>
        <br />
        <form @submit.prevent="submitProduct">
          <input
            id="chooseImage"
            ref="filesimage"
            style="display: none;"
            type="file"
            @change="handleFilesImage"
          />
          ชื่อสินค้า
          <input
            type="text"
            v-model="productE.p_name"
            class="form-control"
            placeholder="ชื่อสินค้า"
            required
          />
          <br />รายละเอียด
          <textarea
            v-model="productE.p_description"
            class="form-control textarea"
            placeholder="รายละเอียด"
            rows="5"
          ></textarea>
          <br />
          <div class="row">
            <div class="col-lg-6">
              ราคาปกติ
              <input
                type="text"
                v-model="productE.p_price"
                class="form-control"
                placeholder="ราคาปกติ"
                required
              />
            </div>
            <div class="col-lg-6">
              ราคาสมาชิก
              <input
                type="text"
                v-model="productE.p_price2"
                class="form-control"
                placeholder="ราคาสมาชิก"
                required
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6">
              จำนวนสินค้า
              <input
                type="text"
                v-model="productE.p_quantity"
                class="form-control"
                placeholder="จำนวนสินค้า"
                required
              />
            </div>
            <div class="col-lg-6">
              ประเภทสินค้า
              <select
                v-model="productE.p_category"
                class="form-control select"
                placeholder="ประเภทสินค้า"
                required
              >
                <option
                class="option"
                  v-for="(pc,index) in product_category"
                  :key="index"
                  :value="pc.pc_id"
                >{{ pc.pc_title }}</option>
              </select>
            </div>
            <!-- image in this product -->
          </div>
          <br />
          <div class="row" v-if="thisProduct_Image">
            <h5 class="col-lg-12">Another Image</h5>
            <div
              class="col-lg-3"
              v-for="(pi,run) in thisProduct_Image"
              :key="run"
            >
              <img class="admin-img" :src="getImgUrl(pi.pi_name)" />
              <button
                type="button"
                class="form-control btn-danger"
                @click="DeleteProduct_Image(pi.pi_id)"
              >Delete</button>
              <br />
              <br />
            </div>
          </div>
          <br />
          <!--  -->
          <h5>New Another Image [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
          <input
            type="file"
            ref="files"
            style="display: none;"
            id="anotherImage"
            @change="handleFileUpload"
            multiple
          />
          <br />
          <div class="row">
            <div class="col-6 block-center" v-for="(f,index) in files" :key="index">
              <img class="admin-img" :src="another_image_pre[index]" />
              <h5></h5>
              <b>{{index+1}}.</b>
              {{files[index].name }}
              <!-- <b> Size </b>{{files[index].size}} byte -->
              <button type="button" class="form-control btn-danger" @click="RemoveRow(index)">ลบ</button>
              <br />
            </div>
          </div>
          <!--  -->
          <div class="row">
            <div class="col-lg-6">
              <button
                type="button"
                class="form-control btn-primary col-lg-12"
                @click="ChooseFiles"
              >เพิ่มรูปภาพอื่น</button>
              <br />
            </div>
            <div class="col-lg-6">
              <button type="submit" class="form-control btn-primary col-lg-12">ดำเนินการต่อ</button>
              <br />
            </div>
          </div>
        </form>
      </div>
      <div class="col-lg-3 col-xs-12"></div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      productE: "",
      url: null,
      another_image_pre: [],
      fileimage: "",
      files: [],
      max_size_file: 0
    };
  },
  methods: {
    getImgUrl(pic) {
      return this.path_files + "Product/" + pic;
    },
    // preview image
    ChooseFilesImage() {
      document.getElementById("chooseImage").click();
    },
    handleFilesImage(e) {
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      let uploadedFiles = this.$refs.filesimage.files[0];
      this.fileimage = uploadedFiles;
      if (this.fileimage.size > 10000000) {
        this.fileimage = [];
        this.url = null;
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    DeleteProduct_Image(product_imageID) {
      // console.log(product_imageID)
      var FD_delete = new FormData();
      FD_delete.append("product_imageID", product_imageID);
      FD_delete.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Delete_Product_Image", FD_delete);
    },
    // another image
    ChooseFiles() {
      document.getElementById("anotherImage").click();
    },
    handleFileUpload(event) {
      this.files = [];
      this.another_image_pre = [];

      var i = 0;
      let uploadedFiles = this.$refs.files.files;
      for (var i = 0; i < uploadedFiles.length; i++) {
        this.files.push(uploadedFiles[i]);
        this.max_size_file = this.max_size_file + uploadedFiles[i].size;
        this.another_image_pre.push(URL.createObjectURL(uploadedFiles[i]));
      }
      if (this.max_size_file > 10000000) {
        this.files = [];
        this.another_image_pre = [];
        this.max_size_file = 0;
        // alert
        this.$swal("Your file is larger than 10 MB. Sorry Choose Again !!!");
      }
    },
    RemoveRow: function(index) {
      this.max_size_file = this.max_size_file - this.files[index].size;
      this.files.splice(index, 1);
      this.another_image_pre.splice(index, 1);
    },
    // submit
    submitProduct() {
      var jsonProduct = JSON.stringify(this.productE);
      var FD = new FormData();
      if (this.url != null || this.url != "") {
        FD.append("userfile", this.fileimage);
      }
      if (this.files.length != 0) {
        for (var i = 0; i < this.files.length; i++) {
          FD.append("userfileupload" + i, this.files[i]);
        }
      }
      FD.append("product", jsonProduct);
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("Edit_Product", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 2000);
      this.$swal("Edit Product Success .", "", "success");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisProduct() {
      var productAll = this.$store.getters.getProduct;
      var product;
      for (var i = 0; i < productAll.length; i++) {
        if (productAll[i].p_id == this.$route.params.ProductID) {
          product = productAll[i];
        }
      }
      this.productE = product;
      return product;
    },
    thisProduct_Image() {
      var product_imageAll = this.$store.getters.getProduct_Image;
      var product_image = [];
      for (var i = 0; i < product_imageAll.length; i++) {
        if (product_imageAll[i].pi_image_key == this.thisProduct.p_image_key) {
          product_image.push(product_imageAll[i]);
        }
      }
      if (product_image.length != 0) {
        return product_image;
      } else {
        return false;
      }
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    },
    product_category() {
      return this.$store.getters.getProduct_Category;
    }
  }
};
</script>
<style scoped>
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
</style>