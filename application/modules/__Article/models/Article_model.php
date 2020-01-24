<?php

    Class Article_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->article = 'article';
            $this->article_category = 'article_category';

        }
        // get all Article
        public function get_all_article()
        {
            $articleAll = $this->db->get($this->article)->result(); 
            return json_encode($articleAll);  
        }
        // get all Article Category
        public function get_all_article_category()
        {
            $articleAll = $this->db->get($this->article_category)->result(); 
            return json_encode($articleAll);  
        }
        // get file key article
        public function get_file_key_article($where = array())
        {
            $article = $this->db->select('a_file_key')->where($where)->get($this->article)->result(); 
            return json_encode($article[0]);    
        }
        // insert Article
        public function insert_article($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->article,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update Article
        public function update_article($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->article,$data));
        }
        // delete article
        public function delete_article($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->article));
        }
        // insert article category
        public function insert_article_category($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->article_category,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update article category
        public function update_article_category ($data=array(),$where=array())
        {
            return json_encode($this->db->where($where)->update($this->article_category,$data));   
        }
        // delete article category
        public function delete_article_category($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->article_category));
        }






        
    }
?>