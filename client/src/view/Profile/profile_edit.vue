<template>
    <div class="container ">
        <center><h4> Edit Profile </h4></center><br>
        <div class="row" v-if="the_user">
            <div class="col-lg-3 col-xs-12"></div>      
            <div class="col-lg-6 col-xs-12">
                <img v-if="the_user.m_imageprofile != '' && url == null" :src="getImgUrl(the_user.m_imageprofile)" width="100%">
                <img v-if="the_user.m_imageprofile == '' && url== null" :src=" this.path_files+'Profile_Image/default_profile.jpg'" width="100%">
                <img v-if="url"  :src="url" width="100%"/><br><br>
                    <button type="button" class="btn btn-primary" @click="ChooseFiles">
                        Change Image
                    </button>
                <br><br>
            <form @submit.prevent="submitEditProfile">                        
                <input id="chooseImage" ref="files" style="display: none;" type="file" @change="handleFiles">

                Firstname TH 
                <input type="text" v-model="E_member.m_firstname" class="form-control " ><br>

                Firstname Eng 
                <input type="text" v-model="E_member.m_firstname_eng" class="form-control " ><br>

                Lastname TH 
                <input type="text" v-model="E_member.m_lastname" class="form-control " ><br>

                Lastname Eng 
                <input type="text" v-model="E_member.m_lastname_eng" class="form-control " ><br>

                Username  
                <input type="text" v-model="E_member.m_username" class="form-control " ><br>

                <!-- Status 
                <input type="text" v-model="E_member.m_status" class="form-control " ><br> -->

                Company 
                <input type="text" v-model="E_member.m_company" class="form-control " ><br>

                Phone 
                <input type="text" v-model="E_member.m_phone" class="form-control " ><br>

                E-mail 
                <input type="email" v-model="E_member.m_email" class="form-control " ><br>

                Institute 
                <input type="text" v-model="E_member.m_institute" class="form-control " ><br>

                Address 
                <input type="text" v-model="E_member.m_address" class="form-control " ><br>

                Confirm Password For Change Profile
                <input type="password" v-model="passwordCheck" class="form-control " required><br>

                <!-- <hr> -->
                <!-- ID : {{the_user.m_id}}<br>
                ID number : {{the_user.m_id_number}}<br>
                Status : {{the_user.m_status}}<br>
                Member Type : {{the_user.m_type}}<br>
                Upgrade Date ID : {{the_user.m_upgrade_date_id}}<br>
                Join in : {{the_user.m_create_date}}<br>
                Last Edit : {{the_user.m_update_date}}<br>
                Password : {{the_user.m_password}} -->
                <div class="row">   
                    <div class="col-lg-9 col-xs-12"></div>
                    <div class="col-lg-3 col-xs-12">
                        <button class="form-control btn-primary">Save</button>
                    </div>
                </div>
            </form>
            </div>
            <div class="col-lg-3 col-xs-12"></div>
        </div>
    </div>
</template>
<script>
import md5 from 'js-md5'
export default {
    data(){
        return{
            E_member:'',
            passwordOld:'',
            passwordCheck:'',
            url: null,
            fileimage:''
        }
    },
    methods:{
        getImgUrl(pic) {
            return this.path_files+'Profile_Image/'+pic
        },
        ChooseFiles(){
            document.getElementById('chooseImage').click()
        },
        handleFiles(e){
            const file = e.target.files[0]
            this.url = URL.createObjectURL(file)
            let uploadedFiles = this.$refs.files.files[0]
            this.fileimage = uploadedFiles
            if(this.fileimage.size>10000000){
                this.fileimage = []
                this.url = null
                this.$swal('Your file is larger than 10 MB. Sorry Choose Again !!!')
            }
        },
        submitEditProfile(){
            var chk = md5(this.passwordCheck)
            var chk_username = 'YES'
                    for(var i=0; i<this.MemberAll.length; i++){
                        if( this.E_member.m_username == this.MemberAll[i].m_username 
                         && this.E_member.m_id != this.MemberAll[i].m_id ){
                            chk_username = 'NO'
                            // console.log(chk_username,this.E_member.m_id,this.MemberAll[i].m_id)
                        }
                    }
            if(chk != this.passwordOld){
                this.$swal(" Confirm Password Incorrect .", "", "error")
                this.passwordCheck = ''
            }else{
                if( chk_username == 'YES' ){
                    var jsonProfile = JSON.stringify(this.E_member)
                    var FD  = new FormData()

                        if(this.url != null || this.url!= ''){
                            FD.append('userfile',this.fileimage)
                        }
                        FD.append('profile',jsonProfile)            
                        FD.append('own_id',JSON.stringify(this.$store.state.log_on))
                        this.$store.dispatch("Edit_Profile",FD)

                        setTimeout(()=>{
                            this.$router.go(-1)
                        },2000)  
                    this.$swal("Edit Profile Success .", "", "success")
                    this.passwordCheck = ''
                }else{
                    this.$swal("This Username Is Already Taken. .", "", "error")
                    this.passwordCheck = ''  
                }
            }
        }
    },
    computed:{
        MemberAll(){
            return this.$store.getters.getMembers
        },
        the_user(){
            var user = this.$store.getters.getThe_User
            this.E_member = user

            this.passwordOld = user.m_password
            return user
        },
        path_files(){
            return this.$store.getters.getPath_Files
        }
    },
    created(){
        this.$store.dispatch("initApp")
    }
}
</script>
