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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get research
        public function get_research($number_of_rows,$permission,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('r_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $research_result = $this->db->where('r_permission <=',$permission)->limit($number_of_rows,$index_start)->get($this->research)->result(); 
            $research_row_all = $this->db->where('r_permission <=',$permission)->from($this->research)->count_all_results();
           
            $result = [$research_row_all,$research_result];
            return json_encode($result);      
        }
        // get this research
        public function get_this_research($permission,$id)
        {   
            $this->db->where('r_permission <=',$permission);
            $result = $this->db->where('r_id',$id)->get($this->research)->result();
            return json_encode($result);  
        }
        // get all research like ...
        public function get_all_research_like($permission,$title_search)
        {   
            $this->db->order_by('r_id', 'DESC');
            $this->db->where('r_permission <=',$permission);
            $research_result = $this->db->like('r_title',$title_search,'both')->get($this->research)->result();
            $research_row_all = sizeof($research_result);
            $result = [$research_row_all,$research_result];
            return json_encode($result);  
        }

        ////////////////////////////////////////////////////////////////////////////////////////
     
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