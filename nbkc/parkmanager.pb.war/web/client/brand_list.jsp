<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
	var height = getTabContentHeight()-78;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>brand!list.action',
		colModel: [
			{label:'商标名称', name:'name', align:"center"}, 
			{label:'商标编号', name:'brandNo', align:"center"}, 
			{label:'企业名称', name:'customer.name', align:"center",width:180}, 
			{label:'注册人',width:80, name:'register', align:"center"}, 
			{label:'注册地址', name:'registerAddress', align:"center",formatter:addrFormat}, 
			{label:'注册有效期',width:160, name:'startDate', align:"center",formatter:dateFormat}, 
			{label:'授权时间',width:90, name:'grantDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
			{label:'注册有效期开始日期',width:80, name:'startDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center",hidden:true}, 
			{label:'注册有效期结束日期',width:80, name:'endDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center", hidden:true},
			{label:'详细说明', name:'memo', align:"center", hidden:true},
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
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_brand_view")){%>	
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
			<%}%>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_brand_edit")){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
			<%}%>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_brand_delete")){%>
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
function viewById(id){
	fbStart('查看商标','<%=basePath%>brand!view.action?id='+id,500,290);
}
function editById(id){
	fbStart('编辑商标','<%=basePath%>brand!edit.action?id='+id,500,317);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>brand!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>brand!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
</script>
</head>

<body >
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_brand_add")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建商标','<%=basePath %>web/client/brand_add.jsp',500,317);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_brand_delete")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		</ul>
	</div>
</div>
 <div class="msglist" id="msglist">
  <table id="list" class="jqGridList"><tr><td/></tr></table>
  <div id="pager"></div>
</div>
</body>
</html>
