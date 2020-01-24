<?php

    Class Product_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->product = 'product';
            $this->product_category = 'product_category';
            $this->product_image = 'product_image';

        }
        // get all Product
        public function get_all_product()
        {
            $productAll = $this->db->get($this->product)->result(); 
            return json_encode($productAll);  
        }
        // get all Product_Category
        public function get_all_product_category()
        {
            $product_categoryAll = $this->db->get($this->product_category)->result(); 
            return json_encode($product_categoryAll);              
        }
        // get all Product_Image
        public function get_all_product_image()
        {
            $product_imageAll = $this->db->get($this->product_image)->result(); 
            return json_encode($product_imageAll);  
        }
        // insert Product
        public function insert_product($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->product,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // insert product_image
        public function insert_product_image($data = array())
        {
            $lastID;
            for($i=0;$i < sizeof($data) ; $i++){
            $ins = $this->db->insert($this->product_image,$data[$i]);
                if($ins){
                    $lastID[$i]=[
                        'pi_id'=>$this->db->insert_id(),
                        'pi_name'=>$data[$i]['pi_name'],
                        'pi_image_key'=>$data[$i]['pi_image_key'],
                        'pi_create_date'=>$data[$i]['pi_create_date']
                    ];
                }
            }
            return $lastID;
        }
        // update Product
        public function update_product($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->product,$data));
        }
        // get image key in this product
        public function get_image_key_product($where = array())
        {   
            $product = $this->db->select('p_image_key')->where($where)->get($this->product)->result(); 
            return json_encode($product[0]);
        }
        //delete product_image
        public function delete_product_image($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->product_image));
        }
        // delete product
        public function delete_product($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->product));
        }




        //================================================================
        // public function select_this_product($where = array())
        // {
        //     $product = $this->db->where($where)->get($this->product)->result(); 
        //     return $product;
        // }


        
    }
?>