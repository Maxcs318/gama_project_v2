<template style="background-color: #ffffff">
    <div class="container x ">
        <div class="row">
            <div class="col-lg-12 col-xs-12">
                <svg viewBox="0 0 960 300">
                    <symbol id="s-text">
                        <text text-anchor="middle" x="50%" y="80%"
                            v-if="this.$store.state.statusPage == 'none' && this.$store.state.the_user.m_status == 'user'">
                         G A M A 
                        </text>
                        <text text-anchor="middle" x="50%" y="80%" 
                            v-if="this.$store.state.statusPage == 'none' && this.$store.state.the_user.m_status == 'admin'">
                         A D M I N 
                        </text>
                        <text text-anchor="middle" x="50%" y="80%" v-if="this.$store.state.statusPage == 'save'">Saving . . .</text>
                    </symbol>
                    <g class = "g-ants">
                        <use xlink:href="#s-text" class="text-copy"></use>
                        <use xlink:href="#s-text" class="text-copy"></use>
                        <use xlink:href="#s-text" class="text-copy"></use>
                        <use xlink:href="#s-text" class="text-copy"></use>
                        <use xlink:href="#s-text" class="text-copy"></use>
                    </g>
                </svg>
            </div>
        </div>
    </div>    
</template>

<style>
    /* @import url(https://fonts.googleapis.com/css?family=Montserrat); */
    
    .x{
        height: 100%;
        font-weight: 100%;
        font-family: Arial;
    }

    svg {
        display: block;
        font: 10.5em 'Montserrat';
        width: 100%;
        height: 100%;
        margin: 0 auto;
    }

    .text-copy {
        fill: none;
        stroke: rgb(0, 44, 189);
        stroke-dasharray: 6% 29%;
        stroke-width: 5px;
        stroke-dashoffset: 0%;
        animation: stroke-offset 5.5s infinite linear;
    }

    .text-copy:nth-child(1){
        stroke: rgb(0, 44, 189);
        animation-delay: -1;
    }

    .text-copy:nth-child(2){
        stroke: rgb(0, 44, 189);
        animation-delay: -2s;
    }

    .text-copy:nth-child(3){
        stroke: rgb(0, 44, 189);
        animation-delay: -3s;
    }

    .text-copy:nth-child(4){
        stroke: rgb(0, 44, 189);
        animation-delay: -4s;
    }

    .text-copy:nth-child(5){
        stroke: rgb(0, 44, 189);
        animation-delay: -5s;
    }

    @keyframes stroke-offset{
        100% {stroke-dashoffset: -35%;}
    }
</style>
