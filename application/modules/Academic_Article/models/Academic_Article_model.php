<?php

    Class Academic_Article_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->academic_article = 'academic_article';
            $this->academic_article_category = 'academic_article_category';

        }
        // get all Academic Article
        public function get_all_academic_article()
        {
            $academic_articleAll = $this->db->get($this->academic_article)->result(); 
            return json_encode($academic_articleAll);  
        }
        // get all Academic Article Category
        public function get_all_academic_article_category()
        {
            $academic_article_categoryAll = $this->db->get($this->academic_article_category)->result(); 
            return json_encode($academic_article_categoryAll);  
        }
        // get file key academic_article
        public function get_file_key_academic_article($where = array())
        {
            $academic_article = $this->db->select('aa_file_key')->where($where)->get($this->academic_article)->result(); 
            return json_encode($academic_article[0]);    
        }
        // insert Academic Article
        public function insert_academic_article($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->academic_article,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update Academic Article
        public function update_academic_article($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->academic_article,$data));
        }
        // delete academic_article
        public function delete_academic_article($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->academic_article));
        }
        // insert_academic article category
        public function insert_academic_article_category($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->academic_article_category,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update_academic article category
        public function update_academic_article_category ($data=array(),$where=array())
        {
            return json_encode($this->db->where($where)->update($this->academic_article_category,$data));   
        }
        // delete academic article category
        public function delete_academic_article_category($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->academic_article_category));
        }





        
    }
?>