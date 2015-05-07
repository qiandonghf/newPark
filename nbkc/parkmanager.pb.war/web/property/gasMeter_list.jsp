<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		initTip();
		$("#msglist").css("height",getTabContentHeight()-28);
		initList();
		jqGridResizeRegister("list");
	});
	
	function initList(){
		var height = getTabContentHeight()-80;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>meter!gasList.action',
	    	colModel: [
				{label:'表名称', width:'120' ,name:'name', align:"center"},
				{label:'表编号', width:'120' ,name:'orderNo', align:"center"}, 
				{label:'母表编号', width:'120' ,name:'parentNo', align:"center"}, 
				{label:'表倍数', width:'60' ,name:'meterFactor', align:"center"}, 
				{label:'上期读数', width:'70' ,name:'preReading', align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},editable:true}, 
				{label:'最后抄表日期', width:'100' ,name:'readingDate', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},  
				{label:'表性质', width:'80' ,name:'kind.title', align:"center"}, 
				{label:'表状态', width:'80' ,name:'status.title', align:"center"}, 
				{label:'是否出报表', width:'100' ,name:'checkOut.title', align:"center"},  
				{label:'房间Id',name:'roomIds', align:"center",hidden:true},  
			    {label:'管理', width:'70' ,name:'manager', align:"center",sortable:false, resizable:false}
				],
			shrinkToFit: false,	
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				var roomIds= jQuery("#list").jqGrid('getCol','roomIds',false);
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var roomId = roomIds[i];
					var text = id+"|"+roomId;
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+text+"');\"  /> ";
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
	function viewById(id){
		fbStart('查看气表','<%=basePath %>meter!view.action?id='+id,600,248);
	}
	
	function editById(id){
		fbStart('编辑气表','<%=basePath %>meter!edit.action?id='+id,600,248);
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(text){
		var id = text.split("|")[0];		
		var roomId = text.split("|")[1];		
		if(roomId!=","){
			showTip("该表已有房间配置,不能删除",2000);
			return;
		}
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>meter!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
</script>

</head>

<body style="background:#fff;">
	<div class="pm_msglist">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
	</div>	
</body>
</html>
