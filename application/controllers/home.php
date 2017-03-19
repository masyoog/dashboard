<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of home
 *
 * @author Yoga Mahendra
 */
class Home extends MY_Controller {

    function __construct() {
        parent::__construct();
    }

    function index() {

        $out = "";
        $data = array();
        $cfg = new Datagridconfig();

        $dg = new Datagrid();
        $dg->set_config($cfg);
        if (!$dg->authorize()) {

            $out .= $dg->get_header();
            $out .= '<section class="content" >';
            $out .= '<div class="row">';
            $out .= '<div class="col-xs-12">';
            $out .= '<p>';
            $out .= $dg->get_validation_error("Anda tidak punya hak akses untuk melihat halaman ini.");
            $out .= '</p>';
            $out .= '</div>';
            $out .= '</div>';
            $out .= '</section>';
            $out .= '</section>';


            $data["pages"] = $out;
            $this->template->load($data);
        } else {
            //newOrder
            $whrNewOrder = array("a.status" => "1");
            $newOrder = $this->base_model->list_single_data("count(id) as jumlah", "orders a", "", $whrNewOrder);
            $data["countNewOrder"] = intval($newOrder->jumlah);

            //Paid
            $whrPaidOrder = array("status" => "2");
            $paidOrder = $this->base_model->list_single_data("count(id) as jumlah, sum(netto) as revenue", "orders", "", $whrPaidOrder);
            $data["countPaidOrder"] = intval($paidOrder->jumlah);
            $data["revPaidOrder"] = intval($paidOrder->revenue);

            //Other Income
            $whrOtherIncome = array("create_at" => date("Y-m-d"));
            $otherIncome = $this->base_model->list_single_data("sum(amount) as revenue", "income_others", "", $whrOtherIncome);
            $data["otherIncome"] = intval($otherIncome->revenue);


            $rsNewOrder = $this->base_model->list_data("a.*, b.nama", "orders a", array("sys_user b" => "b.id=a.create_by"), $whrNewOrder);
            $data["rsNewOrder"] = $rsNewOrder;
//            class="form-control input-sm"
            $data["additional_script2"] = "var dt = $('#example1').DataTable();"
                    . "$('#example1 tbody').on('click', 'tr', function () {                        
                        var dataId = $(this).data('id');
                        return openBox('".base_url("transaksi/update_penjualan/form/edit")."/' + dataId, '90');
                    } );";


            $this->template->load($data, 'home');
        }
    }

}
