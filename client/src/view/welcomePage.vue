<template>
  <div>
    <carousel></carousel>
    <div class="container-fluid">
      <div class="row" style="margin-top: 50px;">
        <div class="col-lg-12 col-xs-12">
          <news></news>
        </div>
      </div>
      <div class="row" style="margin-top: 81px;">
        <div class="col-lg-12 col-xs-12">
          <thearticle></thearticle>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 col-xs-12">
          <book></book>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 col-xs-12">
          <training-course></training-course>
        </div>
      </div>
      <div class="row" style="margin-top: 131px;">
        <div class="col-lg-12 col-xs-12">
          <event></event>
        </div>
      </div>
      <div class="row" style="margin-top: 48px;">
        <div class="col-lg-12 col-xs-12">
          <register></register>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12 col-xs-12">
          <sponsor></sponsor>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Carousel from "../components/WelcomePage/Carousel";
import News from "../components/WelcomePage/News";
import Article from "../components/WelcomePage/Article";
import Book from "../components/WelcomePage/Book";
import TrainingCourse from "../components/WelcomePage/TrainingCourse";
import TheEvent from "../components/WelcomePage/Event";
import Register from "../components/WelcomePage/Register";
import Sponsor from "../components/WelcomePage/Sponsor";
export default {
  methods: {
    scrollToTop() {
      window.scrollTo(0, 0);
    }
  },
  components: {
    carousel: Carousel,
    news: News,
    thearticle: Article,
    book: Book,
    trainingCourse: TrainingCourse,
    event: TheEvent,
    register: Register,
    sponsor: Sponsor
  },
  created() {
    this.$store.dispatch("initApp");
    //   this.$store.dispatch("initDataNews")
    //   this.$store.dispatch("initDataArticle")
    //   this.$store.dispatch("initDataProduct")
    //   this.$store.dispatch("initDataVideos")
    //   this.$store.dispatch("initDataVideo_Room")
  }
};
</script>
<style scoped>
.col-lg-12,
.col-xs-12 {
  padding: 0px;
}
</style>
