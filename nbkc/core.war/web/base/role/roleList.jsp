<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@page import="java.util.Map"%>
<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String basePath = BaseAction.rootLocation;
%>
<base href="<%=BaseAction.rootLocation %>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
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
	//$("#resizable").resizable();
	initTip();
	initList();
});

                 	
function initList(){
	var height = window.parent.document.documentElement.clientHeight-226;
	$("#list").jqGrid({
    	url:'${contextLocation}role!list.action',
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{label:'角色名称', name:'name', index:'name',width:110, align:"center"}, 
		    {label:'描述', name:'memo', index:'memo', width:220,align:"center"}, 
		    {label:'管理', name:'manager', index:'manager', title:false, width:100, align:"center", sortable:false, search:false, fixed:true}, 
	],
		shrinkToFit: false,
		height: height,
		rowNum: 20,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
		rowList: [10,20,30],//用来调整表格显示的记录数
		autowidth: true,//宽度自动
		multiselect: true,//是否可以多选
		viewrecords: true,//是否显示总记录数
		rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui:'disable',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		pager: '#pager',//指定分页栏对象
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%
					Map<String, ResourceDto> resourceMap = CoreActivator.getHttpSessionService().getResourceMap();
					if(CoreActivator.getHttpSessionService().isInResourceMap("core_role_edit")){
				%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				<%	}
					if(CoreActivator.getHttpSessionService().isInResourceMap("core_role_delete")){
				%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" alt=\"删除\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%  }
					if(CoreActivator.getHttpSessionService().isInResourceMap("core_role_editAuthorityConfig")){
				%>	
					content += "<img src=\"core/common/images/config.png\" width=\"14\" height=\"14\" alt=\"应用权限配置\" title=\"应用权限配置\" onclick=\"authorityConfig('"+id+"');\"  /> ";
				<%	
					}
				%>
				//content += "<img src=\"core/common/images/workbenchConfig.png\" width=\"14\" height=\"14\" alt=\"工作台配置\" title=\"工作台配置\" onclick=\"refreshAuthorityRefs('"+id+"');\"  /> ";
				$(this).jqGrid('setRowData',id,{manager:content});
			}
		},
		gridview: true
	}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
	    caption : "列选择",
	    title : "选择要显示的列",
	    onClickButton : function(){
	        $(this).jqGrid('columnChooser');
	    }
	});
}
function editById(id){
	fbStart('编辑角色','${contextLocation}role!edit.action?id='+id,350,150);
}
function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("${contextLocation}role!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}

function searchList(){
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:[{field:'name',op:'cn',data:$("#name").val(),dataType:'string'},{field:'type',op:'eq',data:$("#type").val()}]}}).trigger('reloadGrid');
}
function deleteSelected(){
	if(confirm("确定要删吗")){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		$.post("${contextLocation}role!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}
function authorityConfig(id) {
	fbStart("权限配置", "${contextLocation}role!editAuthorityConfig.action?id="+id, 700, 560);
}

/* function refreshAuthorityRefs(id){
	fbStart("工作台配置", "${contextLocation}role!configRoleDesktop.action?id="+id, 400, 400);
} */

function refreshDataTables() {
 $("#list").trigger("reloadGrid");
}
</script>

</head>

<body>
<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
		<ul>
			<%if(CoreActivator.getHttpSessionService().isInResourceMap("core_role_add")){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建角色','<%=basePath+resourceMap.get("core_role_add").getUri() %>',350,150);"><span><img src="<%=resourceMap.get("core_role_add").getIcon()%>" width="15" height="13" /></span><%=resourceMap.get("core_role_add").getName() %></li>
			<%}%>
			<%if(CoreActivator.getHttpSessionService().isInResourceMap("core_role_delete")){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="<%=resourceMap.get("core_role_delete").getIcon()%>"/></span><%=resourceMap.get("core_role_delete").getName() %></li>
			<%}%>
		</ul>
	</div>
	<!--//leftemail-->
</div>


<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="100%" valign="top">
		<!--msglist-->
		<div class="msglistall">
		</div>
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
        </td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
