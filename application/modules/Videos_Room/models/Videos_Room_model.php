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

        ////////////////////////////////////////////////////////////////////////////////////////

        // get video_room
        public function get_video_room($number_of_rows,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่     
            $this->db->order_by('vr_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;
            $video_room_result = $this->db->limit($number_of_rows,$index_start)->get($this->video_room)->result(); 
            $video_room_row_all = $this->db->from($this->video_room)->count_all_results();
            $result = [$video_room_row_all,$video_room_result];
            return json_encode($result);      
        }
        // get this video_room
        public function get_this_video_room($id)
        {   
            $result = $this->db->where('vr_id',$id)->get($this->video_room)->result();
            return json_encode($result);  
        }
        // get all video in room  ----------------------------------------------
        public function get_all_video_in_room($number_room)
        {   
            $result = $this->db->where('v_room',$number_room)->get($this->videos)->result();
            return json_encode($result);  
        }
        // ----------------------------------------------------------------------
        // get_this_video
        public function get_this_video($id)
        {
            $result = $this->db->where('v_id',$id)->get($this->videos)->result();
            return json_encode($result);  
        }
        // get all video_room like ...
        public function get_all_video_room_like($title_search)
        {   
            $this->db->order_by('vr_id', 'DESC');
            $video_room_result = $this->db->like('vr_title',$title_search,'both')->get($this->video_room)->result();
            $video_room_row_all = sizeof($video_room_result);
            $result = [$video_room_row_all,$video_room_result];
            return json_encode($result);  
        }

        ////////////////////////////////////////////////////////////////////////////////////////
       
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