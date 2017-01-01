<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of transaction_msg
 *
 * @author Yoga Mahendra <masyoog@yahoo.com>
 */
class Transaction {
	var $IP = "ip";
	var $DATETIME = "datetime";
	var $MERCHANT_ID = "MerchantID";
	var $MERCHANT_NAME = "MerchantName";
	var $SIGNATURE = "Signature";
	var $AMOUNT = "Amount";
	var $REFFID = "ReffID";
	var $MERCHANT_KEY = "MechantKey";
	var $URL_REFERER = "Reff_URL";
	var $CUSTOMER_NAME = "Cust_Name";
	var $CUSTOMER_PHONE = "Cust_NoTelp";
	var $CUSTOMER_EMAIL = "Cust_Email";
	var $BILL_NAME = "Bill_Name";
	var $TRX_DATE = "Trx_Date";
	var $REFF_URL = "Reff_URL";
	var $ACTION = "Action";
        
	var $CARD_HOLDER_NAME = "Card_Holder_Name";
	var $CARD_NUMBER = "Card_Number";
	var $ISSUED = "Issued";
	var $EXPIRED_DATE = "Expired_Date";
	var $CARD_TYPE = "Type_Card";
	var $BIRTHDATE = "Cust_Birthdate";
	var $CVV = "CVV";
	var $CUSTOMER_COUNTRY = "Cust_Country";
	var $CUSTOMER_STATE = "Cust_State";
	var $CUSTOMER_CITY = "Cust_City";
	var $CUSTOMER_ADDRESS = "Cust_Address";
	var $CUSTOMER_POSTCODE = "Cust_Postcode";
	
	
	var $URL_LISTENER = "Url_Listener";
	var $URL_REDIRECT = "Url_Redirect";
	
	var $RC = "rc";
	var $DESCRIPTION = "description";
	
	private $username;
	private $password;
	private $ipaddress;
        
	private $data = null;
	
        function __contruct(){
            $this->data = new stdClass();
        }
		
	function jsonParse($jsonObj){
            $this->data = json_decode($jsonObj);
	}
        
        function dbParse($resultSet){
            $this->data = $resultSet;
	}
	
	function getValue($key){
            return _get_raw_object($this->data, $key);
	}
	
	function setValue($key, $value){
            $this->data->{$key} = $value;
	}
	
	function getUsername() {
		return $this->username;
	}

	
	function setUsername($username) {
		$this->username = $username;
	}

	
	function getPassword() {
            return $this->password;
	}

	
	function setPassword($password) {
            $this->password = $password;
	}

	
	function getIPAddress() {
            return $this->ipaddress;
	}

	
	function setIPAddress($ipaddress) {
            $this->ipaddress = $ipaddress;
	}

	function toString(){
            return json_encode($this->data);
	}
}
