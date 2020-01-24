<?php

    Class Money_Transfer_model extends CI_Model{

        public $tableName;

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->money_transfer = 'money_transfer';

        }
        // all Money_Transfer
        public function get_all_money_transfer()
        {
            return json_encode($this->db->get($this->money_transfer)->result());
        }
        // money_trasfer_insert
        public function money_trasfer_insert( $data=array() )
        {
            $lastID;
            $ins = $this->db->insert($this->money_transfer,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }




        
    }
?>