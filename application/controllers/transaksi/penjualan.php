<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of menu
 *
 * @author Yoga Mahendra
 */
class Penjualan extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "orders a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array();
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array(
        "order_state b" => "b.id=a.status",
        "sys_user c" => "c.id=a.create_by"
    );
    private $_INDEX_PAGE;

    function __construct() {
        parent::__construct();

        $this->_INDEX_PAGE = $this->uri->segment(1) . "/" . $this->uri->segment(2);

        $this->_CFG = new Datagridconfig();
        $this->_CFG->set_KEYS($this->_TBL_PRIMARY_PK);
        $this->_CFG->set_PRIMARY_TBL($this->_TBL_PRIMARY);
        $this->_CFG->set_JOIN_TBL($this->_TBL_JOIN);
        $this->_CFG->set_ORDER_TBL($this->_ORDER);
        $this->_CFG->set_ITEM_PER_PAGE($this->_ITEM_PER_PAGE);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("order_date");
        $nama->set_FIELD_DB_ALIAS("order_date");
        $nama->set_DEFAULT_SEARCH(TRUE);
        $nama->set_DEFAULT_SEARCH_TYPE($nama->get_DATE_RANGE_TYPE());
        $nama->set_DEFAULT_SEARCH_DEFAULT_VALUE(date("m/01/Y")." - ".date("m/d/Y"));
        $nama->set_DEFAULT_SEARCH_WITH_IGNORE_OPTION(TRUE);
        $nama->set_DEFAULT_SEARCH_IGNORE_OPTION_DEFAULT_VALUE("1");
        $nama->set_FORM_ID("order_date");
        $this->_CFG->add_column("Tanggal Order", $nama);
        
        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.order_code");
        $userName->set_SIZE(30);
        $userName->set_FORM_ID("order_code");
        $userName->set_EDITABLE(FALSE);
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Order No", $userName);
        
        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.remark");
        $userName->set_SIZE(100);        
        $userName->set_FORM_ID("remark");
        $this->_CFG->add_column("Remark", $userName);

        
        $status = new Datagridcolumn();
        $status->set_FIELD_DB("b.name");
        $status->set_FIELD_DB_ALIAS("status");
        $status->set_FORM_ID("status");
        $this->_CFG->add_column("Status", $status);

        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("c.nama");
        $nama->set_FORM_ID("create_by");
        $this->_CFG->add_column("Dibuat Oleh", $nama);

        $this->_CFG->add_grid_button(
                "Update Status", array(
            "method" => base_url("transaksi/update_penjualan/form/edit"),
            "overideUri" => TRUE,
            "style" => "fa-check",
            "action" => "openBox('URL', '90')",
            "authType" => "ubah"
                )
        );

        $this->_CFG->add_grid_button(
                "Input Item Barang", array(
            "method" => base_url("transaksi/detil_penjualan/index"),
            "overideUri" => TRUE,
            "style" => "fa-server",
            "action" => "openBox('URL', '80')",
            "authType" => "ubah"
                )
        );
    }

    function index() {
        $data = array();
        
        //initiate datagrid
        $dg = new Datagrid();

        $dg->set_config($this->_CFG);
        $data["pages"] = $dg->render();        
        $dg->set_ADDITIONAL_SCRIPT("setDateRangeValue('". date("m/01/Y") . "', '". date("m/d/Y") . "');");
        if ( $dg->get_query_string() == "" ){
            //force submit on first load to apply default filter
            $dg->set_ADDITIONAL_SCRIPT("$('#frmSearch').submit();");
        }
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();

        $this->auditrail("Show");
        //pasing to template lib
        $this->template->load($data);
    }

    function add_new_order_from_dashboard(){
        $this->load->library("DocNumber");
        
        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");

        $orderNumber = $this->docnumber->generate("FORMAT", "ORDER", "orders.order_code");

        $datas = array(
            "order_code" => $orderNumber,
            "status" => 1,
            "order_date" => date("Y-m-d"),
            "create_at" => date("Y-m-d H:i:s"),
            "create_by" => $this->session->userdata(USER_AUTH . "cUserID")
        );
        
        $ID = $this->base_model->insert_data($this->_TBL_PRIMARY, $datas);
        if ($ID > 0) {
            $this->auditrail("Add", $ID);
            echo json_encode(array("id"=>$ID));
        } else {
            echo json_encode(array("id"=>null));
        }       
    }
    
    function form($mode, $key = "") {
        $data = array();

        $dg = new Datagrid();

        $rsGrup = $this->base_model->list_data("id as kunci, name as nilai", "order_state", "", "", array("id asc"));
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.status");
        $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
        $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
        $grupUser->set_SIZE(4);
        $grupUser->set_REQUIRED(TRUE);
        $grupUser->set_FORM_ID("status");
        $this->_CFG->add_column("Status", $grupUser);

        if ($key == "") {
            $userName = new Datagridcolumn();
            $this->_CFG->add_column("Order No", $userName);
        }

        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Tanggal Order", $nama);

        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Dibuat Oleh", $nama);

        $dg->set_config($this->_CFG);
        
        // validation
        $this->form_validation->set_rules($dg->get_validation_rules());
        $this->form_validation->set_error_delimiters('<br />', '');
        $errorMsg = "";
        if ($this->input->post('save') != "") {

            if ($this->form_validation->run() == FALSE) {
                $errorMsg = $dg->get_validation_error($this->form_validation->error_string());
            } else {
                $errorMsg = "";
            }

            if ($errorMsg == "") {
                if ($mode == "add") {
                    $key = $this->_tambah();
                } else if ($mode == "edit") {
                    $this->_ubah($key);
                }

                if ("" != $this->base_model->db->_error_message()) {
                    $errorMsg = $this->base_model->db->_error_message();
                } else {
                    redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
                }
            }
        }

        //initiate datagrid
        $data["pages"] = $dg->render_form($mode, $key, $errorMsg);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();


        //pasing to template lib
        $this->template->load($data);
    }

    private function _tambah() {
        $this->load->library("DocNumber");
        $ID = "";
        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");

        $orderNumber = $this->docnumber->generate("FORMAT", "ORDER", "orders.order_code");

        $datas = array(
            "order_code" => $orderNumber,
            "order_date" => date("Y-m-d"),
            "create_at" => date("Y-m-d H:i:s"),
            "create_by" => $this->session->userdata(USER_AUTH . "cUserID")
        );

        if (is_array($columns)) {
            foreach ($columns as $column => $property) {
                if ($property->get_FIELD_TYPE() != $property->get_FILE_TYPE()) {
                    $value = $this->input->post($property->get_FORM_ID());
                    $value = $property->get_FIELD_TYPE() == $property->get_DATE_TYPE() ? _date($value, "Y-m-d") : $value;
                    $field = _replace_before($property->get_FIELD_DB(), ".");
                    if ("" != $property->get_FIELD_DB()) {
                        $datas = $datas + array($field => $value);
                    }
                }
            }


            $ID = $this->base_model->insert_data($this->_TBL_PRIMARY, $datas);
            if ($ID > 0) {
                $this->auditrail("Add", $ID);
            }
        }

        return $ID;
    }

    private function _ubah($key = "") {

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
        $this->_TBL_PRIMARY_PK = _replace_before($this->_TBL_PRIMARY_PK, ".");

        if ("" != $key && "" != $this->_CFG->get_KEYS()) {
            $columns = $this->_CFG->get_column();
            $whr = array($this->_TBL_PRIMARY_PK => $key);
            $datas = array();
            if (is_array($columns)) {
                foreach ($columns as $column => $property) {
                    if ($property->get_FIELD_TYPE() != $property->get_FILE_TYPE()) {
                        $value = $this->input->post($property->get_FORM_ID());
                        $value = $property->get_FIELD_TYPE() == $property->get_DATE_TYPE() ? _date($value, "Y-m-d") : $value;
                        $field = _replace_before($property->get_FIELD_DB(), ".");
                        if ("" != $property->get_FIELD_DB())
                            $datas = $datas + array($field => $value);
                    }
                }

                $ID = $this->base_model->update_data($this->_TBL_PRIMARY, $datas, $whr);
                if ($ID > 0) {
                    $this->auditrail("Update", $ID);
                }
            }
        }
    }

    function remove($key = "") {

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
        $this->_TBL_PRIMARY_PK = _replace_before($this->_TBL_PRIMARY_PK, ".");

        if ("" != $key) {
            $whr = array($this->_TBL_PRIMARY_PK => $key);
            $affected = $this->base_model->delete_data($this->_TBL_PRIMARY, $whr);
            if ($affected > 0) {
                $this->auditrail("remove", $key);
            }
        }

        redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
    }

}
