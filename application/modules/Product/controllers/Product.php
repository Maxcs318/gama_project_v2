<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Product extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("product_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Product
        public function get_all_product()
        {
            echo $this->product_model->get_all_product();
        }
        // get all Product_Category
        public function get_all_product_category()
        {
            echo $this->product_model->get_all_product_category();
        }
        // get all Product_Image
        public function get_all_product_image()
        {
            echo $this->product_model->get_all_product_image();
        }
        // insert Product
        public function insert_product()
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
            $key_link = 'P'.date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            // insert
            $product = (array)json_decode($this->input->post('product'));
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Product/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config);
                if ($this->upload->do_upload('userfile')){
                    $data = array('upload_data' => $this->upload->data());
                    
                    $product['p_image'] = $_FILES['userfile']['name'];
                    $product['p_image_key'] = $key_link;
                    $product['p_create_date'] = $this->Check__model->date_time_now();
                    $thisID = $this->product_model->insert_product($product);
                    $product['p_id']=$thisID;
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                // insert another image
                $product_image = array();
                $product_dataFiles=[];

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
                            array_push($product_image,array(
                                'pi_name'=>$_FILES['userfileupload'.$x]['name'],
                                'pi_image_key'=>$key_link,
                                'pi_create_date'=>$this->Check__model->date_time_now()
                            ));
                            
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    }
                    if(sizeof($product_image) == $filesupload_length){
                        $data_image = $this->product_model->insert_product_image($product_image);;
                        array_push($product_dataFiles,array('product'=>$product,'product_image'=>$data_image));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($product_dataFiles,array('product'=>$product,'product_image'=>null));
                }
                echo json_encode($product_dataFiles);

        }
        // update Product
        public function update_product()
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
            //update
            $product = (array)json_decode($this->input->post('product'));
            $config = array(
                'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Product/',
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
                    $product['p_image'] = $_FILES['userfile']['name'];
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                    exit;
                }
            }
                $productEditID['p_id'] = $product['p_id'];
                unset($product['p_id']); 
                $product['p_update_date'] = $this->Check__model->date_time_now(); 
                $thisUpdate = $this->product_model->update_product($product,$productEditID);
                if($thisUpdate == true){
                    $product['p_id'] = $productEditID['p_id'];
                    // echo json_encode($product);
                }
                // update image  ( insert another image )
                $product_image = array();
                $product_dataFiles=[];

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
                            array_push($product_image,array(
                                'pi_name'=>$_FILES['userfileupload'.$x]['name'],
                                'pi_image_key'=> $product['p_image_key'],
                                'pi_create_date'=>$this->Check__model->date_time_now()
                            ));
                            
                        }else{
                            $error = array('error' => $this->upload->display_errors());
                            print_r($error);
                        }
                    }
                    if(sizeof($product_image) == $filesupload_length){
                        $data_image = $this->product_model->insert_product_image($product_image);;
                        array_push($product_dataFiles,array('product'=>$product,'product_image'=>$data_image));
                    }else{
                        echo 'Error !!!';
                    }
                }else{
                    array_push($product_dataFiles,array('product'=>$product,'product_image'=>null));
                }
                echo json_encode($product_dataFiles);
        }

        // delete product_image
        public function delete_product_image()
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
            $product_imageID = json_decode($this->input->post('product_imageID'));

            $product_i['pi_id'] = $product_imageID;
            $product_i_status = $this->product_model->delete_product_image($product_i);
            if($product_i_status == true){
                echo $product_imageID;
            }else{
                echo 'fail';
            }

            
        }
        // delete product 
        public function delete_product()
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
            $productID = json_decode($this->input->post('productID'));
            //delete
            $product['p_id'] = $productID;
            //find image key
            $product_image_key = (array)json_decode($this->product_model->get_image_key_product($product));
            // dete product
            $productstatus = $this->product_model->delete_product($product);
            // delete image in this product 
            $image_key['pi_image_key'] = $product_image_key['p_image_key'];
            $imagestatus = $this->product_model->delete_product_image($image_key);

            if($productstatus == true){
                echo $productID ;
            }
        }
        // insert product category
        public function insert_product_category()
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
            $product_category = (array)json_decode($this->input->post('product_category'));
                // insert image
                $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                $typeF = strrev($nameF);
                $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                $config = array(
                    'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Product_Category/',
                    'allowed_types' => '*',
                    'max_size'      => '0',
                );
                $this->load->library('upload', $config,'file_image');
                $this->file_image->initialize($config);
                if ($this->file_image->do_upload('userfile')){
                    $data = array('upload_data' => $this->file_image->data());  
                    // set image name and for put it in DB
                    $product_category['pc_image'] = $_FILES['userfile']['name'];
 
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    print_r($error);
                }
                
                $product_category['pc_create_date'] = $this->Check__model->date_time_now();
                $thisID = $this->product_model->insert_product_category($product_category);
                $product_category['pc_id']=$thisID;

                echo json_encode($product_category);
        }
        //update product category
        public function update_product_category()
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
            $product_category = (array)json_decode($this->input->post('product_category'));

            if($product_category['pc_id']==1 || $product_category['pc_id']==2){
                echo 'fail';
                exit;
            }
                $product_categoryEditID['pc_id'] = $product_category['pc_id'];
                unset($product_category['pc_id']); 
                $product_category['pc_update_date'] = $this->Check__model->date_time_now();
                
                if(isset($_FILES['userfile'])){
                    $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
                    $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
                    $typeF = strrev($nameF);
                    $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
                    $config = array(
                        'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Product_Category/',
                        'allowed_types' => '*',
                        'max_size'      => '0',
                    );
                    $this->load->library('upload', $config,'file_image');
                    $this->file_image->initialize($config);
                    if ($this->file_image->do_upload('userfile')){
                        $data = array('upload_data' => $this->file_image->data());  
                        // set image name and for put it in DB
                        $product_category['pc_image'] = $_FILES['userfile']['name'];
    
                    }else{
                        $error = array('error' => $this->upload->display_errors());
                        print_r($error);
                    }
                }
                $thisUpdate = $this->product_model->update_product_category($product_category,$product_categoryEditID);
                if($thisUpdate == true){
                    $product_category['pc_id'] = $product_categoryEditID['pc_id'];
                    echo json_encode($product_category);
                }else{
                    echo 'fail';
                }
            }
        // delete product category
        public function delete_product_category()
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
            $product_categoryID = json_decode($this->input->post('product_categoryID'));
            $product_category['pc_id'] = $product_categoryID;
            if($product_category['pc_id']==1 || $product_category['pc_id']==2){
                echo 'fail';
                exit;
            }
            $PC_status = $this->product_model->delete_product_category($product_category);
            if($PC_status == true){
                echo $product_categoryID ;
            } 
        }








        
        //===================================================================
        // public function select_this_product(){
        //     $productID['p_id'] = json_decode($this->input->post('productID'));
        //     $product = $this->product_model->select_this_product($productID);

        //     echo json_encode($product);
        // }


    }

?>