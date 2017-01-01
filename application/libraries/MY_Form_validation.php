<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of MY_
 *
 * @author Yoga Mahendra <masyoog@yahoo.com>
 */
class MY_Form_validation extends CI_Form_validation {

    protected $CI;

    //put your code here
    function __construct($rules = array()) {
        parent::__construct($rules);
        // Assign the CodeIgniter super-object
        $this->CI = & get_instance();
    }

    // --------------------------------------------------------------------

    /**
     * Match one field to another
     *
     * @access	public
     * @param	string
     * @param	field
     * @return	bool
     */
    public function is_unique($str, $field) {
        $countRows = 0;
        
        list($table, $field, $model) = explode('.', $field);
        
        if ($model == "") {
            $query = $this->CI->db->limit(1)->get_where($table, array($field => $str));
            $countRows = $query->num_rows();
        } else {
            $this->CI->load->model($model);
            $model = _get_raw_object($this->CI, $model);
            $query = $model->list_single_data($field, $table, "", array($field=>$str));
            $countRows = $query != "" ? 1 : 0;
        }

        return $countRows < 1;
    }

    // --------------------------------------------------------------------
}
