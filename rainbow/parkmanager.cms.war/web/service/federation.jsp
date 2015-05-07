<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
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
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-79;
		var width = $(this).width()-1;
		$("#list").jqGrid({
	    	url:'<%=basePath%>federation!list.action',
			colModel: [
				{label:'联盟名称', name:'name',align:"center",width:120}, 
				{label:'联盟标题', name:'title',align:"center",width:120}, 
				{label:'栏目名称', name:'articleType.typeName',align:"center",width:120}, 
				{label:'网站域名', name:'website',align:"center",width:120}, 
				{label:'联系电话', name:'phone',align:"center",width:120}, 
				{label:'E-mail', name:'email',align:"center",width:120}, 
				{label:'平台内容', hidden:true, name:'content',align:"center",width:200}, 
				{label:'点击次数',hidden:true, name:'hits',align:"center",width:80}, 
				{label:'是否发布', name:'pubed.title',align:"center",width:80}, 
				{label:'发布时间',width:120,name:'pubTime',align:"center",sortable:false, resizable:false,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			multiselect: true,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					var type = $(this).getCell(id,'pubed.title');
					var managerIds = $(this).getCell(id,'managerIds');
					<%
					Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
					boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement__federation_add");
					boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement__federation_view");
					boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement__federation_edit");
					boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement__federation_delete");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					if(type == "否"){
						content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"发布\" onclick=\"publishById('"+id+"');\"  /> ";
						<%if(edit){%>
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
						<%} %>
					}else{
						content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"撤回\" onclick=\"backById('"+id+"');\"  /> ";
					}
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
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
	function add(){
		fbStart('新建','<%=basePath %>web/service/federation_add.jsp',800,504);	
	}
	function viewById(id){
		fbStart('查看','<%=basePath%>federation!view.action?id='+id,670,458);
	}	
	
	function editById(id){
		fbStart('编辑','<%=basePath%>federation!edit.action?id='+id,670,504);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function refreshTree(){
		$("#list").trigger("reloadGrid");
	}
	
	function publishById(id){
		if(confirm("确定要发布吗")){
			$.post("<%=basePath%>federation!publish.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function backById(id){
		if(confirm("确定要撤回吗")){
			$.post("<%=basePath%>federation!back.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteById(id){
		if(confirm("确定删除联盟")){
			$.post("<%=basePath%>federation!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadList();
	        	}
			});
		}
	}
	
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==""){
			showTip('请先选择一个联盟',2000);	
		}else if(confirm("确定要删除这些联盟")){
			$.post("<%=basePath%>federation!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadList();
	        	}
			});
		}
	}
</script>
</head>
<body>
<!--emailtop-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="add();"><span><img src="core/common/images/emailadd.gif"/></span>添加</li>
			<%} %>
			<%
				if (delete) {
			%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
			<%} %>
		</ul>
	</div>
</div>
<!--//emailtop-->
<!--container-->
<div class="msglist" id="msglist" style="padding-bottom:0px;">
	<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
	</div>
</div>
<!--//container-->
</body>
</html>
