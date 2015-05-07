<%@page import="com.wiiy.web.listener.InitListener"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=InitListener.webParam.getName() %></title>
	<!---样式---->
		<jsp:include page="style.jsp"></jsp:include>
	<!---样式结束----> 
	<script type="text/javascript">
		$(function(){
			$(".tb").css("cursor","pointer");
		});
		function login(){
			checkLoginForm();
			$('#loginForm').ajaxSubmit({
				success:function(result, statusText) {
					if (result.success) {
						if("${type}" == 'third'){
							location.href="<%=BaseAction.rootLocation %>index.action?type=${type}";
						}else{
							location.href="<%=BaseAction.rootLocation %>/core/index.action";
						}
					} else {
				    	alert(result.msg);
					}
				}});
			return false;
		}
		function checkLoginForm(){
			if($("#userName").val()==null || $("#userName").val().replace(/(^\s*)|(\s*$)/g, "")==''){
				alert("用户名不能为空");
				return;
			}
			if($("#pwd").val()==null || $("#pwd").val().replace(/(^\s*)|(\s*$)/g, "")==''){
				alert("密码不能为空");
				return;
			}
		}
		
		function keyHandle(event,num){
			if(num == 1){
				if (event.keyCode == 13){
					$('#pwd').focus();
				}
			}else if(num == 2){
				if (event.keyCode == 13){
					login();
				}
			}else
				return;
		}
		
		function changeLogin(num,obj){
			$(".tb").removeClass("bb");
			$(".tb").addClass("aa");
			$(obj).removeClass("aa");
			$(obj).addClass("bb");
			var txt = "企业用户登录";
			var type = "OTHER";
			switch(num){
				case 1:
					txt = "企业用户登录";
					type = "CUSTOMER";
					break;
				case 2:
					txt = "创业导师登录";
					break;
				case 3:
					txt = "投资机构登录";
					break;
			}
			$("#userType").val(type);
			$("#tbc_01 .title").text(txt);
		}
	</script>
</head>
<body >
	<!---顶部开始---->
		<jsp:include page="header.jsp"></jsp:include>
	<!---顶部结束----> 

	<!---导航开始---->
		<jsp:include page="navi.jsp"></jsp:include>
	<!---导航结束----> 

	<!---主体内容开始---->
	<div id="main" style="padding-top:80px; padding-bottom:60px;">
	  <div class="loginpic"> <img src="images/leftpic.gif" width="367" height="294" /></div>
	  <div class="wrapper">
	    <div class="lfloat">
	      <ul id="tab_left">
	        <li class="bb tb" id="tb_1" onclick="changeLogin(1,this);">企业登录</li>
	        <li class="aa tb" id="tb_2" onclick="changeLogin(2,this);">创业导师登录</li>
	        <li class="aa tb" id="tb_3" onclick="changeLogin(3,this);">投资机构登录</li>
	      </ul>
	    </div>
	    <div class="rfloat">
	      <div id="newinfo">
	        <div class="ctt list2">
	          <div class="dis" id="tbc_01"> 
				<form id="loginForm" action="<%=BaseAction.rootLocation %>/core/login!login.action" method="post">
		          <input name="userType" type="hidden" id="userType" value="CUSTOMER"/>
		          <ul>
			          <li class="title">企业用户登录</li>
			          <li class="text"><strong>登录名：</strong></li>
			          <li class="input"><input id="userName" onkeydown="keyHandle(event,1)" name="user.username" type="text" /></li>
			          <li class="text"><strong>密码： </strong></li>
			          <li class="input"><input id="pwd" type="password" onkeydown="keyHandle(event,2)" name="user.password" type="text" /></li>
			          <li class="but"><input onclick="login();" name="" type="button" class="but_login" value="登  录"/></li>
			          <li class="" style="text-align:right;"><span>联系电话：0571-88218885</span></li>
		          </ul>
		         </form>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	  
	    <div class="hackbox"></div>
	</div>
	<!-- <script type="text/javascript" language="javascript">
	//<!cdata[
	function g(o){return document.getElementById(o);}
	function hoverli(n){
	for(var i=1;i<=3;i++){g('tb_'+i).className='aa';g('tbc_0'+i).className='undis';}g('tbc_0'+n).className='list2';g('tb_'+n).className='bb';
	}
	function fun(){
	hoverli(3);
	}
	function hoverli2(n){
	for(var i=1;i<=3;i++){g('js_'+i).className='aa';g('jsc_0'+i).className='undis';}g('jsc_0'+n).className='list2';g('js_'+n).className='bb';
	}
	function fun2(){
	hoverli2(3);
	}
	function hoverli3(n){
	for(var i=1;i<=3;i++){g('be_'+i).className='aa';g('bec_0'+i).className='undis';}g('bec_0'+n).className='list2';g('be_'+n).className='bb';
	}
	function fun3(){
	hoverli2(3);
	}
	
	//如果要做成点击后再转到请将<li>中的onmouseover 改成 onclick;
	//]]>
	</script>  -->
	<!---主体内结束----> 
	<!---底部开始---->
		<jsp:include page="footer.jsp"></jsp:include>
	<!---底部结束----> 
</body>
</html>