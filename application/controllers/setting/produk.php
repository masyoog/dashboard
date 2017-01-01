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
class Produk extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "product a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array();
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array(
        "provider b" => "b.id=a.provider_id",
        "units c" => "c.id=a.unit_id",
        "product_type d" => "d.id=b.ptype_id",
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

        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.code");
        $userName->set_SIZE(20);
        $userName->set_FORM_ID("code");
        $userName->set_REQUIRED(TRUE);
        $userName->set_VALIDATION("is_unique[product.code]");
        $this->_CFG->add_column("Code", $userName);

        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("a.name");
        $nama->set_SIZE(60);
        $nama->set_FORM_ID("name");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Name", $nama);

        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("b.provider_name");
        $grupUser->set_SIZE(9);
        $grupUser->set_FORM_ID("provider_name");
        $this->_CFG->add_column("Provider", $grupUser);
        
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("d.type_name");
        $grupUser->set_SIZE(4);
        $grupUser->set_FORM_ID("type_name");
        $this->_CFG->add_column("Product Type", $grupUser);
        
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("c.unit_name");
        $grupUser->set_SIZE(4);
        $grupUser->set_FORM_ID("unit_name");
        $this->_CFG->add_column("Unit", $grupUser);
        
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.price");
        $grupUser->set_SIZE(9);
        $grupUser->set_FORM_ID("price");
        $grupUser->set_FIELD_TYPE($grupUser->get_NUM_TYPE());
        $this->_CFG->add_column("Price", $grupUser);
        
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.barcode");
        $grupUser->set_SIZE(40);
        $grupUser->set_FORM_ID("barcode");
        $this->_CFG->add_column("Barcode", $grupUser);

        $status = new Datagridcolumn();
        $status->set_FIELD_DB("a.status");
        $status->set_FIELD_TYPE($status->get_ENUM_TYPE());
        $status->set_FORM_ID("status");
        $status->set_ENUM_DEFAULT_VALUE(
                array("1" => "Aktif",
                    "0" => "Pasif"
        ));
        $status->set_STYLE(
                array("1" => '<span class="label label-success">Aktif</span>',
                    "0" => '<span class="label label-warning">Pasif</span>'
        ));
        $status->set_SIZE(1);
        $this->_CFG->add_column("Status", $status);

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

    function form($mode, $key = "") {
        $data = array();


        $dg = new Datagrid();
        $grupUser = new Datagridcolumn();
        $this->_CFG->add_column("Product Type", $grupUser);

        $rsGrup = $this->base_model->list_data("id as kunci, provider_name as nilai", "provider", "", array('status' => 1), array("provider_name asc"));
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.provider_id");
        $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
        $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
        $grupUser->set_SIZE(4);
        $grupUser->set_REQUIRED(TRUE);
        $grupUser->set_FORM_ID("provider_id");
        $this->_CFG->add_column("Provider", $grupUser);
        
        $rsGrup = $this->base_model->list_data("id as kunci, unit_name as nilai", "units", "", array('status' => 1), array("unit_name asc"));
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.unit_id");
        $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
        $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
        $grupUser->set_SIZE(4);
        $grupUser->set_REQUIRED(TRUE);
        $grupUser->set_FORM_ID("unit_id");
        $this->_CFG->add_column("Unit", $grupUser);

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
        $ID = "";
        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");

        $datas = array();
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
