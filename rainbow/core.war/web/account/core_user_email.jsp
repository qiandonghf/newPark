<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
	});
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"userEmailParam.email":"required",
				"userEmailParam.passwd":"required",
				"userEmailParam.nickName":"required",
				"userEmailParam.pop3":"required",
				"userEmailParam.smtp":"required"
			},
			messages: {
				"userEmailParam.email":"请输入Email地址",
				"userEmailParam.passwd":"请输入邮箱密码",
				"userEmailParam.nickName":"请输入发信昵称",
				"userEmailParam.pop3":"请输入收取邮件的IMAP服务器",
				"userEmailParam.smtp":"请输入发送邮件的SMTP服务器"
				
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
			        	if(data.result.success){
		        			showTip(data.result.msg+",请重新登录",2000);
			        	}else{
			        		showTip(data.result.msg,2000);
			        	}
		        		/* if(data.result.success){
							setTimeout(function(){
						 		var src = "core/userEmailParam!emailByUserId.action";
				        		parent.reloadButton(src);
							},2000);
				     	} */
			        } 
			    });
			}
		});
	}
</script>
</head>

<body>
<form action="<%=basePath %>userEmailParam!saveOrUpdate.action" id="form1" name="form1" method="post" >
<input type="hidden" name="userEmailParam.id" value="${result.value.id}"/>
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="layertitle" style="height:27px; line-height:27px;">邮箱设置</div>
	<!--//titlebg-->
	<!--divlay-->
	<div class="divlays">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          	<td width="360"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft" style="width:150px;">您的其它邮箱：</td>
					<td><label>
						<input name="userEmailParam.email" type="text" class="input200" value="${result.value.email}"/>
					</label></td>
				</tr>
				<tr>
					<td class="layertdleft" style="width:150px;">邮箱密码：</td>
					<td class="layerright"><input name="userEmailParam.passwd" type="password" class="input100" value="${result.value.passwd}"/></td>
				</tr>
				<tr>
				  <td class="layertdleft" style="width:150px;">发信昵称：</td>
				  <td class="layerright"><input name="userEmailParam.nickName" type="text" class="input100" value="${result.value.nickName}"/></td>
			 	</tr>
				<tr>
					<td class="layertdleft" style="width:150px;">收取邮件的IMAP服务器：</td>
					<td><input name="userEmailParam.pop3" type="text" class="input200" value="${result.value.pop3}"/></td>
				</tr>
				<tr>
					<td class="layertdleft" style="width:150px;">发送邮件的SMTP服务器：</td>
					<td><input name="userEmailParam.smtp" type="text" class="input200" value="${result.value.smtp}"/></td>
				</tr>
			</table></td>
       	</tr>
      </table>
	</div>
	 <!--titlebg-->
    <div class="hackbox"></div>
</div>
<!--//basediv-->

<div style=" text-align:left; padding-left:105px;">
  <label><input name="Submit" type="submit" class="savebtn" value=""/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="form1.reset();"/></label>
</div>
</form>
</body>
</html>
