import Vue from "vue"
import Vuex from "vuex"
import axios from "axios"

Vue.use(Vuex)
// Web Data
const base_url = 'https://elite-shoponline.com/gama/public/'

// PC Xampp
// const base_url = 'http://gamaproject.vue.com/'

const store = new Vuex.Store({
    state : {
        // Web Data
        file_image_path:'https://elite-shoponline.com/gama/public/assets/',
        
        // PC Xampp
        // file_image_path:'http://gamaproject.vue.com/assets/',

        Base_Url:base_url,

        statusPage:'',
        statusRegister:'',

        the_user:'',
        log_on: localStorage.getItem('The_User') || null,
        
    },
//==========================================================================================================
//==========================================================================================================

    mutations : {
        // Loading page
        LoadingPage(state,statusP){
            state.statusPage = statusP
        },
        ////////////////////////////////////////////////////////////////////////////

        // Log in 
        Logining_in(state,now_user){
            state.log_on = now_user
        },
        Log_Out(state){
            state.log_on = null
            state.the_user = ''
        },
        Log_On(state,user){
            state.the_user = user
        },
        ////////////////////////////////////////////////////////////////////////////

        // Edit Profile
        Edit_Profile(state,Eprofile){
            state.the_user = Eprofile
        },
        ////////////////////////////////////////////////////////////////////////////

        // Cart 
        Add_Cart(state,add_cart){
            // console.log(add_cart.p_id)
            var cart = JSON.parse(localStorage.getItem('Cart'))
            if(cart == null){
                cart = []
            }
            var chk = 'yes'
            if(cart.length>0){
                for(var i=0; i<cart.length; i++){
                    if(cart[i].p_id == add_cart.p_id){
                        cart[i].quantity = cart[i].quantity + add_cart.quantity
                        chk = 'no'
                    } 
                }
            }
            if(chk == 'yes'){
                cart.push(add_cart)
            }
            localStorage.removeItem('Cart')
            localStorage.setItem("Cart", JSON.stringify(cart));
        },
        Remove_Product_In_Cart(state,productID){
            var cart = JSON.parse(localStorage.getItem('Cart'))

            let index = cart.findIndex(p => p.p_id == productID)
            if(index > -1){
                cart.splice(index,1)
            }
            localStorage.removeItem('Cart')
            localStorage.setItem("Cart", JSON.stringify(cart));
        },
        Remove_Cart(state){
            // console.log('remove')
            localStorage.removeItem('Cart')
        },
        Add_Cart_ProductAdd(state,productID){
            var cart = JSON.parse(localStorage.getItem('Cart'))
            let index = cart.findIndex(p => p.p_id == productID)
            cart[index].quantity = cart[index].quantity+1
            localStorage.removeItem('Cart')
            localStorage.setItem("Cart", JSON.stringify(cart));
        },
        Remove_Cart_ProductRemove(state,productID){
            var cart = JSON.parse(localStorage.getItem('Cart'))
            let index = cart.findIndex(p => p.p_id == productID)
            cart[index].quantity = cart[index].quantity-1
            localStorage.removeItem('Cart')
            localStorage.setItem("Cart", JSON.stringify(cart));
        }
       
    },

//==========================================================================================================
//==========================================================================================================

    actions : {
        // Start Load User
        initApp(context){
            // check login            
            if(this.state.log_on !== null){
                var user = { token : this.state.log_on}
                // console.log(user)
                axios.post(base_url +"User/loadLogin", JSON.stringify(user))
                .then(response => {
                    // console.log(response.data)
                    context.commit("Log_On",response.data)
                })
            }else{
                this.state.the_user=''
            }
        },
        // End Load User

        ////////////////////////////////////////////////////////////////////////////
        
        // load page
        LoadingPage(context,statusPage){
            context.commit('LoadingPage',statusPage)
        },
        // login
        Logining_in(context,user){
            // console.log(user)            
            axios.post(base_url +"User/checkLogin", JSON.stringify(user))
            .then(response => {
                // console.log(response)
                    if(response.data != '' && response.data != null){
                        var the_token = response.data.token_logged
                            localStorage.setItem('The_User',the_token)
                            context.commit("Logining_in",the_token)
                            context.commit("Log_On",response.data)
                    }
            })
        },
        Log_Out(context){
            var user_logout = { token : this.state.log_on}
            axios.post(base_url +"User/log_out", JSON.stringify(user_logout))
            .then(response => {
                localStorage.removeItem('The_User')
                context.commit("Log_Out")
                // console.log(response)
            })
        },
        // Register(context,newuser){
        //     axios.post(base_url +"User/save", JSON.stringify(newuser))
        //     .then(response => {
        //         // console.log(response.data)
        //     })
        // },
        // Start Add data
        Add_News(context,news){
            axios.post(base_url +'News/insert_news',news)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                }
            })
        },
        Add_Article(context,article){
            axios.post(base_url +'Article/insert_article',article)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                }
            })
        },
        Add_Product(context,product){
            axios.post(base_url +'Product/insert_product',product)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        CreateRoom(context,newRoom){
            axios.post(base_url +'Videos_Room/insert_room',newRoom)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        AddVideos(context,newvideos){
            axios.post(base_url +'Videos_Room/insert_videos',newvideos)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Academic_Article(context,academic_article){
            axios.post(base_url +'Academic_article/insert_academic_article',academic_article)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Online_Journal(context,online_journal){
            axios.post(base_url +'Online_Journal/insert_online_journal',online_journal)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },


        // End Add Data
        // Start Edit Data
        Edit_News(context,news){
            axios.post(base_url +'News/update_news',news)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Article(context,article){
            axios.post(base_url +'Article/update_article',article)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Product(context,product){
            axios.post(base_url +'Product/update_product',product)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Video_Room(context,video_room){
            axios.post(base_url +'Videos_Room/update_video_room',video_room)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Video(context,video){
            axios.post(base_url +'Videos_Room/update_video',video)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Profile(context,profile){
            axios.post(base_url +'User/edit_profile',profile)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Profile_BY_Admin(context,profile){
            axios.post(base_url +'User/edit_profile',profile)
            .then(response =>{
                // console.log('Response Data',response.data)
               
            })
        },
        Edit_Academic_Article(context,academic_article){
            axios.post(base_url +'Academic_article/update_academic_article',academic_article)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Online_Journal(context,online_journal){
            axios.post(base_url +'Online_Journal/update_online_journal',online_journal)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_News(context,this_news){
            axios.post(base_url +'News/delete_news',this_news)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Article(context,this_article){
            axios.post(base_url +'Article/delete_article',this_article)
            .then(response =>{
                // console.log('Response Data',response.data)
                
            })
        },
        Delete_File(context,this_news){
            axios.post(base_url +'Files_Upload/delete_files_upload',this_news)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Product_Image(context,product_imageID){
            axios.post(base_url +'Product/delete_product_image',product_imageID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })            
        },
        Delete_Product(context,this_product){
            axios.post(base_url +'Product/delete_product',this_product)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Video_Room(context,this_video_room){
            axios.post(base_url +'Videos_Room/delete_video_room',this_video_room)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Video(context,this_video){
            axios.post(base_url +'Videos_Room/delete_video',this_video)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Academic_Article(context,academic_articleID){
            axios.post(base_url +'Academic_article/delete_academic_article',academic_articleID)
            .then(response =>{
                    // console.log('Response Data',response.data)
            })
        },
        Delete_Online_Journal(context,OJID){
            axios.post(base_url +'Online_Journal/delete_online_journal',OJID)
            .then(response =>{
                    // console.log('Response Data',response.data)
            })
        },

        ////////////////////////////////////////////////////////////////////////////
        // Cart Real Time 
        // เพิ่มสินค้าใน แถบสินค้าลงตะกร้า
        Add_Cart(context,addProduct){
            // console.log(addProduct)
            context.commit('Add_Cart',addProduct)
        },
        // ลบสินค้าในตะกร้า ลบออก 1 สินค้า
        Remove_Product_In_Cart(context,productID){
            context.commit('Remove_Product_In_Cart',productID)
        },
        // ล้างตะกร้า ลบสินค้าทั้งหมดในตะกร้า
        Remove_Cart(context){
            context.commit('Remove_Cart')
        },
        // เพิ่มสินค้า 1 ชิ้น ในหน้าตะกร้า
        Add_Cart_ProductAdd(context,productID){
            context.commit('Add_Cart_ProductAdd',productID)
        },
        // นำสินค้าออก 1 ชิ้น ในหน้าตะกร้า
        Remove_Cart_ProductRemove(context,productID){
            context.commit('Remove_Cart_ProductRemove',productID)

        },

        // Order
        Create_Order(context,order){
            axios.post(base_url +'Order/create_order',order)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_My_Order(context,orderID){
            axios.post(base_url +'Order/delete_order',orderID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        // Money Transfer
        Money_Transfer_Insert(context,mtf_i){
            axios.post(base_url +'Money_Transfer/money_trasfer_insert',mtf_i)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Confirm_Order(context,order_code){
            axios.post(base_url +'Order/confirm_order',order_code)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Discard_Order(context,order_code){
            axios.post(base_url +'Order/discard_order',order_code)
            .then(response =>{
                    // console.log('Response Data',response.data)
            })
        },
        Delivery_Order(context,order_code){
            axios.post(base_url +'Order/confirm_order_delivery',order_code)
            .then(response =>{
                    // console.log('Response Data',response.data)
            })
        },
        Add_Gallery(context,gallery){
            axios.post(base_url +'Gallery/insert_gallery',gallery)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Gallery(context,gallery){
            axios.post(base_url +'Gallery/update_gallery',gallery)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Gallery(context,gallery){
            axios.post(base_url +'Gallery/delete_gallery',gallery)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Gallery_Image(context,gallery_imageID){
            axios.post(base_url +'Gallery/delete_gallery_image',gallery_imageID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Research(context,research){
            axios.post(base_url +'Research/insert_research',research)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Research(context,research){
            axios.post(base_url +'Research/update_research',research)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Delete_Research(context,researchID){
            axios.post(base_url +'Research/delete_research',researchID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Award_list(context,award){
            axios.post(base_url +'Award/insert_award_list',award)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Award_list(context,awardEdit){
            axios.post(base_url +'Award/update_award_list',awardEdit)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Award_list(context,awardID){
            axios.post(base_url +'Award/delete_award_list',awardID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Company(context,company){
            axios.post(base_url +'Award/insert_company',company)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Company(context,company){
            axios.post(base_url +'Award/update_company',company)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Company(context,companyID){
            axios.post(base_url +'Award/delete_company',companyID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Award_type(context,award_type){
            axios.post(base_url +'Award/insert_award_type',award_type)
            .then(response =>{
                // console.log('Response Data',response.data)
            }) 
        },
        Edit_Award_type(context,award_type){
            axios.post(base_url +'Award/update_award_type',award_type)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Award_type(context,award_typeID){
            axios.post(base_url +'Award/delete_award_type',award_typeID)
            .then(response =>{
                    // console.log('Response Data',response.data)
            })
        },
        Add_Award_year(context,award_year){
            axios.post(base_url +'Award/insert_award_year',award_year)
            .then(response =>{
                // console.log('Response Data',response.data)
            }) 
        },
        Edit_Award_year(context,award_year){
            axios.post(base_url +'Award/update_award_year',award_year)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Delete_Award_year(context,award_yearID){
            axios.post(base_url +'Award/delete_award_year',award_yearID)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Academic_Article_Category(context,AAC_Insert){
            axios.post(base_url +'Academic_article/insert_academic_article_category',AAC_Insert)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Add_Article_Category(context,AC_Insert){
            axios.post(base_url +'Article/insert_article_category',AC_Insert)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Add_Product_Category(context,PC_Insert){
            axios.post(base_url +'Product/insert_product_category',PC_Insert)
            .then(response =>{
                // console.log('Response Data',response.data)
            })            
        },
        Edit_Academic_Article_Category(context,AAC_Update){
            axios.post(base_url +'Academic_article/update_academic_article_category',AAC_Update)
            .then(response =>{
                // console.log('Response Data',response.data)
            })
        },
        Edit_Article_Category(context,AC_Update){
            axios.post(base_url +'Article/update_article_category',AC_Update)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Edit_Product_Category(context,PC_Update){
            axios.post(base_url +'Product/update_product_category',PC_Update)
            .then(response =>{
                // console.log('Response Data',response.data)
            })            
        },
        Delete_Academic_Article_Category(context,AAC_ID){
            axios.post(base_url +'Academic_article/delete_academic_article_category',AAC_ID)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Delete_Article_Category(context,AC_ID){
            axios.post(base_url +'Article/delete_article_category',AC_ID)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        Delete_Product_Category(context,PC_ID){
            axios.post(base_url +'Product/delete_product_category',PC_ID)
            .then(response =>{
                // console.log('Response Data',response.data[0])
            })
        },
        
    },
//==========================================================================================================
//==========================================================================================================

    getters : {
        // path for filse & image
        getPath_Files(state){
            return state.file_image_path
        },

        // path base url
        getBase_Url(state){
            return state.Base_Url
        },

        // user
        getThe_User(state){
            return state.the_user
        }
      
    }

})

export default store