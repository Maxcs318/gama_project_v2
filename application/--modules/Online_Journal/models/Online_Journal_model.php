<?php

    Class Online_Journal_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->online_journal = 'online_journal';

        }
        // get all online_journal
        public function get_all_online_journal()
        {
            $online_journalAll = $this->db->get($this->online_journal)->result(); 
            return json_encode($online_journalAll);  
        }
        // get file key Online_Journal
        public function get_file_key_online_journal($where = array())
        {
            $oj = $this->db->select('oj_file_key')->where($where)->get($this->online_journal)->result(); 
            return json_encode($oj[0]);    
        }
        // insert Online_Journal
        public function insert_online_journal($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->online_journal,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update Online_Journal
        public function update_online_journal($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->online_journal,$data));
        }
        // delete Online_Journal
        public function delete_online_journal($where = array()){
            return json_encode($this->db->where($where)->delete($this->online_journal));
        }






        
    }
?>