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
            $this->product = 'product';
            


        }
        // all order
        public function get_all_order()
        {
            return json_encode($this->db->get($this->orders)->result());
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get my order
        public function get_my_order($number_of_rows,$myID,$order_status_id,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('o_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $this->db->where('o_own_id',$myID);
            if($order_status_id != 1){
                $order_result = $this->db->where('o_status_id >=',$order_status_id)->limit($number_of_rows,$index_start)->get($this->orders)->result(); 
            }else{
                $order_result = $this->db->where('o_status_id',$order_status_id)->limit($number_of_rows,$index_start)->get($this->orders)->result();               
            }
            
            $this->db->where('o_own_id',$myID);
            if($order_status_id != 1){    
                $order_row_all = $this->db->where('o_status_id >=',$order_status_id)->from($this->orders)->count_all_results();
            }else{
                $order_row_all = $this->db->where('o_status_id',$order_status_id)->from($this->orders)->count_all_results();
            }
           
            $result = [$order_row_all,$order_result];
            return json_encode($result); 
        }
        // get_order_by_code
        public function get_order_by_code($order_code)
        {
            $result = $this->db->where('o_code_order',$order_code)->get($this->orders)->result(); 
            return json_encode($result[0]); 
        }
        // get_order_items_in_order
        public function get_order_items_in_order($orderID)
        {
            $result = $this->db->where('oi_order_id',$orderID)->get($this->order_items)->result(); 
            for($i=0;$i<sizeof($result);$i++){
                $product = $this->db->where('p_id',$result[$i]->oi_product_id)->get($this->product)->result(); 
                $result[$i]->oi_product_id = $product[0]->p_name;
            }
            return json_encode($result); 
        }
        // get_order_status_in_order
        public function get_order_status_in_order($order_status_id)
        {
            $result = $this->db->where('os_id',$order_status_id)->get($this->order_status)->result(); 
            return json_encode($result[0]); 
        }
        // get_order_for_admin
        public function get_order_for_admin($number_of_rows,$order_status_id,$pagenow)
        {
            $this->db->order_by('o_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $order_result = $this->db->where('o_status_id',$order_status_id)->limit($number_of_rows,$index_start)->get($this->orders)->result();                   
            $order_row_all = $this->db->where('o_status_id',$order_status_id)->from($this->orders)->count_all_results();           
           
            $result = [$order_row_all,$order_result];
            return json_encode($result); 
        }
        ////////////////////////////////////////////////////////////////////////////////////////

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