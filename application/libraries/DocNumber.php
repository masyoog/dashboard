<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DocNumber
 *
 * @author Yoga Mahendra <masyoog@yahoo.com>
 */
class DocNumber {
    private $CI;
    
    function __construct() {
        $this->CI = & get_instance();
    }
    
    function generate($cnfType="", $cnfName="", $tableReff=""){
        $out = "";
        $tblReff = explode(".", $tableReff);
        
        $fmt = $this->CI->configloader->get_param($cnfType, $cnfName);
        if ( $fmt != "" ) {
            $rs = $this->CI->base_model->list_single_data($tblReff[1], $tblReff[0], "", "", "", array($tblReff[1]." DESC"));
            $lastNumber = _get_raw_object($rs, $tblReff[1]);
            $lastNumber = explode("/", $lastNumber);
            $lastNumber = end($lastNumber);
            if ( $lastNumber == "" ){
                $lastNumber = 1;
            } else {
                $lastNumber = intval($lastNumber) + 1;
            }
        }
        
        $out = $fmt;
        $out = str_replace("[MONTH]", _bulan_romawi(date('n')), $out);
        $out = str_replace("[YEAR]", date('Y'), $out);
        $lastNumber = _pad($lastNumber, "0", 6);
        $out = str_replace("[NO]", $lastNumber, $out);
        return $out;
    }
}
