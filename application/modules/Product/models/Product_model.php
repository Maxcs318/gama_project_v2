<?php

    Class Product_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->product = 'product';
            $this->product_category = 'product_category';
            $this->product_image = 'product_image';

            $this->order_items = 'order_items';

        }
        // get all Product
        public function get_all_product()
        {
            $productAll = $this->db->get($this->product)->result(); 
            return json_encode($productAll);  
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get product
        public function get_product($number_of_rows,$category,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('p_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            if($category != 'all'){
                $product_result = $this->db->where('p_category',$category)->limit($number_of_rows,$index_start)->get($this->product)->result(); 
                $product_row_all = $this->db->where('p_category',$category)->from($this->product)->count_all_results();
            }else{
                $product_result = $this->db->limit($number_of_rows,$index_start)->get($this->product)->result(); 
                $product_row_all = $this->db->from($this->product)->count_all_results();
            }
            $result = [$product_row_all,$product_result];
            return json_encode($result);      
        }
        // get this product
        public function get_this_product($id)
        {   
            $result = $this->db->where('p_id',$id)->get($this->product)->result();
            return json_encode($result);  
        }
        // get all product like ...
        public function get_all_product_like($category,$title_search)
        {   
            $this->db->order_by('p_id', 'DESC');
            if($category != 'all'){
                $this->db->where('p_category',$category);
                $product_result = $this->db->like('p_name',$title_search,'both')->get($this->product)->result();
                
                $this->db->where('p_category',$category);
                $product_row_all = sizeof($product_result);
            }else{
                $product_result = $this->db->like('p_name',$title_search,'both')->get($this->product)->result();
                $product_row_all = sizeof($product_result);
            }
            $result = [$product_row_all,$product_result];
            return json_encode($result);  
        }
        // get_image_by_product_id
        public function get_image_by_product_id($key)
        {
            // $this->db->order_by('pi_id', 'DESC');
            $result = $this->db->where('pi_image_key',$key)->get($this->product_image)->result();
            return json_encode($result); 

        }
        // get random product
        public function get_random_product($category,$pcs)
        {
            $this->db->order_by('rand()');
            $this->db->limit($pcs);
            $product_result = $this->db->where('p_category',$category)->get($this->product)->result();
            return json_encode($product_result);
        }
        // get product_in_cart
        public function get_product_in_cart($data = array())
        {
            $data_length = sizeof($data);
            $result_product = array();

            $for_cart = array(
                'quantity'=>0,
                'price_total'=>0
            );
            for($i=0;$i<$data_length;$i++){
                $data_product = $data[$i];
                $productID = $data_product->p_id;
                $result = $this->db->where('p_id',$productID)->get($this->product)->result();
                $the_product =  array(
                    'p_id'=>$result[0]->p_id,
                    'p_name'=>$result[0]->p_name,
                    'p_price'=>$result[0]->p_price,
                    'p_price2'=>$result[0]->p_price2,
                    'p_image'=>$result[0]->p_image,
                    'quantity'=>0,
                    'price_total'=>0

                );
                array_push($result_product, $the_product);
            }
            return json_encode($result_product);
        }
        // get this product_category
        public function get_this_product_category($id)
        {   
            $result = $this->db->where('pc_id',$id)->get($this->product_category)->result();
            return json_encode($result[0]);  
        }
        ////////////////////////////////////////////////////////////////////////////////////////

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
        public function check_product_and_order_item($id)
        {
            $result = $this->db->where('oi_product_id',$id)->get($this->order_items)->result(); 
            
            return json_encode(sizeof($result));
        }
        public function delete_product($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->product));
        }
        // insert product category
        public function insert_product_category($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->product_category,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // update product category
        public function update_product_category ($data=array(),$where=array())
        {
            return json_encode($this->db->where($where)->update($this->product_category,$data));   
        }
        // delete product category
        public function check_product_and_product_category($id)
        {
            $result = $this->db->where('p_category',$id)->get($this->product)->result(); 
            
            return json_encode(sizeof($result));
        }
        public function delete_product_category($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->product_category));
        }





        //================================================================
        // public function select_this_product($where = array())
        // {
        //     $product = $this->db->where($where)->get($this->product)->result(); 
        //     return $product;
        // }


        
    }
?>