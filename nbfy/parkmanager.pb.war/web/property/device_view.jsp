<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initMaintenanceList();
		initPatrolList();
		initYearlyList();
		initDeviceWorkOrderList();
	});
	
	
	function initMaintenanceList(){
		var width = $(".textname").width();
		var maintenanceId = ${result.value.id};
		$("#maintenanceList").jqGrid({
	    	url:'<%=basePath%>deviceMaintenance!list.action?id='+maintenanceId,
			colModel: [
				{label:'档案编号', name:'number',width:100, align:"center"}, 
				{label:'上次保养时间', name:'lastTime', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'计划保养时间', name:'planTime', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'检查项目', name:'plan',width:100, align:"center"},
			    {label:'维护工时', name:'manHour',width:100, align:"center"},
			    {label:'维护方式', name:'maintenanceMode',width:100, align:"center"},
			    {label:'维护日期', name:'maintenanceTime',width:100, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'维护人', name:'maintenanceMan',width:100, align:"center"},
			    {label:'维护效果', name:'maintenanceEffect', align:"center",hidden:true},
			    {label:'维护过程', name:'process', align:"center",hidden:true},
			    {label:'维护内容', name:'content', align:"center",hidden:true},
			    {label:'备注', name:'memo', align:"center",hidden:true},
			    {label:'管理', name:'manager',width:100, align:"center", resizable:false,sortable:false}
			],
			height: 80,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:1px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备维护','deviceMaintenance','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备维护','deviceMaintenance','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('maintenanceList','deviceMaintenance','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function initPatrolList(){
		var width = $(".textname").width();
		var maintenanceId = ${result.value.id};
		$("#patrolList").jqGrid({
	    	url:'<%=basePath%>devicePatrol!list.action?id='+maintenanceId,
			colModel: [
				{label:'操作人员', name:'operator', align:"center"}, 
				{label:'巡检日期', name:'operationDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'巡检时间', name:'operationTime', align:"center"},
				{label:'检查人', name:'inspector', align:"center"},
			    {label:'检查结果', name:'memo', align:"center"},
			    {label:'创建人', name:'creator', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 80,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:1px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备巡检','devicePatrol','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备巡检','devicePatrol','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('patrolList','devicePatrol','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function initYearlyList(){
		var width = $(".textname").width();
		var maintenanceId = ${result.value.id};
		$("#yearlyList").jqGrid({
	    	url:'<%=basePath%>deviceYearly!list.action?id='+maintenanceId,
			colModel: [
				{label:'年检日期', name:'operationDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'年检单位', name:'unitName', align:"center"},
				{label:'操作人员', name:'operator', align:"center"},
			    {label:'年检结果', name:'yearlyResults', align:"center"},
			    {label:'备注', name:'memo', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 80,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:1px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备年检','deviceYearly','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备年检','deviceYearly','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('yearlyList','deviceYearly','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function initDeviceWorkOrderList(){
		var width = $(".textname").width();
		var maintenanceId = ${result.value.id};
		$("#deviceWorkOrderList").jqGrid({
	    	url:'<%=basePath%>deviceWorkOrder!list.action?id='+maintenanceId,
			colModel: [
				{label:'维修部位', name:'repairParts', align:"center"},
				{label:'开始日期', name:'startDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'结束日期', name:'endDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'维修人员', name:'repairStaff', align:"center"},
			    {label:'维修负责人', name:'head', align:"center"},
			    {label:'制单人', name:'tabulator', align:"center"},
			    {label:'维修内容', name:'repairContent', align:"center"},
			    {label:'更换部件', name:'repairComponents', align:"center",hidden:true},
			    {label:'备注', name:'memo', align:"center",hidden:true},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 80,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:1px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('维修派工单','deviceWorkOrder','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('维修派工单','deviceWorkOrder','"+id+"');\"  /> "; 
					//content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('deviceWorkOrderList','deviceWorkOrder','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function viewById(fbName,actionName,id){
		fbStart(fbName,'<%=basePath %>'+actionName+'!view.action?id='+id,600,311);
	}
</script>

<style>
	.layerright{
		word-break:break-all;
	}
	.layertdleft100{
		white-space:nowrap;
		width:12%;
	}
</style>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
	<div id="scrollDiv" style=" overflow:hidden; position:relative;">			
	<div class="basediv">
		<!-- <div class="titlebg">设备基本信息</div> -->
		<div class="divlays" class="pm_view_right" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">设备名称：</td>
					<td class="layerright" width="21%">${result.value.name}</td>
					<td class="layertdleft100">设备编号：</td>
					<td class="layerright" width="21%">${result.value.number}</td>
					<td class="layertdleft100">设备规格：</td>
					<td class="layerright" width="21%">${result.value.specifications}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备型号：</td>
					<td class="layerright">${result.value.type}</td>
					<td class="layertdleft100"><span class="psred"></span>制造厂商：</td>
					<td class="layerright">${result.value.manufacturer}</td>
					<td class="layertdleft100"><span class="psred"></span>出厂编号：</td>
					<td class="layerright">${result.value.serialNumber}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>使用单位：</td>
					<td class="layerright">${result.value.department}</td>
					<td class="layertdleft100"><span class="psred"></span>部门编号：</td>
					<td class="layerright">${result.value.departmentNumber}</td>
					<td class="layertdleft100"><span class="psred"></span>使用地点：</td>
					<td class="layerright">${result.value.location}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>制造日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.manufacturingDate}" pattern="yyyy-MM-dd"/></td>
					<td class="layertdleft100"><span class="psred"></span>使用日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.usedDate}" pattern="yyyy-MM-dd"/></td>
					<td class="layertdleft100"><span class="psred"></span>设备类别：</td>
					<td class="layerright">${result.value.category}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备状态：</td>
					<td class="layerright">${result.value.status.title}</td>
					<td class="layertdleft100"><span class="psred"></span>设备级别：</td>
					<td class="layerright">${result.value.level}</td>
					<td class="layertdleft100"><span class="psred"></span>复杂系数：</td>
					<td class="layerright"><fmt:formatNumber value="${result.value.degree}" pattern="#0.0"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>巡检间隔：</td>
					<td class="layerright">${result.value.patrolInterval}&nbsp;${result.value.patrolIntervalType.title}</td>
					<td class="layertdleft100"><span class="psred"></span>巡检日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.patrolTime}" pattern="yyyy-MM-dd"/></td>
					<%-- <td class="layertdleft100"><span class="psred"></span>年检间隔：</td>
					<td class="layerright">${result.value.yearlyInterval}</td> --%>
					<td class="layertdleft100"><span class="psred"></span>年检日期：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.yearlyTime}" pattern="yyyy-MM-dd"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备原值：</td>
					<td class="layerright"><fmt:formatNumber value="${result.value.cost}" pattern="#0.00"/></td>
					<td class="layertdleft100"><span class="psred"></span>折旧年限：</td>
					<td class="layerright">${result.value.depreciationYear}</td>
					<td class="layertdleft100"><span class="psred"></span>外形尺寸：</td>
					<td class="layerright">${result.value.size}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备重量：</td>
					<td class="layerright">${result.value.weight}</td>
					<td class="layertdleft100"><span class="psred"></span>数控设备：</td>
					<td class="layerright">${result.value.isCNC.title}</td>
					<td class="layertdleft100"><span class="psred"></span>进口设备：</td>
					<td class="layerright">${result.value.isImported.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td colspan="5" class="layerright"><div style="height: 40px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.remarks}</div></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div style="height:140px;overflow:hidden;">
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">设备维护</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">设备巡检</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">设备年检</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">维修派工单</li>
			</ul>
		</div>
		<div style="margin-top:0px;">
			<!-- 设备维护 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;">
				<table id="maintenanceList"><tr><td></td></tr></table>
			</div>
			<!-- 设备巡检 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<table id="patrolList"><tr><td></td></tr></table>
			</div>
			<!-- 设备年检 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<table id="yearlyList"><tr><td></td></tr></table>
			</div>
			<!-- 维修派工单 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<table id="deviceWorkOrderList"><tr><td></td></tr></table>
			</div>
		</div>
	</div>
	<!-- <div class="buttondiv" style="margin-top:3px;">
		<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div> -->
</div>
</form>
</body>
</html>