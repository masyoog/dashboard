<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Supplier
 *
 * @author Yoga Mahendra
 */
class Pengeluaran extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "expenses a";
    private $_TBL_PRIMARY_PK = "a.expense_id";
    private $_ORDER = array("a.expense_date DESC");
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array(
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
        $nama->set_FIELD_DB("a.expense_date");
        $nama->set_FIELD_TYPE($nama->get_DATE_TYPE());
        $nama->set_FORM_ID("expense_date");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Tanggal", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("a.amount");
        $nama->set_FIELD_TYPE($nama->get_NUM_TYPE());
        $nama->set_SIZE(9);
        $nama->set_FORM_ID("amount");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Biaya", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("a.description");
        $nama->set_SIZE(255);
        $nama->set_FORM_ID("description");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Keterangan", $nama);
        
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("c.nama");
        $nama->set_FORM_ID("create_by");
        $this->_CFG->add_column("Dibuat Oleh", $nama);

    }

    function index() {
        $data = array();

        //initiate datagrid
        $dg = new Datagrid();
        $dg->set_config($this->_CFG);
        $data["pages"] = $dg->render();
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();

        $this->auditrail("Show");
        //pasing to template lib        
        $this->template->load($data);
    }

    function form($mode = "add", $key = "") {
        $data = array();

        $dg = new Datagrid();

        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Tanggal", $nama);
        
        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Created By", $nama);
        
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
                    $this->_tambah();
                } else if ($mode == "edit") {
                    $this->_ubah($key);
                }

                redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
            }
        }

        //initiate datagrid
        $data["pages"] = $dg->render_form($mode, $key, $errorMsg);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();

        //pasing to template lib
        $this->template->load($data);
    }

    private function _tambah() {
        $ID = "";
        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");


        $datas = array(
            "expense_date" => date("Y-m-d"),
            "create_by" => $this->session->userdata(USER_AUTH . "cUserID")
        );
        if (is_array($columns)) {
            foreach ($columns as $column => $property) {
                $value = $this->input->post($property->get_FORM_ID());
                $value = $property->get_FIELD_TYPE() == $property->get_DATE_TYPE() ? _date($value, "Y-m-d") : $value;
                $field = _replace_before($property->get_FIELD_DB(), ".");
                if ("" != $property->get_FIELD_DB())
                    $datas = $datas + array($field => $value);
            }

            $ID = $this->base_model->insert_data($this->_TBL_PRIMARY, $datas);
            if ($ID > 0) {
                $this->auditrail("add", $ID);
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
                    $value = $this->input->post($property->get_FORM_ID());
                    $value = $property->get_FIELD_TYPE() == $property->get_DATE_TYPE() ? _date($value, "Y-m-d") : $value;
                    $field = _replace_before($property->get_FIELD_DB(), ".");
                    if ("" != $property->get_FIELD_DB())
                        $datas = $datas + array($field => $value);
                }

                $ID = $this->base_model->update_data($this->_TBL_PRIMARY, $datas, $whr);
                if ($ID > 0) {
                    $this->auditrail("update", $key);
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
