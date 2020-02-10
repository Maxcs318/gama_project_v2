<?php header('Access-Control-Allow-Origin: *'); ?>
<?php
    class Order extends CI_Controller
    {
        public $JSON_DATA;
        public function __construct()
        {
            parent::__construct();
            $this->load->model("order_model");
            $this->load->model('../../Check_/models/Check__model');
            $this->load->model('../../Shipping_Address/models/Shipping_Address_model');
            $this->load->model('../../Money_Transfer/models/Money_Transfer_model'); 
            $this->load->model('../../Payment/models/Payment_model');
            $this->load->model('../../Banking/models/Banking_model');

            $this->output->set_content_type("application/json", 'utf-8');
            // $this->output->set_header("Access-Control-Allow-Origin: *");
            $this->output->set_header("Access-Control-Allow-Methods: GET, POST , OPTIONS");
            $this->output->set_header("Access-Control-Allow-Headers: Content-Type, Content-Length, Accept-Encoding");

            $this->load->helper("URL", "DATE", "URI", "FORM");//
            $this->load->library('form_validation');//

        }
        // all order
        public function get_all_order()
        {
            echo $this->order_model->get_all_order();
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////

        // get my order
        public function get_my_order()
        {
            $number_of_rows = json_decode($this->input->post('number_of_row'));
            $myID = json_decode($this->input->post('myID'));
            $order_status_id = json_decode($this->input->post('order_status_id'));
            $pagenow = json_decode($this->input->post('pagenow'));

            echo $this->order_model->get_my_order($number_of_rows,$myID,$order_status_id,$pagenow);
        }
        // get_order_by_code
        public function get_order_by_code()
        {
            $order_code = json_decode($this->input->post('order_code'));

            $order = json_decode($this->order_model->get_order_by_code($order_code));
            $order_items = json_decode($this->order_model->get_order_items_in_order($order->o_id));
            $order_status = json_decode($this->order_model->get_order_status_in_order($order->o_status_id));
            // shipping_address
            $shipping_address = json_decode($this->Shipping_Address_model->shipping_address_in_order($order->o_shipping_address_id));

            if($order->o_status_id > 1){
                 // money_transfer
                $money_transfer = json_decode($this->Money_Transfer_model->money_transfer_in_order($order->o_money_transfer_id));
                // payments
                $payment = json_decode($this->Payment_model->payment_in_money_transfer($money_transfer->mtf_payments_id));
                // banking
                if($money_transfer->mtf_payments_id == 1){
                    $banking = json_decode($this->Banking_model->banking_in_money_transfer($money_transfer->mtf_payments_id));
                }else{
                    $banking = false;
                }
            }else{
                $money_transfer = false;
                $payment = false;
                $banking = false;
            }
            
            $result = [$order,$order_items,$order_status,$shipping_address,$money_transfer,$payment,$banking];
            echo json_encode($result);
            
        }
        // get_order_for_admin
        public function get_order_for_admin()
        {
            $number_of_rows = json_decode($this->input->post('number_of_row'));
            $order_status_id = json_decode($this->input->post('order_status_id'));
            $pagenow = json_decode($this->input->post('pagenow'));

            echo $this->order_model->get_order_for_admin($number_of_rows,$order_status_id,$pagenow);
        }
        ////////////////////////////////////////////////////////////////////////////////////////

        // all order_status
        public function get_all_order_status()
        {
            echo $this->order_model->get_all_order_status();
        }
        // all order_items
        public function get_all_order_items()
        {
            echo $this->order_model->get_all_order_items();
        }
        // create order
        public function create_order(){
            // check status for create order
            $own = json_decode($this->input->post('own_id'));
            if($own==null || $own==''){
                echo 'fail';
                exit;
            }
            $ownID  = $this->Check__model->chk_token($own);
            // echo $ownID;
            $order_input = (array)json_decode($this->input->post('order'));
            // echo $ownID;
            // print_r($order);
            $price_total = 0;
            $order_item=[];
            for($k=0; $k<sizeof($order_input); $k++){
                if($order_input[$k]->quantity>0){
                    array_push($order_item,$order_input[$k]);
                    $price_total = $price_total + $order_item[$k]->price_total;
                }
            }
            if(sizeof($order_item)<1){
                echo 'fail';
                exit;
            }

            //save shipping address 
            if($this->input->post('shipping_address')!=''||$this->input->post('shipping_address')!=null){
                $shipp_AD = (array)json_decode($this->input->post('shipping_address'));
                $shipp_AD['sa_member_id'] = $ownID;
                $shipp_AD['sa_create_date'] = $this->Check__model->date_time_now();
                $shipp_AD_Success = (array)json_decode($this->Shipping_Address_model->save_shipping_address($shipp_AD));
            }else{
                $shipp_AD_Success['sa_id'] = json_decode($this->input->post('shipping_address_id'));
            }
            $order['o_shipping_address_id'] = $shipp_AD_Success['sa_id'];
            $order['o_total_price'] = $price_total;
            $order['o_own_id'] = $ownID;
            $order['o_code_order'] = $ownID.'-'.substr(str_shuffle(str_repeat('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', mt_rand(1,10))), 1, 10);
            $order['o_status_id'] = 1;
            $order['o_create_date'] = $this->Check__model->date_time_now();

            // create order
            $order_created = (array)json_decode($this->order_model->create_order($order));

            $O_items=[];
            for($run=0; $run<sizeof($order_item);$run++){
                $item['oi_product_id'] = $order_item[$run]->p_id;
                $item['oi_quantity'] = $order_item[$run]->quantity;
                $item['oi_product_price'] = $order_item[$run]->p_price;
                $item['oi_total_price'] = $order_item[$run]->price_total;
                $item['oi_order_id'] = $order_created['o_id'];
                $item['oi_create_date'] = $this->Check__model->date_time_now();
                array_push($O_items,$item);
            }

            // add order_item to order
            $order_items_created = (array)json_decode($this->order_model->create_order_item($O_items));

            // echo $order_created['o_id'];
            echo json_encode($order);
            // echo $shipp_AD_Success['sa_id'];
            // echo $order_items_created;
            
        }
        // delete_order
        public function delete_order()
        {
            // check status for create order
            $own = json_decode($this->input->post('own_id'));
            if($own==null || $own==''){
                echo 'fail';
                exit;
            }
            $ownID  = $this->Check__model->chk_token($own);
            // echo $ownID;
            $orderID = json_decode($this->input->post('orderID'));
            //set data order for delete
            $order['o_id'] = $orderID ;
            $order['o_own_id'] = $ownID ;
            //do delete order
            $order_deleted = $this->order_model->delete_order($order);
            //set order id of order item
            $order_item['oi_order_id'] = $orderID ;
            //do delete order item
            $order_item_deleted = $this->order_model->delete_order_item($order_item);

            echo json_encode($order);
        }
        // confirm order
        public function confirm_order()
        {
            //check for confirm
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
            $order_code['o_code_order'] = json_decode($this->input->post('order_code'));
            $order_status['o_status_id'] = 3;
            $order_status['o_update_date'] = $this->Check__model->date_time_now();
            $statusOrder = $this->order_model->change_status_order($order_code,$order_status);            
            echo $order_code['o_code_order'];
        }
        // discard order
        public function discard_order()
        {
            //check for discard
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
            $order_code['o_code_order'] = json_decode($this->input->post('order_code'));
            $order_status['o_status_id'] = 1;
            $statusOrder = $this->order_model->change_status_order($order_code,$order_status);            
            echo $order_code['o_code_order'];
        }
        // delivery order
        public function confirm_order_delivery()
        {
            //check for discard
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
            $order_code['o_code_order'] = json_decode($this->input->post('order_code'));
            $order_status['o_status_id'] = 4;
            $order_status['o_update_date'] = $this->Check__model->date_time_now();
            $statusOrder = $this->order_model->change_status_order($order_code,$order_status);            
            echo $order_code['o_code_order'];
        }










        
    }

?>