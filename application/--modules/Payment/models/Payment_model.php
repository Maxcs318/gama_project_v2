<?php

    Class Payment_model extends CI_Model{

        public $tableName;

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->payment = 'payments';

        }
        // all Payment
        public function get_all_payment()
        {
            return json_encode($this->db->get($this->payment)->result());
        }
        




        
    }
?>