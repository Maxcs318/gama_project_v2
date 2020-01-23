import Vue from 'vue'
import App from './App.vue'
import { router } from "./router";
import store from "./store"
import VueSwal from 'vue-swal'


import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)
Vue.use(VueSwal)


new Vue({
  el: '#app',
  render: h => h(App),
  router,
  store,
})
