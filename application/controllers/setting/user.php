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
class User extends MY_Controller {

    private $_CFG;
    private $_TBL_PRIMARY = "sys_user a";
    private $_TBL_PRIMARY_PK = "a.id";
    private $_ORDER = array();
    private $_ITEM_PER_PAGE = "";
    private $_TBL_JOIN = array("sys_grup_user b" => "b.id=a.sys_grup_user_id");
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

        $userName = new Datagridcolumn();
        $userName->set_FIELD_DB("a.username");
        $userName->set_SIZE(128);
        $userName->set_FORM_ID("username");
        $userName->set_REQUIRED(TRUE);
        $this->_CFG->add_column("User Name", $userName);

        $nama = new Datagridcolumn();
        $nama->set_FIELD_DB("a.nama");
        $nama->set_SIZE(256);
        $nama->set_FORM_ID("nama");
        $this->_CFG->add_column("Nama", $nama);

        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("b.nama");
        $grupUser->set_FIELD_DB_ALIAS("grup");
        $grupUser->set_SIZE(4);
        $grupUser->set_FORM_ID("grup");
        $grupUser->set_REQUIRED(TRUE);
        $this->_CFG->add_column("Grup User", $grupUser);

        $status = new Datagridcolumn();
        $status->set_FIELD_DB("a.is_device");
        $status->set_FIELD_TYPE($status->get_ENUM_TYPE());
        $status->set_FORM_ID("is_device");
        $status->set_ENUM_DEFAULT_VALUE(
                array("1" => "Device",
                    "0" => "User"
        ));
        $status->set_STYLE(
                array("1" => '<span class="label label-warning">Device</span>',
                    "0" => '<span class="label label-success">User</span>'
        ));
        $status->set_SIZE(1);
        $this->_CFG->add_column("Type", $status);
        
        $status = new Datagridcolumn();
        $status->set_FIELD_DB("a.status");
        $status->set_FIELD_TYPE($status->get_ENUM_TYPE());
        $status->set_FORM_ID("status");
        $status->set_ENUM_DEFAULT_VALUE(
                array("1" => "Aktif",
                    "0" => "Pasif"
        ));
        $status->set_STYLE(
                array("1" => '<span class="label label-success">Aktif</span>',
                    "0" => '<span class="label label-warning">Pasif</span>'
        ));
        $status->set_SIZE(1);
        $this->_CFG->add_column("Status", $status);

//        $this->_CFG->add_grid_button(
//                "FORCE LOGOUT", array(
//            "method" => "force_logout",
//            "style" => "fa-share-square-o",
//            "option" => 'data-bb="prompt" data-msg="Anda yakin akan memaksa user logout ?" data-confirm="true"',
//            "authType" => "ubah"));

        $this->_CFG->add_grid_button(
                "Log User", array(
            "method" => base_url("log/auditrail/index"),
            "style" => "fa-exchange",
            "action" => "openBox('URL', '80')",
            "overideUri" => TRUE,
            "authType" => "baca"
                )
        );

        $this->_CFG->add_grid_button(
                "SET PASSWORD", array(
            "method" => "set_password/edit",
            "style" => "fa-key",
            "action" => "openBox('URL', '80')",
            "authType" => "ubah"));
    }

    function index() {
        $data = array();

//        $whr = array("is_device" => 0);
//        $this->_CFG->set_WHR_TBL($whr);

        //initiate datagrid
        $dg = new Datagrid();

        $dg->set_config($this->_CFG);
        $data["pages"] = $dg->render();
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();

        $this->auditrail("Show");
        //pasing to template lib
        $this->template->load($data);
    }

    function force_logout($key) {

        //$this->base_model->execute("CALL fn_force_logout(" . intval($key) . ")");
        redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
    }

    function form($mode, $key = "") {
        $data = array();


        $dg = new Datagrid();

        $rsGrup = $this->base_model->list_data("id as kunci, nama as nilai", "sys_grup_user", "", array('status' => 1, 'is_merchant_grup'=>'0'), array("nama asc"));

        $grupUser = new Datagridcolumn();
        $grupUser->set_FIELD_DB("a.sys_grup_user_id");
        $grupUser->set_FIELD_TYPE($grupUser->get_ENUM_TYPE());
        $grupUser->set_ENUM_DEFAULT_VALUE($rsGrup);
        $grupUser->set_SIZE(4);
        $grupUser->set_REQUIRED(TRUE);
        $grupUser->set_FORM_ID("sys_grup_user_id");
        $this->_CFG->add_column("Grup User", $grupUser);

        $poto = new Datagridcolumn();
        $poto->set_FIELD_DB("a.poto");
        $poto->set_FIELD_TYPE($poto->get_FILE_TYPE());
        $poto->set_SIZE(256);
        $poto->set_FORM_ID("poto");
        $this->_CFG->add_column("Upload Gambar", $poto);

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

                $errorMsg = $dg->get_validation_error($this->_upload($key));

                if ("" != $this->base_model->db->_error_message()) {
                    $errorMsg = $this->base_model->db->_error_message();
                } else {
                    redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
                }
            }
        }

        //initiate datagrid
        $data["pages"] = $dg->render_form($mode, $key, $errorMsg);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();


        //pasing to template lib
        $this->template->load($data);
    }

    function set_password($mode, $key = "") {
        $this->load->library('encrypt');
        $data = array();
        $errorMsg = "";


        $dg = new Datagrid();
        $this->_CFG = new Datagridconfig();
        $this->_CFG->set_KEYS($this->_TBL_PRIMARY_PK);
        $this->_CFG->set_PRIMARY_TBL($this->_TBL_PRIMARY);
        $this->_CFG->set_JOIN_TBL($this->_TBL_JOIN);
        $this->_CFG->set_ORDER_TBL($this->_ORDER);
        $this->_CFG->set_ITEM_PER_PAGE($this->_ITEM_PER_PAGE);

        if ($mode == "change") {

            $userPasswordOld = new Datagridcolumn();
            $userPasswordOld->set_FIELD_DB("a.userpassword");
            $userPasswordOld->set_FIELD_DB_ALIAS("userpasswordold");
            $userPasswordOld->set_SIZE(32);
            $userPasswordOld->set_FORM_ID("userpasswordold");
            $userPasswordOld->set_REQUIRED(TRUE);
            $userPasswordOld->set_FIELD_TYPE($userPasswordOld->get_PASSWORD_TYPE());
            $this->_CFG->add_column("Password Lama", $userPasswordOld);

            $this->_CFG->add_COMMAND_BUTTON("BATAL", array());
        } else {
            $data["isWindowPopUp"] = TRUE;
            $this->_CFG->add_COMMAND_BUTTON(
                    "BATAL", array(
                "name" => 'cancel',
                "type" => 'button',
                "class" => "btn-danger",
                "action" => "javascript:closeBox(true);"
            ));
        }

        $userPassword = new Datagridcolumn();
        $userPassword->set_FIELD_DB("a.userpassword");
        $userPassword->set_SIZE(32);
        $userPassword->set_FORM_ID("userpassword");
        $userPassword->set_REQUIRED(TRUE);
        $userPassword->set_FIELD_TYPE($userPassword->get_PASSWORD_TYPE());
        $this->_CFG->add_column("Password Baru", $userPassword);

        $userPasswordConf = new Datagridcolumn();
        $userPasswordConf->set_FIELD_DB("a.userpassword");
        $userPasswordConf->set_SIZE(32);
        $userPasswordConf->set_FORM_ID("userpasswordconfirm");
        $userPasswordConf->set_REQUIRED(TRUE);
        $userPasswordConf->set_FIELD_TYPE($userPasswordConf->get_PASSWORD_CONFIRM_TYPE());
        $this->_CFG->add_column("Konfirmasi Password", $userPasswordConf);



        $dg->set_config($this->_CFG);

        $dg->set_page_title("Ubah Password");


        $this->form_validation->set_rules($dg->get_validation_rules());
        $this->form_validation->set_error_delimiters('<br />', '');
        $errorMsg = "";

        if ($this->input->post('save') != "") {

            if ($this->form_validation->run() == FALSE) {
                $errorMsg = $dg->get_validation_error($this->form_validation->error_string());
            } else {
                if ($mode == "change") {
                    $rs = $this->base_model->list_single_data("userpassword", "sys_user", "", array('id' => $this->session->userdata(USER_AUTH . "cUserID")));
                    if ( $this->input->post("userpasswordold") != $this->encrypt->decode($rs->userpassword) ) {
                        $errorMsg = $dg->get_validation_error("Password Lama tidak cocok. !");
                    } else {
                        $errorMsg = "";
                    }
                }
            }

            if ($errorMsg == "") {
                if ($mode == "change") {
                    $key = $this->session->userdata(USER_AUTH . "cUserID");
                }

                $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
                $affected = $this->base_model->update_data(
                        $this->_TBL_PRIMARY, array("userpassword" => $this->encrypt->encode($this->input->post("userpassword"))), array("id" => $key)
                );

                if ($affected > 0) {
                    $this->auditrail("set password", $key);
//                    $this->base_model->execute("CALL fn_force_logout(" . intval($key) . ")");
                }

//                if ("" != $this->base_model->db->_error_message()) {
//                    $errorMsg = $dg->get_validation_error($this->base_model->db->_error_message());
//                } else {
                if ($mode == "change") {
                    redirect("authorization/logout");
                } else {
                    $data["additional_script2"] = "closeBox();";
                }
//                }
            }
        }

        $data["pages"] = $dg->render_form($mode, $key, $errorMsg, TRUE);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();
        $this->template->load($data);
    }

    private function _upload($id = "") {

        $err_msg = "";

        if ("" == $id) {
            return "Referensi Tidak ditemukan ";
        }


        $config = new ConfigLoader();

        $cnf = $config->get_config("UPL_USR");

        $upl = new UploadFile();

        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");


        $datas = array();

        if (is_array($columns)) {
            foreach ($columns as $column => $property) {
                $dataUpload = FALSE;
                if ($property->get_FIELD_TYPE() == $property->get_FILE_TYPE()) {

                    if ($_FILES[$property->get_FORM_ID()]["name"] != "") {
                        $dataUpload = $upl->do_upload($property->get_FORM_ID(), $cnf);

                        if ($upl->get_error_msg() == "") {
                            $field = _replace_before($property->get_FIELD_DB(), ".");

                            if ("" != $property->get_FIELD_DB()) {
                                $datas = $datas + array($field => _get_raw_item($dataUpload, "full_path"));
                            }
                        } else {
                            $err_msg .= $upl->get_error_msg();
                        }
                    }
                }
            }
            if (count($datas) > 0)
                $affected = $this->base_model->update_data($this->_TBL_PRIMARY, $datas, array("id" => $id));

            if ($affected > 0)
                $this->auditrail("Upload", $id);
        }



        return $err_msg;
    }

    private function _tambah() {
        $ID = "";
        $columns = $this->_CFG->get_column();

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");

        $datas = array();
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
            }
        }

        return $ID;
    }

    private function _ubah($key = "") {

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
        $this->_TBL_PRIMARY_PK = _replace_before($this->_TBL_PRIMARY_PK, ".");

        if ("" != $key && "" != $this->_CFG->get_KEYS()) {
            $columns = $this->_CFG->get_column();
            $whr = array($this->_TBL_PRIMARY_PK => $key);
            $datas = array();
            if (is_array($columns)) {
                foreach ($columns as $column => $property) {
                    if ($property->get_FIELD_TYPE() != $property->get_FILE_TYPE()) {
                        $value = $this->input->post($property->get_FORM_ID());
                        $value = $property->get_FIELD_TYPE() == $property->get_DATE_TYPE() ? _date($value, "Y-m-d") : $value;
                        $field = _replace_before($property->get_FIELD_DB(), ".");
                        if ("" != $property->get_FIELD_DB())
                            $datas = $datas + array($field => $value);
                    }
                }

                $ID = $this->base_model->update_data($this->_TBL_PRIMARY, $datas, $whr);
                if ($ID > 0) {
                    $this->auditrail("Update", $ID);
                }
            }
        }
    }

    function remove($key = "") {

        $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
        $this->_TBL_PRIMARY_PK = _replace_before($this->_TBL_PRIMARY_PK, ".");

        if ("" != $key) {
            $whr = array($this->_TBL_PRIMARY_PK => $key);
            $affected = $this->base_model->delete_data($this->_TBL_PRIMARY, $whr);
            if ($affected > 0) {
                $this->auditrail("remove", $key);
            }
        }

        redirect(base_url($this->_INDEX_PAGE) . _build_query_string($this->_get_query_string()));
    }

}
