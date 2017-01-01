<?php

class Message_sender {

    private $_ci = "";
    private $_method = FALSE;
    private $_is_secure = FALSE;
    private $_url = "";
    private $_port = "80";
    private $_path = "";
    private $_header = "";
    private $_timeout = 60;
    private $_connect_timeout = 5;
    private $_is_debug_enable = FALSE;
    private $_CL;

    function __construct() {
        $this->_ci = & get_instance();
        $this->_CL = new ConfigLoader();
    }

    function set_debug_enable($isEnable) {
        $this->_is_debug_enable = TRUE;
    }

    function init($cnfHost = "", $cnfPath = "", $isSecure = FALSE) {
        if (!is_array($cnfHost)) {
            $configHost = $this->_CL->get_config($cnfHost);
            $this->_url = _get_raw_item($configHost, "URL");
            $this->_port = _get_raw_item($configHost, "PORT");
            $rawHeader = _get_raw_item($configHost, "HEADER");
            $rawHeaders = explode("|", $rawHeader);
            $this->_header = $rawHeaders;
        } else {
            $this->_url = _get_raw_item($cnfHost, "URL");
            $this->_port = _get_raw_item($cnfHost, "PORT");
            $rawHeader = _get_raw_item($cnfHost, "HEADER");
            $rawHeaders = explode("|", $rawHeader);
            $this->_header = $rawHeaders;
        }

        if (is_array($cnfPath)) {
            $configPath = $this->_CL->get_param(
                    _get_raw_item($cnfPath, 0), _get_raw_item($cnfPath, 1)
            );
        } else {
            $configPath = $cnfPath;
        }

        $this->_path = $configPath;

        $this->_is_secure = $isSecure;
    }

    function do_post($data = "") {
        $this->_method = TRUE;
        $result = $this->send($data);
        return $result;
    }

    function do_get($data = "") {
        $this->_method = FALSE;
        $result = $this->send($data);
        return $result;
    }

    private function send($data = "") {
        $result = '';
        $errno = 0;
        $error = '';

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->_url . $this->_path);
        curl_setopt($ch, CURLOPT_PORT, $this->_port);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $this->_header);
        curl_setopt($ch, CURLOPT_POST, $this->_method);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, $this->_timeout);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $this->_connect_timeout);

        if ($this->_is_secure) {
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        }


        curl_setopt($ch, CURLOPT_VERBOSE, $this->_is_debug_enable);

        //execute post
        $response = curl_exec($ch);
        $errno = curl_errno($ch);
        $error = curl_error($ch);

        if ($this->_is_debug_enable) {
            if ($result === FALSE) {
                printf("cUrl error (#%d): %s<br>\n", curl_errno($handle), htmlspecialchars(curl_error($handle)));
            }
        }
        if ($errno > 0) {
            $result = $error;
        } else {
            $result = $response;
        }
        //close connection
        curl_close($ch);

        return $result;
    }

}

?>
