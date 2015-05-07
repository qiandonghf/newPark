<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.wiiy.commons.action.BaseAction"%>
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
<title>网站管理</title>

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
	<div class="logo"><img src="web/image/logo.jpg" height="45"/></div>
	<div class="quickmenu"><a href="http://www.zjuspnb.com" target="_blank">首页</a><a href="http://www.zjuspnb.com/lxwm.php">帮助</a></div>
</div>
<!--content-->
<div id="content">
	<div class="loginmain">
		<div class="loginborder">
			<div class="logintab">
				<ul>
					<li class="active">用户账号</li>
					<!--<li class="link">协会账号</li> -->
					<li class="link"></li>
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
<div id="footer">
	<div id="footerdiv">
		<div id="footerleft"><img src="core/common/images/downpng.png" /></div>
		<div id="footerlink"><a href="http://www.sanlue.com.cn/web/sanlue/about.html">关于三略</a><a href="http://www.sanlue.com.cn/web/sanlue/contact.html">联系我们</a><a href="http://www.sanlue.com.cn/web/sanlue/copyright.html">版权声明</a>| &nbsp;&nbsp;Copyright © 2010-2012 sanlue.com All Rights Reserved</div>
		<div class="copyright"></div>
	</div>
</div>
</body>
</html>
