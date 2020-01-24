<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Videos_Room extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("Videos_Room_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Videos
        public function get_all_videos()
        {
            echo $this->Videos_Room_model->get_all_videos();
        }
        //get all Video_room
        public function get_all_video_room()
        {
            echo $this->Videos_Room_model->get_all_video_room();
        }
        // insert Room
        public function insert_room()
        {
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);

            if( $statusUser != 'admin' ){
                echo 'fail';
                exit ;
            }
            $newRoom = (array)json_decode($this->input->post('room'));             
            $newRoom['vr_create_date'] = $this->Check__model->date_time_now();
            $newRoom['vr_owner'] = $creatorID;
            $thisID = $this->Videos_Room_model->insert_room($newRoom);
            $newRoom['vr_id'] = $thisID;
            echo json_encode($newRoom);       
        }
        // insert Videos
        public function insert_videos()
        {
            // check status for insert
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);
            if( $statusUser != 'admin' ){
                echo 'fail';
                exit ;
            }
            // insert
            $newVideos = (array)json_decode($this->input->post('videos'));            
            $thisID = $this->Videos_Room_model->insert_videos($newVideos);
            for($i=0; $i<sizeof($newVideos); $i++){
                $newVideos[$i]->v_id = $thisID[$i] ;
            }
            echo json_encode($newVideos);
                
        }
        // update Room
        public function update_video_room()
        {
            // check status for update
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);
            if( $statusUser != 'admin' ){
                echo 'fail';
                exit ;
            }
            //do update Room
            $Room = (array)json_decode($this->input->post('room'));  
            $RoomID['vr_id'] = $Room['vr_id'];
            unset($Room['vr_id']);
            $Room['vr_update_date'] = $this->Check__model->date_time_now();
            $thisUpdate = $this->Videos_Room_model->update_video_room($Room,$RoomID);
                if($thisUpdate == true){
                    $Room['vr_id'] = $RoomID['vr_id'];
                    echo json_encode($Room);
                }      
        }
        // update Video
        public function update_video()
        {
            // check status for update
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);
            if( $statusUser != 'admin' ){
                echo 'fail';
                exit ;
            }
            //do update Video
            $Video = (array)json_decode($this->input->post('video'));  
            $VideoID['v_id'] = $Video['v_id'];
            unset($Video['v_id']);
            $Video['v_update_date'] = $this->Check__model->date_time_now();
            $thisUpdate = $this->Videos_Room_model->update_video($Video,$VideoID);
                if($thisUpdate == true){
                    $Video['v_id'] = $VideoID['v_id'];
                    echo json_encode($Video);
                }      
        }
        // delete Room
        public function delete_video_room()
        {
            // check status for update
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);
            if( $statusUser != 'admin' ){
                echo 'fail';
                exit ;
            }
            //do delete video_room
            $video_roomID = json_decode($this->input->post('video_roomID'));
            $video_room['vr_id'] = $video_roomID;
            $do_delete = $this->Videos_Room_model->delete_video_room($video_room);
            if($do_delete == true){
                // delete video in this room
                $video['v_room'] = $video_roomID;
                $this->Videos_Room_model->delete_video($video);

                echo json_encode($video_roomID);
            }
            //

        }
        // delete Video
        public function delete_video()
        {
            // check status for update
            $creator = json_decode($this->input->post('creator'));
            if($creator==null || $creator==''){
                echo 'fail';
                exit;
            }
            $creatorID  = $this->Check__model->chk_token($creator);
            $statusUser = $this->Check__model->chk_status($creatorID);
            if( $statusUser != 'admin' ){
                echo 'fail';
                exit;
            }
            //do delete video
            $videoID = json_decode($this->input->post('videoID'));
            $video['v_id'] = $videoID;
            $do_delete = $this->Videos_Room_model->delete_video($video);
            // echo $do_delete;
            if($do_delete == true){
                echo json_encode($videoID);
            }

        }







        
    }

?>