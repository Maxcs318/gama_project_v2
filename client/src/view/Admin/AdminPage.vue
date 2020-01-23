<template>
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-primary" @click="news">News & Activity</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-success" @click="article">Article</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-dark" @click="product">Product</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-danger" @click="video_room">Video Room & Videos</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-warning" @click="list_order">Check Order</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control " @click="list_gallery">List Gallery</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control " @click="academic_article">Academic Article</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-warning" @click="online_journal">Online Journal</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-danger" @click="manage_members">Manage Members</button> <br>
            </div>
            <div class="col-lg-6 col-xs-12">
                <button type="button" class="form-control btn-dark" @click="research">Research</button> <br>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    methods:{
        news(){
            this.$router.push('/AdminN/1')
        },
        article(){
            this.$router.push('/AdminA/1')
        },
        product(){
            this.$router.push('/AdminP/1')
        },
        video_room(){
            this.$router.push('/AdminLR/1')
        },
        list_order(){
            this.$router.push('/AdminListOrder/1')
        },
        list_gallery(){
            this.$router.push('/AdminListGallery/1')
        },
        academic_article(){
            this.$router.push('/AdminAA/1')
        },
        online_journal(){
            this.$router.push('/AdminOJ/1')
        },
        manage_members(){
            this.$router.push('/AdminM/1')
        },
        research(){
            this.$router.push('/AdminR/1')
        }
    }
}
</script>

