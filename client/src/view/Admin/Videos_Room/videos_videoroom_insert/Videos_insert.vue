<template>
  <div class="container" v-if="the_user">
    <center>
      <h4 class="header">เพิ่มวีดีโอ</h4>
    </center>
    <div class="row">
      <div class="col-lg-3 col-xs-12"></div>
      <div class="col-lg-6 col-xs-12">
        <form @submit.prevent="submitAddvideos">
          <!-- <h5>Select Room</h5> -->
          <!-- {{ListRoom}} -->
          <select class="form-control select" v-model="selectRoom" required>
            <option class="option" disabled selected value>เลือก ห้องวีดีโอ</option>
            <option class="option"
              v-for="(room,index) in ListRoom"
              :key="index"
              :value="room.vr_id"
            >{{room.vr_title}}</option>
          </select>
          <hr />
          <div v-for="(addV,index) in addVideos" :key="index">
            <h5>ชื่อวีดีโอ</h5>
            <input
              v-model="addVideos[index].v_title"
              type="text"
              class="form-control"
              placeholder="Video Name"
              required
            />
            <br />
            <h5>ลิงค์วีดีโอ ( Embed )</h5>
            <input
              v-model="addVideos[index].v_link"
              type="text"
              class="form-control"
              placeholder="Video Name"
              required
            />
            <br />
            <h5>รายละอียด</h5>
            <textarea
              v-model="addVideos[index].v_description"
              class="form-control textarea"
              rows="4"
              placeholder="รายละเอียด"
              required
            ></textarea>
            <br />
            <div class="row">
              <div class="col-lg-6 col-xs-6">
                <button
                  v-if="addVideos.length > 1"
                  class="form-control btn-danger"
                  type="button"
                  @click="btn_remove(index)"
                >ลบ</button>
              </div>
              <div class="col-lg-6 col-xs-6"></div>
            </div>
            <hr />
          </div>
          <div class="row">
            <div class="col-lg-6 col-xs-6">
              <button class="form-control btn-success" type="button" @click="btn_addmore">เพิ่ม</button>
            </div>
            <div class="col-lg-6 col-xs-6">
              <button class="form-control btn-primary" type="submit">ดำเนินการต่อ</button>
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
      selectRoom: "",
      addVideos: [
        {
          v_title: "",
          v_description: "",
          v_link: "",
          v_room: "",
          v_create_date: ""
        }
      ]
    };
  },
  methods: {
    btn_addmore() {
      this.addVideos.push({
        v_title: "",
        v_description: "",
        v_link: "",
        v_room: ""
      });
    },
    btn_remove(index) {
      if (this.addVideos.length > 1) {
        this.addVideos.splice(index, 1);
      }
    },
    submitAddvideos() {
      for (var i = 0; i < this.addVideos.length; i++) {
        this.addVideos[i].v_room = this.selectRoom;
      }
      // console.log(this.addVideos)
      var FD = new FormData();
      FD.append("videos", JSON.stringify(this.addVideos));
      FD.append("creator", JSON.stringify(this.$store.state.log_on));
      this.$store.dispatch("AddVideos", FD);
      setTimeout(() => {
        this.$router.go(-1);
      }, 1000);
      this.$swal("Add Videos Success .", "", "success");
    }
  },
  computed: {
    ListRoom() {
      return this.$store.getters.getVideo_Room;
    },
    the_user() {
      var user = this.$store.getters.getThe_User;
      if (user.m_status != "admin") {
        this.$router.go(-1);
      }
      return user;
    }
  }
};
</script>