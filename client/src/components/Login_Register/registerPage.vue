<template>
<div class="container">
    <div class="row" >
        <div class="col-lg-4 col-1"></div>
        <div class="col-lg-4 col-10" >
            
            <form @submit.prevent="onSubmitRegister">
                <center><h3> สมัครสมาชิก </h3></center>
                <br>
                <h5>กรุณากรอกข้อมูลใน <b class="alert-required">( * )</b> ให้ครบถ้วน</h5>
                <br>
                <h5>ชื่อจริง <b class="alert-required"> * </b></h5> 
                <input type="text" v-model="newuser.m_firstname" class="form-control" required>
                <br>
                <h5>นามสกุล <b class="alert-required"> * </b></h5>
                <input type="text" v-model="newuser.m_lastname" class="form-control" required>
                <br>
                <h5>E-mail <b class="alert-required"> * </b></h5>
                <input type="email" v-model="newuser.m_email" class="form-control" required>
                <br>
                <h5>หมายเลขโทรศัพท์ <b class="alert-required"> * </b></h5>
                <input type="text" v-model="newuser.m_phone" class="form-control" @keypress="isNumber($event)" required>
                <br>
                <h5>Username {{text_alert}} <b class="alert-required"> * </b></h5> 
                <input type="text" v-model="newuser.m_username" class="form-control" required>
                <br>
                <h5>Password <b class="alert-required"> * </b></h5>
                <input type="password" v-model="password_normal" class="form-control" required>
                <br>
                <h5>Confirm Password <b class="alert-required"> * </b></h5>
                <input type="password" v-model="password_confirm" class="form-control" placeholder="กรุณาใส่ให้ตรงกับ Password" required>
                <br>
                <br>
                <div class="row">
                    <div class="col-6">
                        <button type="button" class="form-control col-12 btn-danger" @click="back_1"> กลับ </button>
                    </div>
                    <br>
                    <br>
                    <br>
                    <div class="col-6">
                        <button type="submit" class="form-control col-12 btn-primary"> ยืนยัน </button>
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
            password_confirm:'',
            newuser:{
                m_firstname:'',
                m_lastname:'',
                m_email:'',
                m_phone:'',
                m_username:'',
                m_password:''
            },
            register_user:'',
            text_alert:''
        }
    },
    methods:{
        onSubmitRegister(){
            if(this.password_normal == this.password_confirm){            
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
                            this.password_confirm = ''  
                            // this.text_alert = 'username ซ้ำ ครับ'
                            this.$swal(" Username ซ้ำ ครับ  .", "", "error") 
                        }else{
                            this.$router.push('/')
                            this.$swal("Register Success .", "", "success") 
                        }
                    }, 400) 
                })
            }else{
                this.$swal("โปรดยืนยัน 'รหัส' ให้ตรงกัน", "", "error")
            }         
        },
        //
        back_1(){
            this.$router.go(-1)
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
