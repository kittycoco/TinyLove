<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>网站后台管理系统 </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="../assets/css/ace.min.css"/>
    <link rel="stylesheet" href="../assets/css/ace-rtl.min.css"/>
    <link rel="stylesheet" href="../assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="../css/style.css"/>
    <script src="../assets/js/ace-extra.min.js"></script>
    <script src="../js/jquery-1.9.1.min.js"></script>
    <script src="../assets/js/bootstrap.min.js"></script>
    <script src="../assets/js/typeahead-bs2.min.js"></script>
    <script src="../assets/js/ace-elements.min.js"></script>
    <script src="../assets/js/ace.min.js"></script>
    <script src="../assets/layer/layer.js" type="text/javascript"></script>
    <script src="../assets/laydate/laydate.js" type="text/javascript"></script>
    <script type="text/javascript">
        if ("ontouchend" in document) {
            document.write("<script src='../assets/js/jquery.mobile.custom.min.js'>"+"<" + "/script>");
        }
        $(function () {
            var cid = $('#nav_list> li>.submenu');
            cid.each(function (i) {
                $(this).attr('id', "Sort_link_" + i);
            })
        })
        jQuery(document).ready(function () {
            $.each($(".submenu"), function () {
                var $aobjs = $(this).children("li");
                var rowCount = $aobjs.size();
                var divHeigth = $(this).height();
                $aobjs.height(divHeigth / rowCount);
            });
            //初始化宽度、高度
            $("#main-container").height($(window).height() - 76);
            $("#iframe").height($(window).height() - 140);

            $(".sidebar").height($(window).height() - 99);
            var thisHeight = $("#nav_list").height($(window).outerHeight() - 173);
            $(".submenu").height();
            $("#nav_list").children(".submenu").css("height", thisHeight);

            //当文档窗口发生改变时 触发
            $(window).resize(function () {
                $("#main-container").height($(window).height() - 76);
                $("#iframe").height($(window).height() - 140);
                $(".sidebar").height($(window).height() - 99);

                var thisHeight = $("#nav_list").height($(window).outerHeight() - 173);
                $(".submenu").height();
                $("#nav_list").children(".submenu").css("height", thisHeight);
            });
            $(".iframeurl").click(function () {
                var cid = $(this).attr("name");
                var cname = $(this).attr("title");
                $("#iframe").attr("src", cid).ready();
                $("#Bcrumbs").attr("href", cid).ready();
                $(".Current_page a").attr('href', cid).ready();
                $(".Current_page").attr('name', cid);
                $(".Current_page").html(cname).css({
                    "color": "#333333",
                    "cursor": "default"
                }).ready();
                $("#parentIframe").html('<span class="parentIframe iframeurl"> </span>').css("display", "none").ready();
                $("#parentIfour").html('').css("display", "none").ready();
            });
        });

        /*********************点击事件*********************/
        $(document).ready(function () {
            $('#nav_list').find('li.home').click(function () {
                $('#nav_list').find('li.home').removeClass('active');
                $(this).addClass('active');
            });

            //时间设置
            function currentTime() {
                var d = new Date(),
                    str = '';
                str += d.getFullYear() + '年';
                str += d.getMonth() + 1 + '月';
                str += d.getDate() + '日';
                str += d.getHours() + '时';
                str += d.getMinutes() + '分';
                str += d.getSeconds() + '秒';
                return str;
            }

            setInterval(function () {
                $('#time').html(currentTime)
            }, 1000);

            $('#Exit_system').on('click', function () {
                layer.confirm('是否确定退出系统？', {
                        btn: ['是', '否'], //按钮
                        icon: 2,
                    },function () {
                        $.ajax({
                            type:"DELETE",
                            url:"../vim.vi/logout.vi?vim=${vim.userName}",
                            success:function (json) {
                                if(json.state==4){
                                    layer.alert(json.message,{
                                        icon:1,
                                        title:"微爱提示",
                                        end : function(){
                                            location.href="../login.jsp";
                                        }
                                    });
                                }
                            }
                        });
                    });
            });
        })
    </script>
</head>
<body>
<div class="navbar navbar-default" id="navbar">
    <script type="text/javascript">
        try {
            ace.settings.check('navbar', 'fixed')
        } catch (e) {
        }
    </script>
    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="#" class="navbar-brand">
                <small>
                    <img src="../images/logo.png">
                </small>
            </a><!-- /.brand -->
        </div><!-- /.navbar-header -->
        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li class="light-blue">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <span class="time"><em id="time"></em></span><span class="user-info">
                        <small>欢迎回来</small>${vim.userName}</span>
                        <i class="icon-caret-down"></i>
                    </a>
                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li><a href="#"><i class="icon-cog"></i>设置</a></li>
                        <li><a href="manager_info.jsp"><i class="icon-user"></i>个人资料</a></li>
                        <li class="divider"></li>
                        <li><a href="javascript:void(0)" id="Exit_system"><i class="icon-off"></i>退出</a></li>
                    </ul>
                </li>
                <li class="purple">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-bell-alt"></i><span
                            class="badge badge-important">8</span></a>
                    <ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
                        <li class="dropdown-header"><i class="icon-warning-sign"></i>8条通知</li>
                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												新闻评论
											</span>
                                    <span class="pull-right badge badge-info">+12</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <i class="btn btn-xs btn-primary icon-user"></i>
                                切换为编辑登录..
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success icon-shopping-cart"></i>
												新订单
											</span>
                                    <span class="pull-right badge badge-success">+8</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info icon-twitter"></i>
												粉丝
											</span>
                                    <span class="pull-right badge badge-info">+11</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                查看所有通知
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>
    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text">123456</span>
        </a>
        <div class="sidebar" id="sidebar">
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'fixed')
                } catch (e) {
                }
            </script>
            <div class="sidebar-shortcuts" id="sidebar-shortcuts">
                <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                    网站后台管理系统
                </div>
                <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                    <span class="btn btn-success"></span>
                    <span class="btn btn-info"></span>
                    <span class="btn btn-warning"></span>
                    <span class="btn btn-danger"></span>
                </div>
            </div><!-- #sidebar-shortcuts -->
            <ul class="nav nav-list" id="nav_list">
                <li class="home"><a href="javascript:void(0)" name="home.jsp" class="iframeurl" title=""><i
                        class="icon-dashboard"></i><span
                        class="menu-text"> 系统首页 </span></a></li>
                <li><a href="#" class="dropdown-toggle"><i class="icon-desktop"></i><span
                        class="menu-text"> 产品管理 </span><b class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="Products_List.html" title="产品类表"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>产品类表</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Brand_Manage.html" title="品牌管理"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>品牌管理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Category_Manage.html" title="分类管理"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>分类管理</a></li>

                    </ul>
                </li>
                <li>
                    <a href="#" class="dropdown-toggle"><i class="icon-picture "></i><span
                            class="menu-text"> 图片管理 </span><b class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="advertising.html" title="广告管理"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>广告管理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Sort_ads.html" title="分类管理"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>分类管理</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="dropdown-toggle"><i class="icon-list"></i><span class="menu-text"> 交易管理 </span><b
                            class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="transaction.html" title="交易信息"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>交易信息</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Orderform.html" title="订单管理"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>订单管理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Amounts.html" title="交易金额"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>交易金额</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Order_handling.html" title="订单处理"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>订单处理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Cover_management.html" title="支付管理"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>支付管理</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" class="dropdown-toggle"><i class="icon-user"></i><span class="menu-text"> 会员管理 </span><b
                            class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="user_list.html" title="会员列表"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>会员列表</a></li>
                        <li class="home"><a href="javascript:void(0)" name="member-Grading.html" title="等级管理"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>等级管理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="integration.html" title="会员记录管理"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>会员记录管理</a></li>

                    </ul>
                </li>
                <li><a href="#" class="dropdown-toggle"><i class="icon-edit"></i><span class="menu-text"> 消息管理 </span><b
                        class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="Guestbook.html" title="留言列表"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>留言列表</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Feedback.html" title="意见反馈"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>意见反馈</a></li>
                    </ul>
                </li>
                <li><a href="#" class="dropdown-toggle"><i class="icon-edit"></i><span class="menu-text"> 文章管理 </span><b
                        class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="Guestbook.html" title="文章列表"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>文章列表</a></li>
                        <li class="home"><a href="javascript:void(0)" name="Feedback.html" title="分类分类"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>分类分类</a></li>
                    </ul>
                </li>
                <li><a href="#" class="dropdown-toggle"><i class="icon-cogs"></i><span class="menu-text"> 系统管理 </span><b
                        class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">
                        <li class="home"><a href="javascript:void(0)" name="Systems.html" title="系统设置"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>系统设置</a></li>
                        <li class="home"><a href="javascript:void(0)" name="菜单管理.html" title="栏目管理" class="iframeurl"><i
                                class="icon-double-angle-right"></i>栏目管理</a></li>

                        <li class="home"><a href="javascript:void(0)" name="用户管理.html" title="系统日志" class="iframeurl"><i
                                class="icon-double-angle-right"></i>系统日志</a></li>
                    </ul>
                </li>
                <li><a href="#" class="dropdown-toggle"><i class="icon-group"></i><span class="menu-text"> 管理员管理 </span><b
                        class="arrow icon-angle-down"></b></a>
                    <ul class="submenu">

                        <li class="home"><a href="javascript:void(0)" name="admin_Competence.html" title="权限管理"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>权限管理</a></li>
                        <li class="home"><a href="javascript:void(0)" name="administrator.html" title="管理员列表"
                                            class="iframeurl"><i
                                class="icon-double-angle-right"></i>管理员列表</a></li>
                        <li class="home"><a href="javascript:void(0)" name="manager_info.jsp" title="个人信息"
                                            class="iframeurl"><i class="icon-double-angle-right"></i>个人信息</a></li>
                    </ul>
                </li>
            </ul>
            <div class="sidebar-collapse" id="sidebar-collapse">
                <i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
                   data-icon2="icon-double-angle-right"></i>
            </div>
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'collapsed')
                } catch (e) {
                }
            </script>
        </div>
        <div class="main-content">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>
            <div class="breadcrumbs" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <a href="#">首页</a>
                    </li>
                    <li class="active"><span class="Current_page iframeurl"></span></li>
                    <li class="active" id="parentIframe"><span class="parentIframe iframeurl"></span></li>
                    <li class="active" id="parentIfour"><span class="parentIfour iframeurl"></span></li>
                </ul>
            </div>

            <iframe id="iframe" style="border:0; width:100%; background-color:#FFF;" name="iframe" frameborder="0"
                    src="manager_info.jsp">
            </iframe>


            <!-- /.page-content -->
        </div><!-- /.main-content -->

        <div class="ace-settings-container" id="ace-settings-container">
            <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                <i class="icon-cog bigger-150"></i>
            </div>

            <div class="ace-settings-box" id="ace-settings-box">
                <div>
                    <div class="pull-left">
                        <select id="skin-colorpicker" class="hide">
                            <option data-skin="default" value="#438EB9">#438EB9</option>
                            <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                            <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                            <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                        </select>
                    </div>
                    <span>&nbsp; 选择皮肤</span>
                </div>
                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar"/>
                    <label class="lbl" for="ace-settings-sidebar"> 固定滑动条</label>
                </div>
                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl"/>
                    <label class="lbl" for="ace-settings-rtl">切换到左边</label>
                </div>
                <div>
                    <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container"/>
                    <label class="lbl" for="ace-settings-add-container">
                        切换窄屏
                        <b></b>
                    </label>
                </div>
            </div>
        </div><!-- /#ace-settings-container -->
    </div><!-- /.main-container-inner -->
</div>
<!--底部样式-->
<div class="footer_style" id="footerstyle">
    <p class="l_f">版权所有：南京四美软件 苏ICP备11011739号</p>
    <p class="r_f">地址：南京市鼓楼区阅江楼街道公共路64号 邮编：210011 技术支持：XXXX</p>
</div>
<!-- /.main-container -->
<!-- basic scripts -->
</body>
</html>
