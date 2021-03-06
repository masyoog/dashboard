<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Group User
 *
 * @author Yoga Mahendra
 */
class Grup_user extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "sys_grup_user a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array("a.nama ASC");
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array();
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
        $nama->set_FIELD_DB("a.nama");
        $nama->set_FIELD_DB_ALIAS("");
        $nama->set_SIZE(128);
        $nama->set_FORM_ID("nama");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Nama Grup", $nama);

        $keterangan = new Datagridcolumn();
        $keterangan->set_FIELD_DB("a.keterangan");
        $keterangan->set_SIZE(256);
        $keterangan->set_FORM_ID("keterangan");
        $keterangan->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Keterangan", $keterangan);

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

        $this->_CFG->add_grid_button(
                "HAK AKSES", array(
            "method" => base_url("setting/grup_akses/index/null"),
            "style" => "fa-unlock",
            "action" => "openBox('URL', '80')",
            "overideUri" => TRUE,
            "authType" => "ubah"
                )
        );

        $this->_CFG->add_grid_button(
                "HAPUS", array(
            "method" => "remove",
            "style" => "fa-trash-o text-danger",
            "option" => 'data-bb="prompt" data-msg="Anda akan menghapus data ini ?" data-confirm="true"',
            "visible" => "check_delete_visible",
            "authType" => "hapus"
        ));
    }

    function check_delete_visible($data) {
        $out = $this->session->userdata(USER_AUTH . 'cGrupUserId') == _get_raw_object($data, "id");
        return !$out;
    }

    function index() {
        $data = array();

        $whr = array("is_merchant_grup" => 0);
        $this->_CFG->set_WHR_TBL($whr);
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


        $datas = array("is_merchant_grup" => 0);
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
            $rsGrupUser = $this->base_model->list_single_data("sys_grup_user_id", "sys_user", "", array("id" => $this->session->userdata(USER_AUTH . 'cUserID')));
            if (_get_raw_object($rsGrupUser, "sys_grup_user_id") != $key) {
                $whr = array($this->_TBL_PRIMARY_PK => $key);
                $affected = $this->base_model->delete_data($this->_TBL_PRIMARY, $whr);
                if ($affected > 0) {
                    $this->auditrail("remove", $key);
                }
            } else {
                
            }
        }

        redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
    }

}
