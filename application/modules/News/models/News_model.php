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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get News
        public function get_news($number_of_rows,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่     
            $this->db->order_by('n_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;
            $news_result = $this->db->limit($number_of_rows,$index_start)->get($this->news)->result(); 
            $news_row_all = $this->db->from($this->news)->count_all_results();
            $result = [$news_row_all,$news_result];
            return json_encode($result);      
        }
        // get this new
        public function get_this_news($id)
        {   
            $result = $this->db->where('n_id',$id)->get($this->news)->result();
            return json_encode($result);  
        }
        // get all new like ...
        public function get_all_news_like($title_search)
        {   
            $this->db->order_by('n_id', 'DESC');
            $news_result = $this->db->like('n_title',$title_search,'both')->get($this->news)->result();
            $news_row_all = sizeof($news_result);
            $result = [$news_row_all,$news_result];
            return json_encode($result);  
        }
        // get random news
        public function get_random_news($pcs)
        {
            $this->db->order_by('rand()');
            $this->db->limit($pcs);
            $news_result = $this->db->get($this->news)->result();
            return json_encode($news_result);
        }
        ////////////////////////////////////////////////////////////////////////////////////////
        
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