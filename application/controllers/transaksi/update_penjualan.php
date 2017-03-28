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
class Update_penjualan extends MY_Controller {

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

            $disc = $this->input->post("disc");
            $close_po = $this->input->post("close_po");
            $pay = $this->input->post("pay");
            $remark = $this->input->post("remark");

            //update item PO
            if ($close_po == "2") {
                $rsPODetail = $this->base_model->list_data(
                        "id", "order_detail", "", array("order_id" => intval($key))
                );
                if ($rsPODetail != "") {
                    foreach ($rsPODetail as $row) {
                        $this->_updateStock($row->id);
                    }
                }
            }

            //update Status PO
            $updatePo = $this->base_model->update_data(
                    "orders", 
                    array(
                        "disc" => $disc, 
                        "netto" => $pay,
                        "remark" => $remark,
                        "status" => $close_po), 
                    array("id" => $key));
            if ($updatePo > 0) {
                $this->auditrail("Update Order", $updatePo);
            }
            $addScript = "closeBox(true);";
        }

        $rsPO = $this->base_model->list_single_data(
                "a.*", "orders a", "", array("a.id" => intval($key))
        );

        $rsPODetail = $this->base_model->list_data(
                "a.*, b.name as product_name", "order_detail a", array("product b" => "b.id=a.product_id"), array("a.order_id" => intval($key))
        );

        $data["rs_po"] = $rsPO;
        $data["rs_po_detail"] = $rsPODetail;

        $data["isWindowPopUp"] = TRUE;

        $addScript .= 'function hitungPo(){'
                . '     var total = $("#total_payment").val();'
                . '     if (total){'
                . '         total = total.replace(".","");'
                . '     }'
                . '     var disc = $("#disc").val();'
                . '     if ( disc ){'
                . '         disc = disc.replace(".","");'
                . '     }'
                . '     var pay = total - disc;'
                . '     $("#pay").val(pay);'
                . '}'
                . '$("#disc").change(function(){'
                . 'hitungPo();'
                . '});'
                . 'hitungPo();';

        $data["additional_script"] = $addScript;
        //pasing to template lib
        $this->template->load($data, "transaksi/update_penjualan");
    }

    private function _updateStock($orderDetailId = "", $refunded = "") {
        // get data po detail
        $rsOrderDetails = $this->base_model->list_single_data("*", "order_detail", "", array("id" => intval($orderDetailId)));

        if ($rsOrderDetails != "") {
            // get data po
            $rsOrder = $this->base_model->list_single_data("*", "orders", "", array("id" => intval($rsOrderDetails->order_id)));

            //check if stock exist by product_id
            $rsStock = $this->base_model->list_single_data("*", "stocks", "", array("products_id" => intval($rsOrderDetails->product_id)));
            if ($rsStock == "") {
                $stocksId = $this->base_model->insert_data("stocks", array("products_id" => intval($rsOrderDetails->product_id)));
                if ($stocksId > 0) {
                    $this->auditrail("Add Stock", $stocksId);
                }
            } else {
                $stocksId = $rsStock->id;
            }

            //insert stock mutasi
            $data = array(
                "stocks_id" => intval($stocksId),
                "description" => $rsOrder->order_code
            );

            if ($refunded != "") {
                $data = $data + array("added" => intval($rsOrderDetails->qty));
            } else {
                $data = $data + array("reduced" => intval($rsOrderDetails->qty));
            }

            $stockMutasiId = $this->base_model->insert_data("stocks_mutasi", $data);
            if ($stockMutasiId > 0) {
                $this->auditrail("Add Stock Mutasi", $stockMutasiId);
            }
        }
    }

}
