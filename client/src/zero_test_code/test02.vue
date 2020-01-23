<template>

  <div class="container">

  <!-- <sidebar></sidebar>
    <book-interesting></book-interesting>
    <training-courses-interesting></training-courses-interesting>
   -->
  {{Research}}
  
  </div>
  
</template>
<script>
import axios from "axios";
import bookinteresting from "../components/Other_interesting/book_interesting";
import traningcoursesinteresting from "../components/Other_interesting/traning_courses_interesting";
import sidebar from "./../components/Sidebar/sidebar";
export default {
  data() {
    return {};
  },
  components: {
    BookInteresting: bookinteresting,
    TrainingCoursesInteresting: traningcoursesinteresting,
    Sidebar: sidebar
  },
  methods: {},
  watch: {},
  mounted() {},
  computed: {
    Research(){
      return this.$store.getters.getResearch
    },
  }
};
</script>
