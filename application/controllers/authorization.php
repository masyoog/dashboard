<?php

class Authorization extends CI_Controller {
    
    function __construct() {
        parent::__construct();
    }
    
    function index()
    {
        $data = '';
        $data['error_msg'] = $this->session->userdata('error_msg');
        $this->auth = new Userauth();

        if ($this->auth->is_logged()) {
            redirect('home');
        }

        $this->load->view('login', $data);
    }
    
    function authorized()
    {
        $username = $this->input->post('login');
        $password = $this->input->post('password');
        
        if (strlen(trim($username)) > 128 || strlen(trim($password)) > 128){
            redirect('authorization');
        }
        
        $auth = new Userauth();
        $auth->authorize($username, $password);
        
        if ( $auth->authorize($username, $password) ){
            $this->session->set_userdata(array('error_msg'=> ''));
            echo "<script>top.window.location='". base_url("home") ."'</script>";
        } else {
            $this->session->set_userdata(array('error_msg'=> $auth->get_error_string()));
            redirect('authorization');
        }
    }
    
    function logout()
    {
        $this->session->sess_destroy();
        redirect('/','refresh');
    }
}
