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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get article
        public function get_article($number_of_rows,$category,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('a_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            if($category != 'all'){
                $article_result = $this->db->where('a_category',$category)->limit($number_of_rows,$index_start)->get($this->article)->result(); 
                $article_row_all = $this->db->where('a_category',$category)->from($this->article)->count_all_results();
            }else{
                $article_result = $this->db->limit($number_of_rows,$index_start)->get($this->article)->result(); 
                $article_row_all = $this->db->from($this->article)->count_all_results();
            }
            $result = [$article_row_all,$article_result];
            return json_encode($result);      
        }
        // get this article
        public function get_this_article($id)
        {   
            $result = $this->db->where('a_id',$id)->get($this->article)->result();
            return json_encode($result);  
        }
        // get all article like ...
        public function get_all_article_like($title_search)
        {   
            $this->db->order_by('a_id', 'DESC');
            $article_result = $this->db->like('a_title',$title_search,'both')->get($this->article)->result();
            $article_row_all = sizeof($article_result);
            $result = [$article_row_all,$article_result];
            return json_encode($result);  
        }
        // get this article_category
        public function get_this_article_category($id)
        {   
            $result = $this->db->where('ac_id',$id)->get($this->article_category)->result();
            return json_encode($result);  
        }
        // get random article
        public function get_random_article($pcs)
        {
            $this->db->order_by('rand()');
            $this->db->limit($pcs);
            $article_result = $this->db->get($this->article)->result();
            return json_encode($article_result);
        }
        ////////////////////////////////////////////////////////////////////////////////////////

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
        public function check_article_and_article_category($id)
        {
            $result = $this->db->where('a_category',$id)->get($this->article)->result(); 
            
            return json_encode(sizeof($result));
        }
        public function delete_article_category($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->article_category));
        }






        
    }
?>