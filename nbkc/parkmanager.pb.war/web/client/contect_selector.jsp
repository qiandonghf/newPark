<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
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
		initList();
	});
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function initList(){
		$("#list").jqGrid({
	    	url:'<%=basePath%>contect!list.action',
			datatype: 'json',
			mtype: 'POST',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'ID', name:'id', index:'id', align:"center", hidden:true},
				{label:'姓名', name:'name', index:'name', align:"center"}
			],
			height: 250,
			autowidth: true,//宽度自动
			multiselect: true,//是否可以多选
			viewrecords: false,//是否显示总记录数
			rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
			//pager: '#pager',//指定分页栏对象
			gridview: true,
			postData:{filters:generateSearchFilters("customerId","eq",'${param.id}',"long")}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
	}
	function submitSelected() {
		try{
			if(typeof(getOpener().eval("setSelectedContect")) == "function"){
				var rowData = $("#list").getRowData($("#list").getGridParam("selrow"));
				getOpener().setSelectedContect(rowData);
			}
		} catch(e){}
		try{
			if(typeof(getOpener().eval("setSelectedContects")) == "function"){
				var array = new Array();
				var selectIds = $("#list").getGridParam("selarrrow");
				for(var i = 0 ; i < selectIds.length; i++){
					array[i] = $("#list").getRowData(selectIds[i]);
				}
				getOpener().setSelectedContects(array);
			}
		} catch(e){}
		fb.end();
	}
</script>
</head>

<body>
	<div class="basediv">
		<div class="titlebg">企业列表</div>
		<div class="searchdiv">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="185"><search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/><search:choose dataType="long" field="customerId" op="eq"><input type="hidden" class="data" value="${param.id}"/></search:choose></td>
					<td><input name="Submit3" type="submit" class="search_cx" value="" onclick="doSearch()"/></td>
				</tr>
			</table>
		</div>
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<input name="Submit" type="button" class="savebtn" value="" onclick="submitSelected()"/>
		<input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/>
	</div>
</body>
</html>
