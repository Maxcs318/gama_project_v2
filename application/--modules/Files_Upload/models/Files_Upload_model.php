<?php

    Class Files_Upload_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->files_upload = 'files_upload';

        }
        // get all Files_Upload
        public function get_all_files_upload()
        {
            $files_upload_All = $this->db->get($this->files_upload)->result(); 
            return json_encode($files_upload_All);      
        }
        // insert Files_Upload
        public function insert_files_upload($data = array())
        {
            $lastID;
            for($i=0;$i < sizeof($data) ; $i++){
            $ins = $this->db->insert($this->files_upload,$data[$i]);
                if($ins){
                    $lastID[$i]=[
                        'f_id'=>$this->db->insert_id(),
                        'f_name'=>$data[$i]['f_name'],
                        'f_title'=>$data[$i]['f_title'],
                        'f_key'=>$data[$i]['f_key'],
                        'f_create_date'=>$data[$i]['f_create_date']
                    ];
                }
            }
            return $lastID;
        }
        // delete Files_Upload
        public function delete_files_upload( $where = array())
        {
            return json_encode($this->db->where($where)->delete($this->files_upload));
        }
        







        
    }
?>