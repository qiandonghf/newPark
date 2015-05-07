<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区经理V1.02</title>

<link href="core/common/style/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".logintab li").each(function(index){
			$(".logintab li").eq(index).click(function(){
				/* if(index==1){
				$(".logintab li").removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("link1");
				$(".logintab li").eq(index).removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("active1");
				document.getElementById("userType").value='ASSOCIATION';
				} */
				if(index==1){
					$(".logintab li").removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("link1");
					$(".logintab li").eq(index).removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("active");
					document.getElementById("userType").value='CUSTOMER';
				}
				else if(index==0){
					$(".logintab li").removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("link");
					$(".logintab li").eq(index).removeClass("link").removeClass("link1").removeClass("active").removeClass("active1").addClass("active");
					document.getElementById("userType").value='CENTER';
				}
				//$(".longdiv").css({display:"none"});
				//$(".longdiv").eq(index).css({display:"block"});
			});
		});
	});
	function keyHandle(event){
		
		if (event.keyCode == 13)    {login();}
	}
	function keyHandle1(event){
		
		if (event.keyCode == 13)    {$('#pwd').focus();}
	}
	function login(){
		
		$('#loginForm').ajaxSubmit({
			success:function(result, statusText) {
				if (result.success) {
			    	location.href="<%=basePath%>index.action";
				} else {
			    	//$("<span color='red'>"+result.msg+"</div>").appendTo($(".loginborder"));
			    	alert(result.msg);
				}
			}});
		return false;
		
	}
</script>
</head>

<body>
<div class="logindiv">
	<div class="logo"><img src="core/common/images/loginlogo_zjuspnb.png" /></div>
	<div class="quickmenu"><a href="http://www.zjuspnb.com" target="_blank">首页</a><a href="http://www.zjuspnb.com/lxwm.php">帮助</a></div>
</div>
<!--content-->
<div id="content">
	<div class="loginmain">
		<div class="loginborder">
			<div class="logintab">
				<ul>
					<li class="active">中心账号</li>
					<!--<li class="link">协会账号</li> -->
					<li class="link">企业账号</li>
				</ul>
			</div>
			<div class="longdiv">
			<!--loginlist-->
			<div class="loginlist">
			<form id="loginForm" name="loginForm" method="post" action="<%=basePath %>login!login.action">				
				<ul>
					<li><input name="user.username" type="text" class="inputlink" value=""  onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
					<li><input name="user.password" id="pwd" type="password" class="inputlink" value="" onkeydown="keyHandle(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}"/></li>
					<!-- <li><label><input name="autoLogin" type="checkbox" class="checkbox" value="true" />两周内自动登录</label></li> -->
					<li>
					<input name="userType" type="hidden" id="userType" value="CENTER"/>
					<input name="" type="button" onclick="login()" class="loginbtn" onmouseover="this.className='loginbtnover'" onmouseout="this.className='loginbtn'" value="登  录" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="" type="button" class="logincancel" value="取  消" />
					</li>
				</ul>
			</form>
			</div>
			<!--//loginlist-->
			<!--logindown-->
			<div class="logindown">
				<ul>
					<li><a href="#">·全新园区办公自动化管理</a></li>
					<li>·<a href="#">聚集创新资源，体验创新服务</a></li>
				</ul>
			</div>
			<!--//logindown-->
			</div>
			
			
			
			
		</div>
	</div>
</div>
<!--//content-->
<!-- <div class="footerlink"><a href="javascript:void(0)">中国科技创业计划大赛 火热进行中...</a></div> -->
<div class="footerlink"><a href="javascript:void(0)">中国科技创业计划大赛 火热进行中...</a></div>
<div id="footer">
	<div id="footerdiv">
		<div id="footerleft"><img src="core/common/images/downpng_zjuspnb.gif" /></div>
		<div id="footerlink"><a href="http://www.zjuspnb.com/index.php?action=about" target="_blank">关于我们</a><a href="http://www.zjuspnb.com/index.php?action=news" target="_blank">新闻中心</a><a href="http://www.zjuspnb.com/index.php?action=settled" target="_blank">入驻指南</a><a href="http://www.zjuspnb.com/index.php?action=services" target="_blank">服务体系</a><a href="http://www.zjuspnb.com/index.php?action=culture" target="_blank">分园文化</a> | &nbsp;&nbsp;<a href="http://www.sanlue.com.cn" target="_blank">www.sanlue.com.cn</a> © 1997-2012</div>
		<div class="copyright"></div>
	</div>
</div>
</body>
</html>
