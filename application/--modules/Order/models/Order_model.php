<?php

    Class Order_model extends CI_Model{

        public $tableName;

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->orders = 'orders';
            $this->order_status = 'order_status';
            $this->order_items = 'order_items';


        }
        // all order
        public function get_all_order()
        {
            return json_encode($this->db->get($this->orders)->result());
        }
        // all order_status
        public function get_all_order_status()
        {
            return json_encode($this->db->get($this->order_status)->result());
        }
        // all order_item
        public function get_all_order_items()
        {
            return json_encode($this->db->get($this->order_items)->result());
        }
        
        // insert order
        public function create_order($data=array())
        {
            $lastID;
            $ins = $this->db->insert($this->orders,$data);
            if($ins){
                $lastID = $data;
                $lastID['o_id'] = $this->db->insert_id();
            }
            return json_encode($lastID);
        }
        // insert order_items
        public function create_order_item($data=array())
        {
            $data_res=[];
            for($i=0; $i<sizeof($data); $i++){
                $ins = $this->db->insert($this->order_items,$data[$i]);
                if($ins){
                    $data[$i]['oi_id'] = $this->db->insert_id();
                    array_push($data_res,$data[$i]);
                }
            }
            return json_encode($data_res);
        }
        //delete order
        public function delete_order($where=array())
        {
            return json_encode($this->db->where($where)->delete($this->orders));
        }
        //delete order item
        public function delete_order_item($where=array())
        {
            return json_encode($this->db->where($where)->delete($this->order_items));
        }
        // Use By Money_Transfer Use for ( up status => 2 ) && Use By Order Use For Up and Drop Status
        public function change_status_order($where=array(),$data=array())
        {
            json_encode($this->db->where($where)->update($this->orders,$data));
        }
    






        
    }
?>