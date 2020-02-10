<template>
<div class="container">
    <div class="row" >
        <div class="col-lg-4 col-1"></div>
        <div class="col-lg-4 col-10" >
            
            <form @submit.prevent="onSubmitRegister">
                <center><h3> Register </h3></center>
                <br>
                <h5>Firstname</h5>
                <input type="text" v-model="newuser.m_firstname" class="form-control" required>
                <br>
                <h5>Lastname</h5>
                <input type="text" v-model="newuser.m_lastname" class="form-control" required>
                <br>
                <h5>Username {{text_alert}}</h5> 
                <input type="text" v-model="newuser.m_username" class="form-control" required>
                <br>
                <h5>Password</h5>
                <input type="password" v-model="password_normal" class="form-control" required>
                <br>
                <br>
                <div class="row">
                    <div class="col-6">
                        <button type="button" class="form-control col-12 btn-danger" @click="back_1"> Back </button>
                    </div>
                    <br>
                    <br>
                    <br>
                    <div class="col-6">
                        <button type="submit" class="form-control col-12 btn-primary"> Save </button>
                    </div>
                    <br>
                    <br>
                    <br>
                </div>
            </form>

        </div>

        <div class="col-lg-4 col-1"></div>
    </div>
</div>
</template>

<script>
import md5 from 'js-md5'
import axios from "axios";
export default {
    data(){
        return{
            password_normal:'',
            newuser:{
                m_firstname:'',
                m_lastname:'',
                m_username:'',
                m_password:''
            },
            register_user:'',
            text_alert:''
        }
    },
    methods:{
        onSubmitRegister(){
            this.newuser.m_password = md5(this.password_normal);
            this.register_user = this.newuser

            axios.post(this.$store.getters.getBase_Url+"User/save", JSON.stringify(this.register_user))
            .then(response => {
                // console.log(response.data)
                setTimeout(() => {
                    if(response.data == 'fail'){
                        this.newuser.m_username =''
                        this.newuser.m_password ='' 
                        this.password_normal = ''  
                        // this.text_alert = 'username ซ้ำ ครับ'
                        this.$swal(" Username ซ้ำ ครับ  .", "", "error") 
                    }else{
                        this.$router.push('/')
                        this.$swal("Register Success .", "", "success") 
                    }
                }, 400) 
            })
                        
        },
        //
        back_1(){
            this.$router.go(-1)
        }
    },
    computed:{
        log_on(){
            var user = this.$store.getters.getThe_User
            if(user == '' || user == null){
                return 'register'                
            }else{
                this.$router.go(-1)
            }
        }
    }
}
</script>
