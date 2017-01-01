<?php
$form_input_attr = array('class' => 'form-control',);
?>

<section class="content-header" style="background: #FFFFFF;">
    <div class="row">
        <div class="col-xs-6 pull-left"> 
            <h4 class="text-primary">Pembelian</h4>
        </div>
    </div>
</section>

<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-primary">
                <?php
                $attributes = array('class' => 'formEvent', 'id' => 'formBBLK', 'role' => 'form');
                echo form_open_multipart("", $attributes);
                ?>
                <div class="box-header">
                    <h4 class="box-title text-orange">PO</h4>
                </div>

                <div class="box-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="no_po">PO No
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <?php
                        echo my_input_elm("no_po", $rs_po->no_po, array("readonly" => "readonly", "required" => "required"));
                        ?>                            
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="supplier_name">Supplier Name
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <?php
                        echo my_input_elm("supplier_name", $rs_po->supplier_name, array("readonly" => "readonly", "required" => "required"));
                        ?>                            
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="po_date">PO Date
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <?php
                        echo my_input_elm("po_date", _date($rs_po->create_at, "d/m/Y"), array("readonly" => "readonly", "required" => "required"));
                        ?>                            
                    </div>    
                    <div class="form-group form-group-sm">
                        <br>
                        <h4>Detail PO</h4>

                        <?php
                        if ($rs_po_detail!= "") {
                            $i = 0;
                            ?>
                            <table class="table table-hover nowrap dataTable">
                                <tr>
                                    <th>No.</td>
                                    <th>Product Name</td>
                                    <th>Item Price</td>
                                    <th>Qty Ordered</td>
                                    <th>Total Price</td>
                                    <th>Qty Approved</td>
                                    <!--<th>Qty Returned</td>-->
                                    <!--<th>Qty Reject</td>-->
                                    <th>Total Price Approved</td>    
                                </tr>
                                <?php
                                foreach ($rs_po_detail as $row) {
                                    $i++;
                                    ?>
                                    <tr>
                                        <td><?php echo $i ?></td>
                                        <td><?php echo $row->product_name ?></td>
                                        <td><?php echo _number($row->item_price) ?></td>
                                        <td><?php echo _number($row->qty) ?></td>
                                        <td><?php echo _number($row->total_price) ?></td>
                                        <td><?php echo my_input_elm("qty[" . $row->id . "]", _number($row->qty_approved), array("required" => "required", "class" => "txt-qty elm-num", "data-price" => intval($row->item_price), "style" => "text-align:right;")); ?></td>
                                        <!--<td><?php echo my_input_elm("retur[" . $row->id . "]", _number($row->qty_returned), array("required" => "required", "class" => "txt-qty elm-num", "style" => "text-align:right;")); ?></td>-->
                                        <!--<td><?php echo my_input_elm("reject[" . $row->id . "]", _number($row->qty_rejected), array("required" => "required", "class" => "txt-qty elm-num", "style" => "text-align:right;")); ?></td>-->
                                        <td><?php echo my_input_elm("total_price[" . $row->id . "]", _number($row->total_price_approved), array("required" => "required", "readonly" => "readonly", "class" => "txt-price", "style" => "text-align:right;")); ?></td>                                        
                                    </tr>
    <?php } ?>
                                <tr>
                                    <td colspan="6" align="right"><b>Total Payment</b></td>
                                    <td><?php echo my_input_elm("total_payment", 0, array("required" => "required", "class" => "elm-num", "readonly" => "readonly", "style" => "text-align:right;")); ?></td>
                                </tr>
                            </table>
<?php } ?>
                    </div>
                    <div class="form-group form-group-sm">
                        <div class="checkbox">
                            <label class="control-label" for="close_po">
                                <input type="checkbox" name="close_po" id="close_po" value="2" <?php echo ($rs_po->status == "2" ? "checked" : ""); ?>>
                                Close PO
                            </label>
                        </div>                          
                    </div>
                </div>

                <div class="box-footer">
                    <div style="text-align: right;">
                        <button  type="button" class="btn btn-danger cancelFormBtn" name="cancel" value="BATAL" onclick="window.location.href = 'http://localhost/mrs/transaksi/pembelian/index'">BATAL</button>
                        <button  type="submit" class="btn btn-primary submitFormBtn" name="save" value="SIMPAN" >SIMPAN</button>
                    </div>
                </div>

<?php echo form_close(); ?>
            </div>
        </div>
</section>