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
class Update_pembelian extends MY_Controller {

    private $_INDEX_PAGE;

    function __construct() {
        parent::__construct();
        $this->_INDEX_PAGE = $this->uri->segment(1) . "/" . $this->uri->segment(2);
    }
    
    function form($mode, $key = "") {
        $data = array();
        $errorMsg = "";
        if ($this->input->post('save') != "") {
            _debug_var($this->input->post());
            die();
        }         
        $rsPO = $this->base_model->list_single_data(
                "a.*, b.supplier_name ", 
                "purchase_orders a",
                array("supplier b"=>"b.id=a.supplier_id"),
                array("a.id"=>intval($key))
        );
        
        $rsPODetail = $this->base_model->list_data(
                "a.*, b.name as product_name", 
                "purchase_order_details a",
                array("product b"=>"b.id=a.product_id"),
                array("a.purchase_orders_id"=>intval($key))
        );
        
        $data["rs_po"] = $rsPO;
        $data["rs_po_detail"] = $rsPODetail;
        
        $data["isWindowPopUp"] = TRUE;
        
        $data["additional_script"] = 'function hitungPo(){'
                . 'var payprice = 0;'
                . '$(".txt-qty").each(function(){'
                . 'var qty = $(this).unmask();'
                . 'var elmTotal = $(this).parent().next("td").children(".txt-price");'
                . 'var price = $(this).data("price");'
                . 'var total = qty * price;'
                . 'payprice += total;'
                . 'elmTotal.val(total);'                    
                . '});'
                . '$("#total_payment").val(payprice);'
                . '}'
                . '$(".txt-qty").change(function(){'
                . 'hitungPo();'
                . '});';
        //pasing to template lib
        $this->template->load($data,"transaksi/update_pembelian");
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

    

}
