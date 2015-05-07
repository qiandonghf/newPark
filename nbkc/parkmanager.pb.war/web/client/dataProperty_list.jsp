<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	initList("list");
});
function initList(list){
	var height = getTabContentHeight()-105;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#"+list).jqGrid({
    	url:'<%=basePath%>dataProperty!list.action',
    	treeGrid:true,
    	treeGridModel: 'adjacency',
    	ExpandColumn:'name',
    	rownumbers:false,
		colModel: [
			//{label:'上级数据', name:'parent.name', align:"center"}, 
			{label:'数据项名称', name:'name', align:"center"}, 
			{label:'数据类型', width:100,name:'dataType.title', align:"center"}, 
			{label:'单位', width:80, name:'unit', align:"center"}, 
			{label:'填报说明', name:'note', align:"center", sortable:false}, 
			{label:'数据类型扩展', name:'dataTypeExt', align:"center",hidden:true}, 
		    {label:'管理', width:80,name:'manager', align:"center", sortable:false, resizable:false}
		],
		height: height,
		width: width,
		shrinkToFit: false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_up")){%>
				content += "<img src=\"core/common/images/up.png\" width=\"14\" height=\"14\" title=\"上移\" onclick=\"upById('"+id+"');\"  /> ";
			<%}%>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_down")){%>
				content += "<img src=\"core/common/images/down.png\" width=\"14\" height=\"14\" title=\"下移\" onclick=\"downById('"+id+"');\"  /> ";
			<%}%>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_edit")){%>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
			<%}%>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_delete")){%>
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
function upById(id){
	$.post("<%=basePath%>dataProperty!up.action?id="+id,function(data){
		if(data.result.success) {
			reloadList();
		}
	});
}
function downById(id){
	$.post("<%=basePath%>dataProperty!down.action?id="+id,function(data){
		if(data.result.success) {
			reloadList();
		}
	});
}
function reloadListNode(id){
	location.reload();
}
function reloadList(){
	$("#list").trigger("reloadGrid");
}
function editById(id){
	fbStart('编辑数据项','<%=basePath%>dataProperty!edit.action?id='+id,650,211);
}
function viewById(id){
	fbStart('查看数据项','<%=basePath%>dataProperty!view.action?id='+id,650,211);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>dataProperty!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>dataProperty!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function doSearch(){
	search(getSearchFilters());
}
function search(filters){
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
}
</script>
</head>

<body >
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_add")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建数据项','<%=basePath %>dataProperty!add.action',650,211);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
	<%} %>
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataProperty_delete")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		</ul>
	</div>
</div>
<div class="searchdiv">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="80" align="right">数据项名称：</td>
			<td width="100"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td> 
			<td width="10">&nbsp;</td>
			<td width="75" align="center"><input type="button" name="Submit" value="" class="searchbtn" onclick="doSearch()"/></td>
			<td>&nbsp;</td>
		</tr>
    </table>
</div>
 <div class="msglist" id="msglist">
  <table id="list" class="jqGridList"><tr><td/></tr></table>
  <div id="pager"></div>
</div>
</body>
</html>
