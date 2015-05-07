<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.DataReport"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.crm.preferences.enums.ReportStatusEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
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
	$(function(){initList();
		initTip();
	});
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function initList(){
		var ids = ${result.value.id}+","+${cId};
		var height = getTabContentHeight()-108;
		var width = window.parent.parent.document.documentElement.clientWidth-(window.parent.screenLeft-window.parent.parent.screenLeft)-604;
		$("#list").jqGrid({
	    	url:'<%=basePath%>dataReportToCustomer!list.action?ids='+ids,
			colModel: [
						{label:'企业', name:'customer.name',width:160, align:"center"}, 
						{label:'报表名称', name:'report.name',width:50, align:"center",hidden:true}, 
						{label:'报表类型', name:'report.reportType.title',width:30,align:"center",hidden:true}, 
						{label:'类型', name:'report.reportType',width:30,align:"center",hidden:true}, 
						{label:'数据时间', name:'report.date', width:75,align:"center",formatter:formatDate}, 
					    {label:'日期', name:'report.dataTime',width:60, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'},hidden:true},
						{label:'报表状态', name:'report.status.title',width:60, align:"center", index:'status',hidden:true},
						{label:'填报日期', name:'fillTime', align:"center",width:70, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
						{label:'填报状态', name:'status.title', align:"center",width:50},
					    {label:'管理', name:'manager', align:"center", resizable:false,sortable:false,width:65}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"退回\" onclick=\"backById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	function formatDate(cellvalue,options,rowObject){
		var type = rowObject["report"].reportType.title;
		var dataTime = rowObject["report"].dataTime;
		var year;
		var month;
		if(type=="月报"){
		    year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			cellvalue = year+"年"+month+"月";
		}
		if(type=="季报"){
			year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			cellvalue = year+"年"+month/3+"季度";
		}
		if(type=="半年报"){
			year = dataTime.substring(0,4);
			month = dataTime.substring(5,7);
			if(month<10){
				month = dataTime.substring(6,7);
			}
			if(month==6){
				cellvalue = year+"年上半年";
			}
			if(month==12){
				cellvalue = year+"年下半年";
			}
		}
		if(type=="年报"){
			year = dataTime.substring(0,4);
			cellvalue = year+"年";
		}
		if(type=="临时"){
			year = dataTime.substring(0,10);
			cellvalue = year;
		} 
		return cellvalue; 
	}
	
	function viewById(id){
		window.open("<%=basePath%>dataReportToCustomer!view.action?id="+id);
	}
	function backById(id){
		if(confirm("确定要退回吗")){
			fbStart("数据报送退回原因","<%=basePath%>web/client/dataReportToCustomer_backSuggestion.jsp?id="+id,500,170);
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>dataReportToCustomer!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>dataReportToCustomer!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function editById(id){
		fbStart('编辑企业报表','<%=basePath %>dataReportToCustomer!edit.action?id='+id,620,540,false);
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function refresh(){
		if($(".tabswitch").size()==2){
			$("#list").trigger("reloadGrid");
		}else{
			location.reload();
		}
	}
	function closeReport(){
		if(confirm("是否关闭${result.value.name}报表")){
			$.post("<%=basePath%>dataReport!close.action?id=${result.value.id}",function(data){
				showTip(data.result.msg,2000);
				setTimeout("location.reload();parent.fb.end();", 500);
			});
		}
	}
	function openReport(){
		if(confirm("是否打开${result.value.name}报表")){
			$.post("<%=basePath%>dataReport!open.action?id=${result.value.id}",function(data){
				setTimeout("location.reload();parent.fb.end();", 500);
			});
		}
	}
	
	function setSelectedCustomers(customerIds){
		var action = $("#action").val();
		var url = "<%=basePath%>dataReport!"+action+".action?id=${result.value.id}&ids="+customerIds;
		$.post(url,function(data){
			showTip(data.result.msg,2000);
			setTimeout("location.reload();parent.fb.end();", 500);
		});
	}
	
	function publishReport(){
		$("#action").val("publish");
		fbStart('发布','<%=basePath %>customer!multiSelect.action',520,400);
	}
	function addCustomer(){
		$("#action").val("addCustomer");
		fbStart('添加企业','<%=basePath %>customer!multiSelect.action',520,400);
	}
</script>
</head>

<body>
<input id="action" type="hidden" value="addCustomer"/>
<div class="titlebg">企业数据填报列表</div>


<div class="tabswitch">
	<div class="pm_msglist" >
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<!-- <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addCustomer()"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>添加企业</li> -->
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
				</ul>
			</div>
		</div>
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</div>
</div>
</body>
</html>