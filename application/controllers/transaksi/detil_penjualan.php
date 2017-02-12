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
class Detil_penjualan extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "order_detail a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array();
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array(
        "product c" => "c.id=a.product_id",
        "supplier b" => "b.id=a.supplier_id",
        "units d" => "d.id=a.unit"
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
        $nama->set_FIELD_DB("c.name");
        $nama->set_FIELD_DB_ALIAS("product");
        $nama->set_FORM_ID("product");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Product", $nama);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("b.supplier_name");
        $nama->set_FIELD_DB_ALIAS("supplier_name");
        $nama->set_FORM_ID("supplier_name");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Supplier", $nama);

        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.pprice");
        $userName->set_SIZE(4);
        $userName->set_FORM_ID("pprice");
        $userName->set_FIELD_TYPE($userName->get_NUM_TYPE());
        $userName->set_REQUIRED(TRUE);
        $userName->set_EDITABLE(FALSE);
        $this->_CFG->add_column("Pprice", $userName);
        
        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.price");
        $userName->set_SIZE(4);
        $userName->set_FORM_ID("price");
        $userName->set_EDITABLE(FALSE);
        $userName->set_FIELD_TYPE($userName->get_NUM_TYPE());
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Price", $userName);
        
        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.qty");
        $userName->set_SIZE(4);
        $userName->set_FORM_ID("qty");
        $userName->set_FIELD_TYPE($userName->get_NUM_TYPE());
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Qty", $userName);
        
        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("d.unit_name");
        $nama->set_FIELD_DB_ALIAS("unit_name");
        $nama->set_FORM_ID("unit");
        $nama->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Unit", $nama);
        
        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.amount");
        $userName->set_SIZE(4);
        $userName->set_FORM_ID("amount");
        $userName->set_EDITABLE(FALSE);
        $userName->set_FIELD_TYPE($userName->get_NUM_TYPE());
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Amount", $userName);
        
        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.description");
        $grupUser->set_SIZE(128);
        $grupUser->set_FORM_ID("description");
        $this->_CFG->add_column("Description", $grupUser);

        $this->_CFG->add_grid_button("UBAH", array());
    }

    function index($orderId = "null") {
        $data = array();
        $whr = array();
        $this->session->set_userdata(array(md5(__FILE__ . "order_id") => $orderId));

        if ($orderId != "null") {
            $whr = $whr + array("a.order_id" => intval($orderId));
        }


        //initiate datagrid
        $dg = new Datagrid();
        if (count($whr) > 0) {
            $this->_CFG->set_WHR_TBL($whr);
        }
        $dg->set_config($this->_CFG);

        $data["pages"] = $dg->render(TRUE);
        $data["isWindowPopUp"] = TRUE;
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();

        $this->auditrail("Show");
        //pasing to template lib
        $this->template->load($data);
    }

    function form($mode, $key = "") {
        $data = array();
        $id_supplier = $this->session->userdata(md5(__FILE__ . "order_id"));

        $dg = new Datagrid();

        if ($key == "") {
            $rsGrup = $this->base_model->list_data("id as kunci, concat_ws(' - ', code, name) as nilai", "product", "", array('status' => 1), array("name asc"), "", "", "", FALSE);
            $grupUser = new Datagridcolumn();
            $grupUser->set_FIELD_DB("a.product_id");
            $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
            $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
            $grupUser->set_SIZE(4);
            $grupUser->set_REQUIRED(TRUE);
            $grupUser->set_FORM_ID("product_id");
            $this->_CFG->add_column("Product", $grupUser);
            
//            $rsSup = $this->base_model->list_data("id as kunci, concat_ws(' - ', supplier_code, supplier_name) as nilai", "supplier", "", array('status' => 1), array("supplier_name asc"), "", "", "", FALSE);
            $rsSup = array();
            $grupUser = new Datagridcolumn();
            $grupUser->set_FIELD_DB("a.supplier_id");
            $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
//            $grupUser->set_ENUM_DEFAULT_VALUE();
            $grupUser->set_SIZE(4);
            $grupUser->set_REQUIRED(TRUE);
            $grupUser->set_FORM_ID("supplier_id");
            $this->_CFG->add_column("Supplier", $grupUser);
            
//            $rsUnit = $this->base_model->list_data("id as kunci, unit_name as nilai", "units", "", array('status' => 1), array("unit_name asc"), "", "", "", FALSE);
            $grupUser = new Datagridcolumn();
            $grupUser->set_FIELD_DB("a.unit");
            $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
//            $grupUser->set_ENUM_DEFAULT_VALUE();
            $grupUser->set_SIZE(4);
            $grupUser->set_REQUIRED(TRUE);
            $grupUser->set_FORM_ID("unit");
            $this->_CFG->add_column("Unit", $grupUser);
        } else {
            $grupUser = new Datagridcolumn();
            $this->_CFG->add_column("Product", $grupUser);
            
            $grupUser = new Datagridcolumn();
            $this->_CFG->add_column("Supplier", $grupUser);
            
            $grupUser = new Datagridcolumn();
            $this->_CFG->add_column("Unit", $grupUser);
        }

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

                    redirect(base_url($this->_INDEX_PAGE . "/index/" . $id_supplier . "/null/") . _build_query_string($this->_get_query_string()));
                }
            }
        }


        $this->_CFG->add_COMMAND_BUTTON(
                "BATAL", array(
            "type" => "button",
            "name" => "cancel",
            "style" => "",
            "class" => "btn-danger cancelFormBtn",
            "action" => "window.location.href='" . base_url(_replace_after($this->uri->uri_string, "form") . "index/" . $id_supplier . "/null/") . _build_query_string($this->_get_query_string()) . "'"
        ));
        //initiate datagrid
        $data["pages"] = $dg->render_form($mode, $key, $errorMsg, TRUE);
        $data["isWindowPopUp"] = TRUE;
        
        $script = '$("#product_id").change(function(){'
                . '     var productId = $(this).val();'
                . '     $.ajax({
                            url: "'. base_url("transaksi/detil_penjualan/products") .'/" + productId,
                            beforeSend: function( xhr ) {
                              $("#loading_img").show();
                            },
                            success : function(response){
                                console.log(response);
                                var data = $.parseJSON(response);
                                $("#price").val(data.product.price);
                                var sup = data.suppliers;
                                var unit = data.units;
                                parseToSelect(sup, $("#supplier_id"));
                                parseToSelect(unit, $("#unit"));
                                getPPrice();
                                $("#loading_img").hide();
                                
                            },
                            error : function(){
                                $("#loading_img").hide();
                            }
                        });'
                . '});'
                . '$("#supplier_id").change(function(){'
                . '     getPPrice();'
                . '});'
                . 'function parseToSelect(data, elm){'                
                . '     elm.empty();'
                . '     if ( data.length > 0){'
                . '         $.each(data, function(i, item){'
                . '             elm.append("<option value=\""+ item.kunci +"\">"+ item.nilai +"</option>");'
                . '         })'
                . '     }'
                . '}'
                . 'function getPPrice(){'
                . '     var productId = $("#product_id").val();'
                . '     var supplierId = $("#supplier_id").val();'
                . '     $.ajax({
                            url: "'. base_url("transaksi/detil_penjualan/pprice") .'/" + productId + "/" + supplierId,
                            beforeSend: function( xhr ) {
                              
                            },
                            success : function(response){
                                console.log(response);
                                var data = $.parseJSON(response);
                                $("#pprice").val(data.pprice);
                            },
                            error : function(){
                                
                            }
                        });'
                . '}'
                . '$("#qty").change(function(){'
                . '     setAmount();'
                . '});'                
                . 'function setAmount(){'
                . '     var price=$("#price").val().replace(".", "");'
                . '     var qty=$("#qty").val().replace(".", "");'
                . '     var amount = price * qty;'
                . '     $("#amount").val(amount);'
                . '}';
      
        $dg->set_ADDITIONAL_SCRIPT($script);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();


        //pasing to template lib
        $this->template->load($data);
    }

    private function _tambah() {
        $ID = "";
        $columns = $this->_CFG->get_column();
        $orderId = $this->session->userdata(md5(__FILE__ . "order_id"));
        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");

        $datas = array("order_id" => $orderId);
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
                $this->_updateStock($ID);                
            }
        }

        return $ID;
    }

    private function _updateStock($orderDetailId = "", $refunded="") {
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
                "stocks_id"=>intval($stocksId),
                "description" => $rsOrder->order_code
            );
            
            if ( $refunded != ""){
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
    
    function remove($key = "") {
        $id_supplier = $this->session->userdata(md5(__FILE__ . "order_id"));
        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
        $this->_TBL_PRIMARY_PK = _replace_before($this->_TBL_PRIMARY_PK, ".");

        if ("" != $key) {
            $whr = array($this->_TBL_PRIMARY_PK => $key);
            
            //refund stock first 
            $this->_updateStock($key, "refunded");
            $affected = $this->base_model->delete_data($this->_TBL_PRIMARY, $whr);
            if ($affected > 0) {
                $this->auditrail("remove", $key);
            }
        }

        redirect(base_url($this->_INDEX_PAGE . "/index/" . $id_supplier . "/null/") . _build_query_string($this->_get_query_string()));
    }

    
    function products($productId=""){
        $rsPrd = $this->base_model->list_single_data("*", "product", "", array("status"=>1, "id"=> intval($productId)));
        $rsSup = $this->base_model->list_data("b.id as kunci, concat_ws(' - ', b.supplier_code, b.supplier_name ) as nilai", "parsing a", array("supplier b"=>"b.id=a.supplier_id"), array("a.product_id"=> intval($productId)));
        
        
        $rsUnit = $this->base_model->list_data("id as kunci, unit_name as nilai", "units", "", array("id"=>intval($rsPrd->unit_id)));
        $data["product"] = $rsPrd;
        $data["units"] = $rsUnit;
        $data["suppliers"] = $rsSup;
        
        echo json_encode($data);        
    }
    
    function pprice($productId="", $supplier_id){
        
        $rsSup = $this->base_model->list_single_data("pprice", "parsing", "", array("product_id"=> intval($productId), "supplier_id"=> intval($productId)));
        
        echo json_encode(array("pprice"=>intval($rsSup->pprice)));        
    }
}
