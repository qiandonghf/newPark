<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
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
	    	url:'<%=basePath%>deviceManagement!list.action',
			colModel: [
					{label:'设备名称', name:'name', align:"center"}, 
					{label:'设备编号', name:'number', align:"center",hidden:true}, 
					{label:'运行状态', name:'status.title', align:"center",hidden:true}, 
					{label:'巡检间隔',width:'100',name:'patrolInterval', align:"center"}, 
					{label:'初始巡检日期',width:'100', name:'patrolTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'最近巡检日期',width:'100', name:'lastPatrolTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'初始年检日期',width:'100', name:'yearlyTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'最近年检日期',width:'100', name:'lastYearlyTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'设备规格', name:'specifications', align:"center",hidden:true}, 
				    {label:'使用部门', name:'department', align:"center",hidden:true}, 
				    {label:'使用地点', name:'location', align:"center",hidden:true},
				    {label:'管理', width:'110' ,name:'manager', align:"center",sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deviceManage_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" style=\"margin-top:4px;\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deviceManage_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deviceManage_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>
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
	function count(cellvalue,options,rowObject){
	   if(cellvalue.length > 15){
		   cellvalue = cellvalue.substring(0,14)+"......";
	   }
	   return cellvalue;
	}
	
	function viewById(id){
		fbStart('查看设备管理','<%=basePath %>deviceManagement!view.action?id='+id,770,418);
	}
	
	function editById(id){
		fbStart('编辑设备管理','<%=basePath %>deviceManagement!edit.action?id='+id,770,498);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>deviceManagement!delete.action?id="+id,function(data){
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
			$.post("<%=basePath%>deviceManagement!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
</script>
</head>
<body>
	<div class="emailtop">
		<div class="leftemail">
			<ul>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deviceManage_add")){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建设备管理','<%=basePath %>web/property/device_add.jsp',770,498);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
			<%} %>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_deviceManage_delete")){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
			<%} %>
			</ul>
		</div>
	</div>
	<div class="msglist" id="msglist">
		<div id="container">
			<table id="list" class="jqGridList"><tr><td/></tr></table>
			<div id="pager"></div>
		</div>
	</div>
</body>
</html>
