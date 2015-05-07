<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	var height = getTabContentHeight()-75;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
    	url:'<%=basePath%>fixedAssets!list2.action',
    	colModel: [
   				{label:'资产编号',width:70, name:'id',align:"center"}, 
   				{label:'资产名称',name:'name',align:"center"}, 
   				{label:'资产类别',width:70,name:'type.dataValue',align:"center"}, 
   				{label:'置办日期',width:110, name:'dealDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
   				{label:'折旧类型',width:110, name:'depreciation.title',align:"center",hidden:true}, 
   				{label:'开始折旧日期',width:110,name:'startDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center",hidden:true}, 
   				{label:'原资产值',width:135, name:'originalValue',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",hidden:true}, 
   				{label:'现资 产值',width:135,name:'newValue',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center" ,hidden:true},			
   				{label:'所属部门',name:'org.name',align:"center",hidden:true,hidden:true}, 
   				{label:'规格型号',name:'spec',align:"center",hidden:true,hidden:true}, 
   				{label:'厂商',name:'factory',align:"center",hidden:true,hidden:true}, 
   				{label:'采购日期',name:'buyDate',align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
   				{label:'备注',name:'memo',align:"center",hidden:true},
   			    {label:'管理',width:70, name:'manager', align:"center", sortable:false, resizable:false}
   			    
   			],
   			height: height,
   			width: width,
   			shrinkToFit: false,
   			multiselect: true,
   			gridComplete: function(){
   				var ids = $(this).jqGrid('getDataIDs');
   				for(var i = 0 ; i < ids.length; i++){
   					var id = ids[i];
   					var content = "";
   					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
   					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
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
function viewById(id){
	fbStart('查看','<%=basePath %>fixedAssets!view.action?id='+id,500,200);
}

function editById(id){
	fbStart('编辑','<%=basePath %>fixedAssets!edit.action?id='+id,500,200);
}
function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("<%=basePath%>fixedAssets!delete.action?id="+id,function(data){
			if(data.result!=null){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			}else{
				showTip("没有权限");
			}
		});
	}
}

function deleteByIds(){
	var ids = $("#list").jqGrid("getGridParam","selarrrow");
	if(ids!='' && confirm("确定要删吗")){
		$.post("<%=basePath%>fixedAssets!delete.action?ids="+ids,function(data){
			if(data.result!=null){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			}else{
				showTip("没有权限");
			}
		});
	}
}

function reloadList(){
	$("#list").trigger("reloadGrid");
}

</script>

</head>
<form action="<%=basePath%>fixedAssets!export.action?type=2" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<body>
	<!--emailtop-->
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="deleteByIds()"><span><img
						src="core/common/images/emaildel.png" /></span>删除</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
			</ul>
		</div>
	</div>
	<!--//emailtop-->
	<!--container-->
	<div class="msglist" id="msglist">
		<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
		</div>
		
		
	</div>
	<!--//container-->
</body>
</html>
