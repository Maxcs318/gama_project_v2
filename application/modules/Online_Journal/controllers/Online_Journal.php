<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Online_Journal extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("online_journal_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->load->model('../../Files_Upload/models/Files_Upload_model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Online_Journal
        public function get_all_online_journal()
        {
            echo $this->online_journal_model->get_all_online_journal();
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get online_journal
        public function get_online_journal($number_of_rows,$permission,$pagenow)
        {
            echo $this->online_journal_model->get_online_journal($number_of_rows,$permission,$pagenow);
        }
        // get this online_journal
        public function get_this_online_journal($permission,$id)
        {
            $online_journal = json_decode($this->online_journal_model->get_this_online_journal($permission,$id));
            if(sizeof($online_journal)==0){
                $files_upload = false;
            }else{
                $key = $online_journal[0]->oj_file_key;
                $files_upload = json_decode($this->Files_Upload_model->get_file_by_key($key));
            }
            $online_journal_and_files = json_encode([$online_journal,$files_upload]);
            echo $online_journal_and_files;
        }
        // get all online_journal like
        public function get_all_online_journal_like($permission,$title_search)
        {
            $title_search = urldecode($title_search);
            echo $this->online_journal_model->get_all_online_journal_like($permission,$title_search);
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////
        
        // insert Online_Journal
        public function insert_online_journal()
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
            $key_link = 'OJ'.date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            $online_journal = (array)json_decode($this->input->post('online_journal'));
            $file_title = (array)json_decode($this->input->post('file_title'));

            $online_journal['oj_create_date'] = $this->Check__model->date_time_now();
            $online_journal['oj_file_key'] = $key_link;
            $thisID = $this->online_journal_model->insert_online_journal($online_journal);
            $online_journal['oj_id']=$thisID;
                
                // insert file_upload
                $filesAll = array();
                $online_journal_dataFiles=[];
                
                if(isset($_FILES['userfileupload0'])){
                $filesupload_length = sizeof($_FILES);
                for($x = 0; $x < $filesupload_length; $x++) {
                    // Set New FileName
                    $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $nameF = substr(strrev($_FILES['userfileupload'.$x]['name']), 0, strrpos(strrev($_FILES['userfileupload'.$x]['name']),"."));
                    $typeF = strrev($nameF);
                    $_FILES['userfileupload'.$x]['name'] = $ranSTR.'.'.$typeF;
                    // End Set FileName
                    $configFiles = array(
                        'upload_path'   => './../public/assets/Online_Journal_Files_Upload/',
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
                    array_push($online_journal_dataFiles,array('online_journal'=>$online_journal,'files'=>$dataFiles));
                }else{
                    echo 'Error !!!';
                }
            }else{
                array_push($online_journal_dataFiles,array('online_journal'=>$online_journal,'files'=>null));

            }
                echo json_encode($online_journal_dataFiles);

        }
        // update online_journal
        public function update_online_journal(){
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
            $online_journal = (array)json_decode($this->input->post('online_journal'));
            $file_title = (array)json_decode($this->input->post('file_title'));

                $online_journalEditID['oj_id'] = $online_journal['oj_id'];
                unset($online_journal['oj_id']); 
                $online_journal['oj_update_date'] = $this->Check__model->date_time_now();
                $thisUpdate = $this->online_journal_model->update_online_journal($online_journal,$online_journalEditID);
                if($thisUpdate == true){
                    $online_journal['oj_id'] = $online_journalEditID['oj_id'];
                }

                $filesAll = array();
                $online_journal_dataFiles=[];

                if(isset($_FILES['userfileupload0'])){                    
                    $filesupload_length = sizeof($_FILES);
                    for($x = 0; $x < $filesupload_length; $x++) {
                        // Set New FileName
                        $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                        $nameF = substr(strrev($_FILES['userfileupload'.$x]['name']), 0, strrpos(strrev($_FILES['userfileupload'.$x]['name']),"."));
                        $typeF = strrev($nameF);
                        $_FILES['userfileupload'.$x]['name'] = $ranSTR.'.'.$typeF;
                        // End Set FileName
                        $configFiles = array(
                            'upload_path'   => './../public/assets/Online_Journal_Files_Upload/',
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
                                'f_key'=>$online_journal['oj_file_key'],
                                'f_create_date'=>$this->Check__model->date_time_now()
                            ));
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    } 
                    if(sizeof($filesAll) == $filesupload_length){
                        $dataFiles = $this->Files_Upload_model->insert_files_upload($filesAll);
                        array_push($online_journal_dataFiles,array('online_journal'=>$online_journal,'files'=>$dataFiles));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($online_journal_dataFiles,array('online_journal'=>$online_journal,'files'=>null));
                }
                
                echo json_encode($online_journal_dataFiles);
        }

        // delete online_journal
        public function delete_online_journal(){
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
            $online_journalID = json_decode($this->input->post('online_journalID'));
            $online_journal['oj_id'] = $online_journalID;
            //find file key
            $online_journal_file_key = (array)json_decode($this->online_journal_model->get_file_key_online_journal($online_journal));
            // dete online_journal
            $online_journalstatus = $this->online_journal_model->delete_online_journal($online_journal);
            // delete files in this online_journal 
            $file_key['f_key'] = $online_journal_file_key['oj_file_key'];
            $filesstatus =$this->Files_Upload_model->delete_files_upload($file_key);

            if($online_journalstatus == true){
                echo $online_journalID ;
            }        
        }









        
    }

?>