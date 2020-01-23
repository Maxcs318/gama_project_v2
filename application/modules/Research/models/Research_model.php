<?php

    Class research_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->research = 'research';
            
        }
        // get all Research
        public function get_all_research()
        {
            $ResearchAll = $this->db->get($this->research)->result(); 
            return json_encode($ResearchAll);  
        }
        // get file key research
        public function get_file_key_research($where = array())
        {
            $research = $this->db->select('r_file_key')->where($where)->get($this->research)->result(); 
            return json_encode($research[0]);    
        }
        // insert 
        public function insert_research($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->research,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update Research
        public function update_research($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->research,$data));
        }
        // delete research
        public function delete_research($where = array()){
            return json_encode($this->db->where($where)->delete($this->research));
        }
        



















        
    }
?>