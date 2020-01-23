<template>
    <div class="container ">
        <center><h5> My Profile </h5></center>
        <div class="row" v-if="the_user">
            <div class="col-lg-3 col-xs-12" ></div>      
            <div class="col-lg-6 col-xs-12">
                <img v-if="the_user.m_imageprofile!=''" :src="getImgUrl(the_user.m_imageprofile)" width="100%">
                <img v-if="the_user.m_imageprofile==''" :src="getImgUrlDefault()" width="100%">
                <br><br>
                <div style="text-align: center; " v-for="m_up in Member_Upgrade_Date" v-if="m_up.mud_id == the_user.m_upgrade_date_id">
                    <div v-for="m_up_type in Member_Type" v-if="m_up.mud_member_type_id == m_up_type.mt_id">
                        Member Type : {{m_up_type.mt_name}} <br>
                        End in : {{m_up.mud_date_end}}
                    </div>
                    <br>
                </div>
                Firstname TH : {{the_user.m_firstname}}<br>
                Firstname Eng : {{the_user.m_firstname_eng}}<br>
                Lastname TH : {{the_user.m_lastname}}<br>
                Lastname Eng : {{the_user.m_lastname_eng}}<br>
                Username  : {{the_user.m_username}}<br>
                Image Profile  : {{the_user.m_imageprofile}}<br>
                Company : {{the_user.m_company}}<br>
                Phone : {{the_user.m_phone}}<br>
                E-mail : {{the_user.m_email}}<br>
                Institute : {{the_user.m_institute}}<br>
                Address : {{the_user.m_address}}<br><br>
                <br>
                Join in : {{the_user.m_create_date}}<br>
                Last Edit : {{the_user.m_update_date}}<br>
                <div class="row">
                    <div class="col-lg-8 col-xs-12"></div>
                    <div class="col-lg-4 col-xs-12">
                        <button class="form-control btn-primary" @click="profile_edit">Edit Profile</button>
                    </div>
                </div>
                <!-- <hr> -->
                <!-- ID : {{the_user.m_id}}<br>
                ID number : {{the_user.m_id_number}}<br>
                Status : {{the_user.m_status}}<br>
                Member Type : {{the_user.m_type}}<br>
                Upgrade Date ID : {{the_user.m_upgrade_date_id}}<br>
                
                Password : {{the_user.m_password}} -->

            </div>
            <div class="col-lg-3 col-xs-12"></div>

        </div>
    </div>
</template>
<script>
export default {
    methods:{
        getImgUrl(pic) {
            return this.path_files+'Profile_Image/'+pic
        },
        getImgUrlDefault(){
            return this.path_files+'Profile_Image/default_profile.jpg'
        },
        profile_edit(){
            this.$router.push('/editprofile')
        }
    },
    computed:{
        the_user(){
            var user = this.$store.getters.getThe_User
            return user
        },
        Member_Type(){
            return this.$store.getters.getMember_Type
        },
        Member_Upgrade_Date(){
            return this.$store.getters.getMember_Upgrade_Date
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
