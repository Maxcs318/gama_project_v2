<?php

    Class Banking_model extends CI_Model{

        public $tableName;

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->banking = 'banking';
        }
        // all Banking
        public function get_all_banking()
        {
            return json_encode($this->db->get($this->banking)->result());
        }
        ////////////////////////////////////////////////////////////////////////////////////////

        // banking_in_money_transfer
        public function banking_in_money_transfer($banking_id)
        {
            $result = $this->db->where('b_id',$banking_id)->get($this->banking)->result(); 
            return json_encode($result[0]); 
        }

        ////////////////////////////////////////////////////////////////////////////////////////


        
    }
?>