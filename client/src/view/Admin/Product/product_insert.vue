<template>
  <div>
    <div>
      <div class="container" v-if="the_user">
        <div class="row">
          <div class="col-lg-12 col-xs-12">
            <h4 class="header">
              <center>เพิ่มสินค้า</center>
            </h4>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-3 col-xs-12"></div>
          <div class="col-lg-6 col-xs-12">
            <form @submit.prevent="submitProduct">
              <center>
                <img v-if="url" :src="url" max-width="250px" height="250px" />
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
              <br />
              <input
                type="text"
                v-model="product.p_name"
                class="form-control"
                placeholder="ชื่อสินค้า"
                required
              />
              <br />
              <textarea
                v-model="product.p_description"
                class="form-control textarea"
                placeholder="รายละเอียด"
                rows="6"
              ></textarea>
              <br />
              <div class="row">
                <div class="col-lg-6">
                  <input
                    type="text"
                    v-model="product.p_price"
                    class="form-control"
                    placeholder="ราคาปกติ"
                    required
                  />
                </div>
                <div class="col-lg-6">
                  <input
                    type="text"
                    v-model="product.p_price2"
                    class="form-control"
                    placeholder="ราคาสมาชิก"
                    required
                  />
                </div>
              </div>
              <br />
              <div class="row">
                <div class="col-lg-6">
                  <input
                    type="text"
                    v-model="product.p_quantity"
                    class="form-control"
                    placeholder="จำนวนสินค้า"
                    required
                  />
                </div>
                <div class="col-lg-6">
                  <select v-model="product.p_category" class="form-control select" required>
                    <option class="option" selected disabled value>ประเภทสินค้า</option>
                    <option
                      class="option"
                      v-for="(pc,index) in product_category"
                      :key="index"
                      :value="pc.pc_id"
                    >{{ pc.pc_title }}</option>
                  </select>
                </div>
              </div>
              <br />
              <h5>Another Image [ {{files.length}} ] Size Files All [ {{max_size_file}} byte ]</h5>
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
                <div
                  class="col-6"
                  v-for="(f,index) in files"
                  :key="index"
                  style="diaplay:block; margin-left:auto; margin-right:auto;"
                >
                  <img class="admin-img" :src="another_image_pre[index]" />
                  <h5></h5>
                  <b>{{index+1}}.</b>
                  {{files[index].name }}
                  <!-- <b> Size </b>{{files[index].size}} byte -->
                  <button
                    type="button"
                    class="form-control btn-danger"
                    @click="RemoveRow(index)"
                  >ลบ</button>
                  <br />
                </div>
              </div>
              <br />
              <div class="row">
                <div class="col-lg-6">
                  <button
                    type="button"
                    class="form-control btn-primary col-lg-12"
                    @click="ChooseFiles"
                  >เลือกไฟล์</button>
                  <br />
                </div>
                <div class="col-lg-6">
                  <button type="submit" class="form-control btn-primary col-12">ดำเนินการต่อ</button>
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
export default {
  data() {
    return {
      product: {
        p_name: "",
        p_description: "",
        p_image: "",
        p_price: "",
        p_price2: "",
        p_quantity: "",
        p_category: "",
        p_create_date: ""
      },
      url: null,
      another_image_pre: [],
      fileimage: "",
      files: [],
      max_size_file: 0
    };
  },
  methods: {
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
        // console.log(uploadedFiles[i])
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
    submitProduct() {
      if (this.fileimage.size < 10000000 && this.fileimage != "") {
        var jsonProduct = JSON.stringify(this.product);
        var FD = new FormData();
        FD.append("userfile", this.fileimage);
        if (this.files.length != 0) {
          for (var i = 0; i < this.files.length; i++) {
            FD.append("userfileupload" + i, this.files[i]);
          }
        }
        FD.append("product", jsonProduct);
        FD.append("creator", JSON.stringify(this.$store.state.log_on));
        this.$store.dispatch("Add_Product", FD);
        setTimeout(() => {
          this.$router.go(-1);
        }, 2000);
        this.$swal("Save Product Success .", "", "success");
      } else {
        this.$swal("Please Choose Image .", "", "error");
      }
    }
  },
  computed: {
    product_category() {
      return this.$store.getters.getProduct_Category;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        // this.$router.go(-1)
      }
      return user;
    }
  }
};
</script>