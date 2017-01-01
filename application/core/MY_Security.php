<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of MY_Security
 *
 * @author Yoga Mahendra <masyoog@yahoo.com>
 */
class MY_Security extends CI_Security {
    
    //put your code here
    function __construct() {
        parent::__construct();
//        $this->CI =& get_instance();
    }

    /**
     * Verify Cross Site Request Forgery Protection
     *
     * @return	object
     */
    public function csrf_verify() {
        // If no POST data exists we will set the CSRF cookie
        if (count($_POST) == 0) {
            return $this->csrf_set_cookie();
        }

        // Do the tokens exist in both the _POST and _COOKIE arrays?
        if (!isset($_POST[$this->_csrf_token_name]) OR ! isset($_COOKIE[$this->_csrf_cookie_name])) {
            header("Location: ". config_item('base_url'));
//            redirect('authorization');
//            $this->csrf_show_error();
//            echo "mamamammama";
        }

        // Do the tokens match?
        if ($_POST[$this->_csrf_token_name] != $_COOKIE[$this->_csrf_cookie_name]) {
            header("Location: ". config_item('base_url'));
//            redirect('authorization');
//            $this->csrf_show_error();
//            echo "mamamammama";
        }

        // We kill this since we're done and we don't want to
        // polute the _POST array
        unset($_POST[$this->_csrf_token_name]);

        // Nothing should last forever
        unset($_COOKIE[$this->_csrf_cookie_name]);
        $this->_csrf_set_hash();
        $this->csrf_set_cookie();

        log_message('debug', "CSRF token verified ");

        return $this;
    }

    // --------------------------------------------------------------------
    /**
     * Set Cross Site Request Forgery Protection Cookie
     *
     * @return	object
     */
    public function csrf_set_cookie() {
        $expire = time() + $this->_csrf_expire;
        $secure_cookie = (config_item('cookie_secure') === TRUE) ? 1 : 0;

        if ($secure_cookie) {
            $req = isset($_SERVER['HTTPS']) ? $_SERVER['HTTPS'] : FALSE;

            if (!$req OR $req == 'off') {
                return FALSE;
            }
        }

        setcookie(
                $this->_csrf_cookie_name, $this->_csrf_hash, $expire, config_item('cookie_path'), config_item('cookie_domain'), $secure_cookie, config_item('cookie_httponly')
        );

        log_message('debug', "CRSF cookie Set");

        return $this;
    }

}
