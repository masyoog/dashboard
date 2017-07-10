<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of auditrail
 *
 * @author Yoga Mahendra <masyoog@yahoo.com>
 */
class Auditrail extends MY_Controller {
    
    private $_CFG;
    private $_TBL_PRIMARY = "sys_log a";
    private $_TBL_PRIMARY_PK = "a.id";    
    private $_ORDER = array("a.id DESC");
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array("sys_user b"=>"b.id=a.sys_user_id");
    private $_INDEX_PAGE;

    
    function __construct() {
        parent::__construct();        
        
        $this->_INDEX_PAGE = $this->uri->segment(1)."/".$this->uri->segment(2);
        
        $this->_CFG = new Datagridconfig();
        $this->_CFG->set_KEYS($this->_TBL_PRIMARY_PK);
        $this->_CFG->set_PRIMARY_TBL($this->_TBL_PRIMARY);
        $this->_CFG->set_JOIN_TBL($this->_TBL_JOIN);
        $this->_CFG->set_ORDER_TBL($this->_ORDER);
        $this->_CFG->set_ITEM_PER_PAGE($this->_ITEM_PER_PAGE);
        
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("a.log_date");
        $menu->set_FORM_ID("log_date");
        $menu->set_FIELD_TYPE($menu->get_DATE_TYPE());
        $this->_CFG->add_column("Tanggal Log", $menu);
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("a.log_time");
        $menu->set_FORM_ID("log_time");
        $this->_CFG->add_column("Waktu Log", $menu);
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("b.nama");
        $menu->set_FORM_ID("nama");
        $this->_CFG->add_column("Nama User", $menu);
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("a.log_event");
        $menu->set_FORM_ID("log_event");
        $this->_CFG->add_column("Event", $menu);
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("a.log_object");
        $menu->set_FORM_ID("log_object");
        $this->_CFG->add_column("Lokasi", $menu);
        
        $menu = new Datagridcolumn();
        $menu->set_FIELD_DB("a.log_ref_key");
        $menu->set_FORM_ID("log_ref_key");
        $this->_CFG->add_column("ID Reff", $menu);
        
        
        $this->_CFG->add_COMMAND_BUTTON(
                    "KOSONGKAN LOG", array(
                "method" => "/remove",
                "style" => "fa-trash",
                "class" => "btn-danger",
                "option" => 'data-bb="prompt" data-msg="Anda akan menghapus data ini ?" data-confirm="true"',
                "authType" => "hapus"
            ));
        
        //disable tambah
        $this->_CFG->add_COMMAND_BUTTON("TAMBAH", array());
        
        //disable ubah
        $this->_CFG->add_grid_button("UBAH", array());        
        
        //disable hapus
        $this->_CFG->add_grid_button("HAPUS", array());        
        
    }
    
    function index($userid=""){
        $data = array();
        $whr = $userid != "" ? array("sys_user_id"=>intval($userid)) : array();
        if ( count($whr) > 0){
            $this->_CFG->set_WHR_TBL($whr);
        }
        
        //initiate datagrid
        $dg = new Datagrid();
        $dg->set_config($this->_CFG);
        $data["pages"] = $dg->render($userid != "" ? TRUE : FALSE);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();
        
        if ( $userid != "" ){
            $data["isWindowPopUp"] = TRUE;
        }
        
        $this->auditrail("Show", $userid);
        
        //pasing to template lib        
        $this->template->load($data);        
    }
    
    
    function remove(){
        $this->load->model($this->_CFG->get_DBMODEL());
        $model = _get_raw_object($this, $this->_CFG->get_DBMODEL());
        
        
        $model->execute("TRUNCATE TABLE sys_log ", FALSE);
        
        $this->auditrail("Empty");
        
        redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
    }
    
    
}
