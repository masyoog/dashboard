<?php
$form_input_attr = array('class' => 'form-control',);
?>

<section class="content-header" style="background: #FFFFFF;">
    <div class="row">
        <div class="col-xs-6 pull-left"> 
            <h4 class="text-primary">Penjualan</h4>
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
                    <h4 class="box-title text-orange">Penjualan</h4>
                </div>

                <div class="box-body">
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="no_po">Order No
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <?php
                        echo my_input_elm("order_code", $rs_po->order_code, array("readonly" => "readonly", "required" => "required"));
                        ?>                            
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="no_po">Customer
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <select class="form-control elm-select" name="customer_id" id="customer_id" required="">
                            <option value="">&nbsp;Tulis Nama atau No HP&nbsp;</option>                            
                        </select>    
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="control-label" for="order_date">Order Date
                            <span class="fa fa-asterisk text-info"></span>                                
                        </label>
                        <?php
                        echo my_input_elm("order_date", date("Y-m-d H:i:s"), array("readonly" => "readonly", "required" => "required"));
                        ?>                            
                    </div>    
                    <div class="form-group form-group-sm">
                        <br>
                        <h4>Detail Order</h4>
<!--                        <p>
                        - Ketika data anda simpan dengan status <b>PAID</b> tercentang, maka sistem akan otomatis mengurangi stock berdasarkan Produk dengan nilai dari <b>Qty.</b><br>                            
                        </p>-->
                        <?php
                        if ($rs_po_detail != "") {
                            $i = 0;
                            ?>
                            <table class="table table-hover nowrap dataTable">
                                <tr>
                                    <th>No.</td>
                                    <th>Product Name</td>
                                    <th>Item Price</td>
                                    <th>Qty Ordered</td>
                                    <th>Total Price</td>
                                    <!--<th>Qty Approved</td>-->
                                    <!--<th>Qty Returned</td>-->
                                    <!--<th>Qty Reject</td>-->
                                    <!--<th>Total Price Approved</td>-->    
                                </tr>
                                <?php
                                $totalPayment = 0;
                                foreach ($rs_po_detail as $row) {
                                    $i++;
                                    ?>
                                    <tr>
                                        <td><?php echo $i ?></td>
                                        <td><?php echo $row->product_name ?></td>
                                        <td><?php echo _number($row->price) ?></td>
                                        <td><?php echo _number($row->qty) ?></td>
                                        <!--<td><?php echo _number($row->amount) ?></td>-->
                                        <!--<td><?php echo my_input_elm("qty[" . $row->id . "]", _number($row->qty_approved), array("required" => "required", "class" => "txt-qty elm-num", "data-price" => intval($row->item_price), "style" => "text-align:right;")); ?></td>-->
                                        <!--<td><?php echo my_input_elm("retur[" . $row->id . "]", _number($row->qty_returned), array("required" => "required", "class" => "txt-qty elm-num", "style" => "text-align:right;")); ?></td>-->
                                        <!--<td><?php echo my_input_elm("reject[" . $row->id . "]", _number($row->qty_rejected), array("required" => "required", "class" => "txt-qty elm-num", "style" => "text-align:right;")); ?></td>-->
                                        <td><?php echo my_input_elm("total_price[" . $row->id . "]", _number($row->amount), array("required" => "required", "readonly" => "readonly", "class" => "txt-price", "style" => "text-align:right;")); ?></td>                                        
                                    </tr>
                                    <?php
                                    $totalPayment = $totalPayment + $row->amount;
                                }
                                ?>
                                <tr>
                                    <td colspan="4" align="right"><b>Total Payment</b></td>
                                    <td><?php echo my_input_elm("total_payment", _number($totalPayment), array("required" => "required", "class" => "elm-num", "readonly" => "readonly", "style" => "text-align:right;")); ?></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>Discount</b></td>
                                    <td><?php echo my_input_elm("disc", _number($rs_po->disc), array("required" => "required", "class" => "elm-num", "style" => "text-align:right;")); ?></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="right"><b>Pay Amount</b></td>
                                    <td><?php echo my_input_elm("pay", _number($rs_po->netto), array("required" => "required", "class" => "elm-num", "readonly" => "readonly", "style" => "text-align:right;")); ?></td>
                                </tr>
                            </table>
<?php } ?>
                    </div>
                    <!--                    <div class="form-group form-group-sm">
                                            <div class="checkbox">
                                                <label class="control-label" for="close_po">
                                                    <input type="checkbox" name="close_po" id="close_po" value="2" <?php echo ($rs_po->status == "2" ? "checked disabled=\"disabled\"" : ""); ?>>
                                                    PAID
                                                </label>
                                            </div>                          
                                        </div>-->
                </div>

                <div class="box-footer">
                    <div style="text-align: right;">
<?php //if($rs_po->status != "2"): ?>
                        <button  type="button" class="btn btn-danger cancelFormBtn" name="cancel" value="BATAL" onclick="closeBox()">BATAL</button>
                        <button  type="submit" class="btn btn-primary submitFormBtn" name="save" value="BAYAR" >BAYAR</button>
<?php //endif; ?>
                    </div>
                </div>

<?php echo form_close(); ?>
            </div>
        </div>
</section>