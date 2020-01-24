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
        




        
    }
?>