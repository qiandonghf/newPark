<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		initForm();
		initMaintenanceList();
	});
	
	/*
		让日期选择框向上居中
	*/
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"deviceManagement.name":"required",
			},
			messages: {
				"deviceManagement.name":"请输入设备名称"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(check() == true){
					$('#form1').ajaxSubmit({ 
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		$(".tabheader").show();
				        		$("#deviceId").val(data.deviceManagement.id);
				        		$("#deviceMaintenance").show();
				        		initPatrolList();
				        		initYearlyList();
				        		initDeviceWorkOrderList();
				        		getOpener().location.reload();
				        	}
				        } 
				    });
				}
			}
		});
	}
	
	function check(){
		var type = $("#patrolIntervalType").val();
		var interval = $("#patrolInterval").val();
		if(type != ''){
			if(interval == ''){
				$("#patrolInterval").focus();
				showTip("请输入巡检间隔",2000);
				return false;
			}
		}else{
			if(interval != ''){
				$("#patrolIntervalType").focus();
				showTip("请选择巡检间隔类型",2000);
				return false;
			}
		}
		return true;
	}
	
	function initMaintenanceList(){
		var width = $(".textname").width();
		$("#maintenanceList").jqGrid({
	    	url:'<%=basePath%>deviceMaintenance!list.action?id=0',
			colModel: [
				{label:'档案编号', name:'number', align:"center"}, 
				{label:'上次保养时间', name:'lastTime', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'计划保养时间', name:'planTime', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'检查项目', name:'plan', align:"center"},
			    {label:'维护工时', name:'manHour', align:"center"},
			    {label:'维护方式', name:'maintenanceMode', align:"center"},
			    {label:'维护日期', name:'maintenanceTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'维护人', name:'maintenanceMan', align:"center"},
			    {label:'维护效果', name:'maintenanceEffect', align:"center",hidden:true},
			    {label:'维护过程', name:'process', align:"center",hidden:true},
			    {label:'维护内容', name:'content', align:"center",hidden:true},
			    {label:'备注', name:'memo', align:"center",hidden:true},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 120,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:4px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备维护','deviceMaintenance','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备维护','deviceMaintenance','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('maintenanceList','deviceMaintenance','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	
	function initPatrolList(){
		var width = $(".textname").width();
		$("#patrolList").jqGrid({
	    	url:'<%=basePath%>devicePatrol!list.action?id=0',
			colModel: [
				{label:'操作人员', name:'operator', align:"center"}, 
				{label:'巡检日期', name:'operationDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'巡检时间', name:'operationTime', align:"center"},
				{label:'检查人', name:'inspector', align:"center"},
			    {label:'检查结果', name:'memo', align:"center"},
			    {label:'创建人', name:'creator', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 100,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:4px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备巡检','devicePatrol','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备巡检','devicePatrol','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('patrolList','devicePatrol','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function initYearlyList(){
		var width = $(".textname").width();
		$("#yearlyList").jqGrid({
	    	url:'<%=basePath%>deviceYearly!list.action?id=0',
			colModel: [
				{label:'年检日期', name:'operationDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'年检单位', name:'unitName', align:"center"},
				{label:'操作人员', name:'operator', align:"center"},
			    {label:'年检结果', name:'yearlyResults', align:"center"},
			    {label:'备注', name:'memo', align:"center"},
			    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false}
			],
			height: 100,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:4px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('设备年检','deviceYearly','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('设备年检','deviceYearly','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('yearlyList','deviceYearly','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function initDeviceWorkOrderList(){
		var width = $(".textname").width();
		$("#deviceWorkOrderList").jqGrid({
	    	url:'<%=basePath%>deviceWorkOrder!list.action?id=0',
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
			height: 100,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:4px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('维修派工单','deviceWorkOrder','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('维修派工单','deviceWorkOrder','"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('deviceWorkOrderList','deviceWorkOrder','"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function viewById(fbName,actionName,id,height){
		if(height == undefined)
			height = 311;
		fbStart(fbName,'<%=basePath %>'+actionName+'!view.action?id='+id,600,311);
	}
	function editById(fbName,actionName,id){
		fbStart(fbName,'<%=basePath %>'+actionName+'!edit.action?id='+id,600,311);
	}
	
	//cssId:html标签中的id
	function deleteById(cssId,actionName,id){
		if(confirm("确定要删吗")){
			$.post('<%=basePath%>'+actionName+'!delete.action?id='+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadInitList(cssId,actionName);
	        	}
			});
		}
	}
	
	//id:html标签的id
	function deleteByIds(actionName,id){
		var ids = $("#"+id).jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post('<%=basePath%>'+actionName+'!delete.action?ids='+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadInitList(id,actionName);
	        	}
			});
		}else if(ids =='')
			showTip("请先选择要删除的项");
	}
	//cssId:html标签中的id
	function reloadInitList(cssId,actionName){
		var id = $("#deviceId").val();
		$("#"+cssId).setGridParam({url:'<%=basePath%>'+actionName+'!list.action?id='+id}).trigger('reloadGrid');
	}
	
</script>
</head>

<body>
<form action="<%=basePath %>deviceManagement!saveOrUpdate.action" method="post" name="form1" id="form1">
	<input id="deviceId" value="${result.value.id}" name="deviceManagement.id" type="hidden"/>
	<div id="scrollDiv" style=" overflow:hidden; position:relative;">			
	<div class="basediv">
		<!-- <div class="titlebg">设备基本信息</div> -->
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>设备名称：</td>
					<td width="22%" class="layerright"><input id="name" name="deviceManagement.name" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>设备编号：</td>
					<td width="22%" class="layerright"><input id="code" name="deviceManagement.number" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>设备规格：</td>
					<td width="22%" class="layerright"><input id="code" name="deviceManagement.specifications" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备型号：</td>
					<td class="layerright"><input id="name" name="deviceManagement.type" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>制造厂商：</td>
					<td class="layerright"><input id="code" name="deviceManagement.manufacturer" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>出厂编号：</td>
					<td class="layerright"><input id="code" name="deviceManagement.serialNumber" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>使用单位：</td>
					<td class="layerright"><input id="name" name="deviceManagement.department" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>部门编号：</td>
					<td class="layerright"><input id="code" name="deviceManagement.departmentNumber" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>使用地点：</td>
					<td class="layerright"><input id="code" name="deviceManagement.location" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>制造日期：</td>
					<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><input id="manufacturingDate" name="deviceManagement.manufacturingDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('manufacturingDate');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('manufacturingDate');"/></td>
						</tr>
					</table>
					</td>
					<td class="layertdleft100"><span class="psred"></span>使用日期：</td>
					<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><input id="usedDate" name="deviceManagement.usedDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('usedDate');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('usedDate');"/></td>
						</tr>
					</table>
					</td>
					<td class="layertdleft100"><span class="psred"></span>设备类别：</td>
					<td class="layerright"><input id="code" name="deviceManagement.category" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备状态：</td>
					<td class="layerright">
						<enum:select id="name" name="deviceManagement.status" type="com.wiiy.pb.preferences.enums.DeviceStatusEnum"/>
					</td>
					<td class="layertdleft100"><span class="psred"></span>设备级别：</td>
					<td class="layerright"><input id="code" name="deviceManagement.level" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>复杂系数：</td>
					<td class="layerright"><input id="code" name="deviceManagement.degree" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>巡检间隔：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td ><input id="patrolInterval" name="deviceManagement.patrolInterval" type="text" class="inputauto" /></td>
								<td style="position: relative;left:5px;height:22px;border-color: #333;">
									<enum:select id="patrolIntervalType" name="deviceManagement.patrolIntervalType" type="com.wiiy.pb.preferences.enums.PatrolIntervalEnum"/>
								</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100"><span class="psred"></span>巡检日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="patrolTime" title="首次巡检日期" name="deviceManagement.patrolTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('patrolTime');"/></td>
								<td width="20"><img title="首次巡检日期" src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('patrolTime');"/></td>
							</tr>
						</table>
					</td>
					<!-- <td class="layertdleft100"><span class="psred"></span>年检间隔：</td>
					<td class="layerright"><input id="name" name="deviceManagement.yearlyInterval" type="text" class="inputauto" /></td> -->
					<td class="layertdleft100"><span class="psred"></span>年检日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="yearlyTime" name="deviceManagement.yearlyTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('yearlyTime');"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('yearlyTime');"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备原值：</td>
					<td class="layerright"><input id="name" name="deviceManagement.cost" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>折旧年限：</td>
					<td class="layerright"><input id="code" name="deviceManagement.depreciationYear" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>外形尺寸：</td>
					<td class="layerright"><input id="code" name="deviceManagement.size" type="text" value="${result.value.size}" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>设备重量：</td>
					<td class="layerright"><input id="name" name="deviceManagement.weight" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred"></span>数控设备：</td>
					<td class="layerright">
						<enum:select id="code" name="deviceManagement.isCNC" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
					</td>
					<td class="layertdleft100"><span class="psred"></span>进口设备：</td>
					<td class="layerright">
						<enum:select id="code" name="deviceManagement.isImported" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td colspan="5" class="layerright">
						<textarea name="deviceManagement.remarks"  class="inputauto"  style="height:40px;resize: none;"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div style="height:190px;overflow:hidden;">
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">设备维护</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)" style="display:none;">设备巡检</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)" style="display:none;">设备年检</li>
				<li class="apptabli tabheader" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)" style="display:none;">维修派工单</li>
			
			</ul>
		</div>
		<div style="margin-top:0px;">
			<!-- 设备维护 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;">
				<div class="emailtop">
					<div id="deviceMaintenance" class="leftemail" style="display:none;">
						<ul>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="fbStart('新增设备维护',
									'<%=basePath %>web/property/deviceMaintenance_add.jsp?deviceId='+$('#deviceId').val(),600,327);">
								<span><img src="core/common/images/emailadd.gif" /></span>添加
							</li>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="deleteByIds('deviceMaintenance','maintenanceList')">
								<span><img src="core/common/images/emaildel.png" /></span>删除
							</li>
						</ul>
					</div>
				</div>
				<table id="maintenanceList"><tr><td></td></tr></table>
			</div>
			
			<!-- 设备巡检 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<div class="emailtop">
					<div id="" class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="fbStart('新增设备巡检',
									'<%=basePath %>web/property/devicePatrol_add.jsp?deviceId='+$('#deviceId').val(),600,327);">
								<span><img src="core/common/images/emailadd.gif" /></span>添加
							</li>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="deleteByIds('devicePatrol','patrolList')">
								<span><img src="core/common/images/emaildel.png" /></span>删除
							</li>
						</ul>
					</div>
				</div>
				<table id="patrolList"><tr><td></td></tr></table>
			</div>
			
			<!-- 设备年检 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<div class="emailtop">
					<div id="" class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="fbStart('新增设备年检',
									'<%=basePath %>web/property/deviceYearly_add.jsp?deviceId='+$('#deviceId').val(),600,327);">
								<span><img src="core/common/images/emailadd.gif" /></span>添加
							</li>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="deleteByIds('deviceYearly','yearlyList')">
								<span><img src="core/common/images/emaildel.png" /></span>删除
							</li>
						</ul>
					</div>
				</div>
				<table id="yearlyList"><tr><td></td></tr></table>
			</div>
			
			<!-- 维修派工单 -->
			<div class="basediv tabswitch textname" style="margin-top:0px;display:none;" >
				<div class="emailtop">
					<div id="" class="leftemail">
						<ul>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="fbStart('新增维修派工单',
									'<%=basePath %>web/property/deviceWorkOrder_add.jsp?deviceId='+$('#deviceId').val(),600,327);">
								<span><img src="core/common/images/emailadd.gif" /></span>添加
							</li>
							<li onmouseover="this.className='libg'" 
								onmouseout="this.className=''" 
								onclick="deleteByIds('deviceWorkOrder','deviceWorkOrderList')">
								<span><img src="core/common/images/emaildel.png" /></span>删除
							</li>
						</ul>
					</div>
				</div>
				<table id="deviceWorkOrderList"><tr><td></td></tr></table>
			</div>
		</div>
	</div>
	<div class="buttondiv" style="margin-top:2px;height:auto;">
		<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div>
</div>
</form>
</body>
</html>