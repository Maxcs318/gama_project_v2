<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Award extends CI_Controller
    {
        // public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("Award_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // get all award_list
        public function get_all_award_list()
        {
            echo $this->Award_model->get_all_award_list();
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get award
        public function get_award($number_of_rows,$type,$year,$pagenow)
        {
            echo $this->Award_model->get_award($number_of_rows,$type,$year,$pagenow);
        }
        // get this award
        public function get_this_award($id)
        {
            echo $award = $this->Award_model->get_this_award($id);
        }
        // get all award like
        public function get_all_award_like($type,$year,$title_search)
        {
            $title_search = urldecode($title_search);
            echo $this->Award_model->get_all_award_like($type,$year,$title_search);
        }

        // get this company
        public function get_this_company($id)
        {
            echo $award = $this->Award_model->get_this_company($id);
        }
        // get this award_type
        public function get_this_award_type($id)
        {
            echo $award = $this->Award_model->get_this_award_type($id);
        }
        // get this award_year
        public function get_this_award_year($id)
        {
            echo $award = $this->Award_model->get_this_award_year($id);
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////

        // insert_award_list
        public function insert_award_list()
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
            $award_list = (array)json_decode($this->input->post('award_list'));
            $award_list['al_create_date'] = $this->Check__model->date_time_now();
            $award_listInsert = $this->Award_model->insert_award_list($award_list);
            echo json_encode($award_listInsert);
        }
        // update award
        public function update_award_list()
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
            $award_list = (array)json_decode($this->input->post('award_list'));
            $award_listID['al_id'] = $award_list['al_id'];
            unset($award_list['al_id']); 
            $award_list['al_update_date'] = $this->Check__model->date_time_now();
            $award_Update = $this->Award_model->update_award_list($award_list,$award_listID);
            if($award_Update==true){
                $award_list['al_id'] = $award_listID['al_id'];
                echo json_encode($award_list);
            }
        }
        // delete award_list
        public function delete_award_list()
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
            $awardID = json_decode($this->input->post('awardID'));
            $award['al_id'] = $awardID;
            $award_delete = $this->Award_model->delete_award_list($award);
            if($award_delete == true){
                echo json_encode($awardID);
            }
        }
        // ====================================================
        //get all award type
        public function get_all_award_type()
        {
            echo $this->Award_model->get_all_award_type();     
        }
        // insert award type
        public function insert_award_type()
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
            $award_type = (array)json_decode($this->input->post('award_type'));
            $award_type['at_create_date'] = $this->Check__model->date_time_now();
            $award_typeInsert = $this->Award_model->insert_award_type($award_type);
            echo json_encode($award_typeInsert);
        }
        // update award_type
        public function update_award_type()
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
            $award_type = (array)json_decode($this->input->post('award_type'));
            $award_typeID['at_id'] = $award_type['at_id'];
            unset($award_type['at_id']); 
            $award_type['at_update_date'] = $this->Check__model->date_time_now();
            $award_type_Update = $this->Award_model->update_award_type($award_type,$award_typeID);
            if($award_type_Update==true){
                $award_type['at_id'] = $award_typeID['at_id'];
                echo json_encode($award_type);
            }
        }
        // delete award_type
        public function delete_award_type()
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
            $award_typeID = json_decode($this->input->post('award_typeID'));
            $award_type['at_id'] = $award_typeID;
            $award_type_delete = $this->Award_model->delete_award_type($award_type);
            if($award_type_delete == true){
                echo json_encode($award_typeID);
            }
        }
        // =====================================================
        
        // get all award years
        public function get_all_award_years()
        {
            echo $this->Award_model->get_all_award_years();   
        }
        // insert award year
        public function insert_award_year()
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
            $award_year = (array)json_decode($this->input->post('award_year'));
            $award_year['ay_create_date'] = $this->Check__model->date_time_now();
            $award_yearInsert = $this->Award_model->insert_award_year($award_year);
            echo json_encode($award_yearInsert);
        }
        // update award_year
        public function update_award_year()
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
            $award_year = (array)json_decode($this->input->post('award_year'));
            $award_yearID['ay_id'] = $award_year['ay_id'];
            unset($award_year['ay_id']); 
            $award_year['ay_update_date'] = $this->Check__model->date_time_now();
            $award_year_Update = $this->Award_model->update_award_year($award_year,$award_yearID);
            if($award_year_Update==true){
                $award_year['ay_id'] = $award_yearID['ay_id'];
                echo json_encode($award_year);
            }
        }
        // delete award_year
        public function delete_award_year()
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
            $award_yearID = json_decode($this->input->post('award_yearID'));
            $award_year['ay_id'] = $award_yearID;
            $award_year_delete = $this->Award_model->delete_award_year($award_year);
            if($award_year_delete == true){
                echo json_encode($award_yearID);
            }
        }
        // =====================================================

        // get all company
        public function get_all_company()
        {
            echo $this->Award_model->get_all_company();    
        }
        // insert company
        public function insert_company()
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
            $company = (array)json_decode($this->input->post('company'));
            $company['c_create_date'] = $this->Check__model->date_time_now();
            $companyInsert = $this->Award_model->insert_company($company);
            echo json_encode($companyInsert);
        }
        // update company
        public function update_company()
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
            $company = (array)json_decode($this->input->post('company'));
            $companyID['c_id'] = $company['c_id'];
            unset($company['c_id']); 
            $company['c_update_date'] = $this->Check__model->date_time_now();
            $company_Update = $this->Award_model->update_company($company,$companyID);
            if($company_Update==true){
                $company['c_id'] = $companyID['c_id'];
                echo json_encode($company);
            }
        }
        // delete company
        public function delete_company()
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
            $companyID = json_decode($this->input->post('companyID'));
            $company['c_id'] = $companyID;
            $company_delete = $this->Award_model->delete_company($company);
            if($company_delete == true){
                echo json_encode($companyID);
            }
        }


        

        


        
    }

?>