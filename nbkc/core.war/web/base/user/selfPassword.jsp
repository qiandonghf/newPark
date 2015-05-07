<%--@elvariable id="enums" type="java.util.Map<String, Map<String, String>>"--%>
<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	initTip();
	$('#passwordForm').submit(function(e) {
		e.preventDefault();
		if ($("#newPassword").val() != $("#newPasswordConfirm").val()) {
			$("#newPassword").focus();
			alert("新密码不一致！请重输！");
			return false;
		}
		$(this).ajaxSubmit(
				{
					success:
						function(result, statusText) {
							if (result.success) {
								fb.end();
								showTip(result.msg, 2000);
							} else {
								showTip(result.msg, 2000);
							}
						}
				}
		);
		return false;
	});
});

</script>
</head>

<body>
<form id="passwordForm" name="passwordForm" method="post" action="${contextLocation}self!passwordResetDone.action">
<input type="hidden" name="user.id" value="${user.id}" />
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft">用户名：</td>
      <td><label>${user.username}</label></td>
    </tr>
    <tr>
      <td class="layertdleft">旧密码：</td>
      <td><label>
      <input name="oldPassword" type="password" class="input200" />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft">新密码：</td>
      <td><input id="newPassword" name="newPassword" type="password" class="input200" /></td>
    </tr>
    <tr>
    	<td class="layertdleft">确认新密码：</td>
    	<td><input id="newPasswordConfirm" name="newPasswordConfirm" type="password" class="input200" /></td>
    	</tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label>
  <input name="Submit" type="submit" class="savebtn" value="" />
  </label>
  <input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/>
</div>
</form>
</body>
</html>
