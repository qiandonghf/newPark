<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<base href="<%=BaseAction.rootLocation %>/"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
				initForm();
			});
			function getCalendarScrollTop(){
				return $("#scrollDiv").scrollTop();
			}
			
			function initForm(){
				$("#form1").validate({
					rules: {
						"investmentDirector.name":"required"
					},
					messages: {
						"investmentDirector.name":"请输入姓名"
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
					        		setTimeout("getOpener().location.reload();parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>
		<style>
			table{
				table-layout:fixed;
			}
			#inline_table td{
				height:24px;
			}
		</style>
	</head>

<body style="padding-bottom: 2px;">
	<form action="<%=basePath %>investment!legalUpdate.action" method="post" name="form1" id="form1">
		<input type="hidden" name="investmentDirector.id" value="${result.value.id }"/>
		<div class="basediv">
		<div class="divlays" style="margin:0px;">
		<div>
			<div class="apptable" style="border-top:none; border-left:none;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  				<tr>
				        <td class="layertdleft120"><span class="psred">*</span>姓名：</td>
				        <td class="layerright">
				          <input value="${result.value.name }" name="investmentDirector.name" type="text" class="inputauto" />
				        </td>
				        <td class="layertdleft120">出生年月：</td>
				        <td class="layerright">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="birthday" name="investmentDirector.birthDay" value='<fmt:formatDate value="${result.value.birthDay }" pattern="yyyy-MM-dd" />' onclick="showCalendar('birthday');" readonly="readonly" class="inputauto" /></td>
									<td width="30"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('birthday');"/></td>
								</tr>
							</table>  
						</td>
				     </tr>
				     <tr>
				        <td class="layertdleft120">性别：</td>
				        <td class="layerright">
				        	<enum:radio name="investmentDirector.gender" checked="result.value.gender" type="com.wiiy.commons.preferences.enums.GenderEnum"/>
						</td>
				        <td class="layertdleft120">文化程度：</td>
				        <td class="layerright">
				        	<dd:select checked="result.value.degreeId" key="crm.0015" name="investmentDirector.degreeId"/>
				        </td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">政治面目：</td>
				        <td class="layerright">
				        	<dd:select checked="result.value.politicalId" name="investmentDirector.politicalId" key="crm.0029" />
				        </td>
				        <td class="layertdleft120">技术职称：</td>
				        <td class="layerright"><input value="${result.value.profession }" name="investmentDirector.profession" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">企业名称：</td>
				        <td class="layerright"><input name="investmentDirector.customer" value="${result.value.customer }" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">担任职务：</td>
				        <td class="layerright"><input name="investmentDirector.position" value="${result.value.position }" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">原工作单位：</td>
				        <td class="layerright"><input name="investmentDirector.original" value="${result.value.original }" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">离职方式：</td>
				        <td class="layerright"><input name="investmentDirector.leaveBy" value="${result.value.leaveBy }" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">家庭住址：</td>
				        <td colspan="3" class="layerright"><input name="investmentDirector.address" value="${result.value.address }" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">主要学历<br/>（获得何种学位）</td>
				        <td colspan="3" class="layerright" style="padding-bottom:1px;">
				          <textarea class="inputauto" name="investmentDirector.specialty" style="height:50px;resize:none;">${result.value.specialty }</textarea>
				        </td>
				        </tr>
				        <tr>
				        <td class="layertdleft120">工作简历<br/>（有何发明、论著，获得何种奖励）</td>
				        <td colspan="3" class="layerright" style="padding-bottom:1px;">
				          <textarea class="inputauto" name="investmentDirector.resume" style="height:70px;resize:none;">${result.value.resume }</textarea>
				        </td>
				        </tr>
	  			</table>
			</div>
		</div>
	</div>
	</div>
	<div class="buttondiv" style="margin-top:10px;">
		<label><input name="Submit" type="submit" class="savebtn" value=" " /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
	</div>
	</form>
</body>
</html>
