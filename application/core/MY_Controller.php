<?php

class MY_Controller extends CI_Controller {

    var $auth;

    function __construct() {

        parent::__construct();

        $this->auth = new Userauth();

        if (!$this->auth->is_logged() || $this->auth->is_force_logout()) {
            redirect('authorization');
        }

        if ($this->router->fetch_method() != 'error_page') {
            if ($this->auth->view_page_authorize() !== TRUE)
                redirect($this->auth->view_page_authorize() . '/error_page');
        }
    }

    function _get_query_string($param = "") {
        $out = "";
        if (is_array($_GET)) {
            if ("" == $param) {
                foreach ($_GET as $param => $value) {
                    $out[$param] = $this->input->get_post($param);
                }
            } else {
                $out = $this->input->get_post($param);
            }
        }
        return $out;
    }

    function error_page() {
        $data = '';
        $data['paging'] = '';
        $data['grid'] = '';
        $this->template->load('template/template_error', 'error.php', $data);
    }

    function select_required($str) {
        $str = trim($str);
        $this->form_validation->set_message('select_required', 'field %s harus dipilih');
        return $str == '0' || strlen($str) < 1 ? FALSE : TRUE;
    }

    function export($model="", $filename = "") {
        $auth = $this->session->userdata("EXPORT" . $this->router->directory . $this->router->class);

        if ($auth) {
            $this->load->model($model);
            $this->load->dbutil();
            
            $model = _get_raw_object($this, $model);
            $qry = _replace_after($this->session->userdata(md5("lastQuery" . $this->router->directory . $this->router->class)), "LIMIT");
            $query = $model->export($qry);
            
            $delimiter = ",";
            $newline = "\r\n";
            $queryResult = $this->dbutil->csv_from_result($query, $delimiter, $newline);
            $queryResult = str_replace(array("\n"), ' ', $queryResult);
            $dateNow = date('Y-m-d_H-i-s');
            $fn = $filename == "" ? $this->router->class : $filename;
            $this->auditrail("export");
            force_download($fn . '_' . $dateNow . '.csv', $queryResult);
        } else {
            force_download();
        }

        
    }

    function auditrail($event = "", $reffKey = "", $object = "") {

        $logActor = $this->session->userdata(USER_AUTH . 'cUserID');
        $logEvent = $event == "" ? $this->router->method : $event;
        $logObject = $object == "" ? $this->router->directory . $this->router->class : $object;
        $logRefKey = $reffKey;

        $logEvent = ucwords($logEvent);
        $data = array(
            "sys_user_id" => $logActor,
            "log_event" => $logEvent,
            "log_object" => $logObject,
            "log_ref_key" => $logRefKey,
            "log_date" => date("Y-m-d"),
            "log_time" => date("H:i:s")
        );

        $this->base_model->insert_data("sys_log", $data);
    }

}

?>
