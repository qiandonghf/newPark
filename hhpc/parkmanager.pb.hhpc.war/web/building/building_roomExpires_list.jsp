<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initList("list");
});

function initList(list){
	var height = getTabContentHeight()-75;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#"+list).jqGrid({
    	url:'<%=basePath%>room!expiresRoomList.action',
		colModel: [
			{label:'状态',width:60, name:'status.title',index:'status',align:"center"}, 
			{label:'房间',width:80, name:'name',align:"center"},
			{label:'性质',width:60, name:'kind.dataValue',index:'kind',align:"center",hidden:true},
			{label:'所在楼宇',width:80, name:'building.name',align:"center"}, 
			{label:'楼层',width:80, name:'floor.name',align:"center"}, 
			{label:'建筑面积',width:100, name:'buildingArea',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0},align:"center"}, 
			{label:'企业名称', name:'customerName',align:"center",width:180}, 
			{label:'合同到期',width:120, name:'endDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
		    {label:'管理',width:50, name:'manager', align:"center", sortable:false, resizable:false}
		],
		shrinkToFit: false,
		height: height,
		width: width,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_view")){%>
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_edit")){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_delete")){%>
				content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>
				$(this).jqGrid('setRowData',id,{manager:content});
			}
		}
	}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
}
function reloadRoomList(){
	$("#list").trigger("reloadGrid");
}
function editById(id){
	fbStart('编辑房间信息','<%=basePath%>room!edit.action?id='+id,700,463);
}
function viewById(id){
	fbStart('查看房间信息','<%=basePath%>room!view.action?id='+id,700,192);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>room!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>room!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function doSearch(){
	var filters = getSearchFilters();
	$("#filters").val(filters);
	search(filters);
}
function search(filters){
	$("#filters").val(filters);
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
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
<form action="<%=basePath%>room!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" name="exportName" value="到期单元列表"/>
</form>
<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_delete")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds();"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_search")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbSearch('高级搜索','<%=basePath %>web/building/building_room_search.jsp',550,300);"><span><img src="core/common/images/searchico.gif"/></span>搜索</li>
		<%} %>
		<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif"/></span>导出</li>
		</ul>
	</div>
</div>
<div id="container">
	<table id="list" class="jqGridList"><tr><td/></tr></table>
	<div id="pager"></div>
</div>
</body>
</html>
