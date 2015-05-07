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
<title>科技园区信息管理系统</title>
<link href="core/common/style/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	});
function login(){
	if($("#message-span").html()!="您的试用帐号已过期" && $("#message-span").html()!="邮箱不正确"){
		$.ajax({ 
	        type: "post", 
	        data:{
	       	  "user.username":$("#name").val(),
	          "user.password":$("#pwd").val(),
	          "userType":     $("#userType").val()
	       	  },
	        url: "<%=basePath %>login!login.action", 
	        dataType: "json", 
	        success: function (data) { 
	                //alert(data.message);
	                location.href="<%=basePath%>index.action";
	                //alert($("#email_span").html(data.message));
	        }, 
	        error: function (XMLHttpRequest, textStatus, errorThrown) { 
	                alert(errorThrown); 
	        } 
	     });
	}
}
function loginYG(){
	if($("#message-span").html()!="您的试用帐号已过期" && $("#message-span").html()!="邮箱不正确"){
		$.ajax({ 
	        type: "post", 
	        data:{
	       	  "user.username":$("#name2").val(),
	          "user.password":$("#pwd2").val(),
	          "userType":     $("#userType2").val()
	       	  },
	        url: "<%=basePath %>login!login.action", 
	        dataType: "json", 
	        success: function (data) { 
	                //alert(data.message);
	                location.href="<%=basePath%>index.action";
	                //alert($("#email_span").html(data.message));
	        }, 
	        error: function (XMLHttpRequest, textStatus, errorThrown) { 
	                alert(errorThrown); 
	        } 
	     });
	}	
}
function loginWuYe(){
	if($("#message-span").html()!="您的试用帐号已过期" && $("#message-span").html()!="邮箱不正确"){
		$.ajax({ 
	        type: "post", 
	        data:{
	       	  "user.username":$("#name3").val(),
	          "user.password":$("#pwd3").val(),
	          "userType":     $("#userType3").val()
	       	  },
	        url: "<%=basePath %>login!login.action", 
	        dataType: "json", 
	        success: function (data) { 
	                //alert(data.message);
	                location.href="<%=basePath%>index.action";
	                //alert($("#email_span").html(data.message));
	        }, 
	        error: function (XMLHttpRequest, textStatus, errorThrown) { 
	                alert(errorThrown); 
	        } 
	     });
	}	
}
	
function loginKeHu(){
	if($("#message-span").html()!="您的试用帐号已过期" && $("#message-span").html()!="邮箱不正确"){
		$.ajax({ 
	        type: "post", 
	        data:{
	       	  "user.username":$("#name4").val(),
	          "user.password":$("#pwd4").val(),
	          "userType":     $("#userType4").val()
	       	  },
	        url: "<%=basePath %>login!login.action", 
	        dataType: "json", 
	        success: function (data) { 
	                //alert(data.message);
	                location.href="<%=basePath%>index.action";
	                //alert($("#email_span").html(data.message));
	        }, 
	        error: function (XMLHttpRequest, textStatus, errorThrown) { 
	                alert(errorThrown); 
	        } 
	     });
	}		
}
</script>
</head>

<body>
<div class="logindiv">
	<div class="logo"><img src="core/common/images/loginlogo.png" /></div>
	<div class="quickmenu"><a href="http://www.sanlue.com.cn/web/sanlue/index.html">首页</a><a href="javascript:void(0)">帮助</a></div>
</div>
<!--content-->
<div id="content">
	<div class="loginmain">
		<div class="loginborder2">
			
			<div class="">
            <li style="margin-left: 25px;padding-top:10px;">${message}</li>
			<ul class="role-list">
            	<li class="">
                	<div class="role">
                        <img src="core/common/images/role1.gif" class="img" />
                        <div class="info">
                            <h2>园区领导</h2>
                            
                            <div>完整记录客户历史信息，随随时可以进行调用随时可以进行调用随时随时</div>
              <form id="loginForm" method="post" action="<%=basePath %>login!login.action" style="display: none">				
				<ul>
					<li><input name="user.username" id="name" type="hidden" class="inputlink" value="officeManager"   onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
					<li><input name="user.password" id="pwd" type="hidden" class="inputlink" value="123456" onkeydown="keyHandle(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}"/></li>
					<!-- <li><label><input name="autoLogin" type="checkbox" class="checkbox" value="true" />两周内自动登录</label></li> -->
					<input name="userType" type="hidden" id="userType" value="CENTER"/>
					<li>
					</li>
				</ul>		
				 
			</form>
                     <a  title="" style="cursor:pointer;" class="btn-ty" onclick="javascript:login();" >立即进入</a>     		 
                        </div>
                    </div>
                </li>
                <li class="">
                	<div class="role">
                        <img src="core/common/images/role2.gif" class="img" />
                        <div class="info">
                            <h2>园区工作人员</h2>
                            
                            <div>完整记录客户历史信息，随随时可以进行调用随时可以进行调用随时随时</div>
                            <form id="loginForm2" method="post" action="<%=basePath %>login!login.action" style="display: none">				
								<ul>
									<li><input name="user.username" id="name2" type="hidden" class="inputlink" value="YG"   onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
									<li><input name="user.password" id="pwd2" type="hidden" class="inputlink" value="123456" onkeydown="keyHandle(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}"/></li>
									<!-- <li><label><input name="autoLogin" type="checkbox" class="checkbox" value="true" />两周内自动登录</label></li> -->
									<input name="userType" type="hidden" id="userType2" value="CENTER"/>
									<li>
									</li>
								</ul>		
								 
							</form>
                            <a  title="" style="cursor:pointer;" class="btn-ty" onclick="javascript:loginYG();">立即进入</a>
                        </div>
                    </div>
                </li>
                <li class="">
                	<div class="role">
                        <img src="core/common/images/role3.gif" class="img" />
                        <div class="info">
                            <h2>园区物业管理</h2>
                            
                            <div>完整记录客户历史信息，随随时可以进行调用随时可以进行调用随时随时</div>
                            <form id="loginForm2" method="post" action="<%=basePath %>login!login.action" style="display: none">				
								<ul>
									<li><input name="user.username" id="name3" type="hidden" class="inputlink" value="WuYe"   onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
									<li><input name="user.password" id="pwd3" type="hidden" class="inputlink" value="123456" onkeydown="keyHandle(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}"/></li>
									<!-- <li><label><input name="autoLogin" type="checkbox" class="checkbox" value="true" />两周内自动登录</label></li> -->
									<input name="userType" type="hidden" id="userType3" value="CENTER"/>
									<li>
									</li>
								</ul>		
								 
							</form>
                            <a  title="" style="cursor:pointer;" class="btn-ty" onclick="loginWuYe()">立即进入</a>
                        </div>
                    </div>
                </li>
                <li class="">
                	<div class="role">
                        <img src="core/common/images/role4.gif" class="img" />
                        <div class="info">
                            <h2>园区客户</h2>
                            
                            <div>完整记录客户历史信息，随随时可以进行调用随时可以进行调用随时随时</div>
                            <form id="loginForm2" method="post" action="<%=basePath %>login!login.action" style="display: none">				
								<ul>
									<li><input name="user.username" id="name4" type="hidden" class="inputlink" value="KeHu"   onkeydown="keyHandle1(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}" /></li>
									<li><input name="user.password" id="pwd4" type="hidden" class="inputlink" value="123456" onkeydown="keyHandle(event)" onfocus="this.className='inputactive';if(this.value==this.defaultValue){this.value=''}"  onblur="this.className='inputlink';if(this.value==''){this.value=this.defaultValue}"/></li>
									<!-- <li><label><input name="autoLogin" type="checkbox" class="checkbox" value="true" />两周内自动登录</label></li> -->
									<input name="userType" type="hidden" id="userType4" value="Customer"/>
									<li>
									</li>
								</ul>		
								 
							</form>
                            <a title="" style="cursor:pointer;" class="btn-ty" onclick="loginKeHu()">立即进入</a>
                        </div>
                    </div>
                </li>
            </ul>
			


			<!--logindown-->
			
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
