<?php

define('USER_AUTH', 'VISA_MONITORING_USER');

class Userauth {

    private $_error_string;
    private $_table_users;
    private $_table_users_access;
    private $_table_menu;
    private $_timeout;
    private $_off_is_called;
    private $CI;

    function __construct() {
        $this->_off_is_called = true;
        $this->_timeout = 1000;
        $this->_table_users = "sys_user";
        $this->_table_users_access = "sys_grup_akses";
        $this->_table_menu = "sys_menu";

        $this->CI = & get_instance();
        $this->CI->load->model('base_model');
    }

    function logout($username = '') {

        $this->CI->session->sess_destroy();
    }

    function is_force_logout() {
        $rs = $this->CI->base_model->list_single_data("force_logout", $this->_table_users, "", array('id' => $this->CI->session->userdata(USER_AUTH . 'cUserID')));
        $isForce = _get_raw_object($rs, "force_logout") == "0" ? FALSE : TRUE;
        if ($isForce) {
            $this->logout();
        }
        return $isForce;
    }

    function is_logged() {
        try {
            $time_now = time();
            $time = $time_now - intval($this->CI->session->userdata(USER_AUTH . 'log_time')) + 10; //10 adalah faktor tambahan ketepatan

            if ($time > $this->_timeout && $this->_off_is_called) {
                $this->_error_string = "Your session has been expired after reaching timeout, please login...";
                $this->logout();
            } else {

                $this->CI->session->set_userdata(array(USER_AUTH . 'log_time' => time()));
            }

            $hasil = true;

            if ($this->CI->session->userdata(USER_AUTH . 'logged') == USER_AUTH) {
                $hasil = true;
            } else {
                $hasil = false;
            }

            return $hasil;
        } catch (Exception $e) {
            return false;
        }
    }

    private function get_current_url() {


        $dir = str_replace('/', '', $this->CI->router->fetch_directory());
        $class = str_replace('/', '', $this->CI->router->fetch_class());

        $out = $dir . '/' . $class;
        return $out;
    }

    function view_page_authorize() {

        return true;
        $out = FALSE;
        $menulist = $this->CI->session->userdata(USER_AUTH . "menulist");
        $menulist = json_decode($menulist, TRUE);
        $out = $this->get_current_url();
        if (is_array($menulist)) {
            if (array_search($this->get_current_url(), $menulist) !== FALSE) {
                $out = TRUE;
            }
        }

        return $out;
    }

    function authorize($username, $password) {
        $this->CI->load->library('encrypt');
        $is_authenticated = false;

        $username = $this->CI->base_model->db->escape_str($username);
        $password = $this->CI->base_model->db->escape_str($password);

        $result = $this->CI->base_model->list_single_data("*", $this->_table_users, "", array('username' => $username));


        $is_userexist = false;

        if ($result != '') {

            $is_userexist = true;
            $passdb = trim($result->userpassword);
            $passdb = $this->CI->encrypt->decode($passdb);
            if ($password === $passdb) {

                if ($result->status == "1") {
                    $is_authenticated = true;
                    //reset force logout to 0
                    $this->CI->base_model->update_data($this->_table_users, array("force_logout" => 0), array("id" => $result->id));

                    $this->_get_list_access($result->sys_grup_user_id);
                } else {
                    $this->_error_string = "User ID anda saat ini tidak aktif !";
                }
            } else {
                $this->_error_string = "User ID atau password anda tidak cocok !";
            }
        }

        if (!$is_userexist) {
            $this->_error_string = "User ID Belum Terdaftar!";
        }

        if ($is_authenticated) {

            $rsGrupUser = $this->CI->base_model->list_single_data("*", "sys_grup_user", "", array("id" => $result->sys_grup_user_id));

            $rsMapMerchant = "";
            $mapMerchant = "";
            if ($result->is_merchant == 1) {
                $rsMapMerchant = $this->CI->base_model->list_data("merchant_id", "sys_map_user_merchant", "", array("sys_user_id" => $result->id));

                if ($rsMapMerchant != "") {
                    $rsMapMerchant = json_decode(json_encode($rsMapMerchant), TRUE);
                    $mapMerchant = implode("', '", array_column($rsMapMerchant, "merchant_id"));
                    $mapMerchant = "'" . $mapMerchant . "'";
                }
            }

            $data = array(
                USER_AUTH . 'log_time' => time(),
                USER_AUTH . 'logged' => USER_AUTH,
                USER_AUTH . 'cUserID' => $result->id,
                USER_AUTH . 'cUsername' => $result->username,
                USER_AUTH . 'cNama' => $result->nama,
                USER_AUTH . 'cPoto' => str_replace(FCPATH, "", $result->poto),
                USER_AUTH . 'cGrupUserId' => _get_raw_object($rsGrupUser, "id"),
                USER_AUTH . 'cGrupUser' => _get_raw_object($rsGrupUser, "nama"),
                USER_AUTH . 'cIsMercantUser' => $result->is_merchant,
                USER_AUTH . 'cMercantMapID' => $mapMerchant
            );
            $this->CI->session->set_userdata($data);
        }

        return $is_authenticated;
    }

    private function _get_list_access($id_group_user = "") {

        $rsInduk = $this->CI->base_model->list_data(
                "b.*, a.baca, a.tambah, a.ubah, a.hapus, a.cetak", $this->_table_users_access . " a", array($this->_table_menu . " b" => " b.id = a.sys_menu_id "), array(
            "a.sys_grup_user_id" => intval($id_group_user),
            "b.id_induk" => 0,
//                    "b.status"=>1,
            "a.baca" => 1
//                    "(a.baca=1 OR a.tambah=1 OR a.ubah=1 OR a.hapus=1 OR a.cetak=1)" => NULL
                ), array("b.urutan ASC")
        );

        $rsAnak = $this->CI->base_model->list_data(
                "b.*, a.baca, a.tambah, a.ubah, a.hapus, a.cetak", $this->_table_users_access . " a", array($this->_table_menu . " b" => " b.id = a.sys_menu_id "), array(
            "a.sys_grup_user_id" => intval($id_group_user),
            "b.id_induk > " => 0,
//                    "b.status"=>1,
            "a.baca" => 1
                ), array("b.urutan ASC")
        );


        $this->CI->session->set_userdata(array(USER_AUTH . "main_menu" => $rsInduk));
        $this->CI->session->set_userdata(array(USER_AUTH . "child_menu" => $rsAnak));
    }

    function get_error_string() {
        return $this->_error_string;
    }

}

?>
