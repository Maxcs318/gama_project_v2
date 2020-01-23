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


        statusPage:'',
        statusRegister:'',

        news:[],
        article:[],article_category:[],
        academic_article:[],academic_article_category:[],
        online_journal:[],
        research:[],
        files:[],

        product:[],product_category:[],product_image:[],
        order:[],order_items:[],order_status:[],  
        shipping_address:[],
        payment:[],banking:[],
        money_transfer:[],
        
        gallery:[],gallery_image:[],

        members : [],member_type:[],member_upgrade_date:[],
        the_user:'',
        log_on: localStorage.getItem('The_User') || null,
        videos:[], video_room:[],

        award_list:[],award_type:[],award_years:[],company:[]
    },
//==========================================================================================================
//==========================================================================================================
//==========================================================================================================

    mutations : {
        initMembers(state,members){
            state.members = members
        },
        Member_Type(state,member_type){
            state.member_type = member_type
        },
        Members_Upgrade_date(state,members_up){
            state.member_upgrade_date = members_up
        },
        NewsAll(state,news){
            state.news = news
        },
        ArticleAll(state,article){
            state.article = article
        },
        Article_Category(state,a_category){
            state.article_category = a_category
        },
        ProductAll(state,product){
            state.product = product
        },
        Product_CategoryAll(state,product){
            state.product_category = product
        },
        Product_ImageAll(state,product){
            state.product_image = product
        },
        FilesAll(state,files){
            state.files = files
        },
        Orders(state,order){
            state.order = order
        },
        Order_Items(state,order_items){
            state.order_items = order_items
        },
        Order_Status(state,order_status){
            state.order_status = order_status
        },
        Shipping_Address(state,sa){
            state.shipping_address = sa
        },
        Payment(state,pm){
            state.payment = pm
        },
        Banking(state,bk){
            state.banking = bk
        },
        Money_Transfer(state,mtf){
            state.money_transfer = mtf
        },
        GalleryAll(state,gallery){
            state.gallery = gallery
        },
        Gallery_ImageAll(state,gallery_image){
            state.gallery_image = gallery_image
        },
        Academic_ArticleAll(state,academic_article){
            state.academic_article = academic_article
        },
        Academic_Article_Category(state,aa_category){
            state.academic_article_category = aa_category
        },
        Online_Journal(state,oj){
            state.online_journal = oj
        },
        Research(state,research){
            state.research = research
        },

        LoadingPage(state,statusP){
            state.statusPage = statusP
        },
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
        addMember(state,statusrR){
            // state.members.push(member)
            state.statusRegister = statusrR
        },
        Add_News(state,Newnews){
            // console.log('News',Newnews.news)
            // console.log('File',Newnews.files)
            state.news.push(Newnews.news)
        },
        Add_Article(state,Newarticle){
            // console.log('News',Newarticle.article)
            // console.log('File',Newarticle.files)
            state.article.push(Newarticle.article)
        },
        Add_Files_Upload(state,Newfiles){
            state.files.push(Newfiles)
        },
        Add_Product(state,Newproduct){
            state.product.push(Newproduct.product)
            if(Newproduct.product_image.length>0){
                for(var i=0; i<Newproduct.product_image.length; i++){
                    state.product_image.push(Newproduct.product_image[i])
                }
            }
        },
        VideosAll(state,videosall){
            state.videos = videosall
        },
        Video_Room(state,video_room){
            state.video_room = video_room
        },
        CreateRoom(state,NRoom){
            state.video_room.push(NRoom)
        },
        AddVideos(state,NVideos){
            for(var i=0; i<NVideos.length; i++){
                state.videos.push(NVideos[i])
            }
        },
        Add_Academic_Article(state,Newacademic_article){

            state.academic_article.push(Newacademic_article.academic_article)    
        },
        Edit_News(state,E_news){
            var Editnews = E_news.news
            let index = state.news.findIndex(n => n.n_id == Editnews.n_id)
            if(index > -1){
                state.news[index] = Editnews
            }
            var addFiles = E_news.files
            if(addFiles!=null){
                for(var i=0; i<addFiles.length; i++){
                    state.files.push(addFiles[i])
                }
            }
        },
        Edit_Article(state,E_article){
            var Editarticle = E_article.article
            var AID = Editarticle.a_id
            
            let index = state.article.findIndex(a => a.a_id == AID)
            if(index > -1){
                state.article[index] = Editarticle
            }
            var addFiles = E_article.files
            if(addFiles != null){
                for(var i=0; i<addFiles.length; i++){
                    state.files.push(addFiles[i])
                }
            }
        },
        Edit_Product(state,thisProduct){
            var Editproduct = thisProduct.product
            let index = state.product.findIndex(p => p.p_id == Editproduct.p_id)
            if(index > -1){
                state.product[index] = Editproduct
                // console.log(state.product[index])
            }
            var addProductImage = thisProduct.product_image
            if(addProductImage != null){
                for(var i=0; i<addProductImage.length;i++){
                    // console.log(addProductImage[i])
                    state.product_image.push(addProductImage[i])
                }
            }
        },
        Edit_Video_Room(state,Editvideo_room){
            let index = state.video_room.findIndex(vr => vr.vr_id == Editvideo_room.vr_id)
            if(index > -1){
                state.video_room[index] = Editvideo_room
            }
        },
        Edit_Video(state,Editvideo){
            let index = state.videos.findIndex(v => v.v_id == Editvideo.v_id)
            if(index > -1){
                state.videos[index] = Editvideo
            }
        },
        Edit_Profile(state,Eprofile){
            state.the_user = Eprofile
        },
        Edit_Profile_BY_Admin(state,Eprofile){
            let index = state.members.findIndex(m => m.m_id == Eprofile.m_id)
            if(index > -1){
                state.members[index] = Eprofile
            }
        },
        Edit_Academic_Article(state,E_academic_article){
            var Edit_AA = E_academic_article.academic_article
            // console.log(Edit_AA)
            let index = state.academic_article.findIndex(a => a.aa_id == Edit_AA.aa_id)
            if(index > -1){
                state.academic_article[index] = Edit_AA
            }
            var addFiles = E_academic_article.files
            if(addFiles != null){
                for(var i=0; i<addFiles.length; i++){
                    state.files.push(addFiles[i])
                }
            }
        },
        Edit_Online_Journal(state,E_OJ){
            var Edit_OJ = E_OJ.online_journal
            let index = state.online_journal.findIndex(oj => oj.oj_id == Edit_OJ.oj_id)
            if(index > -1){
                state.online_journal[index] = Edit_OJ
            }
            var addFiles = E_OJ.files
            if(addFiles != null){
                for(var i=0; i<addFiles.length; i++){
                    state.files.push(addFiles[i])
                }
            }
        },
        Delete_News(state,newsID){
            let index = state.news.findIndex(n => n.n_id == newsID)
            if(index > -1){
                // console.log(state.news[index])
                state.news.splice(index,1)
            }
        },
        Delete_Article(state,articleID){
            let index = state.article.findIndex(a => a.a_id == articleID)
            if(index > -1){
                // console.log(state.article[index])
                state.article.splice(index,1)
            }
        },
        Delete_File(state,fileID){
            let index = state.files.findIndex(f => f.f_id == fileID)
            if(index > -1){
                // console.log(state.files[index])
                state.files.splice(index,1)
            }
        },
        Delete_Product_Image(state,product_imageID){
            let index = state.product_image.findIndex(pi => pi.pi_id == product_imageID)
            if(index > -1){
                // console.log(state.files[index])
                state.product_image.splice(index,1)
            }
        },
        Delete_Product(state,productID){
            let index = state.product.findIndex(p => p.p_id == productID)
            if(index > -1){
                // console.log(state.product[index])
                state.product.splice(index,1)
            }
        },
        Delete_Video_Room(state,video_roomID){
            let index = state.video_room.findIndex(v => v.vr_id == video_roomID)
            if(index > -1){
                // console.log(state.video_room[index])
                state.video_room.splice(index,1)
            }
        },
        Delete_Video(state,videoID){
            let index = state.videos.findIndex(v => v.v_id == videoID)
            if(index > -1){
                // console.log(state.videos[index])
                state.videos.splice(index,1)
            }
        },
        Delete_Academic_Article(state,academic_articleID){
            let index = state.academic_article.findIndex(a => a.aa_id == academic_articleID)
            if(index > -1){
                // console.log(state.article[index])
                state.academic_article.splice(index,1)
            }
        },
        Delete_Online_Journal(state,ojID){
            let index = state.online_journal.findIndex(oj => oj.oj_id == ojID)
            if(index > -1){
                // console.log(state.article[index])
                state.online_journal.splice(index,1)
            }
        },

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
        },
        Create_Order(state,order){
            state.order.push(order)
            // localStorage.removeItem('Cart')
        },
        Delete_My_Order(state,order){
            var order_id = order.o_id 
            let index = state.order.findIndex(o => o.o_id == order_id)
            if(index > -1){
                state.order.splice(index,1)
            }
        },
        Money_Transfer_Insert(state, mtf_insert){
            
            var mtf = mtf_insert.money_transfer
            var order_id = mtf_insert.order_id
            // console.log(order_id)
            // console.log(mtf)
            state.money_transfer.push(mtf)
            let index = state.order.findIndex(o => o.o_id == order_id)
            if(index > -1){
                state.order[index].o_money_transfer_id = mtf.mtf_id
                state.order[index].o_status_id = 2
            }
        },
        Confirm_Order(state,order_code){
            let index = state.order.findIndex(o => o.o_code_order == order_code)
            if(index > -1){
                state.order[index].o_status_id = 3
                // console.log(state.order[index])
            }
        },
        Discard_Order(state,order_code){
            let index = state.order.findIndex(o => o.o_code_order == order_code)
            if(index > -1){
                state.order[index].o_status_id = 1
                // console.log(state.order[index])
            }
        },
        Delivery_Order(state,order_code){
            let index = state.order.findIndex(o => o.o_code_order == order_code)
            if(index > -1){
                state.order[index].o_status_id = 4
                // console.log(state.order[index])
            }
        },
        Add_Gallery(state,gallery){
            var gallery_image = gallery.gallery_image
            state.gallery.push(gallery.gallery)
            // console.log(gallery.gallery)
            for(var i=0;i<gallery_image.length;i++){
                // console.log(gallery_image[i])
                state.gallery_image.push(gallery_image[i])
            }
        },
        Edit_Gallery(state,gallery){
            var this_gallery = gallery.gallery
            var gallery_image = gallery.gallery_image
            let index = state.gallery.findIndex(g => g.g_id == this_gallery.g_id)
            if(index > -1){
                // console.log(this_gallery)
                state.gallery[index] = this_gallery
            }
            for(var i=0;i<gallery_image.length;i++){
                // console.log(gallery_image[i])
                state.gallery_image.push(gallery_image[i])
            }
        },
        Delete_Gallery(state,gallery){
            let index = state.gallery.findIndex(g => g.g_id == gallery)
            if(index > -1){
                state.gallery.splice(index,1)
            }
        },
        Delete_Gallery_Image(state,gallery_imageID){
            let index = state.gallery_image.findIndex(gi => gi.gi_id == gallery_imageID)
            if(index > -1){
                state.gallery_image.splice(index,1)
            }
        },
        Add_Online_Journal(state,NewOJ){
            state.news.push(NewOJ.online_journal)
        },
        Add_Research(state,New_research){
            // console.log(New_research)
            state.research.push(New_research.research)
        },
        Edit_Research(state,Edit_research){
            var Editresearch = Edit_research.research
            let index = state.research.findIndex(r => r.r_id == Editresearch.r_id)
            if(index > -1){
                state.research[index] = Editresearch
            }
            var addFiles = Edit_research.files
            if(addFiles != null){
                for(var i=0; i<addFiles.length; i++){
                    state.files.push(addFiles[i])
                }
            }
        },
        Delete_Research(state,researchID){
            let index = state.research.findIndex(r => r.r_id == researchID)
            if(index > -1){
                state.research.splice(index,1)
            }
        },
        Award_List(state,award){
            state.award_list = award
        },
        Award_Type(state,award_type){
            state.award_type = award_type
        },
        Award_years(state,award_years){
            state.award_years = award_years
        },
        Company(state,company){
            state.company = company
        },
        Add_Award_list(state,awardInsert){
            state.award_list.push(awardInsert)
        },
        Edit_Award_list(state,awardEdit){
            let index = state.award_list.findIndex(al => al.al_id == awardEdit.al_id)
            if(index > -1){
                state.award_list[index] = awardEdit
            }
        },
        Delete_Award_list(state,awardID){
            let index = state.award_list.findIndex(al => al.al_id == awardID)
            if(index > -1){
                state.award_list.splice(index,1)
            }
        },
        Add_Company(state,companyInsert){
            state.company.push(companyInsert)
        },
        Edit_Company(state,companyEdit){
            let index = state.company.findIndex(c => c.c_id == companyEdit.c_id)
            if(index > -1){
                state.company[index] = companyEdit
            }
        },
        Delete_Company(state,companyID){
            let index = state.company.findIndex(c => c.c_id == companyID)
            if(index > -1){
                state.company.splice(index,1)
            }
        },
        Add_Award_type(state,award_typeInsert){
            state.award_type.push(award_typeInsert)
        },
        Edit_Award_type(state,award_typeEdit){
            let index = state.award_type.findIndex(at => at.at_id == award_typeEdit.at_id)
            if(index > -1){
                state.award_type[index] = award_typeEdit
            }
        },
        Delete_Award_type(state,award_typeID){
            let index = state.award_type.findIndex(at => at.at_id == award_typeID)
            if(index > -1){
                state.award_type.splice(index,1)
            }
        },
        Add_Award_year(state,award_yearInsert){
            state.award_years.push(award_yearInsert)
        },
        Edit_Award_year(state,award_yearEdit){
            let index = state.award_years.findIndex(ay => ay.ay_id == award_yearEdit.ay_id)
            if(index > -1){
                state.award_years[index] = award_yearEdit
            }
        },
        Delete_Award_year(state,award_yearID){
            let index = state.award_years.findIndex(ay => ay.ay_id == award_yearID)
            if(index > -1){
                state.award_years.splice(index,1)
            }
        },
        Add_Academic_Article_Category(state,newAAC){
            state.academic_article_category.push(newAAC)
        },
        Add_Article_Category(state,newAC){
            state.article_category.push(newAC)
        },
        Add_Product_Category(state,newPC){
            state.product_category.push(newPC)
        },
        Edit_Academic_Article_Category(state,EditAAC){
            let index = state.academic_article_category.findIndex(aac => aac.aac_id == EditAAC.aac_id)
            if(index > -1){
                state.academic_article_category[index] = EditAAC
            }
        },
        Edit_Article_Category(state,EditAC){
            let index = state.article_category.findIndex(ac => ac.ac_id == EditAC.ac_id)
            if(index > -1){
                state.article_category[index] = EditAC
            }
        },
        Edit_Product_Category(state,EditPC){
            let index = state.product_category.findIndex(pc => pc.pc_id == EditPC.pc_id)
            if(index > -1){
                state.product_category[index] = EditPC
            }
        },
        Delete_Academic_Article_Category(state,AAC_ID){
            let index = state.academic_article_category.findIndex(aac => aac.aac_id == AAC_ID)
            if(index > -1){
                state.academic_article_category.splice(index,1)
            }
        },
        Delete_Article_Category(state,AC_ID){
            let index = state.article_category.findIndex(ac => ac.ac_id == AC_ID)
            if(index > -1){
                state.article_category.splice(index,1)
            }
        },
        Delete_Product_Category(state,PC_ID){
            let index = state.product_category.findIndex(pc => pc.pc_id == PC_ID)
            if(index > -1){
                state.product_category.splice(index,1)
            }
        }





    },

//==========================================================================================================
//==========================================================================================================
//==========================================================================================================

    actions : {
        // Start Load Data
        initApp(context){
            // check login            
            if(this.state.log_on !== null){
                var user = { token : this.state.log_on}
                // console.log(user)
                axios.post(base_url +"User/loadLogin", JSON.stringify(user))
                .then(response => {
                    context.commit("Log_On",response.data)
                })
            }else{
                this.state.the_user=''
            }
        },
        initMembers(context){
            axios.get(base_url +"User/get_all_datamember")
            .then(response => {
                // console.log(response.data)
                context.commit("initMembers",response.data)
            })
        },
        initDataMember_Upgrade_Date(context){
            axios.get(base_url +"User/get_all_member_upgrade")
            .then(response => {
                // console.log(response.data)
                context.commit("Members_Upgrade_date",response.data)
            })
        },
        initDataMember_Type(context){
            axios.get(base_url +"User/get_all_member_type")
                .then(response => {
                    // console.log(response)
                    context.commit("Member_Type",response.data)
                })
        },
        initDataNews(context){
            axios.get(base_url +"News/get_all_news")
                .then(response => {
                    // console.log(response)
                    context.commit("NewsAll",response.data)
            })
        },
        initDataArticle(context){
            axios.get(base_url +"Article/get_all_article")
                .then(response => {
                    // console.log(response)
                    context.commit("ArticleAll",response.data)
            })
        },
        initDataArticle_Category(context){
            axios.get(base_url +"Article/get_all_article_category")
                .then(response => {
                    // console.log(response)
                    context.commit("Article_Category",response.data)
            })
        },
        initDataFiles(context){
            axios.get(base_url +"Files_Upload/get_all_files_upload")
                .then(response => {
                    context.commit("FilesAll",response.data)
            })
        },
        initDataProduct(context){
            // get product
            axios.get(base_url +"Product/get_all_product")
                .then(response => {
                    // console.log(response)
                    context.commit("ProductAll",response.data)
            })
        },
        initDataProduct_Category(context){
            axios.get(base_url +"Product/get_all_product_category")
                .then(response => {
                    // console.log(response)
                    context.commit("Product_CategoryAll",response.data)
            })
        },
        initDataProduct_Image(context){
            axios.get(base_url +"Product/get_all_product_image")
                .then(response => {
                    // console.log(response)
                    context.commit("Product_ImageAll",response.data)
            })
        },
        initDataVideos(context){
            axios.get(base_url +"Videos_Room/get_all_videos")
                .then(response => {
                    // console.log(response.data)
                    context.commit("VideosAll",response.data)
            })
        },
        initDataVideo_Room(context){
            axios.get(base_url +"Videos_Room/get_all_video_room")
                .then(response => {
                    // console.log(response)
                    context.commit("Video_Room",response.data)
            })
        },
        // = = =
        initDataOrders(context){
            axios.get(base_url +"Order/get_all_order")
                .then(response => {
                    // console.log(response)
                    context.commit("Orders",response.data)
            })
        },
        initDataOrder_Items(context){
            axios.get(base_url +"Order/get_all_order_items")
                .then(response => {
                    // console.log(response)
                    context.commit("Order_Items",response.data)
            })
        },
        initDataOrder_Status(context){
            axios.get(base_url +"Order/get_all_order_status")
                .then(response => {
                    // console.log(response)
                    context.commit("Order_Status",response.data)
            })
        },
        initDataShipping_Address(context){
            axios.get(base_url +"Shipping_Address/get_all_shipping_address")
                .then(response => {
                    // console.log(response)
                    context.commit("Shipping_Address",response.data)
            })
        },
        initDataPayment(context){
            axios.get(base_url +"Payment/get_all_payment")
                .then(response => {
                    // console.log(response)
                    context.commit("Payment",response.data)
            })
        },
        initDataBanking(context){
            axios.get(base_url +"Banking/get_all_banking")
                .then(response => {
                    // console.log(response)
                    context.commit("Banking",response.data)
            })
        },
        initDataMoney_Transfer(context){
            axios.get(base_url +"Money_Transfer/get_all_money_transfer")
                .then(response => {
                    // console.log(response)
                    context.commit("Money_Transfer",response.data)
            })
        },
        initDataGallery(context){
            axios.get(base_url +"Gallery/get_all_gallery")
                .then(response => {
                    // console.log(response.data)
                    context.commit("GalleryAll",response.data)
            })
        },
        initDataGallery_Image(context){
            axios.get(base_url +"Gallery/get_all_gallery_image")
                .then(response => {
                    // console.log(response.data)
                    context.commit("Gallery_ImageAll",response.data)
            })
        },
        initDataAcademic_Article(context){
            axios.get(base_url +"Academic_article/get_all_academic_article")
            .then(response => {
                // console.log(response)
                context.commit("Academic_ArticleAll",response.data)
            })
        },
        initDataAcademic_Article_Category(context){
            axios.get(base_url +"Academic_article/get_all_academic_article_category")
            .then(response => {
                // console.log(response)
                context.commit("Academic_Article_Category",response.data)
            })
        },
        initDataOnline_Journal(context){
            axios.get(base_url +"Online_Journal/get_all_online_journal")
            .then(response => {
                // console.log(response)
                context.commit("Online_Journal",response.data)
            })
        },
        initDataResearch(context){
            axios.get(base_url +"Research/get_all_research")
            .then(response => {
                // console.log(response)
                context.commit("Research",response.data)
            })
        },
        initDataAward_List(context){
            axios.get(base_url +"Award/get_all_award_list")
            .then(response => {
                // console.log(response)
                context.commit("Award_List",response.data)
            })
        },
        initDataAward_Type(context){
            axios.get(base_url +"Award/get_all_award_type")
            .then(response => {
                // console.log(response)
                context.commit("Award_Type",response.data)
            })
        },
        initDataAward_years(context){
            axios.get(base_url +"Award/get_all_award_years")
            .then(response => {
                // console.log(response)
                context.commit("Award_years",response.data)
            })
        },
        initDataCompany(context){
            axios.get(base_url +"Award/get_all_company")
            .then(response => {
                // console.log(response)
                context.commit("Company",response.data)
            })
        },

        // End Load Data
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
        Register(context,newuser){
            axios.post(base_url +"User/save", JSON.stringify(newuser))
            .then(response => {
                // console.log(response.data)
                context.commit("addMember",response.data)
            })
        },
        // Start Add data
        Add_News(context,news){
            axios.post(base_url +'News/insert_news',news)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Add_News",response.data[0])
                }
            })
        },
        Add_Article(context,article){
            axios.post(base_url +'Article/insert_article',article)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Add_Article",response.data[0])
                }
            })
        },
        Add_Product(context,product){
            axios.post(base_url +'Product/insert_product',product)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Add_Product",response.data[0])
                }
            })
        },
        CreateRoom(context,newRoom){
            axios.post(base_url +'Videos_Room/insert_room',newRoom)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("CreateRoom",response.data)
                }
            })
        },
        AddVideos(context,newvideos){
            axios.post(base_url +'Videos_Room/insert_videos',newvideos)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("AddVideos",response.data)
                }
            })
        },
        Add_Academic_Article(context,academic_article){
            axios.post(base_url +'Academic_article/insert_academic_article',academic_article)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Add_Academic_Article",response.data[0])
                }
            })
        },
        Add_Online_Journal(context,online_journal){
            axios.post(base_url +'Online_Journal/insert_online_journal',online_journal)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Add_Online_Journal",response.data[0])
                }
            })
        },


        // End Add Data
        // Start Edit Data
        Edit_News(context,news){
            axios.post(base_url +'News/update_news',news)
            .then(response =>{
                // console.log('Response Data',response.data[0])
                if(response.data != 'fail'){
                    context.commit("Edit_News",response.data[0])
                }
            })
        },
        Edit_Article(context,article){
            axios.post(base_url +'Article/update_article',article)
            .then(response =>{
                // console.log('Response Data',response.data[0])
                if(response.data != 'fail'){
                    context.commit("Edit_Article",response.data[0])
                }
            })
        },
        Edit_Product(context,product){
            axios.post(base_url +'Product/update_product',product)
            .then(response =>{
                // console.log('Response Data',response.data[0])
                if(response.data != 'fail'){
                    context.commit("Edit_Product",response.data[0])
                }
            })
        },
        Edit_Video_Room(context,video_room){
            axios.post(base_url +'Videos_Room/update_video_room',video_room)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Edit_Video_Room",response.data)
                }
            })
        },
        Edit_Video(context,video){
            axios.post(base_url +'Videos_Room/update_video',video)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Edit_Video",response.data)
                }
            })
        },
        Edit_Profile(context,profile){
            axios.post(base_url +'User/edit_profile',profile)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Edit_Profile",response.data)
                }
            })
        },
        Edit_Profile_BY_Admin(context,profile){
            axios.post(base_url +'User/edit_profile',profile)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Edit_Profile_BY_Admin",response.data)
                }
            })
        },
        Edit_Academic_Article(context,academic_article){
            axios.post(base_url +'Academic_article/update_academic_article',academic_article)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Edit_Academic_Article",response.data[0])
                }
            })
        },
        Edit_Online_Journal(context,online_journal){
            axios.post(base_url +'Online_Journal/update_online_journal',online_journal)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Edit_Online_Journal",response.data[0])
                }
            })
        },
        Delete_News(context,this_news){
            axios.post(base_url +'News/delete_news',this_news)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_News",response.data)
                }
            })
        },
        Delete_Article(context,this_article){
            axios.post(base_url +'Article/delete_article',this_article)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_Article",response.data)
                }
            })
        },
        Delete_File(context,this_news){
            axios.post(base_url +'Files_Upload/delete_files_upload',this_news)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_File",response.data)
                }
            })
        },
        Delete_Product_Image(context,product_imageID){
            axios.post(base_url +'Product/delete_product_image',product_imageID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_Product_Image",response.data)
                }
            })            
        },
        Delete_Product(context,this_product){
            axios.post(base_url +'Product/delete_product',this_product)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Delete_Product",response.data)
                }
            })
        },
        Delete_Video_Room(context,this_video_room){
            axios.post(base_url +'Videos_Room/delete_video_room',this_video_room)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Delete_Video_Room",response.data)
                }
            })
        },
        Delete_Video(context,this_video){
            axios.post(base_url +'Videos_Room/delete_video',this_video)
            .then(response =>{
                // console.log('Response Data',response.data)
                if(response.data != 'fail'){
                    context.commit("Delete_Video",response.data)
                }
            })
        },
        Delete_Academic_Article(context,academic_articleID){
            axios.post(base_url +'Academic_article/delete_academic_article',academic_articleID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_Academic_Article",response.data)
                }
            })
        },
        Delete_Online_Journal(context,OJID){
            axios.post(base_url +'Online_Journal/delete_online_journal',OJID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Delete_Online_Journal",response.data)
                }
            })
        },
        
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
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Create_Order',response.data)
                }
            })
        },
        Delete_My_Order(context,orderID){
            axios.post(base_url +'Order/delete_order',orderID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_My_Order',response.data)
                }
            })
        },
        // Money Transfer
        Money_Transfer_Insert(context,mtf_i){
            axios.post(base_url +'Money_Transfer/money_trasfer_insert',mtf_i)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Money_Transfer_Insert',response.data)
                }
            })
        },
        Confirm_Order(context,order_code){
            axios.post(base_url +'Order/confirm_order',order_code)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Confirm_Order',response.data)
                }
            })
        },
        Discard_Order(context,order_code){
            axios.post(base_url +'Order/discard_order',order_code)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Discard_Order',response.data)
                }
            })
        },
        Delivery_Order(context,order_code){
            axios.post(base_url +'Order/confirm_order_delivery',order_code)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delivery_Order',response.data)
                }
            })
        },
        Add_Gallery(context,gallery){
            axios.post(base_url +'Gallery/insert_gallery',gallery)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit('Add_Gallery',response.data[0])
                }
            })
        },
        Edit_Gallery(context,gallery){
            axios.post(base_url +'Gallery/update_gallery',gallery)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Edit_Gallery',response.data[0])
                }
            })
        },
        Delete_Gallery(context,gallery){
            axios.post(base_url +'Gallery/delete_gallery',gallery)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Gallery',response.data)
                }
            })
        },
        Delete_Gallery_Image(context,gallery_imageID){
            axios.post(base_url +'Gallery/delete_gallery_image',gallery_imageID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Gallery_Image',response.data)
                }
            })
        },
        Add_Research(context,research){
            axios.post(base_url +'Research/insert_research',research)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit('Add_Research',response.data[0])
                }
            })
        },
        Edit_Research(context,research){
            axios.post(base_url +'Research/update_research',research)
            .then(response =>{
                // console.log('Response Data',response.data[0])
                if(response.data != 'fail'){
                    context.commit("Edit_Research",response.data[0])
                }
            })
        },
        Delete_Research(context,researchID){
            axios.post(base_url +'Research/delete_research',researchID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Research',response.data)
                }
            })
        },
        Add_Award_list(context,award){
            axios.post(base_url +'Award/insert_award_list',award)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Add_Award_list',response.data)
                }
            })
        },
        Edit_Award_list(context,awardEdit){
            axios.post(base_url +'Award/update_award_list',awardEdit)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Edit_Award_list',response.data)
                }
            })
        },
        Delete_Award_list(context,awardID){
            axios.post(base_url +'Award/delete_award_list',awardID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Award_list',response.data)
                }
            })
        },
        Add_Company(context,company){
            axios.post(base_url +'Award/insert_company',company)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Add_Company',response.data)
                }
            })
        },
        Edit_Company(context,company){
            axios.post(base_url +'Award/update_company',company)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Edit_Company',response.data)
                }
            })
        },
        Delete_Company(context,companyID){
            axios.post(base_url +'Award/delete_company',companyID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Company',response.data)
                }
            })
        },
        Add_Award_type(context,award_type){
            axios.post(base_url +'Award/insert_award_type',award_type)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Add_Award_type',response.data)
                }
            }) 
        },
        Edit_Award_type(context,award_type){
            axios.post(base_url +'Award/update_award_type',award_type)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Edit_Award_type',response.data)
                }
            })
        },
        Delete_Award_type(context,award_typeID){
            axios.post(base_url +'Award/delete_award_type',award_typeID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Award_type',response.data)
                }
            })
        },
        Add_Award_year(context,award_year){
            axios.post(base_url +'Award/insert_award_year',award_year)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Add_Award_year',response.data)
                }
            }) 
        },
        Edit_Award_year(context,award_year){
            axios.post(base_url +'Award/update_award_year',award_year)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Edit_Award_year',response.data)
                }
            })
        },
        Delete_Award_year(context,award_yearID){
            axios.post(base_url +'Award/delete_award_year',award_yearID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit('Delete_Award_year',response.data)
                }
            })
        },
        Add_Academic_Article_Category(context,AAC_Insert){
            axios.post(base_url +'Academic_article/insert_academic_article_category',AAC_Insert)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Add_Academic_Article_Category",response.data)
                }
            })
        },
        Add_Article_Category(context,AC_Insert){
            axios.post(base_url +'Article/insert_article_category',AC_Insert)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Add_Article_Category",response.data)
                }
            })
        },
        Add_Product_Category(context,PC_Insert){
            axios.post(base_url +'Product/insert_product_category',PC_Insert)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Add_Product_Category",response.data)
                }
            })            
        },
        Edit_Academic_Article_Category(context,AAC_Update){
            axios.post(base_url +'Academic_article/update_academic_article_category',AAC_Update)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Edit_Academic_Article_Category",response.data)
                }
            })
        },
        Edit_Article_Category(context,AC_Update){
            axios.post(base_url +'Article/update_article_category',AC_Update)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Edit_Article_Category",response.data)
                }
            })
        },
        Edit_Product_Category(context,PC_Update){
            axios.post(base_url +'Product/update_product_category',PC_Update)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data)
                    context.commit("Edit_Product_Category",response.data)
                }
            })            
        },
        Delete_Academic_Article_Category(context,AAC_ID){
            axios.post(base_url +'Academic_article/delete_academic_article_category',AAC_ID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Delete_Academic_Article_Category",response.data)
                }
            })
        },
        Delete_Article_Category(context,AC_ID){
            axios.post(base_url +'Article/delete_article_category',AC_ID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Delete_Article_Category",response.data)
                }
            })
        },
        Delete_Product_Category(context,PC_ID){
            axios.post(base_url +'Product/delete_product_category',PC_ID)
            .then(response =>{
                if(response.data != 'fail'){
                    // console.log('Response Data',response.data[0])
                    context.commit("Delete_Product_Category",response.data)
                }
            })
        },
        
    },
//==========================================================================================================
//==========================================================================================================
//==========================================================================================================

    getters : {
        getMember_Type(state){
            return state.member_type
        },
        getMember_Upgrade_Date(state){
            return state.member_upgrade_date
        },
        getPath_Files(state){
            return state.file_image_path
        },
        getMembers(state){
            return state.members
        },
        getThe_User(state){
            return state.the_user
        },
        getNews(state){
            return state.news
        },
        getArticle(state){
            return state.article
        },
        getArticle_Category(state){
            return state.article_category
        },
        getArticle_Set_Category(state){
            var article = state.article
            var article_c = state.article_category
            for(var i=0;i<article.length;i++){
                for(var j=0; j<article_c.length; j++){
                    if(article[i].a_category == article_c[j].ac_id){
                    article[i].a_category = article_c[j].ac_title
                    }
                }
            }
            return article
        },
        getFiles(state){
            return state.files
        },
        getProduct(state){
            return state.product
        },
        getProduct_Category(state){
            return state.product_category
        },
        getProduct_Image(state){
            return state.product_image
        },
        getProduct_Set_Category(state){
            let productall = state.product
            let productcategory = state.product_category
            var product_set_category =[]
                for(var i=0; i<productall.length; i++){                    
                    for(var j=0; j<productcategory.length;j++){
                        if(productall[i].p_category == productcategory[j].pc_id){
                            productall[i].p_category = productcategory[j].pc_title
                        }
                    }
                    product_set_category.push(productall[i])
                }
            return product_set_category
        },
        getVideos(state){
            return state.videos
        },
        getVideo_Room(state){
            return state.video_room
        },
        getOrder(state){
            return state.order
        },
        getOrder_Item(state){
            return state.order_items
        },
        getOrder_Status(state){
            return state.order_status
        },
        getMy_Order(state){
            var ord = state.order
            var user = state.the_user
            var my_o = []
            var my_oh = []
            var my_all_order = []
            for(var i=0; i<ord.length; i++){
                if( ord[i].o_own_id == user.m_id && ord[i].o_status_id == 1 ){
                    my_o.push(ord[i])
                }else if( ord[i].o_own_id == user.m_id && ord[i].o_status_id != 1 ){
                    my_oh.push(ord[i])
                }
            }
                my_all_order.push(my_o)
                my_all_order.push(my_oh)
            return my_all_order
        },
        getOrder_For_Admin(state){
            var ord = state.order
            var order_admin = []
            for(var i=0; i<ord.length; i++){
                if( ord[i].o_status_id != 1 ){
                    order_admin.push(ord[i])
                }
            }
            return order_admin
        },
        getShipping_Address(state){
            return state.shipping_address
        },
        getMy_Shipping_Address(state){
            var sa = state.shipping_address
            var user = state.the_user
            var my_sa =[]
                for(var i=0; i<sa.length; i++){
                    if(sa[i].sa_member_id == user.m_id){
                        my_sa.push(sa[i])
                    }
                }
            return my_sa
        },
        getPayments(state){
            return state.payment
        },
        getBanking(state){
            return state.banking
        },
        getMoney_Transfer(state){
            return state.money_transfer
        },
        getGallery(state){
            return state.gallery
        },
        getGallery_Image(state){
            return state.gallery_image
        },
        getAcademic_Article(state){
            return state.academic_article
        },
        getAcademic_Article_Category(state){
            return state.academic_article_category
        },
        getAcademic_Article_Set_Category(state){
            var academic_article = state.academic_article
            var academic_article_c = state.academic_article_category
            for(var i=0;i<academic_article.length;i++){
                for(var j=0; j<academic_article_c.length; j++){
                    if(academic_article[i].aa_category == academic_article_c[j].aac_id){
                        academic_article[i].aa_category = academic_article_c[j].aac_title
                    }
                }
            }
            return academic_article
        },
        getOnline_Journal(state){
            return state.online_journal
        },
        getOnline_Journal_For_User(state){
            var oj_user = []
            var user = state.the_user
            var online_journal = state.online_journal
                for(var i=0; i<online_journal.length; i++){
                    if(user.m_type >=online_journal[i].oj_permission){
                        oj_user.push(online_journal[i])
                    }
                }
            return oj_user
        },
        getResearch(state){
            var research = state.research
            var user = state.the_user
            var research_cansee = []
            if(user.m_status == 'admin'){
                return research
            }
            for(var i=0; i<research.length; i++){
                if( user.m_type >= research[i].r_permission ){
                    research_cansee.push(research[i])
                }
            }
            return research_cansee
        },
        getAward_List(state){
            return state.award_list
        }, 
        getAward_Type(state){
            return state.award_type
        }, 
        getAward_Years(state){
            return state.award_years
        }, 
        getCompany(state){
            return state.company
        },       
    }

})

export default store