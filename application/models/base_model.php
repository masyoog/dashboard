<?php

class Base_model extends CI_Model {
    private $_lastQuery;
    
    function __construct() {
        parent::__construct();        
    }
    
    function escapeDBParam($param){
        return $this->db->escape_str($param);
    }
    
    function _getLastQuery(){
        return $this->_lastQuery;
    }
    
    function _setLastQuery($qry){
        $this->_lastQuery = $qry;
    }

    function execute_count($SQL, $whr = "") {

        $where = "";
        if (count($whr) > 0) {

            $where = $where == "" ? " WHERE " : "";
            $whrTemp = "";
            foreach ($whr as $key => $cond) {
                $whrTemp .= $whrTemp == "" ? "" : " AND ";
                $whrTemp .= $cond;
            }
            $where .= $whrTemp;
        }

        $query = $this->db->query($SQL . $where);
        $row = $query->row()->JUMLAH;
        return $row;
    }

    function execute($SQL, $returnResult = FALSE) {
        $out = "";
        
        $rs = $this->db->query($SQL);
        if ( $returnResult ){
            return $rs;
        }
        
        if ($rs->num_rows() > 0) {
            $out = $rs->result();
        }
        return $out;
    }

    function insert_data($table = '', $datas = '', $isRetID = TRUE) {
        $insert_id = "";
        $this->db->insert($table, $datas);
        if ($isRetID == TRUE) {
            $insert_id = $this->db->insert_id();
            
        }
        return $insert_id;
    }

    function update_data($table = '', $datas = '', $wheres = '') {
        $out = 0;
        if ($wheres != '') {
            $this->db->update($table, $datas, $wheres);
            $out = $this->db->affected_rows();
        }
        return $out;
    }

    function update_data_adv($table = '', $datas = '', $wheres = '') {
        if ($wheres != '') {
            foreach ($datas as $key => $value) {
                if (is_array($value)) {
                    $this->db->set($key, _get_raw_item($value, 0), _get_raw_item($value, 1));
                } else {
                    $this->db->set($key, $value);
                }
            }
            $this->db->where($wheres);
            $this->db->update($table);
        }
    }

    function delete_data($table = '', $wheres = '') {
        $out = 0;
        if ($wheres != '') {
            $this->db->delete($table, $wheres);
            $out = $this->db->affected_rows();
        }
        return $out;
    }
    
    


    /*
     * Digunakan untuk insert table yang mempunyai constraint, sehingga mengabaikan violation :D
     */

    function insert_ignore_data($table = "", $datas = "") {

        $qry = $this->db->insert_string('my_table', $data_item);

        $qry = str_replace('INSERT INTO', 'INSERT IGNORE INTO', $insert_query);

        $this->db->query($qry);

        return $this->db->insert_id();
    }

    function count_all_data($field, $table, $join = "", $where = "", $distinct = "") {
        $out = '';

        $this->db->select($field);
        if ($distinct != "") {
            $this->db->distinct($distinct);
            $this->db->group_by($distinct);
        }
        $this->db->from($table);
        if (is_array($join)) {
            foreach ($join as $key => $value) {
                $this->db->join($key, $value, "left");
            }
        }

        if (is_array(_get_raw_item($where, 0))) {
            foreach ($where as $whr) {
                $this->db->where($whr);
            }
        } else {
            $this->db->where($where);
        }

        $out = $this->db->count_all_results();
        return $out;
    }

    function list_single_data($field, $table, $join, $where = "", $escapes = TRUE, $order_by = "", $distinc="") {
        $out = '';
//        if ('' != $where)
        $out = $this->list_data($field, $table, $join, $where, $order_by, 1, "", $distinc, $escapes);

        return _get_raw_item($out, 0);
    }

    function list_data($field, $table, $join, $where = "", $order = "", $limit = "", $offset = "", $distinct = "", $escapes = TRUE) {
        $out = '';

        $this->db->select($field, $escapes);
        $this->db->from($table);

        if ($distinct != "") {
            $this->db->distinct($distinct);
            $this->db->group_by($distinct);
        }

        if (is_array($join)) {
            foreach ($join as $key => $value) {
                if (is_array($value) ){
                    $this->db->join($key, $value[0], $value[1]);
                } else {
                    $this->db->join($key, $value, "left");
                }
            }
        }

        if ($where != "") {
            if (is_array(_get_raw_item($where, 0))) {
                foreach ($where as $whr) {
                    $this->db->where($whr);
                }
            } else {
                $this->db->where($where);
            }
        }

        if (is_array($order)) {
            foreach ($order as $ord) {
                $this->db->order_by($ord);
            }
        }

        if ($limit !== '') {
            if ($offset != ''){
                $this->db->limit($limit, $offset);
            }else{
                $this->db->limit($limit);
            }    
        }

        $rs = $this->db->get();
//        echo $this->db->last_query();
        $this->_setLastQuery($this->db->last_query());

        if ($rs->num_rows() > 0) {
            $out = $rs->result();
        }

        return $out;
    }

}
