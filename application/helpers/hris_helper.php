<?php
/**
 * This file is part of the array_column library
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * @copyright Copyright (c) Ben Ramsey (http://benramsey.com)
 * @license http://opensource.org/licenses/MIT MIT
 */
if (!function_exists('array_column')) {
    /**
     * Returns the values from a single column of the input array, identified by
     * the $columnKey.
     *
     * Optionally, you may provide an $indexKey to index the values in the returned
     * array by the values from the $indexKey column in the input array.
     *
     * @param array $input A multi-dimensional array (record set) from which to pull
     *                     a column of values.
     * @param mixed $columnKey The column of values to return. This value may be the
     *                         integer key of the column you wish to retrieve, or it
     *                         may be the string key name for an associative array.
     * @param mixed $indexKey (Optional.) The column to use as the index/keys for
     *                        the returned array. This value may be the integer key
     *                        of the column, or it may be the string key name.
     * @return array
     */
    function array_column($input = null, $columnKey = null, $indexKey = null)
    {
        // Using func_get_args() in order to check for proper number of
        // parameters and trigger errors exactly as the built-in array_column()
        // does in PHP 5.5.
        $argc = func_num_args();
        $params = func_get_args();
        if ($argc < 2) {
            trigger_error("array_column() expects at least 2 parameters, {$argc} given", E_USER_WARNING);
            return null;
        }
        if (!is_array($params[0])) {
            trigger_error(
                'array_column() expects parameter 1 to be array, ' . gettype($params[0]) . ' given',
                E_USER_WARNING
            );
            return null;
        }
        if (!is_int($params[1])
            && !is_float($params[1])
            && !is_string($params[1])
            && $params[1] !== null
            && !(is_object($params[1]) && method_exists($params[1], '__toString'))
        ) {
            trigger_error('array_column(): The column key should be either a string or an integer', E_USER_WARNING);
            return false;
        }
        if (isset($params[2])
            && !is_int($params[2])
            && !is_float($params[2])
            && !is_string($params[2])
            && !(is_object($params[2]) && method_exists($params[2], '__toString'))
        ) {
            trigger_error('array_column(): The index key should be either a string or an integer', E_USER_WARNING);
            return false;
        }
        $paramsInput = $params[0];
        $paramsColumnKey = ($params[1] !== null) ? (string) $params[1] : null;
        $paramsIndexKey = null;
        if (isset($params[2])) {
            if (is_float($params[2]) || is_int($params[2])) {
                $paramsIndexKey = (int) $params[2];
            } else {
                $paramsIndexKey = (string) $params[2];
            }
        }
        $resultArray = array();
        foreach ($paramsInput as $row) {
            $key = $value = null;
            $keySet = $valueSet = false;
            if ($paramsIndexKey !== null && array_key_exists($paramsIndexKey, $row)) {
                $keySet = true;
                $key = (string) $row[$paramsIndexKey];
            }
            if ($paramsColumnKey === null) {
                $valueSet = true;
                $value = $row;
            } elseif (is_array($row) && array_key_exists($paramsColumnKey, $row)) {
                $valueSet = true;
                $value = $row[$paramsColumnKey];
            }
            if ($valueSet) {
                if ($keySet) {
                    $resultArray[$key] = $value;
                } else {
                    $resultArray[] = $value;
                }
            }
        }
        return $resultArray;
    }
}

if (!function_exists('_pad')) {

    function _pad($input, $pad="", $len=0, $dir="LEFT") {
        if ( $dir == "LEFT") {
            $out =  str_pad($input, $len, $pad, STR_PAD_LEFT);
        } else if ($dir == "RIGHT"){
            $out =  str_pad($input, $len, $pad, STR_PAD_RIGHT);
        } else {
            $out =  str_pad($input, $len, $pad, STR_PAD_BOTH);
        }
        return $out;
    }

}

if (!function_exists('_bulan_romawi')) {

    function _bulan_romawi($bln) {
        $out = array("", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII");
        $out = _get_raw_item($out, $bln);
        return $out;
    }

}

if (!function_exists('_build_query_string')) {

    function _build_query_string($array) {
        $out = "";
        if (is_array($array)) {
            $out = "?" . http_build_query($array);
        }
        return $out;
    }

}

if (!function_exists('_sanitize_input')) {

    function _sanitaze_input($input) {

        $input = str_replace("'", "''", $input);
        return $input;
    }

}
if (!function_exists('_debug_var')) {
    /*
     * Get value from given array by key return '' if key not exist
     * param @array array
     * param @key given key
     * return String value
     */

    function _debug_var($obj, $withDump = FALSE) {
        if ($withDump)
            var_dump($obj);

        echo "<pre>";
        print_r($obj);
        echo "</pre>";
//        return $str;
    }

}

if (!function_exists('_replace_before')) {

    function _replace_before($string, $search) {
        $out = "";
        $pos = strpos($string, $search);
        if ($pos !== FALSE) {
            $out = substr($string, $pos + strlen($search));
        } else {
            $out = $string;
        }
        return $out;
    }

}

if (!function_exists('_replace_after')) {

    function _replace_after($string, $search) {
        $out = "";
        $pos = strpos($string, $search);
        if ($pos !== FALSE) {
            $out = substr($string, 0, $pos);
        } else {
            $out = $string;
        }
        return $out;
    }

}


if (!function_exists('_string_human')) {
    /*
     * Get value from given array by key return '' if key not exist
     * param @array array
     * param @key given key
     * return String value
     */

    function _string_human($string) {
        $str = preg_replace('/[^A-Za-z0-9\. -]/', ' ', $string);
        return ucwords($str);
    }

}


if (!function_exists('_get_raw_item')) {
    /*
     * Get value from given array by key return '' if key not exist
     * param @array array
     * param @key given key
     * return String value
     */

    function _get_raw_item($array, $key, $default = '') {
        $out = $default;
        if (is_array($array)) {
            if (array_key_exists($key, $array)) {
                $out = $array['' . $key . ''];
            }
        }
        return $out;
    }

}

if (!function_exists('_get_raw_object')) {
    /*
     * Get value / property from given object by property return '' if property not exist
     * param @object object to test
     * param @property given property to test
     * return String value
     */

    function _get_raw_object($object, $property) {
        $out = '';
        if (is_object($object)) {
            if (property_exists($object, $property) !== TRUE) {
                $out = 'NULL';
            } else {
                $out = $object->$property;
            }
        }
        return $out;
    }

}

if (!function_exists('_set_checked')) {
    /*
     * Get value from given array by key return '' if key not exist
     * param @key given key
     * return String ' checked'
     */

    function _set_checked($value = "", $default_checked = "") {
        $out = '';
//        _debug_var($value);
//        _debug_var($default_checked);
        if ($value == $default_checked) {
            $out = 'checked';
        }
        return $out;
    }

}

if (!function_exists('_dateIndo')) {

    function _dateIndo($date) { // fungsi atau method untuk mengubah tanggal ke format indonesia
        // variabel BulanIndo merupakan variabel array yang menyimpan nama-nama bulan
        $BulanIndo = array("Januari", "Februari", "Maret",
            "April", "Mei", "Juni",
            "Juli", "Agustus", "September",
            "Oktober", "November", "Desember");
        $tahun = substr($date, 0, 4); // memisahkan format tahun menggunakan substring
        $bulan = substr($date, 5, 2); // memisahkan format bulan menggunakan substring
        $tgl = substr($date, 8, 2); // memisahkan format tanggal menggunakan substring
        $result = $tgl . " " . $BulanIndo[(int) $bulan - 1] . " " . $tahun;
        return($result);
    }

}
if (!function_exists('_date')) {
    /*
     * Get format date from given date
     * param @tanggal given key
     * param @format default Y-m-d 
     * return String date formated
     */

    function _date($tanggal, $format = 'Y-m-d') {
        $out = date($format, strtotime(str_replace("/", "-", $tanggal)));
        return $out;
    }

}

if (!function_exists('_number')) {
    /*
     * Get format number from given int
     * param @angka given key
     * param @pemisah 
     * return String number, 0 if not int
     */

    function _number($angka, $digit_sen=0, $pemisah_ribuan = '.', $pemisah_sen = ',') {

        $angka = intval($angka);
        $out = number_format($angka, $digit_sen, $pemisah_sen, $pemisah_ribuan);
        return $out;
    }

}

if (!function_exists('_unset_array')) {
    /*
     * void unset array from given key
     * param @array given array
     * param @key optional key 
     */

    function _unset_array(&$array = '', $key = FALSE) {
        if ($array != '' && is_array($array)) {
            if ($key !== FALSE) {
                if (is_array($key)) {
                    foreach ($key as $kunci) {
                        if (_get_raw_item($array, $kunci) != '')
                            unset($array[$kunci]);
                    }
                }else {
                    if (_get_raw_item($array, $key) != '')
                        unset($array[$key]);
                }
            }else {
                unset($array);
            }
        }
    }

}