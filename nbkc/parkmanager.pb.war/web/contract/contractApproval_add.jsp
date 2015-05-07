<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
		$(function(){
			initTip();
		});
		function checkForm(){
			if(notNull("memo","内容")){
				$("#form1").ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadContractApprovalList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		}
	</script>
</head>

<body>
<form action="<%=basePath %>contractApproval!save.action" method="post" name="form1" id="form1">
	<input type="hidden" id="contractId" name="contractApproval.contractId" value="${param.id}"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">审批结果：</td>
					<td class="layerright"><enum:select name="contractApproval.state" type="com.wiiy.crm.preferences.enums.ContractApprovalStateEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">审批意见：</td>
					<td class="layerright"><textarea id="memo" name="contractApproval.memo" rows="7" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>
