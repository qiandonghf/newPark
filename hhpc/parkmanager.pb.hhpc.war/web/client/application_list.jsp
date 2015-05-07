<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
$(document).ready(function(){
	initTip();
	initList();
});
function initList(){
	var height = getTabContentHeight()-51;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>customer!applyList.action',
		colModel: [
			{label:'企业名称', name:'name', align:"center",width:180}, 
			{label:'申请时间',width:80, name:'applyTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
			{label:'申请状态',width:80, name:'pub.title', align:"center"}, 
		    {label:'管理', width:70,name:'manager', align:"center", sortable:false, resizable:false}
		],
		height: height,
		width: width,
		shrinkToFit: false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"同意申请\" onclick=\"publishById('"+id+"');\"  /> ";
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
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

function addrFormat(cellvalue,options,rowObject){
	 var registerAddress = rowObject["registerAddress"];
	   if(registerAddress.length > 15){
		   cellvalue = registerAddress.substring(0,14)+"......";
	   }
	   return cellvalue;
}

function dateFormat(cellvalue,options,rowObject){
	var startDate = rowObject["startDate"];
	var endDate = rowObject["endDate"];
	if(startDate!=null && endDate!=null){
		startDate = startDate.substring(0,10);
		endDate = endDate.substring(0,10);
		cellvalue = startDate+"至"+endDate;
	}
	return cellvalue;
}

function reloadList(){
	$("#list").trigger("reloadGrid");
}
function reloadRewardList(){
	reloadList();
}
function publishById(id){
	if(confirm("确定要同意申请吗")){
		$.post("<%=basePath%>customer!changeApplyState.action?state=AGREE&id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}
function viewById(id){
	fbStart('查看','<%=basePath %>customer!view.action?id='+id,940,458);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>reward!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>reward!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
</script>
</head>

<body >
 <div class="msglist" id="msglist" style="padding-bottom:0px;">
  <table id="list" class="jqGridList"><tr><td/></tr></table>
  <div id="pager"></div>
</div>
</body>
</html>
