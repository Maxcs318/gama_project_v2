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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get online_journal
        public function get_online_journal($number_of_rows,$permission,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('oj_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $online_journal_result = $this->db->where('oj_permission <=',$permission)->limit($number_of_rows,$index_start)->get($this->online_journal)->result(); 
            $online_journal_row_all = $this->db->where('oj_permission <=',$permission)->from($this->online_journal)->count_all_results();
           
            $result = [$online_journal_row_all,$online_journal_result];
            return json_encode($result);      
        }
        // get this online_journal
        public function get_this_online_journal($permission,$id)
        {   
            $this->db->where('oj_permission <=',$permission);
            $result = $this->db->where('oj_id',$id)->get($this->online_journal)->result();
            return json_encode($result);  
        }
        // get all online_journal like ...
        public function get_all_online_journal_like($permission,$title_search)
        {   
            $this->db->order_by('oj_id', 'DESC');
            $this->db->where('oj_permission <=',$permission);
            $online_journal_result = $this->db->like('oj_title',$title_search,'both')->get($this->online_journal)->result();
            $online_journal_row_all = sizeof($online_journal_result);
            $result = [$online_journal_row_all,$online_journal_result];
            return json_encode($result);  
        }

        ////////////////////////////////////////////////////////////////////////////////////////

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