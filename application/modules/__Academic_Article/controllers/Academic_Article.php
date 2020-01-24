<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Academic_Article extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("academic_article_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->load->model('../../Files_Upload/models/Files_Upload_model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Academic Article
        public function get_all_academic_article()
        {
            echo $this->academic_article_model->get_all_academic_article();
        }
        // get all Academic Article_Category
        public function get_all_academic_article_category()
        {
            echo $this->academic_article_model->get_all_academic_article_category();
        }
        // insert Academic Article
        public function insert_academic_article()
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
            // set key
            $key_link = 'AA'.date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            // insert image & academic_article
            $academic_article = (array)json_decode($this->input->post('academic_article'));
         
            $file_title = (array)json_decode($this->input->post('file_title'));

                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());   
                    $academic_article['aa_image'] = $_FILES['userfile']['name'];
                    $academic_article['aa_create_date'] = $this->Check__model->date_time_now();
                    $academic_article['aa_file_key'] = $key_link;
                    $thisID = $this->academic_article_model->insert_academic_article($academic_article);
                    $academic_article['aa_id']=$thisID;
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                // insert file_upload
                $filesAll = array();
                $academic_article_dataFiles=[];
                
                if(isset($_FILES['userfileupload0'])){
                $filesupload_length = sizeof($_FILES)-1;
                for($x = 0; $x < $filesupload_length; $x++) {
                    // Set New FileName
                    $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $nameF = substr(strrev($_FILES['userfileupload'.$x]['name']), 0, strrpos(strrev($_FILES['userfileupload'.$x]['name']),"."));
                    $typeF = strrev($nameF);
                    $_FILES['userfileupload'.$x]['name'] = $ranSTR.'.'.$typeF;
                    // End Set FileName
                    $configFiles = array(
                        'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article_Files_Upload/',
                        'allowed_types' => '*',
                        'max_size'      => '0',
                    );
                    $this->load->library('upload', $configFiles,'files_upload');
                    $this->files_upload->initialize($configFiles);
                    if ($this->files_upload->do_upload('userfileupload'.$x)){
                        $data = array('upload_data' => $this->files_upload->data());
                        array_push($filesAll,array(
                            'f_name'=>$_FILES['userfileupload'.$x]['name'],
                            'f_title'=>$file_title[$x],
                            'f_key'=>$key_link,
                            'f_create_date'=>$this->Check__model->date_time_now()
                        ));
                    }else{
                        $error = array('error' => $this->upload->display_errors());
                        print_r($error);
                    }
                } 
                if(sizeof($filesAll) == $filesupload_length){
                    $dataFiles = $this->Files_Upload_model->insert_files_upload($filesAll);
                    array_push($academic_article_dataFiles,array('academic_article'=>$academic_article,'files'=>$dataFiles));
                }else{
                    echo 'Error !!!';
                }
            }else{
                array_push($academic_article_dataFiles,array('academic_article'=>$academic_article,'files'=>null));

            }
                echo json_encode($academic_article_dataFiles);

        }
        // update Academic Article
        public function update_academic_article()
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
            //update
            $academic_article = (array)json_decode($this->input->post('academic_article'));
            $file_title = (array)json_decode($this->input->post('file_title'));

            if(isset($_FILES['userfile'])){
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());
                    $academic_article['aa_image'] = $_FILES['userfile']['name'];
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                    exit;
                }
            }
                $academic_articleEditID['aa_id'] = $academic_article['aa_id'];
                unset($academic_article['aa_id']); 
                $academic_article['aa_update_date'] = $this->Check__model->date_time_now();
                $thisUpdate = $this->academic_article_model->update_academic_article($academic_article,$academic_articleEditID);
                if($thisUpdate == true){
                    $academic_article['aa_id'] = $academic_articleEditID['aa_id'];
                }

                $filesAll = array();
                $academic_article_dataFiles=[];

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
                        $configFiles = array(
                            'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article_Files_Upload/',
                            'allowed_types' => '*',
                            'max_size'      => '0',
                        );
                        $this->load->library('upload', $configFiles,'files_upload');
                        $this->files_upload->initialize($configFiles);
                        if ($this->files_upload->do_upload('userfileupload'.$x)){
                            $data = array('upload_data' => $this->files_upload->data());
                            array_push($filesAll,array(
                                'f_name'=>$_FILES['userfileupload'.$x]['name'],
                                'f_title'=>$file_title[$x],
                                'f_key'=>$academic_article['aa_file_key'],
                                'f_create_date'=>$this->Check__model->date_time_now()
                            ));
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    }
                    if(sizeof($filesAll) == $filesupload_length){
                        $dataFiles = $this->Files_Upload_model->insert_files_upload($filesAll);
                        array_push($academic_article_dataFiles,array('academic_article'=>$academic_article,'files'=>$dataFiles));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($academic_article_dataFiles,array('academic_article'=>$academic_article,'files'=>null));
                }
                
                echo json_encode($academic_article_dataFiles);
        }

        // delete Academic Article
        public function delete_academic_article()
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
            //delete
            $academic_articleID = json_decode($this->input->post('academic_articleID'));
            $academic_article['aa_id'] = $academic_articleID;
            //find file key
            $academic_article_file_key = (array)json_decode($this->academic_article_model->get_file_key_academic_article($academic_article));
            // dete academic_article
            $academic_articlestatus = $this->academic_article_model->delete_academic_article($academic_article);
            // delete files in this academic_article 
            $file_key['f_key'] = $academic_article_file_key['aa_file_key'];
            $filesstatus =$this->Files_Upload_model->delete_files_upload($file_key);

            if($academic_articlestatus == true){
                echo $academic_articleID ;
            }        
        }
        // insert_academic_article_category
        public function insert_academic_article_category()
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
            $academic_article_category = (array)json_decode($this->input->post('academic_article_category'));
                // insert image
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article_Category/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());  
                    // set image name and for put it in DB
                    $academic_article_category['aac_image'] = $_FILES['userfile']['name'];
 
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                
                $academic_article_category['aac_create_date'] = $this->Check__model->date_time_now();
                $thisID = $this->academic_article_model->insert_academic_article_category($academic_article_category);
                $academic_article_category['aac_id']=$thisID;

                echo json_encode($academic_article_category);
        }
        //update academic article category
        public function update_academic_article_category()
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
            // update 
            $academic_article_category = (array)json_decode($this->input->post('academic_article_category'));

                $academic_article_categoryEditID['aac_id'] = $academic_article_category['aac_id'];
                unset($academic_article_category['aac_id']); 
                $academic_article_category['aac_update_date'] = $this->Check__model->date_time_now();
                
                if(isset($_FILES['userfile'])){
                    $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                    $typeF = strrev($nameF);
                    $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                    $config = array(
                        'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Academic_Article_Category/',
                        'allowed_types' => '*',
                        'max_size'      => '0',
                    );
                    $this->load->library('upload', $config,'file_image');
                    $this->file_image->initialize($config);
                    if ($this->file_image->do_upload('userfile')){
                        $data = array('upload_data' => $this->file_image->data());  
                        // set image name and for put it in DB
                        $academic_article_category['aac_image'] = $_FILES['userfile']['name'];
    
                    }else{
                        $error = array('error' => $this->upload->display_errors());
                        print_r($error);
                    }
                }
                $thisUpdate = $this->academic_article_model->update_academic_article_category($academic_article_category,$academic_article_categoryEditID);
                if($thisUpdate == true){
                    $academic_article_category['aac_id'] = $academic_article_categoryEditID['aac_id'];
                    echo json_encode($academic_article_category);
                }else{
                    echo 'fail';
                }
            }
        // delete academic article category
        public function delete_academic_article_category()
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
            //delete
            $academic_article_categoryID = json_decode($this->input->post('academic_article_categoryID'));
            $academic_article_category['aac_id'] = $academic_article_categoryID;
            $AAC_status = $this->academic_article_model->delete_academic_article_category($academic_article_category);
            if($AAC_status == true){
                echo $academic_article_categoryID ;
            } 

        }






        
    }

?>