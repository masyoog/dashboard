<?php

if (!function_exists("my_input_elm")){
    function my_input_elm($name, $value, $extra=array()){
        $attr = array("class"=>"form-control", "name"=>$name, "id"=>$name );
        if(count($extra) > 0 && is_array($extra)){
            foreach($extra as $key=>$val){
                if (array_key_exists($key, $attr)){
                    $attr[$key] = $attr[$key]." ". $val;
                }else {
                    $attr = $attr + array($key => $val);
                }
            }
        }
        return form_input($attr, $value);
    }
}
