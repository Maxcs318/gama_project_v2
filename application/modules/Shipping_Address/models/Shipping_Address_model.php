<?php

    Class Shipping_Address_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->shipping_address = 'shipping_address';

        }
        // get all Shipping_Address
        public function get_all_shipping_address()
        {
            $Shipping_AddressAll = $this->db->get($this->shipping_address)->result(); 
            return json_encode($Shipping_AddressAll);      
        }
        public function save_shipping_address($data=array())
        {
            $ins = $this->db->insert($this->shipping_address,$data);
            if($ins){
                $data['sa_id'] = $this->db->insert_id();
            }
            
            return json_encode($data);
        }
        //////////////////////////////////////////////////////////////////////////////////

        // get my shipping address
        public function get_my_shipping_address($id)
        {
            $this->db->order_by('sa_id', 'DESC');
            $result = $this->db->where('sa_member_id',$id)->get($this->shipping_address)->result();
            return json_encode($result);
        }
        //  shipping_address_in_order
        public function shipping_address_in_order($shipping_address_id)
        {
            $result = $this->db->where('sa_id',$shipping_address_id)->get($this->shipping_address)->result();
            return json_encode($result[0]);
        }
        //////////////////////////////////////////////////////////////////////////////////





        
    }
?>