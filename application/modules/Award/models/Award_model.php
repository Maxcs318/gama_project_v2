<?php

    Class Award_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->award_list = 'award_list';
            $this->award_type = 'award_type';
            $this->award_year = 'award_year';
            $this->company = 'company';

        }
        // get all award_list
        public function get_all_award_list()
        {
            $award_list_All = $this->db->get($this->award_list)->result(); 
            return json_encode($award_list_All);      
        }
        // insert award_list
        public function insert_award_list($data=array())
        {
            $ins = $this->db->insert($this->award_list,$data);
            if($ins){
                $data['al_id'] = $this->db->insert_id();
            }
            return json_encode($data);
        }
        // update award_list
        public function update_award_list($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->award_list,$data));
        }
        // delete awart_list
        public function delete_award_list($where = array()){
            return json_encode($this->db->where($where)->delete($this->award_list));
        }
        // ====================================================

        // get award type
        public function get_all_award_type()
        {
            $award_list_All = $this->db->get($this->award_type)->result(); 
            return json_encode($award_list_All);      
        }
        // insert award type
        public function insert_award_type($data=array())
        {
            $ins = $this->db->insert($this->award_type,$data);
            if($ins){
                $data['at_id'] = $this->db->insert_id();
            }
            return json_encode($data);
        }
        // update award_type
        public function update_award_type($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->award_type,$data));
        }
        // delete award_type
        public function delete_award_type($where = array()){
            return json_encode($this->db->where($where)->delete($this->award_type));
        }
        // =====================================================
        
        // get award years
        public function get_all_award_years()
        {
            $award_list_All = $this->db->get($this->award_year)->result(); 
            return json_encode($award_list_All);      
        }
        // insert award year
        public function insert_award_year($data=array())
        {
            $ins = $this->db->insert($this->award_year,$data);
            if($ins){
                $data['ay_id'] = $this->db->insert_id();
            }
            return json_encode($data);
        }
        // update award_year
        public function update_award_year($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->award_year,$data));
        }
        // delete award_year
        public function delete_award_year($where = array()){
            return json_encode($this->db->where($where)->delete($this->award_year));
        }
        // =====================================================
        
        // get company
        public function get_all_company()
        {
            $company_All = $this->db->get($this->company)->result(); 
            return json_encode($company_All);      
        }
        // insert company
        public function insert_company($data=array())
        {
            $ins = $this->db->insert($this->company,$data);
            if($ins){
                $data['c_id'] = $this->db->insert_id();
            }
            return json_encode($data);
        }
        // update company
        public function update_company($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->company,$data));
        }
        // delete company
        public function delete_company($where = array()){
            return json_encode($this->db->where($where)->delete($this->company));
        }





        
    }
?>