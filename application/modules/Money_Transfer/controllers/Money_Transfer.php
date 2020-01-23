<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Money_Transfer extends CI_Controller
    {
        public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("Money_Transfer_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->load->model('../../Order/models/order_model');
            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // all Money_Transfer
        public function get_all_money_transfer()
        {
            echo $this->Money_Transfer_model->get_all_money_transfer();
        }
        // insert money transfer
        public function money_trasfer_insert()
        {
            // check status for confirm money transfer
            $own = json_decode($this->input->post('own_id'));
            if($own==null || $own==''){
                echo 'fail';
                exit;
            }
            $order = (array)json_decode($this->input->post('order'));
            $ownID  = $this->Check__model->chk_token($own);
            if($ownID != $order['o_own_id']){
                echo 'fail';
                exit;
            }
            $money_tf = (array)json_decode($this->input->post('money_transfer'));
            if($money_tf['mtf_payments_id']!=1){
                $money_tf['mtf_banking_id']='';
            }
            // start insert image slip
            $ranSTR = date('dmYHis').substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            $nameF = substr(strrev($_FILES['userfile']['name']), 0, strrpos(strrev($_FILES['userfile']['name']),"."));
            $typeF = strrev($nameF);
            $_FILES['userfile']['name'] = $ranSTR.'.'.$typeF;
            $config = array(
                'upload_path'   => $_SERVER["DOCUMENT_ROOT"].'assets/Slip/',
                'allowed_types' => '*',
                'max_size'      => '0',
            );
            $this->load->library('upload', $config,'file_image');
            $this->file_image->initialize($config);
            if ($this->file_image->do_upload('userfile')){
                $data = array('upload_data' => $this->file_image->data());   
                $money_tf['mtf_slip'] = $_FILES['userfile']['name'];
            }else{
                $error = array('error' => $this->upload->display_errors());
                print_r($error);
            }
            // end insert slip
            // $money_tf['mtf_slip'] = 0;
            $money_tf['mtf_create_date'] = $this->Check__model->date_time_now();
            $money_tf['mtf_member_id'] = $ownID;
            $money_tf['mtf_id'] = $this->Money_Transfer_model->money_trasfer_insert($money_tf);

            $order_id['o_id'] = $order['o_id'];
            $order_set['o_status_id'] = 2;
            $order_set['o_money_transfer_id'] = $money_tf['mtf_id'];
            $order_set['o_update_date'] = $this->Check__model->date_time_now();
            $statusUpdate_Order = $this->order_model->change_status_order($order_id,$order_set);
            // print_r($order_set);
            // print_r($money_tf);
            $mtf_and_order['money_transfer'] = $money_tf;
            $mtf_and_order['order_id'] = $order['o_id'];
            echo json_encode($mtf_and_order);
        }
        
       












        
    }

?>