<template>
<div>
  {{date_now}}
</div>
</template>
<script>
import logintest from "./../components/Login_Register/loginPage";
// Get the modal
// var modal = document.getElementById("id01");
export default {
  components: {
    login: logintest
  },
  methods: {
    PopupLogin() {
      document.getElementById("id02").style.display = "block";
    }
  },
  computed:{
    date_now(){
      var today = new Date();
      var date = today.getDate()+'-'+(today.getMonth()+1)+'-'+today.getFullYear()+' '+today.getHours() + ":" + today.getMinutes();
      return date
    }
  }
};

</script>
