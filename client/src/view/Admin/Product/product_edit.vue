<template>
  <div class="container">
    <center>
      <h4 class="header">แก้ไข สินค้า</h4>
    </center>
    <div class="row mt-5" v-if="thisProduct && the_user">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <center>
          <img v-if="url" :src="url" width="100%"/>
          <img v-else :src="getImgUrl(thisProduct.p_image)" width="100%" />
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
          <br>
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
                @keypress="isNumber($event)"
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
                @keypress="isNumber($event)"
                required
              />
            </div>
          </div>
          <!-- <div class="row">
            <div class="col-lg-6">
              จำนวนสินค้า
              <input
                type="text"
                v-model="productE.p_quantity"
                class="form-control"
                placeholder="จำนวนสินค้า"
                @keypress="isNumber($event)"
                required
              />
            </div>
          </div> -->
          <br />
          <div class="row" v-if="product_data_file">
            <h5 class="col-lg-12">รูปภาพอื่่นๆของ สินค้า</h5>
            <div
              class="col-lg-3"
              v-for="(pi,run) in product_data_file"
              :key="run"
            >
              <img class=" " :src="getImgUrl(pi.pi_name)" width="100%"/>
              <button
                type="button"
                class="form-control btn-danger"
                @click="DeleteProduct_Image(pi.pi_id)"
              >ลบ</button>
              <br />
              <br />
            </div>
          </div>
          <br />
          <!--  -->
          <h5> รูปภาพที่ต้องการเพิ่มใหม่ [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
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
              <img class=" " :src="another_image_pre[index]" width="100%"/>
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
import axios from "axios";
export default {
  data() {
    return {
      productE: "",
      url: null,
      another_image_pre: [],
      fileimage: "",
      files: [],
      max_size_file: 0,

      data_load:false,
      text_alert:'',
      product_data:'',
      product_data_file:'',

      data_product_category:'',
      data_load_category:false,

      check_delete_file:false
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
      
      this.$swal({
          title: "Are you sure?",
          text: "You want delete this Image ",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
        if (willDelete) {
          this.$store.dispatch("Delete_Product_Image", FD_delete);
          setTimeout(() => {
            this.check_delete_file=true
            this.data_load=false
          },100);
          swal({title: "Delete Success.",icon: "success",});
        } else {
          //
        }
      })

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
    },
    // @keypress="isNumber($event)"
    isNumber: function(evt) {
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode != 9)) {
            evt.preventDefault();
        } else {
            return true;
        }
    },
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    },
    thisProduct() {
      var productID = this.$route.params.ProductID
      if(this.data_load==false){
        axios.get(this.$store.getters.getBase_Url+'Product/get_this_product/'+productID)
        .then(response => {
            // console.log(response.data),
            this.product_data = response.data[0][0],
            this.product_data_file = response.data[1]
        })
        this.data_load = true
        if(this.product_data.length == 0){
          setTimeout(() => {
            this.text_alert = 'This Page No Data.'
          },1000);
        }
      }
      var product_show = this.product_data
      if(this.check_delete_file == false){
        this.productE = this.product_data
      }
      return product_show;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    },
    product_category() {
      if(this.data_load_category==false){
        axios.get(this.$store.getters.getBase_Url+'Product/get_all_product_category')
        .then(response => {
            // console.log(response.data)
            this.data_product_category = response.data
        })
        this.data_load_category = true
      }
      var product_category_all = this.data_product_category
      return product_category_all
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