<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
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
			rules:{
				"sealApply.applicant":"required",
				"sealApply.applyTime":"required",
				"sealApply.name":"required",
				"sealApply.cnt":"number",
				"sealApply.content":"required"
			},
			messages: {
				"sealApply.applicant":"请填写姓名",
				"sealApply.applyTime":"请选择申请日期",
				"sealApply.name":"请填写用印名称",
				"sealApply.cnt":"请正确填写用印数量",
				"sealApply.content":"请填写申请内容"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function toSubmit(){
		if(!$("#sealType").val()){
			showTip("请选择印章类型");
			return false;
		}
		if(!$("#status").val()){
			showTip("请选择审批结果");
			return false;
		}
		if(!$("#memo").val()){
			showTip("请输入审批意见");
			return false;
		}
		$.post("<%=basePath%>sealApproval!update.action",{"sealApproval.id":$("#id").val(),"sealApproval.sealType":$("#sealType").val(),"sealApproval.status":$("#status").val(),"sealApproval.memo":$("#memo").val()},function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
        	}
		});
	}
	function approval(){
		fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
	}
	function setSelectedUser(user){
		$.post("<%=basePath%>sealApply!configApproval.action",{id:'${result.value.applyId}',approverId:user.id,ids:user.realName},function(data){
			showTip(data.result.msg,2000);
		});
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>sealApproval!update.action">
<input type="hidden" value="${result.value.id}" id="id" name="sealApproval.id"/>
<div class="basediv" style="border:none;height:370px;overflow-y: auto">
		<table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2"  style=" border-right:none; text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;"><h2 style="text-align:center; padding-top:5px;font-size:14px;">用印审批</h2></td>
			</tr>
			<tr>
				<td class="layertdleftblack">姓名：</td>
				<td class="oatabletdright">${result.value.apply.applicant}</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请日期：</td>
				<td class="oatabletdright"><fmt:formatDate value="${result.value.apply.applyTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请项目：</td>
				<td  class="oatabletdright">${result.value.apply.project}</td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印名称：</td>
				<td class="oatabletdright">${result.value.apply.name}</td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印数量：</td>
				<td  class="oatabletdright">${result.value.apply.cnt}</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请内容：</td>
				<td  class="oatabletdright" style="padding:2px 5px;">
					<div style="width:620; border:none; height:50px; color:#333;line-height:22px;">${result.value.apply.content}</div>
				</td>
			</tr>
		</table>
		<c:forEach items="${sealApprovalList}" var="sealApproval">
		<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td  class="layertdleftblack">审批人：</td>
				<td class="oatabletdright" width="200">${sealApproval.approver}</td>
				<td  class="layertdleftblack">审批时间：</td>
				<td class="oatabletdright"><fmt:formatDate value="${sealApproval.modifyTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td class="layertdleftblack">审批意见：</td>
				<td class="oatabletdright" colspan="3"><div style="width:620; border:none; height:50px; color:#333;line-height:22px;">${sealApproval.status.title}</div></td>
			</tr>
		</table>
		</c:forEach>
		<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td  class="layertdleftblack">审批人：</td>
				<td class="oatabletdright" width="200"><%=OaActivator.getSessionUser(request).getRealName() %></td>
				<td  class="layertdleftblack">审批时间：</td>
				<td class="oatabletdright"><%=DateUtil.format(new Date(),"yyyy-MM-dd HH:mm") %></td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印类型：</td>
				<td class="oatabletdright" style="padding:2px 5px;"><enum:select id="sealType" checked="result.value.sealType" type="com.wiiy.oa.preferences.enums.SealTypeEnum" name="sealApproval.sealType" /></td>
				<td class="layertdleftblack">审批结果：</td>
				<td class="oatabletdright"><enum:select id="status" checked="result.value.status" type="com.wiiy.oa.preferences.enums.SealApprovalStatusEnum" name="sealApproval.status" /></td>
			</tr>
			<tr>
				<td class="layertdleftblack">审批意见：</td>
				<td class="oatabletdright" colspan="3"><textarea id="memo" name="sealApproval.memo" class="textareaauto" style=" height:50px;">${result.value.memo}</textarea></td>
			</tr>
		</table>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="savebtn" value="" onclick="toSubmit()"/></label>
		<label><input name="Submit" type="button" class="" value="送审" onclick="approval()"/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
	</div>
</form>
</body>
</html>