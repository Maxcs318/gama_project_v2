<template>
  <div>
    <div class="menu">
      <div class="title">MENU</div>
      <ul class="nav">
        <li>
          <h6 href="#" @click="home">
            <!-- <i class="fas fa-home">&nbsp; Home</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/home.png'" /> หน้าหลัก
          </h6>
        </li>
        <li>
          <h6 href="#" @click="news">
            <!-- <i class="fas fa-newspaper">&nbsp; News & Activity</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/news.png'" /> News & Activity
          </h6>
        </li>
        <li>
          <h6 href="#" @click="article">
            <!-- <i class="fas fa-newspaper">&nbsp; Article</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/article.png'" /> Article
          </h6>
        </li>
        <li>
          <h6 href="#" @click="academic_article">
            <!-- <i class="fas fa-scroll">&nbsp; Academic article</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/academic-article.png'" /> Academic article
          </h6>
        </li>
        <li>
          <h6 href="#" @click="research">
            <!-- <i class="fas fa-search-plus">&nbsp; Research</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/research.png'" /> Research
          </h6>
        </li>
        <li>
          <h6 href="#" @click="online_journal">
            <!-- <i class="fas fa-blog">&nbsp; Online journal</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/online-journal.png'" /> Online journal
          </h6>
        </li>
        <li>
          <h6 href="#" @click="product">
            <!-- <i class="fab fa-product-hunt">&nbsp; Product</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/product.png'" /> Product
          </h6>
        </li>
        <li>
          <h6 href="#" @click="list_order">
            <!-- <i class="fas fa-tasks">&nbsp; Check order</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/check-order.png'" /> Check order
          </h6>
        </li>
        <li>
          <h6 href="#" @click="order_complete">
            <!-- <i class="fas fa-tasks">&nbsp; Check order</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/check.png'" /> Order Complete
          </h6>
        </li>
        <li>
          <h6 href="#" @click="video_room">
            <!-- <i class="fas fa-video">&nbsp; Video Room & Videos</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/video.png'" /> Video Room & Videos
          </h6>
        </li>
        <li>
          <h6 href="#" @click="list_gallery">
            <!-- <i class="fas fa-images">&nbsp; Gallery list</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/gallery.png'" /> Event
          </h6>
        </li>
        <li>
          <h6 href="#" @click="award">
            <!-- <i class="fas fa-trophy">&nbsp; Award</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/award.png'" /> Award
          </h6>
        </li>
        <li>
          <h6 href="#" @click="manage_members">
            <!-- <i class="fas fa-users-cog">&nbsp; Manage members</i> -->
            <img class="sidebar-logo" :src="path_files+'logo_img/member.png'" /> Manage members
          </h6>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    home() {
      this.$router.push("/");
    },
    news() {
      this.$router.push("/AdminN/1");
    },
    article() {
      this.$router.push("/AdminA/1");
    },
    product() {
      this.$router.push("/AdminP/1");
    },
    video_room() {
      this.$router.push("/AdminLR/1");
    },
    list_order() {
      this.$router.push("/AdminListOrder/1");
    },
    list_gallery() {
      this.$router.push("/AdminListGallery/1");
    },
    academic_article() {
      this.$router.push("/AdminAA/1");
    },
    online_journal() {
      this.$router.push("/AdminOJ/1");
    },
    manage_members() {
      this.$router.push("/AdminM/1");
    },
    research() {
      this.$router.push("/AdminR/1");
    },
    award() {
      this.$router.push("/AdminAw/all/now/1");
    },
    order_complete() {
      this.$router.push("/AdminListOrder_delivered/1");
    }
  },
  computed: {
    path_files() {
      return this.$store.getters.getPath_Files;
    }
  }
};
</script>

<style scoped>
.menu {
  margin-top: 90px;
  font-weight: 100;
  background: #efefef;
  width: 270px;
  height: 520px;
  z-index: 100;
  padding-left: 20px;
  padding-right: 50px;
  position: fixed;
  -webkit-box-shadow: -3px 0px 5px 0px rgba(0, 0, 0, 0.2);
  box-shadow: -3px 0px 7px 8px rgba(0, 0, 0, 0.2);
  left: -235px;
  transition: 0.3s;
  color: #222;
  border-radius: 4px;
}

.menu:hover,
.menu:focus {
  /* -5px for border-radius */
  transform: translate3d(230px, 0, 0);
  animation-timing-function: 0.5s ease-in;
}
.title {
  top: 12%;
  position: absolute;
  transform: rotate(-270deg);
  left: 227px;
  font-weight: 800;
  font-size: 1.3em;
}
.nav {
  vertical-align: absolute;
  font-weight: 100;
}
ul {
  margin-top: 23px;
}
li {
  width: 100%;
  padding-bottom: 9px;
  list-style-type: none;
}
h6 {
  display: block;
  text-decoration: none;
  color: inherit;
  font-weight: 800;
  transition: 0.2s;
  cursor: pointer;
}

.sidebar-logo {
  margin: auto;
  margin-right: 14px;
  width: 10%;
  height: 10%;
}
.nav h6:hover {
  color: #aaa;
}
</style>