<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
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
		initProject();
		jqGridResizeRegister("inList","outList");
	});
	function initProject(){
		$("#inList").jqGrid({
	    	url:'<%=basePath%>supply!inList.action?id='+$("#id").val(),
			colModel: [
			    {label:'入货数量', name:'amount',align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
			    {label:'入库时间', name:'inTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'购买人', name:'purchaser',align:"center"}
			   
			],
			height: 299,//加上分页栏高度为106
			forceFit: true,
			width: 676,
			multiselect: false,
			pager: '#pager1',
			postData:{filters:generateSearchFilters("supplyId","eq",<%=request.getParameter("id")%>,"long")},
			
		}).navGrid('#pager1',{add: false, edit: false, del: false, search: false, refresh: false});
		
		$("#outList").
	jqGrid(
				{
					url : '<%=basePath%>supply!outList.action?id='
							+ $("#id").val(),
					colModel : [ {
						label : '数量',
						name : 'amount',
						align : "center",
						formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"
					}, {
						label : '申请时间',
						name : 'applyTime',
						align : "center",
						formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}
					}, {
						label : '申请人',
						name : 'applyer',
						align : "center"
					} ],
					height : 299,
					forceFit : true,
					width : 676,
					multiselect : false,
					pager : '#pager2',
					postData : {
						filters : generateSearchFilters("supplyId","eq",<%=request.getParameter("id")%>, "long")
					},
					}).navGrid('#pager2', {
						add : false,
						edit : false,
						del : false,
						search : false,
						refresh : false
					});
	}

	function reloadList(test) {
		$("#" + test + "List").trigger("reloadGrid");
	}
</script>
</head>

<body>
	<div style="padding:10px 10px;">
	<input id="id" name="id" value="${id }" type="hidden" />
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">入库明细</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">出库明细</li>
		</ul>
	</div>
	<!--//table切换开始-->
	<div class="basediv tabswitch" style="margin: 0px;" id="textname">
		<table id="inList" width="100%">
			<tr>
				<td />
			</tr>
		</table>
		<div id="pager1"></div>
	</div>

	<div class="basediv tabswitch" style="margin: 0px; display: none;" id="textname">
		<table id="outList" width="100%">
			<tr>
				<td />
			</tr>
		</table>
		<div id="pager2"></div>
	</div>
	</div>
	<!--//basediv-->
</body>
</html>
