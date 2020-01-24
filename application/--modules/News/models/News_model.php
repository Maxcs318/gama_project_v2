<?php

    Class News_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->news = 'news';

        }
        // get all News
        public function get_all_news()
        {
            // $this->db->order_by('n_id', 'DESC');
            $newsAll = $this->db->get($this->news)->result(); 
            return json_encode($newsAll);  
            
        }
        // get file key news
        public function get_file_key_news($where = array())
        {
            $news = $this->db->select('n_file_key')->where($where)->get($this->news)->result(); 
            return json_encode($news[0]);  
        }
        // insert News
        public function insert_news($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->news,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update News
        public function update_news($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->news,$data));
        }
        // delete News
        public function delete_news($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->news));
        }






        
    }
?>