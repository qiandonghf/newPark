<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link href="core/common/style/ui.jqgrid.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>

<script>
$(document).ready(function() {
	////$("#resizable").resizable();
	$("#resizable").css("height",window.parent.document.documentElement.clientHeight-52);
	initTip();
	$("#filter_data").val($(".appli2").attr("simpleName"));
	initList();
	$("#appul li").click(function(){
		$(this).attr("class", "appli2");
		$(this).siblings().attr("class", "appli1");
		$("#bundleId").val($(this).attr("bundleId"));
		$("#filter_data").val($(this).attr("simpleName"));
		$("#list").setGridParam({page:1, postData:{"ids":$("#filter_data").val()}}).trigger('reloadGrid');
	});
});
function initList(){
	var height = window.parent.document.documentElement.clientHeight-259;
	$("#list").jqGrid({
    	url:'${contextLocation}dataDict!list.action',
    	postData : {"ids":$("#filter_data").val()},
		datatype: 'json',
		prmNames: {search: "search"},
		jsonReader: {root:"root",repeatitems: false},
		colModel: [
			{label:'类型名称(英文)', name:'dataName', index:'dataName', width:240, align:"center"}, 
			{label:'类型名称(中文)', name:'dataValue', index:'dataValue', width:280, align:"center"}, 
		    {label:'管理', name:'manager', index:'manager', title:false, width:80, align:"center", sortable:false, search:false, fixed:true}, 
	],
		shrinkToFit: false,
		height: height,
		rowNum: 20,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
		rowList: [10,20,30],//用来调整表格显示的记录数
		autowidth: true,//宽度自动
		multiselect: true,//是否可以多选
		viewrecords: true,//是否显示总记录数
		rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
		loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
		pager: '#pager',//指定分页栏对象
		gridComplete: function(){
			var rowDatas = $(this).jqGrid("getRowData");
 			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < rowDatas.length; i++){
				var id = ids[i];
				var content = "";
				content += "<img src=\"core/common/images/edit.gif\" alt=\"编辑\" title=\"编辑\" onclick=\"editById('"+id+"');\"/>"; 
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
	fbStart('编辑数据','${contextLocation}dataDict!edit.action?id='+id,400,186);
}
function goTab(tabUri) {
	if ($("#bundleId").val() == null || $("#bundleId").val() == "") {
		location.href="${contextLocation}"+tabUri;
	} else {
		location.href="${contextLocation}"+tabUri+"?bundleId="+$("#bundleId").val();
	}
}
function refreshDataTables() {
	$("#list").jqGrid('setGridParam',{page:1,postData:{"ids":$("#filter_data").val()}}).trigger('reloadGrid');
}  
</script>
</head>

<body>
<!--container-->
<div id="container">
<input id="filter_name" class="field" type="hidden" value="id"/>
<input id="filter_op" class="op" type="hidden" value="bw"/>
<input id="filter_dataType" class="dataType" type="hidden" value="string"/>
<input id="filter_data" type="hidden" class="data" value="noname"/>

<input id="filter_name" class="field" type="hidden" value="parentId"/>
<input id="filter_op" class="op" type="hidden" value="nl"/>
<input id="filter_dataType" class="dataType" type="hidden" value="long"/>
<input id="filter_data" type="hidden" class="data" value="-1"/>

<input type="hidden" name="bundleId" id="bundleId" value="${bundleId}" />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="182" valign="top">
			<div class="agency" id="resizable" >
			<!--titlebg-->
			<div class="titlebg">应用列表</div>
			<!--//titlebg-->
			<!--applist-->
			<div class="applist">
				<ul id="appul">
					<c:forEach var="app" items="${appDtoList}" varStatus="rowStatus">
					<c:if test="${empty bundleId and rowStatus.first}">
						<li class="appli2" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId eq bundleId}">
						<li class="appli2" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${empty bundleId and not rowStatus.first}">
						<li class="appli1" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					<c:if test="${not empty bundleId and app.bundleId ne bundleId}">
						<li class="appli1" bundleId="${app.bundleId}" simpleName="${app.simpleName}"><a href="javascript:void(0)">${app.name}</a></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<!--//applist-->
            </div></td>
        <td width="100%" valign="top">
		<!--msglist-->
		<div class="msglist" id="msglist">
		
		<!--titlebg-->
			<div class="titlebg">应用信息</div>
		 <!--//titlebg-->
		<!--appmsglist-->
		<div class="appmsglist">
		<!--apptab-->
		<div class="apptab" id="apptab">
			<ul>
				<li class="apptabli" ><a href="javascript:goTab('appConsole.action')">应用信息</a></li>
				<li class="apptabli" ><a href="javascript:goTab('appParam.action')">应用参数</a></li>
				<li class="apptabliover"><a href="javascript:goTab('dataDict.action')">数据字典</a></li>
			</ul>
		</div>
		<!--//apptab-->
		<div class="appname" style="border-bottom:none;">
				<!--//titlebg-->
				<table id="list" class="jqGridList"><tr><td/></tr></table>
				<div id="pager"></div>
			</div>
			<!--appname-->
		</div>
		<!--//appmsglist-->
        </div>
		<!--//msglist-->		
		</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
