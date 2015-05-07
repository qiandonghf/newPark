<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
	});
	function exp(){
		var report = $("#report").val();
		var type = $("#type").val();
		var year = $("#year").val();
		var week = $("#weekSelect").val();
		var month = $("#monthSelect").val();
		if(report==''){
			showTip("请选择导出报表",2000);
			return;
		}
		if(type==''){
			showTip("请选择导出数据",2000);
			return;
		}
		if(report=='week'){
			if(year=='' || week==''){
				showTip("请选择时间",2000);
				return;
			}
		}
		if(report=='month'){
			if(year=='' || month==''){
				showTip("请选择时间",2000);
				return;
			}
		}
		$("#exportForm").submit();
		setTimeout("fb.end();", 2000);
	}
	
	function selectType(type){
		var year = $("#year").val();
		if(type=='week'){
			if(year!=''){
				$("#month").attr("style","display:none");
				$("#week").attr("style","display:block");
				$.post("<%=basePath%>workReport!loadWeekByYear.action?year="+year, function(data) {	
					if (data.result.success) {
						var list = data.result.value;
						var contectId = $("#weekSelect");
						contectId.empty();
						contectId.append($("<option></option>", {value : ""}).append("--请选择--"));
						for ( var i = 0; i < list.length; i++) {
							var contect = list[i];
							contectId.append($("<option></option>", {value : contect}).append(contect));
						}
					}
				});
				
			}
		}
		if(type=='month'){
			$("#week").attr("style","display:none");
			$("#month").attr("style","display:block");
		}
	}
	
	
	function selectTimeType(){
		var report = $("#report").val();
		var year = $("#year").val();
		if(report==''){
			return;
		}
		if(report=='week'){
			$("#month").attr("style","display:none");
			$("#week").attr("style","display:block");
			$.post("<%=basePath%>workReport!loadWeekByYear.action?year="+year, function(data) {	
				if (data.result.success) {
					var list = data.result.value;
					var contectId = $("#weekSelect");
					contectId.empty();
					contectId.append($("<option></option>", {value : ""}).append("--请选择--"));
					for ( var i = 0; i < list.length; i++) {
						var contect = list[i];
						contectId.append($("<option></option>", {value : contect}).append(contect));
					}
				}
			});
		}
		if(report=='month'){
			$("#week").attr("style","display:none");
			$("#month").attr("style","display:block");
		}
	}
</script>
</head>

<body>
<form action="<%=basePath %>workReport!personExport.action" method="post" name="exportForm" id="exportForm">
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>请选择报表：</td>
				<td class="layerright">
					<select id="report" onchange="selectType(this.value);" name="report">
						<option value="">--请选择--</option>
						<option value="week">周报</option>
						<option value="month">月报</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>请选择数据：</td>
				<td class="layerright">
					<select id="type" name="type">
						<option value="">--请选择--</option>
						<option value="task">工作任务</option>
						<option value="plan">工作计划</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>请选择时间：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<select onchange="selectTimeType();" id="year" name="year">
									<option value="">--请选择--</option>
									<c:forEach var="year" items="${yearList}">
										<option value="${year}">${year}&nbsp;</option>
									</c:forEach>
								</select>&nbsp;年
							</td>
							<td id="week" style="display: none;">
								<select id="weekSelect" name="weekSelect">
									<option>--请选择--</option>
									<option>工作任务</option>
									<option>工作计划</option>
								</select>&nbsp;周
							</td>
							<td id="month" style="display: none;">
								<select id="monthSelect" name="monthSelect">
									<option value="">--请选择--</option>
									<c:forEach  items="${yearList}" varStatus="s" end="11">
										<option value="${s.index+1}">${s.index+1}</option>
									</c:forEach>
								</select>&nbsp;月
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
	<label><input name="Submit" type="button" class="allbtn"  value="导出" onclick="exp();"/></label>
</div>
</form>
</body>
</html>
