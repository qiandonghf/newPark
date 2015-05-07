<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
				initForm();
			});
			function initForm(){
				$("#form1").validate({
					rules: {
						"investmentLog.linkMan":"required",
						"investmentLog.userName":"required",
						"investmentLog.linkTime":"required",
						"investmentLog.content":"required"
					},
					messages: {
						"investmentLog.linkMan":"请输入项目方联系人",
						"investmentLog.userName":"请输入招商人员",
						"investmentLog.linkTime":"请输入时间",
						"investmentLog.content":"请输入内容"
					},
					errorPlacement: function(error, element){
						showTip(error.html());
					},
					submitHandler: function(form){
						$(form).ajaxSubmit({
					        dataType: 'json',		        
					        success: function(data){
				        		showTip(data.result.msg,2000);
					        	if(data.result.success){
					        		setTimeout(function(){
						        		try{
							        		getOpener().frames[0].location.reload();
						        		} catch(e){
						        			parent.refresh();
						        		}
						        		parent.fb.end();
					        		},2000);
					        	}
					        } 
					    });
					}
				});
			}
			function setSelectedUser(user){
				$("#username").val(user.realName);
				$("#userId").val(user.id);
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>investmentLog!update.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.id}" name="investmentLog.id"/>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>项目名称：</td>
						<td class="layerright">${result.value.investment.name}</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>项目方联系人：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="200"><input name="investmentLog.linkMan" type="text" class="inputauto" value="${result.value.linkMan}"/></td>
									<td width="25" align="center">&nbsp;</td>
									<td align="center">&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>招商人员：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="200"><input id="username" name="investmentLog.userName" readonly="readonly" type="text" class="inputauto" value="${result.value.userName}"/><input value="${result.value.userId}" id="userId" name="investmentLog.userId" type="hidden" class="inputauto" /></td>
									<td width="25"><img style="position: relative;left:-1px;" onclick="fbStart('选择联系人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
									<td align="center">&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>时间：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="200"><input id="linkTime" name="investmentLog.linkTime" value="<fmt:formatDate value="${result.value.linkTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('linkTime')"/></td>
									<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('linkTime')"/></td>
									<td align="center">&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>内容：</td>
						<td class="layerright"><textarea name="investmentLog.content" style="height:150px;" class="textareaauto">${result.value.content}</textarea></td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div class="buttondiv">
			<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
			<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
		</div>
	</form>
	</body>
</html>

