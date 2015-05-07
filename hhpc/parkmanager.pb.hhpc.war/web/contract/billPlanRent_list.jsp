<%@page import="com.wiiy.crm.preferences.enums.ContractItemEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String contractIds = request.getParameter("contractIds");
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

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-77;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>billPlanRent!listRendPredict.action?status=${param.status}&year=${param.year}',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'类型', name:'feeType.title', align:"center",width:20}, 
				{label:'计费开始时间', name:'startDate', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计费结束时间', name:'endDate', align:"center",width:30,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'计划金额', name:'planFee',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",width:30}, 
				{label:'实际金额', name:'realFee',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",width:30}, 
				{label:'计划付费时间', name:'planPayDate', align:"center",width:30, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'状态', name:'status.title', align:"center",width:30}, 
			    {label:'管理', name:'manager', align:"center", resizable:false,width:36,sortable:false}
			],
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewBillPlanRentById('"+id+"');\"  /> "; 
					if($(this).getCell(id,9)=='未出账'){
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editBillPlanRentById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteBillPlanRentById('"+id+"');\"  /> ";
						content += "<img src=\"core/common/images/rece2.gif\" width=\"14\" height=\"14\" title=\"收款出账\" onclick=\"billPlanRentCheckinById('"+id+"');\"  /> "; 
					}
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewBillPlanRentById(id){
		fbStart('资金计划',"<%=basePath%>billPlanRent!view.action?id="+id,500,179);
	}
	function editBillPlanRentById(id){
		fbStart('编辑资金计划',"<%=basePath%>billPlanRent!edit.action?id="+id,500,315);
	}
	function deleteBillPlanRentById(id){
		if(confirm("确认删除该资金计划？")){
			$.post("<%=basePath%>billPlanRent!delete.action?id="+id,function(){
				$("#billPLanRentList").trigger("reloadGrid");
			});
		}
	}
	function billPlanRentCheckinById(id){
		if(confirm("确认收款出账?")){
			$.post("<%=basePath%>billPlanRent!checkinById.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				$("#billPLanRentList").trigger("reloadGrid");
			});
		}
	}
	
	
	function exportDate(){
		var columns = "{";
		$.each($("#list").getGridParam("colModel"),function(){
			if(this.label && this.name!="manager" && !this.hidden){
				columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
			}
		});
		columns = deleteLastCharWhenMatching(columns,",");
		columns += "}";
		$("#columns").val(columns);
		$("#exportForm").submit();
	}
</script>

</head>
<body>
<form action="<%=basePath%>billPlanRent!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
	<input type="hidden" id="year" name="year" value="${param.year }"/>
	<input type="hidden" id="status" name="status" value="${param.status }"/>
</form>
<div class="emailtop" style="position:relative;z-index:99999;">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif"/></span>导出</li>
		</ul>
	</div>
</div>
<div  id="container">
	<div class="msglist" style="display:block;" id="textname">
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</div>
</div>
</body>
</html>