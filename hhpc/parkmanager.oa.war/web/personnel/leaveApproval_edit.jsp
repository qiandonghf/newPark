<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
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
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	 $(function(){
		initTip();
	}); 
	 
	 function toSubmit(){
			if(!$("#status").val()){
				showTip("请选择审批结果");
				return false;
			}
			if(!$("#memo").val() || $("#memo").val()==""){
				showTip("请输入审批意见");
				return false;
			}
			$.post("<%=basePath%>leaveApproval!update.action",{"leaveApproval.id":$("#id").val(),"leaveApproval.status":$("#status").val(),"leaveApproval.memo":$("#memo").val()},function(data){
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
		$.post("<%=basePath%>leaveApproval!approve.action",{applyId:'${leaveApproval.applyId}',approverId:user.id,approver:user.realName},function(data){
			showTip("送审成功",2000);
		});
	}
</script>	 
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>leaveApproval!update.action">
<input type="hidden" name="leaveApproval.id" value="${leaveApproval.id}" id="id"/>
	<!--basediv-->
	<div class="basediv" style="border:none;">
		<table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2"  style=" border-right:none; text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;"><h2 style="text-align:center; padding-top:5px;font-size:14px;">请假单</h2></td>
			</tr>
			<tr>
				<td class="layertdleftblack">姓名：</td>
				<td class="oatabletdright">${leaveApproval.apply.applicant}</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请日期：</td>
				<td class="oatabletdright">
			   		<fmt:formatDate value="${leaveApproval.apply.applyTime}" pattern="yyyy-MM-dd"/>
			    </td>
			</tr>
			<tr>
				<td class="layertdleftblack">假别：</td>
				<td  class="oatabletdright">
					&nbsp;${leaveApproval.apply.leaveType.title}
				</td>
			</tr>
			<tr>
				<td class="layertdleftblack">请假时间：</td>
				<td class="oatabletdright">
					<fmt:formatDate value="${leaveApproval.apply.startTime}" pattern="yyyy-MM-dd HH:mm"/>
					至
					 <fmt:formatDate value="${leaveApproval.apply.endTime}" pattern="yyyy-MM-dd HH:mm"/>
					 <c:if test="${day<=1 && day>0.5}">
					 	共1天 
					 </c:if>
					  <c:if test="${day<=0.5 && day>0}">
						共半天 
					 </c:if>
					 <c:if test="${day>1}">
						共${day}天 
					 </c:if>
				</td>
			</tr>
			<tr>
				<td class="layertdleftblack">请假原因：</td>
				<td  class="oatabletdright" style="padding:2px 5px;">
				<div style="width:620; border:none; height:50px; color:#333;line-height:22px;">
					${leaveApproval.apply.memo}
				</div>				
			</td>
			</tr>
		</table>
		<c:forEach items="${leaveApprovalList}" var="list">
			<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td  class="layertdleftblack">审批人：</td>
					<td class="oatabletdright" width="200">
						${list.approver}
					</td>
					<td  class="layertdleftblack">审批时间：</td>
					<td class="oatabletdright">
						<fmt:formatDate value="${list.modifyTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
				<tr>
					<td class="layertdleftblack">审批意见：</td>
					<td class="oatabletdright" colspan="3">
						<div style="width:620; border:none; height:50px; color:#333;line-height:22px;">
						${list.memo}
						</div>
					</td>
				</tr>
			</table>
		</c:forEach>
		<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td  class="layertdleftblack">审批人：</td>
					<td class="oatabletdright" width="200">
						${leaveApproval.approver}
					</td>
					<td  class="layertdleftblack">审批时间：</td>
					<td class="oatabletdright">
						<%=DateUtil.format(new Date(),"yyyy-MM-dd HH:mm")%>
					</td>
				</tr>
				<tr>
					<td class="layertdleftblack"><span class="psred">*</span>审批结果：</td>
					<td class="oatabletdright"><enum:select id="status" checked="leaveApproval.status" type="com.wiiy.oa.preferences.enums.LeaveApprovalStatusEnum" name="leaveApproval.status" /></td>
				</tr>
				<tr>
					<td class="layertdleftblack"><span class="psred">*</span>审批意见：</td>
					<td class="oatabletdright" colspan="3">
						<textarea id="memo" name="leaveApproval.memo" class="textareaauto" style=" height:50px;">${leaveApproval.memo}</textarea>
					</td>
				</tr>
			</table>
		
	</div>
	<!--//basediv-->
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="savebtn" value="" onclick="toSubmit()"/></label>
		<label><input name="Submit" type="button" style="width: 70px;" class="" value="送审" onclick="approval()"/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
	</div>
</form>
</body>
</html>
