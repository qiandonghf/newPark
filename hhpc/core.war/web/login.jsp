<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<title>杭州高新区科技创业服务中心</title>

<link href="core/common/style/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var type = "${type}";
		if(type == 'third'){
			$("#userType").val("OTHER");
		}else{
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
		}
	});
	function keyHandle(event){
		
		if (event.keyCode == 13)    {login();}
	}
	function keyHandle1(event){
		
		if (event.keyCode == 13)    {$('#pwd').focus();}
	}
	function login(){
		if($("#userName").val()==null || $("#userName").val().replace(/(^\s*)|(\s*$)/g, "")==''){
			alert("用户名不能为空");
			return;
		}
		if($("#pwd").val()==null || $("#pwd").val().replace(/(^\s*)|(\s*$)/g, "")==''){
			alert("密码不能为空");
			return;
		}
		$('#loginForm').ajaxSubmit({
			success:function(result, statusText) {
				if (result.success) {
					if("${type}" == 'third'){
						location.href="<%=basePath%>index.action?type=${type}";
					}else{
						location.href="<%=basePath%>index.action";
					}
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
	<div class="logoinfo">
		<div class="logo" style="padding-top:12px;"><img height="63" src="core/common/images/web_logo.gif" /></div>
		<div class="quickmenu"><a href="http://www.hhpc.gov.cn/" target="_blank">首页</a><a href="easy.action?type=contact">帮助</a></div>
	</div>
</div>
<!--content-->
<div id="content">
	<div class="loginmain">
		<div class="loginborder">
			<div class="logintab">
				<ul>
					<li class="active" style="margin-left: 80px; margin-top: 10px;font-size:20px;">用户登录</li>
				</ul>
			</div>
			<div class="longdiv">
			<!--loginlist-->
			<div class="loginlist">
			<form id="loginForm" name="loginForm" method="post" action="<%=basePath %>login!login.action">				
				<ul>
					<li><input name="user.username" id="userName" type="text" class="inputlink" value=""  onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
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
		<div id="footerleft" style="padding-top:9px;width:auto;"></div>
		<div id="footerlink"><a href="/view.action?categoryId=8">中心介绍</a><a href="base.action?type=north&categoryId=46">江北基地</a><a href="base.action?type=nursery&categoryId=49">创业苗圃</a>| &nbsp;&nbsp;Copyright © 2009 - 2010 www.hhpc.gov.cn Inc. All Rights Reserve</div>
		<div class="copyright"></div>
	</div>
</div>
</body>
</html>
