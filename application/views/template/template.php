<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><?php echo $this->config->item("MY_MODULE_NAME") ?></title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<!--        <link rel="icon" type="image/png" href="<?php echo base_url() ?>/favicon.ico">-->
        <link rel="shortcut icon" href="<?php echo base_url() ?>/favicon.ico" type="image/x-icon">
        <link rel="icon" href="<?php echo base_url() ?>/favicon.ico" type="image/x-icon">
        <!-- bootstrap 3.0.2 -->
        <link href="<?php echo base_url('assets') ?>/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="<?php echo base_url('assets') ?>/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- daterange picker -->
        <link href="<?php echo base_url('assets') ?>/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- date picker -->
        <link href="<?php echo base_url('assets') ?>/css/datepicker/datepicker3.css" rel="stylesheet" type="text/css" />

        <!-- DATA TABLES -->
        <link href="<?php echo base_url('assets') ?>/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />

        <!-- selectize -->
        <link href="<?php echo base_url('assets') ?>/selectize/css/selectize.bootstrap3.css" rel="stylesheet" type="text/css" />

        <!-- bootstrap-select -->
<!--        <link href="<?php echo base_url('assets') ?>/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" type="text/css" />-->

        <!-- Theme style -->
        <link href="<?php echo base_url('assets') ?>/css/AdminLTE.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo base_url('assets') ?>/style.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <style>

            body { font-size: 12px; background: #f9f9f9;}
            .content{ padding: 10px 15px; padding-bottom: 0;}
            .btn-grid { min-width: 15px; font-size: 14px; margin-left: 5px;}

            /*#tbl-grid th.grid-btn-action, #tbl-grid td.grid-btn-action { min-width: 100px; text-align: right; padding-right: 20px;}*/

            .right-side > .content-header {
                padding: 5px 15px 0px 20px;
            }
            .form-group {
                margin-left: 5px;
            }

            .user-info { margin: 10px auto; width: 400px; text-align: center; color: #999; }
            .user-info a { color: #999; margin: 0 10px; }
            .user-info a.logout { color: #f00; }
            .user-info a.logout:hover { color: #f00; text-decoration: underline; }

            iframe { margin: -16px -18px -15px -15px; padding: 0; border: 0px solid red; }

            .box-gold {border-top-color: #006100;}
            .text-green-wismilak {color: #006100;}

            .billTitle { font-size: 16px; margin-left: 20px;}
            .billContent { list-style: none; padding-left: 20px;}
            .billContent li { padding-top : 5px;}
            .billItemTitle{ font-weight: bold;}
            .billItemValue{ float:right;}
            /***********tbox style*********/
            .tbox {position:absolute; display:none; padding:14px 17px; z-index:2002}
            .tinner {padding:15px; -moz-border-radius:5px; border-radius:5px; background:#fff url(<?php echo base_url('assets/tinybox') ?>/preload.gif) no-repeat 50% 50%; border-right:1px solid #333; border-bottom:1px solid #333}
            .tmask {position:absolute; display:none; top:0px; left:0px; height:100%; width:100%; background:#000; z-index:2000;}
            .tclose {position:absolute; top:0px; right:0px; width:32px; height:32px; cursor:pointer; background:url(<?php echo base_url('assets/tinybox') ?>/close.png) no-repeat}
            .tclose:hover {opacity: 0.7}

            .tooltip-inner {
                max-width: 300px !important; 
            }
        </style>
    </head>
    <body class="skin-blue">

        <?php if (!isset($isWindowPopUp)) { ?>
            <!-- header logo: style can be found in header.less -->
            <header class="header">
                <!--                <div class="logo" style="font-family: 'Squada One', Arial;font-weight: normal;font-size: 26px;">-->
                <div class="logo" style="font-weight: bolder;font-size: 20px;">
                    <span class="fa fa-credit-card" style="font-size: 24px;color: #FFFFFF;">&nbsp;</span>MRS
                </div>

                <nav class="navbar  navbar-static-top" role="navigation" ><!--#1D8B58;-->
                    <!--<nav class="navbar navbar-default navbar-static-top" role="navigation" style="background:#1D8B58; margin-left: 0;">14C574-->

                    <div class="navbar-right">
                        <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </a>
                        <ul class="nav navbar-nav">   
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-user-md"></i>
                                    <span><?php echo $this->session->userdata(USER_AUTH . 'cUsername') ?> <i class="caret"></i></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- User image -->
                                    <li class="user-header bg-light-blue">
                                        <?php
                                        $imgUsr = file_exists($this->session->userdata(USER_AUTH . 'cPoto')) ? $this->session->userdata(USER_AUTH . 'cPoto') : "assets/img/no-pic.png";
                                        ?>
                                        <img src="<?php echo base_url() . $imgUsr ?>" class="img-circle" alt="User Image">
                                        <p>
                                            <?php echo $this->session->userdata(USER_AUTH . 'cNama') . " - " . $this->session->userdata(USER_AUTH . 'cGrupUser') ?>
                                            <!--<small>Member since Nov. 2012</small>-->
                                        </p>
                                    </li>

                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-left">
                                            <a href="<?php echo base_url("setting/change_password"); ?>" class="btn btn-default btn-flat">Ubah Password</a>
                                        </div>
                                        <div class="pull-right">
                                            <a href="<?php echo base_url("authorization") . "/logout" ?>" class="btn btn-danger btn-flat">Sign out</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
        <?php } ?>
        <div class="wrapper row-offcanvas row-offcanvas-left">

            <!-- Left side column. contains the logo and sidebar -->
            <?php if (!isset($isWindowPopUp)) { ?>
                <aside class="left-side sidebar-offcanvas" <?php
                if (isset($isWindowPopUp)) {
                    echo 'style="display:none;"';
                }
                ?>>
                    <!-- sidebar: style can be found in sidebar.less -->
                    <section class="sidebar" <?php
                    if (isset($isWindowPopUp)) {
                        echo 'style="display:none;"';
                    }
                    ?>>

                        <?php
                        if ('' != $main_menu) {

                            echo '<ul id="ul-parent-side-menu" class="sidebar-menu">';
                            foreach ($main_menu as $row_main_menu) {
                                if ($row_main_menu->status != 1) {
                                    continue;
                                }

                                if ($this->router->directory != "") {
                                    $active_menu = strpos($row_main_menu->uri, _replace_after($this->router->directory, "/"));
                                    $active_menu = $active_menu === 0 ? "active" : "";
                                } else {
                                    if ($this->router->fetch_class() != "") {
                                        $active_menu = $row_main_menu->uri == str_replace("/", "", $this->router->fetch_class());
                                        $active_menu = $active_menu ? "active" : "";
                                    } else {
                                        $active_menu = "";
                                    }
                                }

                                if ("" != _get_raw_item($child_menu, $row_main_menu->id)) {
                                    echo '<li class="treeview ' . $active_menu . '"><a href="#"><i class="fa fa-' . $row_main_menu->icon . ' text-primary"></i>' . $row_main_menu->menu . '</a>';
                                    $this->template->parse_child_menu(_get_raw_item($child_menu, $row_main_menu->id), $child_menu);
                                    echo '</li>';
                                } else {
                                    echo '<li class="' . $active_menu . '"><a href="' . base_url($row_main_menu->uri) . '"><i class="fa fa-' . $row_main_menu->icon . ' text-primary"></i>' . $row_main_menu->menu . '</a>';
                                    echo '</li>';
                                }
                            }
                            echo '</ul>';
                        }
                        ?>

                    </section>
                    <!-- /.sidebar -->
                </aside>

            <?php } ?>
            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side" <?php
            if (isset($isWindowPopUp)) {
                echo 'style="width:100%; margin-left:0;"';
            }
            ?>>

                <?php echo isset($pages) ? $pages : ""; ?>
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->
        <div id="loading_img" style="display: none; z-index: 10000;position: absolute; width: 100%; height: 100%; top:0;left: 0; background: url(<?php echo base_url('assets/img/ajax-loader1.gif') ?>) no-repeat center center #eaeaea; opacity: .4;">
        </div>
        <!-- jQuery 2.0.2 -->
        <script src="<?php echo base_url('assets') ?>/jquery/jquery.min.js"></script>

        <!-- Bootstrap -->
        <script src="<?php echo base_url('assets') ?>/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- date-range-picker -->
        <script src="<?php echo base_url('assets') ?>/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- date-picker -->
        <script src="<?php echo base_url('assets') ?>/js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
        <!-- DATA TABES SCRIPT -->
        <script src="<?php echo base_url('assets') ?>/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="<?php echo base_url('assets') ?>/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>

        <!--selective select autocomplete-->
        <script src="<?php echo base_url('assets') ?>/selectize/js/standalone/selectize.min.js" type="text/javascript"></script>

        <!--numberFormat-->
        <script src="<?php echo base_url('assets/js/plugins/numberFormat') ?>/numberFormat.js" type="text/javascript"></script>

        <!--tinybox-->
        <script src="<?php echo base_url('assets') ?>/tinybox/tinybox.js" type="text/javascript"></script>
        <!--bootstap confirm-->
        <script src="<?php echo base_url('assets') ?>/confirm/bootbox.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <script src="<?php echo base_url('assets') ?>/js/AdminLTE/app.js" type="text/javascript"></script>


        <script type="text/javascript">
            function openBox(url, percentSize, withReload) {
                var pc = parseInt(percentSize);
                if (pc < 1) {
                    pc = 80;
                }
                var w = window.innerWidth;
                var h = window.innerHeight;
//                console.log('width ' + w);
//                console.log('height ' + h);
                w = parseInt(w * pc / 100);
                h = parseInt(h * pc / 100);
//                console.log('width ' + w);
//                console.log('height ' + h);
                withReload = null == withReload ? false : true;
                if (withReload) {
                    tiny.box.show({iframe: url, width: w, height: h, closejs: function () {
                            parent.location.reload()
                        }});
                } else {
                    tiny.box.show({iframe: url, width: w, height: h, close: true});
                }
            }

            function closeBox(withReload) {
                withReload = null == withReload ? false : true;
                parent.tiny.box.hide();
                if (withReload) {
                    parent.location.reload();
                }
            }

            function setInputDateSearcOnLoad(obj) {
                alert(obj.val());
            }

            $(function () {
                var actionGridLength = $("#tbl-grid td.grid-btn-action").children().length;
                if (actionGridLength > 3) {
                    $("#tbl-grid td.grid-btn-action, #tbl-grid th.grid-btn-action").css("min-width", "90px");
                } else if (actionGridLength < 1) {
                    $("#tbl-grid td.grid-btn-action, #tbl-grid th.grid-btn-action").css("min-width", "30px");
                } else {

                }


                //FORMAT NUMBER
                var numFormat = {prefix: "",
                    thousandsSeparator: '.',
                    centsLimit: 0,
                    clearPrefix: true};
                var moneyFormat = {prefix: "",
                    thousandsSeparator: '.',
                    centsSeparator: ',',
                    centsLimit: 2,
                    clearPrefix: true};
                $(".elm-num").priceFormat(numFormat);

                //replace 
                $("form").submit(function (e) {
//                    e.preventDefault();
                    $(".elm-num").each(function () {
                        $(this).val($(this).unmask());
                    });

                });

                //Error Msg
                $("#divErrorMsg").change(function () {
                    $(this).hide();
                    $(this).show(450);
                }).change();

                $(document).ajaxStart(function () {
                    $('#loading_img').show();
                });

                $(document).ajaxComplete(function () {
                    $('#loading_img').hide();
                });


                if ($("#tbl-grid").width() > $("#tbl-grid").parent().width()) {
                    $("#tbl-grid").parent().css("overflow-x", "scroll");
                }

                //Grid Table
                $("#tbl-grid").dataTable({
                    "bPaginate": false,
                    "bLengthChange": false,
                    "bFilter": false,
                    "bSort": false,
                    "bInfo": false,
                    "scrollX": true
                });

                var d = new Date();

                var currDate = d.getDate();
                var currMonth = d.getMonth();
                var currYear = d.getFullYear();

                var dateStr = currDate + "-" + currMonth + "-" + currYear;

                $(".elm-date").parent(".input-group").css("width", "165px");
                $(".elm-date").each(function () {
                    var elm = $(this);
                    if (elm.val() == '') {
                        elm.val('<?php echo date("d/m/Y") ?>');
                    }
                });

                $(".elm-date").datepicker({
                    format: "dd/mm/yyyy",
                    autoclose: true
                }).on('show', function () {
                    var dp = $(this);
                    if (dp.val() == '') {
                        dp.val('<?php echo date("d/m/Y") ?>').datepicker('update');
                    }
                });

                $(".elm-date-month").parent(".input-group").css("width", "165px");
                $(".elm-date-month").datepicker({
                    format: "mm-yyyy",
                    viewMode: "months",
                    minViewMode: "months",
                    autoclose: true
                }).on('show', function () {
                    var dp = $(this);
                    if (dp.val() == '') {
                        dp.val('<?php echo date("m-Y") ?>').datepicker('update');
                    }
                });

                function setDateRangeValue(start, end, label) {
                    var startDate = moment(start);
                    var endDate = moment(end);
                    console.log("lala");
                    $('.elm-date-range').val(startDate.format('DD/MM/YYYY') + ' - ' + endDate.format('DD/MM/YYYY'));
                }
                $('.elm-date-range').daterangepicker(
                {
                    locale: {
                        format: 'DD/MM/YYYY'
                    },
                    "showDropdowns": true,
                },setDateRangeValue
                );
            
                

                $("input.form-control").keyup(function () {
                    var parent = $(this).parent();
                    var lbl = parent.children("label").attr("for", $(this).attr("id"));
                    var elm_i = lbl.children("i");
                    if (Boolean($(this)[0].checkValidity) && (!$(this)[0].checkValidity())) {
                        parent.addClass("has-error");
                        lbl.css("color", "#333333");
                        elm_i.addClass("fa-warning");
                        elm_i.html("<span class=\"text-red\">&nbsp;&nbsp;Input tidak sesuai dengan format yang diharapkan !!!</span>");
                        elm_i.css("color", "#F39C12");
                    } else {
                        parent.removeClass("has-error");
                        lbl.css("color", "#333333");
                        elm_i.removeClass("fa-warning");
                        elm_i.html("");
                        elm_i.css("color", "#F39C12");
                    }
                });

                $('#formHris').find('input').each(function () {
                    var parent = $(this).parent();
                    var lbl = parent.children("label").attr("for", $(this).attr("id"));
                    var elm_i = lbl.children("i");
                    if ($(this).prop('required')) {
                        parent.removeClass("has-error");
                        lbl.css("color", "#333333");
                        elm_i.removeClass("fa-warning");
                        elm_i.html("");
                        elm_i.css("color", "#F39C12");
                    }
                });

                $('textarea[maxlength]').change(function () {
                    hitungChar($(this));
                }).change();

                $('textarea[maxlength]').keyup(function (e) {
                    hitungChar($(this));
                });

                // Selectize Overide
                Selectize.define('selectable_placeholder', function (options) {
                    var self = this;

                    options = $.extend({
                        placeholder: self.settings.placeholder,
                        html: function (data) {
                            return (
                                    '<div class="selectize-dropdown-content placeholder-container">' +
                                    '<div data-selectable class="option">' + data.placeholder + '</div>' +
                                    '</div>');
                        }
                    }, options);

                    // override the setup method to add an extra "click" handler
                    self.setup = (function () {
                        var original = self.setup;
                        return function () {
                            original.apply(this, arguments);
                            self.$placeholder_container = $(options.html(options));
                            self.$dropdown.prepend(self.$placeholder_container);
                            self.$dropdown.on('click', '.placeholder-container', function () {
                                self.setValue('');
                                self.close();
                                self.blur();
                            });
                        };
                    })();

                });

                $('.elm-select-selectize').selectize({
                    create: false,
                    createOnBlur: false,
                    dropdownParent: 'body',
                    plugins: {
                        'selectable_placeholder': {}
                    },
                    selectedField: "selected"
                });


                $(".sortTable").click(function (e) {
                    e.preventDefault();
                    var currSort = $(this).data("sort");
                    var currOrder = $(this).data("order");

                    if ('desc' == currOrder) {
                        currOrder = 'asc';
                    } else if ('asc' == currOrder) {
                        currOrder = 'desc';
                    } else {
                        currOrder = 'asc';
                    }

                    var str = window.location.search;

                    str = replaceQueryParam('sort', currSort, str);
                    str = replaceQueryParam('order', currOrder, str);

                    window.location = window.location.pathname + str;
                });


                $('.grid-row-btn').each(function (idx, elm) {
                    var isConfirm = $(elm).data("confirm");
                    if (isConfirm) {
                        var action = $(elm).prop("onclick");
                        $(this).prop("onclick", null);
                        $(this).bind("click", function () {
                            var msg = $(this).data("msg");
                            var cnfrm = false;
                            bootbox.confirm(msg, function (result) {
                                if (result) {
                                    action.apply();
                                } else {
                                    return true;
                                }
                            });
                        });
                    }
                });

                $('[data-confirm="true"]').click(function (e) {
                    e.preventDefault();
                    if (!$(this).hasClass('grid-row-btn')) {
                        var uri = $(this).attr("href");
                        var action = $(this).prop("onclick");
                        var msg = $(this).data("msg");
                        var isSubmit = $(this).hasClass('submitFormBtn');
                        bootbox.confirm(msg, function (result) {
                            if (result) {
                                if (isSubmit) {
                                    $("#formBBLK").append('<input type="hidden" name="save" value="Simpan">');
                                    $("#formBBLK").submit();
                                } else {
                                    window.location = uri;
                                }
                            } else {
                                return true;
                            }
                        });
                    }

                });

                $("#btnAddSearch").click(function (e) {
                    e.preventDefault();
                    var objToClone = $("#frmSearch").children(":last").prev();
                    var objCloned = objToClone.clone(true);
                    objCloned.find(".srcOperan").val("");
                    objCloned.find(".srcCari").val("");
                    objCloned.insertAfter(objToClone);
                });




<?php
if (isset($additional_script)) {
    echo $additional_script;
}
if (isset($additional_script2)) {
    echo $additional_script2;
}
?>


            });

            function replaceQueryParam(param, newval, search) {
                var regex = new RegExp("([?;&])" + param + "[^&;]*[;&]?")
                var query = search.replace(regex, "$1").replace(/&$/, '')
                return (query.length > 2 ? query + "&" : "?") + param + "=" + newval
            }

            function hitungChar(obj) {
                var text = $(obj).val();
                var enters = text.split(/\r|\r\n|\n/);
                var enterCount = enters.length - 1;

                var temp = $(obj).val().replace(/\n/g, '');
                var textLen = (enterCount * 2) + temp.length;
                var charRemaining = 0;

                //console.log(temp.length);
                var max = parseInt($(obj).attr('maxlength'));
                if (max > 0) {
                    if (textLen > max) {
                        $(this).val($(obj).val().substr(0, $(obj).attr('maxlength')));
                    } else {
                        charRemaining = max - textLen;
                    }

                    $(obj).parent().find('.charsRemaining').html('You have ' + charRemaining + ' characters remaining');
                }
            }
        </script>
    </body>
</html>