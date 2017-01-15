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
        $addScript = "";
        $errorMsg = "";
        if ($this->input->post('save') != "") {

            $qtys = $this->input->post("qty");
            $close_po = $this->input->post("close_po");

            
            //update item PO
            if ( $qtys) {
                foreach ($qtys as $poDetId => $qty) {
                    $qry = "UPDATE purchase_order_details SET qty_approved=" . intval($qty) . ", qty_returned=GREATEST((qty-" . intval($qty) . "), 0), total_price_approved=(item_price*" . intval($qty) . ") WHERE purchase_order_detail_id=" . intval($poDetId);
                    $isUpdated = $this->base_model->execute($qry, FALSE);

                    //if affected rows > 0 then update stock
                    if ($isUpdated > 0) {
                        $this->auditrail("Update PO Detail", $isUpdated);
                        $this->_updateStock($poDetId);
                    }
                }
            }

            //update Status PO
            $updatePo = $this->base_model->update_data("purchase_orders", array("status" => $close_po), array("purchase_order_id" => $key));
            if ($updatePo > 0) {
                $this->auditrail("Update PO", $updatePo);
            }
            $addScript = "closeBox(true);";
        }

        $rsPO = $this->base_model->list_single_data(
                "a.*, b.supplier_name ", "purchase_orders a", array("supplier b" => "b.id=a.supplier_id"), array("a.purchase_order_id" => intval($key))
        );

        $rsPODetail = $this->base_model->list_data(
                "a.*, b.name as product_name", "purchase_order_details a", array("product b" => "b.id=a.product_id"), array("a.purchase_order_id" => intval($key))
        );

        $data["rs_po"] = $rsPO;
        $data["rs_po_detail"] = $rsPODetail;

        $data["isWindowPopUp"] = TRUE;

        $addScript .= 'function hitungPo(){'
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
                . '});'
                . 'hitungPo();';

        $data["additional_script"] = $addScript;
        //pasing to template lib
        $this->template->load($data, "transaksi/update_pembelian");
    }

    private function _updateStock($poDetailId = "") {
        // get data po detail
        $rsPoDetails = $this->base_model->list_single_data("*", "purchase_order_details", "", array("purchase_order_detail_id" => intval($poDetailId)));

        if ($rsPoDetails != "") {
            // get data po
            $rsPo = $this->base_model->list_single_data("*", "purchase_orders", "", array("purchase_order_id" => intval($rsPoDetails->purchase_order_id)));

            //check if stock exist by product_id
            $rsStock = $this->base_model->list_single_data("*", "stocks", "", array("products_id" => intval($rsPoDetails->product_id)));
            if ($rsStock == "") {
                $stocksId = $this->base_model->insert_data("stocks", array("products_id" => intval($rsPoDetails->product_id)));
                if ($stocksId > 0) {
                    $this->auditrail("Add Stock", $stocksId);
                }
            } else {
                $stocksId = $rsStock->id;
            }

            //insert stock mutasi
            $stockMutasiId = $this->base_model->insert_data("stocks_mutasi", array("stocks_id" => intval($stocksId), "added" => intval($rsPoDetails->qty_approved), "description" => $rsPo->no_po));
            if ($stockMutasiId > 0) {
                $this->auditrail("Add Stock Mutasi", $stockMutasiId);
            }
        }
    }

}
