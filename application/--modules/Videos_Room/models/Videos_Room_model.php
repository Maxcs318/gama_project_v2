<?php

    Class Videos_Room_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            $this->videos = 'videos';
            $this->video_room = 'video_room';

        }
        // get all Videos
        public function get_all_videos()
        {
            $videosAll = $this->db->get($this->videos)->result(); 
            return json_encode($videosAll);  
        }
        // get all Video_room
        public function get_all_video_room()
        {               
            $videosAll = $this->db->get($this->video_room)->result(); 
            return json_encode($videosAll);  
        }
        // insert Room
        public function insert_room($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->video_room,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // insert Videos
        public function insert_videos($data = array())
        {
            $lastID = array();
            for($i=0; $i<sizeof($data); $i++){
                $data[$i]->v_create_date = $this->Check__model->date_time_now();
            $ins = $this->db->insert($this->videos,$data[$i]);
                if($ins){
                    array_push($lastID,$this->db->insert_id());
                }
            }
            return $lastID;
        }
        // update Room
        public function update_video_room($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->video_room,$data));
        }
        // update Video
        public function update_video($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->videos,$data));
        }
        // delete Room
        public function delete_video_room($where=array())
        {
            return json_encode($this->db->where($where)->delete($this->video_room));
        }
        // delete Video
        public function delete_video($where=array())
        {
            return json_encode($this->db->where($where)->delete($this->videos));
        }





        
    }
?>