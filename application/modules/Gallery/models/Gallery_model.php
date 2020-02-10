<?php

    Class Gallery_model extends CI_Model{

        public function __construct()
        {
            parent::__construct();
            $this->output->set_content_type("application/json", 'utf-8');
            $this->gallery = 'gallery';
            $this->gallery_image = 'gallery_image';

        }
        // get all gallery
        public function get_all_gallery()
        {
            $galleryAll = $this->db->get($this->gallery)->result(); 
            return json_encode($galleryAll);  
        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get gallery
        public function get_gallery($number_of_rows,$pagenow)
        {
            // limit(1,2)  1 แรกคือจำนวน row ที่ต้องการ 2 หลัง คือ เริ่มจาก index ที่เท่าไหร่  
            $this->db->order_by('g_id', 'DESC');
            $index_start = ($pagenow-1)*$number_of_rows;

            $gallery_result = $this->db->limit($number_of_rows,$index_start)->get($this->gallery)->result(); 
            $gallery_row_all = $this->db->from($this->gallery)->count_all_results();
            
            $result = [$gallery_row_all,$gallery_result];
            return json_encode($result);      
        }
        // get this gallery
        public function get_this_gallery($id)
        {   
            $result = $this->db->where('g_id',$id)->get($this->gallery)->result();
            return json_encode($result);  
        }
        // get all gallery like ...
        public function get_all_gallery_like($title_search)
        {   
            $this->db->order_by('g_id', 'DESC');
            $gallery_result = $this->db->like('g_name',$title_search,'both')->get($this->gallery)->result();
            $gallery_row_all = sizeof($gallery_result);
            $result = [$gallery_row_all,$gallery_result];
            return json_encode($result);  
        }
        // get_image_by_gallery_id
        public function get_image_by_gallery_id($key){
            // $this->db->order_by('gi_id', 'DESC');
            $result = $this->db->where('gi_gallery_id',$key)->get($this->gallery_image)->result();
            return json_encode($result); 

        }

        ////////////////////////////////////////////////////////////////////////////////////////

        // get all gallery_Image
        public function get_all_gallery_image()
        {
            $gallery_imageAll = $this->db->get($this->gallery_image)->result(); 
            return json_encode($gallery_imageAll);  
        }
        // insert gallery
        public function insert_gallery($data = array())
        {
            $lastID;
            $ins = $this->db->insert($this->gallery,$data);
            if($ins){
                $lastID = $this->db->insert_id();
                }
            return json_encode($lastID);
        }
        // insert gallery_image
        public function insert_gallery_image($data = array())
        {
            $lastID;
            for($i=0;$i < sizeof($data) ; $i++){
            $ins = $this->db->insert($this->gallery_image,$data[$i]);
                if($ins){
                    $lastID[$i]=[
                        'gi_id'=>$this->db->insert_id(),
                        'gi_image'=>$data[$i]['gi_image'],
                        'gi_gallery_id'=>$data[$i]['gi_gallery_id'],
                        'gi_create_date'=>$data[$i]['gi_create_date']
                    ];
                }
            }
            return $lastID;
        }
        // update gallery
        public function update_gallery($data = array(), $where = array())
        {
            return json_encode($this->db->where($where)->update($this->gallery,$data));
        }
        
        //delete gallery_image
        public function delete_gallery_image($where = array())
        {
            return json_encode($this->db->where($where)->delete($this->gallery_image));
        }
        // delete gallery
        public function delete_gallery($where = array()){
            return json_encode($this->db->where($where)->delete($this->gallery));
        }





        
    }
?>