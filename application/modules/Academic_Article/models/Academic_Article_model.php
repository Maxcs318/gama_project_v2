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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get academic_article
        public function get_academic_article($number_of_rows,$category,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('aa_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            if($category != 'all'){
                $academic_article_result = $this->db->where('aa_category',$category)->limit($number_of_rows,$index_start)->get($this->academic_article)->result(); 
                $academic_article_row_all = $this->db->where('aa_category',$category)->from($this->academic_article)->count_all_results();
            }else{
                $academic_article_result = $this->db->limit($number_of_rows,$index_start)->get($this->academic_article)->result(); 
                $academic_article_row_all = $this->db->from($this->academic_article)->count_all_results();
            }
            $result = [$academic_article_row_all,$academic_article_result];
            return json_encode($result);      
        }
        // get this academic_article
        public function get_this_academic_article($id)
        {   
            $result = $this->db->where('aa_id',$id)->get($this->academic_article)->result();
            return json_encode($result);  
        }
        // get all academic_article like ...
        public function get_all_academic_article_like($title_search)
        {   
            $this->db->order_by('aa_id', 'DESC');
            $academic_article_result = $this->db->like('aa_title',$title_search,'both')->get($this->academic_article)->result();
            $academic_article_row_all = sizeof($academic_article_result);
            $result = [$academic_article_row_all,$academic_article_result];
            return json_encode($result);  
        }

        // get this academic_article_category
        public function get_this_academic_article_category($id)
        {   
            $result = $this->db->where('aac_id',$id)->get($this->academic_article_category)->result();
            return json_encode($result);  
        }
        // get random academic_article
        public function get_random_academic_article($pcs)
        {
            $this->db->order_by('rand()');
            $this->db->limit($pcs);
            $academic_article_result = $this->db->get($this->academic_article)->result();
            return json_encode($academic_article_result);
        }
        ////////////////////////////////////////////////////////////////////////////////////////
     
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
        public function check_academic_article_and_article_academic_category($id)
        {
            $result = $this->db->where('aa_category',$id)->get($this->academic_article)->result(); 
            
            return json_encode(sizeof($result));
        }
        public function delete_academic_article_category($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->academic_article_category));
        }





        
    }
?>