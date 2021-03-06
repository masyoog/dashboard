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
class Stocks_mutasi extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "stocks a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array();
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array(
        "stocks_mutasi d" => "d.stocks_id=a.id",        
        "product b" => "b.id=a.products_id",        
        "sys_user c" => "c.id=a.closed_by",        
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
        $userName->set_FIELD_DB("b.name");
        $userName->set_FIELD_DB_ALIAS("products_name");
        $userName->set_SIZE(32);
        $userName->set_FORM_ID("products_name");
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Produk", $userName);

        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("d.last_balance");
        $nama->set_FIELD_DB_ALIAS("last_balance");
        $nama->set_FORM_ID("last_balance");
        $this->_CFG->add_column("Stok Terakhir", $nama);

        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("d.added");
        $grupUser->set_FORM_ID("added");        
        $this->_CFG->add_column("Penambahan", $grupUser);

        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("d.reduced");
        $nama->set_FORM_ID("reduced");
        $this->_CFG->add_column("Pengurangan", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("d.balance");
        $nama->set_FORM_ID("balance");
        $this->_CFG->add_column("Stok Saat Ini", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("d.description");
        $nama->set_FORM_ID("description");
        $this->_CFG->add_column("Deskripsi", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("a.closing_date");
        $nama->set_FORM_ID("closing_date");
        $this->_CFG->add_column("Tanggal Closing", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("c.nama");
        $nama->set_FORM_ID("user");
        $this->_CFG->add_column("Closing Oleh", $nama);

        $this->_CFG->add_grid_button("UBAH", array());
        $this->_CFG->add_grid_button("HAPUS", array());

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

        $rsGrup = $this->base_model->list_data("id as kunci, supplier_name as nilai", "supplier", "", array('status' => 1), array("supplier_name asc"));

        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.supplier_id");
        $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
        $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
        $grupUser->set_SIZE(4);
        $grupUser->set_REQUIRED(TRUE);
        $grupUser->set_FORM_ID("supplier_id");
        $this->_CFG->add_column("Supplier Name", $grupUser);

        if ($key == "") {
            $userName = new Datagridcolumn();
            $this->_CFG->add_column("PO No", $userName);
        }

        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Created Date", $nama);

        $nama = new Datagridcolumn();
        $this->_CFG->add_column("Created By", $nama);
        
        $status = new Datagridcolumn();
        $this->_CFG->add_column("Status", $status);

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

        $poNumber = $this->docnumber->generate("FORMAT", "PO", "purchase_orders.no_po");

        $datas = array(
            "no_po" => $poNumber,
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
