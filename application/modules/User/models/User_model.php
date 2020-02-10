<?php

    Class User_model extends CI_Model{

        public $tableName;

        public function __construct()
        {
            parent::__construct();
            $this->load->model('../../Check_/models/Check__model');
            $this->tableName = 'member';
            $this->member_type = 'member_type';
            $this->member_upgrade_date = 'member_upgrade_date';
            $this->logged = 'logged';

            $this->load->library('session');//

        }
        // all member
        public function get_all_datamember()
        {
            return json_encode($this->db->get($this->tableName)->result());
        }

        //////////////////////////////////////////////////////////////////////////////////
        
        // check_user_already
        public function check_user_already($username)
        {
            $result = $this->db->where('m_username',$username)->get($this->tableName)->result();
            if( sizeof($result) == 0){
                $result[0] = 'YES';
            }
            return json_encode($result[0]);
        }
        // get_member_type_by_id
        public function get_member_type_by_id($member_type_id)
        {
            $result = $this->db->where('mt_id',$member_type_id)->get($this->member_type)->result();
            return json_encode($result[0]);
        }
        // get_member_upgrade_date_by_id
        public function get_member_upgrade_date_by_id($member_upgrade_date_id)
        {
            $result = $this->db->where('mud_id',$member_upgrade_date_id)->get($this->member_upgrade_date)->result();
            return json_encode($result[0]);
        }
        // get_member_all_by_admin
        public function get_member_all_by_admin($number_of_rows,$pagenow)
        {
            $this->db->order_by('m_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $tableName_result = $this->db->limit($number_of_rows,$index_start)->get($this->tableName)->result(); 
            $tableName_row_all = $this->db->from($this->tableName)->count_all_results();
           
            $result = [$tableName_row_all,$tableName_result];
            return json_encode($result);   
        }
        // get_this_member
        public function get_this_member($id)
        {
            $result = $this->db->where('m_id',$id)->get($this->tableName)->result(); 
            return json_encode($result[0]);   
        }
        // get_all_username_like
        public function get_all_username_like($title_search)
        {
            $this->db->order_by('m_id', 'DESC');
            $username_result = $this->db->like('m_username',$title_search,'both')->get($this->tableName)->result();
            $username_row_all = sizeof($username_result);
            $result = [$username_row_all,$username_result];
            return json_encode($result); 
        }
        //////////////////////////////////////////////////////////////////////////////////

        // all member_type
        public function get_all_member_type()
        {
            return json_encode($this->db->get($this->member_type)->result());
        }
        // all member upgrade date
        public function get_all_member_upgrade()
        {
            return json_encode($this->db->get($this->member_upgrade_date)->result());
        }
        // register
        public function save($data = array())
        {
            $data['m_create_date'] = $this->Check__model->date_time_now();
            $data['m_status'] = 'user';
            $data['m_id'] = null;
            $data['m_type'] = 1;
            if($data['m_username'] == ''||$data['m_username'] == null ){
                return 'fail';
                // exit;
            }
            if($data['m_password'] == ''||$data['m_password'] == null ){
                return 'fail';
                // exit;
            }
            $new_username['m_username'] = $data['m_username'];
            $checkMember = $this->db->where($new_username)->get($this->tableName)->result(); 
            if($checkMember != []){
                return 'fail' ;
            }

            $insert = $this->db->insert($this->tableName,$data);
            if($insert){
                return json_encode(
                    array("insert_id" => $this->db->insert_id())
                );
            }
        }

        // ----------------------------------------------------------------------------------------

        // login 
        public function checkLogin($where = array())
        {	
            $query = $this->db->where($where)->get($this->tableName)->result();
            if($query != null){
                $Now_user = $query[0];
                    $genDate = date('dmYHis').$Now_user->m_id.substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $data = array('l_id_m_id'=>$Now_user->m_id,'token'=>$genDate);
                    $create_token = $this->db->insert($this->logged,$data);
                    if($create_token == true){
                        $Now_user->token_logged = $genDate;
                        return json_encode($Now_user);
                    }                
            }else{
                return json_encode('');
            }
        }

        public function loadLogin($where = array())
        {
            $userold = $this->db->where($where)->get($this->logged)->result();
            if($userold == true){
                $old_id = array('m_id'=>$userold[0]->l_id_m_id);
                    $Now_userold = $this->db->where($old_id)->get($this->tableName)->result();
                    return json_encode($Now_userold[0]);
            }else{
                return json_encode('');
            }
        }

        public function log_out($where = array())
        {
            $id_logout = $this->db->where($where)->get($this->logged)->result();
            // return json_encode($id_logout[0]->l_id_m_id);
            if($id_logout == true){
                $do_logout = array('l_id_m_id'=>$id_logout[0]->l_id_m_id);
                    $exit = $this->db->where($do_logout)->delete($this->logged);
                    return json_encode('success');
            }else{
                return json_encode('error');
            }
        }

        // Check Username Already Taken For Edit Profile
        public function username_already_taken($data=array(),$ID_for_check=array())
        {
            $checkMember = $this->db->where($data)->get($this->tableName)->result(); 
            if( sizeof($checkMember) != 0){
                if($checkMember[0]->m_id != $ID_for_check){
                    return json_encode('unsuccess');
                }
            }
            
            return json_encode('success');
            
        }
        // Edit Profile
        public function edit_profile($data = array(),$where = array())
        {
            $statusEdit = $this->db->where($where)->update($this->tableName,$data);
            return json_encode($statusEdit);
        }

        public function upgrade_member_type($data=array())
        {
            $insert = $this->db->insert($this->member_upgrade_date,$data);
            if($insert){
                return json_encode( $this->db->insert_id() );
            }
        }










        
    }
?>