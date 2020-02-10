<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Article extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("article_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->load->model('../../Files_Upload/models/Files_Upload_model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Article
        public function get_all_article()
        {
            echo $this->article_model->get_all_article();
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get article
        public function get_article($number_of_rows,$category,$pagenow)
        {
            echo $this->article_model->get_article($number_of_rows,$category,$pagenow);
        }
        // get this article
        public function get_this_article($id)
        {
            $article = json_decode($this->article_model->get_this_article($id));
            if(sizeof($article)==0){
                $files_upload = false;
            }else{
                $key = $article[0]->a_file_key;
                $files_upload = json_decode($this->Files_Upload_model->get_file_by_key($key));
            }
            $article_and_files = json_encode([$article,$files_upload]);
            echo $article_and_files;
        }
        // get all article like
        public function get_all_article_like($title_search)
        {
            $title_search = urldecode($title_search);
            echo $this->article_model->get_all_article_like($title_search);
        }
        
        // article_category
        public function get_this_article_category($id)
        {
            $article_category = json_decode($this->article_model->get_this_article_category($id));
            
            echo json_encode($article_category);
        }
        //get random article
        public function get_random_article($pcs)
        {
            echo $this->article_model->get_random_article($pcs);
        }
        ////////////////////////////////////////////////////////////////////////////////////////

        // get all Article_Category
        public function get_all_article_category()
        {
            echo $this->article_model->get_all_article_category();
        }
        // insert Article
        public function insert_article()
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
            $key_link = 'A'.date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            // insert image & article
            $article = (array)json_decode($this->input->post('article'));
            $file_title = (array)json_decode($this->input->post('file_title'));

                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => './../public/assets/Article/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());   
                    $article['a_image'] = $_FILES['userfile']['name'];
                    $article['a_create_date'] = $this->Check__model->date_time_now();
                    $article['a_file_key'] = $key_link;
                    $thisID = $this->article_model->insert_article($article);
                    $article['a_id']=$thisID;
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                // insert file_upload
                $filesAll = array();
                $article_dataFiles=[];
                
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
                        'upload_path'   => './../public/assets/Article_Files_Upload/',
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
                    array_push($article_dataFiles,array('article'=>$article,'files'=>$dataFiles));
                }else{
                    echo 'Error !!!';
                }
            }else{
                array_push($article_dataFiles,array('article'=>$article,'files'=>null));

            }
                echo json_encode($article_dataFiles);

        }
        // update Article
        public function update_article(){
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
            $article = (array)json_decode($this->input->post('article'));
            $file_title = (array)json_decode($this->input->post('file_title'));

            if(isset($_FILES['userfile'])){
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => './../public/assets/Article/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());
                    $article['a_image'] = $_FILES['userfile']['name'];
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                    exit;
                }
            }
                $articleEditID['a_id'] = $article['a_id'];
                unset($article['a_id']); 
                $article['a_update_date'] = $this->Check__model->date_time_now();
                $thisUpdate = $this->article_model->update_article($article,$articleEditID);
                if($thisUpdate == true){
                    $article['a_id'] = $articleEditID['a_id'];
                }

                $filesAll = array();
                $article_dataFiles=[];

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
                            'upload_path'   => './../public/assets/Article_Files_Upload/',
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
                                'f_key'=>$article['a_file_key'],
                                'f_create_date'=>$this->Check__model->date_time_now()
                            ));
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    } 
                    if(sizeof($filesAll) == $filesupload_length){
                        $dataFiles = $this->Files_Upload_model->insert_files_upload($filesAll);
                        array_push($article_dataFiles,array('article'=>$article,'files'=>$dataFiles));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($article_dataFiles,array('article'=>$article,'files'=>null));
                }
                
                echo json_encode($article_dataFiles);
        }

        // delete article
        public function delete_article(){
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
            $articleID = json_decode($this->input->post('articleID'));
            $article['a_id'] = $articleID;
            //find file key
            $article_file_key = (array)json_decode($this->article_model->get_file_key_article($article));
            // dete article
            $articlestatus = $this->article_model->delete_article($article);
            // delete files in this article 
            $file_key['f_key'] = $article_file_key['a_file_key'];
            $filesstatus =$this->Files_Upload_model->delete_files_upload($file_key);

            if($articlestatus == true){
                echo $articleID ;
            }        
        }
        // insert_article_category
        public function insert_article_category()
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
            $article_category = (array)json_decode($this->input->post('article_category'));
                // insert image
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => './../public/assets/Article_Category/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());  
                    // set image name and for put it in DB
                    $article_category['ac_image'] = $_FILES['userfile']['name'];
 
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                
                $article_category['ac_create_date'] = $this->Check__model->date_time_now();
                $thisID = $this->article_model->insert_article_category($article_category);
                $article_category['ac_id']=$thisID;

                echo json_encode($article_category);
        }
        //update article category
        public function update_article_category()
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
            $article_category = (array)json_decode($this->input->post('article_category'));

                $article_categoryEditID['ac_id'] = $article_category['ac_id'];
                unset($article_category['ac_id']); 
                $article_category['ac_update_date'] = $this->Check__model->date_time_now();
                
                if(isset($_FILES['userfile'])){
                    $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                    $typeF = strrev($nameF);
                    $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                    $config = array(
                        'upload_path'   => './../public/assets/Article_Category/',
                        'allowed_types' => '*',
                        'max_size'      => '0',
                    );
                    $this->load->library('upload', $config,'file_image');
                    $this->file_image->initialize($config);
                    if ($this->file_image->do_upload('userfile')){
                        $data = array('upload_data' => $this->file_image->data());  
                        // set image name and for put it in DB
                        $article_category['ac_image'] = $_FILES['userfile']['name'];
    
                    }else{
                        $error = array('error' => $this->upload->display_errors());
                        print_r($error);
                    }
                }
                $thisUpdate = $this->article_model->update_article_category($article_category,$article_categoryEditID);
                if($thisUpdate == true){
                    $article_category['ac_id'] = $article_categoryEditID['ac_id'];
                    echo json_encode($article_category);
                }else{
                    echo 'fail';
                }
            }
        // delete article category
        public function check_article_and_article_category($id)
        {
            echo $this->article_model->check_article_and_article_category($id);
        }
        public function delete_article_category()
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
            $article_categoryID = json_decode($this->input->post('article_categoryID'));
            $article_category['ac_id'] = $article_categoryID;
            $AC_status = $this->article_model->delete_article_category($article_category);
            if($AC_status == true){
                echo $article_categoryID ;
            } 

        }









        
    }

?>