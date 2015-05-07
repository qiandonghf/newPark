<%--@elvariable id="result" type="com.sanlue.common.domain.service.Result<com.sanlue.core.domain.model.base.User>"--%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String basePath = BaseAction.rootLocation;
%>
<base href="${rootLocation}" />
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
	var height = window.parent.document.documentElement.clientHeight-250;
	$("#list").jqGrid({
    	url:'${contextLocation}user!listSelf.action',
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{label:'状态', name:'entityStatus.title', index:'entityStatus', width:60, align:"center"}, 
			{label:'用户名', name:'username', index:'username',width:110, align:"center"}, 
		    {label:'真实姓名', name:'realName', index:'realName', width:110,align:"center"}, 
		    {label:'移动电话', name:'mobile', index:'mobile', width:90, align:"center"},
		    {label:'所属机构', name:'orgName', index:'org', width:90, align:"center"},
		    {label:'Email', name:'email', index:'email', width:100, align:"center"},
		    {label:'最后登录时间',  name:'lastLoginTime', index:'lastLoginTime', width:85, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
		    {label:'管理', name:'manager', index:'manager', title:false, width:80, align:"center", sortable:false, search:false, fixed:true}, 
	],
		height: height,
		rowNum: 20,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
		rowList: [10,20,30],//用来调整表格显示的记录数
		autowidth: true,//宽度自动
		multiselect: true,//是否可以多选
		viewrecords: true,//是否显示总记录数
		rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui:'disable',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		pager: '#pager',//指定分页栏对象
		shrinkToFit: false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%
					Map<String, ResourceDto> resourceMap = CoreActivator.getHttpSessionService().getResourceMap();
					boolean add = CoreActivator.getHttpSessionService().isInResourceMap("core_user_add");
					boolean edit = CoreActivator.getHttpSessionService().isInResourceMap("core_user_edit");
					boolean delete = CoreActivator.getHttpSessionService().isInResourceMap("core_user_delete");
					boolean reset = CoreActivator.getHttpSessionService().isInResourceMap("core_user_resetPwd");
					boolean importCard = CoreActivator.getHttpSessionService().isInResourceMap("core_user_importCard");
				%>
				<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
				<%}%>
				<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" alt=\"删除\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
				<%}%>	
				<%if(reset){%>
					content += "<img src=\"core/common/images/pwd.png\" width=\"14\" height=\"14\" alt=\"重置密码\" title=\"重置密码\" onclick=\"resetById('"+id+"');\"  /> ";
				<%}%>
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
	fbStart('编辑用户','${contextLocation}user!edit.action?id='+id,590,528);
}
function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("${contextLocation}user!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}
function resetById(id){
	if(confirm("确定要重置该用户的密码吗？")){
		showTip("正在重置密码，请稍候...",10000);
		$.post("${contextLocation}user!resetPwd.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	
		});
	}
}
function searchList(){
	$("#list").jqGrid('setGridParam',{page:1,postData:{filters:[{field:'name',op:'cn',data:$("#name").val(),dataType:'string'},{field:'type',op:'eq',data:$("#type").val()}]}}).trigger('reloadGrid');
}
function deleteSelected(){
	if(confirm("确定要删吗")){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		$.post("${contextLocation}user!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}
 function refreshDataTables() {
  $("#list").trigger("reloadGrid");
 }
 function importCardWithGroup() {
	var ids = $("#list").jqGrid("getGridParam","selarrrow");
	$.post("${contextLocation}user!importCard.action?ids="+ids,
			function(data){
				showTip(data.result.msg,2000);
	});
 }
 function toImportCard() {
	showTip("正在导入名片，请稍候...",100000);
	$.post("${contextLocation}user!importCard.action",
			function(data){
				showTip("导入成功",2000);
	});
 }
 	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
</script>
</head>

<body>

<div class="emailtop">
	<!--leftemail-->
	<div class="leftemail">
	<ul>
		<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建用户','<%=basePath+resourceMap.get("core_user_add").getUri() %>',590,528);">
				<span><img src="<%=resourceMap.get("core_user_add").getIcon() %>" width="15" height="13" /></span><%=resourceMap.get("core_user_add").getName() %>
			</li>
		<%} %>
		<% if(delete){%>	
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()">
				<span><img src="core/common/images/emaildel.png"/></span><%=resourceMap.get("core_user_delete").getName() %>
			</li>
		<%} %>
		<% if(importCard){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="importCardWithGroup()">
				<span><img src="core/common/images/card.png"/></span>导入名片
			</li>
		<%} %>
	</ul>
	</div>
	<!--//leftemail-->
</div>
<div class="searchdivkf">
	    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
	     <tr>
	        <td width="45" align="right">用户名称：</td>
	        <td width="100">
	        	<search:input dataType="string" field="username" op="cn" inputClass="inputauto"/>
	     	</td>
	     	<td width="10">&nbsp;</td>
	        <td width="75" align="center"><input type="button" name="Submit" value="" class="searchbtn" onclick="doSearch()"/></td>
	        <td>&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	    </table>
	</div>
<!--//btndiv-->
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
