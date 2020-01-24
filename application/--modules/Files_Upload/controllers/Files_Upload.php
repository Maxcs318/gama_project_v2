<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Files_Upload extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("Files_Upload_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all Files_Upload
        public function get_all_files_upload()
        {
            echo $this->Files_Upload_model->get_all_files_upload();
        }
        // delete file
        public function delete_files_upload()
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
            $fileID = json_decode($this->input->post('fileID'));
            $this_file['f_id'] = $fileID;
            $filestatus = $this->Files_Upload_model->delete_files_upload($this_file);
            if($filestatus == true){
                echo $fileID;
            }else{
                echo 'fail';
            }

        }
        








        
    }

?>