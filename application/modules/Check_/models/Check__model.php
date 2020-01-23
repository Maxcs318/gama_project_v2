<?php

    Class Check__model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->logged = 'logged';
            $this->member = 'member';

        }
        
        // check token 
        public function chk_token($data)
        {
            $this->db->where('token', $data);
            $tokenUser = $this->db->get($this->logged)->result();                      
            return $tokenUser[0]->l_id_m_id;
        }
        // check status
        public function chk_status($data)
        {
            $this->db->where('m_id', $data);
            $userS = $this->db->get($this->member)->result();                      
            return $userS[0]->m_status;
        }
        
        public function date_time_now(){
            $createM ;
                    if(date('m')==1){
                        $createM = 'มกราคม';
                    }else if(date('m')==2){
                        $createM = 'กุมภาพันธ์';
                    }else if(date('m')==3){
                        $createM = 'มีนาคม';
                    }else if(date('m')==4){
                        $createM = 'เมษายน';
                    }else if(date('m')==5){
                        $createM = 'พฤษภาคม';
                    }else if(date('m')==6){
                        $createM = 'มิถุนายน';
                    }else if(date('m')==7){
                        $createM = 'กรกฎาคม';
                    }else if(date('m')==8){
                        $createM = 'สิงหาคม';
                    }else if(date('m')==9){
                        $createM = 'กันยายน';
                    }else if(date('m')==10){
                        $createM = 'ตุลาคม';
                    }else if(date('m')==11){
                        $createM = 'พฤษจิกายน';
                    }else if(date('m')==12){
                        $createM = 'ธันวาคม';                            
                    }
                    $createY = date('Y')+543;
                    $date_now = date('d').' '.$createM.' '.$createY.' time '.date('H:i:s');
            return $date_now;
        }






        
    }
?>