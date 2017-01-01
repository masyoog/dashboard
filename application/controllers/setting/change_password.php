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
class Change_password extends MY_Controller {

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
            "method" => "set_password/change",
            "style" => "fa-key",
            "action" => "openBox('URL', '80')",
            "authType" => "ubah"));
    }

    function index() {
        $this->load->library('encrypt');
        $data = array();
        $errorMsg = "";
        $mode = "change";
        $key = $this->session->userdata(USER_AUTH . "cUserID");


        $dg = new Datagrid();
        $this->_CFG = new Datagridconfig();
        $this->_CFG->set_KEYS($this->_TBL_PRIMARY_PK);
        $this->_CFG->set_PRIMARY_TBL($this->_TBL_PRIMARY);
        $this->_CFG->set_JOIN_TBL($this->_TBL_JOIN);
        $this->_CFG->set_ORDER_TBL($this->_ORDER);
        $this->_CFG->set_ITEM_PER_PAGE($this->_ITEM_PER_PAGE);



        $userPasswordOld = new Datagridcolumn();
        $userPasswordOld->set_FIELD_DB("a.userpassword");
        $userPasswordOld->set_FIELD_DB_ALIAS("userpasswordold");
        $userPasswordOld->set_SIZE(32);
        $userPasswordOld->set_FORM_ID("userpasswordold");
        $userPasswordOld->set_REQUIRED(TRUE);
        $userPasswordOld->set_FIELD_TYPE($userPasswordOld->get_PASSWORD_TYPE());
        $this->_CFG->add_column("Password Lama", $userPasswordOld);

        $this->_CFG->add_COMMAND_BUTTON("BATAL", array());


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

                $rs = $this->base_model->list_single_data("userpassword", "sys_user", "", array('id' => $this->session->userdata(USER_AUTH . "cUserID")));

                if ( $this->input->post("userpasswordold") != $this->encrypt->decode($rs->userpassword) ) {
                    $errorMsg = $dg->get_validation_error("Password Lama tidak cocok. !");
                } else {
                    $errorMsg = "";
                }
            }

            if ($errorMsg == "") {

                

                $this->_TBL_PRIMARY = _replace_after($this->_TBL_PRIMARY, " ");
                $affected = $this->base_model->update_data(
                        $this->_TBL_PRIMARY, array("userpassword" => $this->encrypt->encode($this->input->post("userpassword"))), array("id" => $key)
                );

                if ($affected > 0) {
                    $this->auditrail("change password", $key);
                }

//                $this->base_model->execute("CALL fn_force_logout(". $key .")");
                redirect("authorization/logout");
            }
        }

        $data["pages"] = $dg->render_form($mode, $key, $errorMsg);
        $data["additional_script"] = $dg->get_ADDITIONAL_SCRIPT();
        $this->template->load($data);
    }

}
