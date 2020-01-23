<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Gallery extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("gallery_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Gallery
        public function get_all_gallery()
        {
            echo $this->gallery_model->get_all_gallery();
        }
        // get all Gallery image
        public function get_all_gallery_image()
        {
            echo $this->gallery_model->get_all_gallery_image();
        }
        
        // insert Gallery
        public function insert_gallery()
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
            // insert gallery
            $gallery = (array)json_decode($this->input->post('gallery'));
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Gallery/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config);
                if ($this->upload->do_upload('userfile')){
                    $data = array('upload_data' => $this->upload->data());
                    $gallery['g_image'] = $_FILES['userfile']['name'];
                    $gallery['g_create_date'] = $this->Check__model->date_time_now();
                    $thisID = $this->gallery_model->insert_gallery($gallery);
                    $gallery['g_id']=$thisID;
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                // insert gallery another image
                $gallery_image = array();
                $gallery_dataFiles=[];
                if(isset($_FILES['userfileupload0'])){
                    $filesupload_length = sizeof($_FILES)-1;
                    for($x = 0; $x < $filesupload_length; $x++) {
                        // Set New FileName
                        $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                        $nameF = substr(strrev($_FILES['userfileupload'.$x]['name']), 0, strrpos(strrev($_FILES['userfileupload'.$x]['name']),"."));
                        $typeF = strrev($nameF);
                        $_FILES['userfileupload'.$x]['name'] = $ranSTR.'.'.$typeF;
                        // End Set FileName
                        // upload image to dir
                        
                        $this->load->library('upload', $config);
                        if ($this->upload->do_upload('userfileupload'.$x)){
                            $data = array('upload_data' => $this->upload->data());
                            array_push($gallery_image,array(
                                'gi_image'=>$_FILES['userfileupload'.$x]['name'],
                                'gi_gallery_id'=>$gallery['g_id'],
                                'gi_create_date'=>$this->Check__model->date_time_now()
                            ));
                            
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    }
                    if(sizeof($gallery_image) == $filesupload_length){
                        $data_image = $this->gallery_model->insert_gallery_image($gallery_image);;
                        array_push($gallery_dataFiles,array('gallery'=>$gallery,'gallery_image'=>$data_image));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($gallery_dataFiles,array('gallery'=>$gallery,'gallery_image'=>null));
                }
                echo json_encode($gallery_dataFiles);

        }
        // update Gallery
        public function update_gallery(){
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
            //update
            $gallery = (array)json_decode($this->input->post('gallery'));
            // echo json_encode($gallery);
            $config = array(
                'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Gallery/',
                'allowed_types' => '*',
                'max_size'      => '0',
            );
            if(isset($_FILES['userfile'])){
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                
                $this->load->library('upload', $config);
                if ($this->upload->do_upload('userfile')){
                    $data = array('upload_data' => $this->upload->data());
                    $gallery['g_image'] = $_FILES['userfile']['name'];
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                    exit;
                }
            }
                $galleryEditID['g_id'] = $gallery['g_id'];
                unset($gallery['g_id']); 
                $gallery['g_update_date'] = $this->Check__model->date_time_now(); 
                $thisUpdate = $this->gallery_model->update_gallery($gallery,$galleryEditID);
                if($thisUpdate == true){
                    $gallery['g_id'] = $galleryEditID['g_id'];
                }
                // update image  ( insert another image )
                $gallery_image = array();
                $gallery_dataFiles=[];

                if(isset($_FILES['userfileupload0'])){
                    if(isset($_FILES['userfile'])){
                        $filesupload_length = sizeof($_FILES)-1;
                    }else{
                        $filesupload_length = sizeof($_FILES);
                    }
                    for($x = 0; $x < $filesupload_length; $x++) {
                        // Set New FileName
                        $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                        $nameF = substr(strrev($_FILES['userfileupload'.$x]['name']), 0, strrpos(strrev($_FILES['userfileupload'.$x]['name']),"."));
                        $typeF = strrev($nameF);
                        $_FILES['userfileupload'.$x]['name'] = $ranSTR.'.'.$typeF;
                        // End Set FileName
                        // upload image to dir
                        $this->load->library('upload', $config);
                        if ($this->upload->do_upload('userfileupload'.$x)){
                            $data = array('upload_data' => $this->upload->data());
                            array_push($gallery_image,array(
                                'gi_image'=>$_FILES['userfileupload'.$x]['name'],
                                'gi_gallery_id'=> $gallery['g_id'],
                                'gi_create_date'=>$this->Check__model->date_time_now()
                            ));
                            
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    }
                    if(sizeof($gallery_image) == $filesupload_length){
                        $data_image = $this->gallery_model->insert_gallery_image($gallery_image);;
                        array_push($gallery_dataFiles,array('gallery'=>$gallery,'gallery_image'=>$data_image));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($gallery_dataFiles,array('gallery'=>$gallery,'gallery_image'=>null));
                }
                echo json_encode($gallery_dataFiles);
        }
        
        // delete gallery 
        public function delete_gallery()
        {
            // check status for delete
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
            $galleryID = json_decode($this->input->post('galleryID'));
            //delete
            $gallery['g_id'] = $galleryID;
            // dete gallery
            $gallerystatus = $this->gallery_model->delete_gallery($gallery);
            // delete image in this gallery 
            $image_key['gi_gallery_id'] = $gallery['g_id'];
            $imagestatus = $this->gallery_model->delete_gallery_image($image_key);
            if($gallerystatus == true){
                echo $galleryID ;
            }
        }

        // delete gallery image
        public function delete_gallery_image()
        {
            // check status for delete
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
            $gallery_imageID = json_decode($this->input->post('gallery_imageID'));

            $gallery_i['gi_id'] = $gallery_imageID;
            $gallery_i_status = $this->gallery_model->delete_gallery_image($gallery_i);
            if($gallery_i_status == true){
                echo $gallery_imageID;
            }else{
                echo 'fail';
            }
        }







        
    }

?>