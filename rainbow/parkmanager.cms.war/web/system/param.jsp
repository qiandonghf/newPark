
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
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
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'parkmanager.cms/param!list.action',
			colModel: [
				{label:'网站名称', name:'name',align:"center",width:200}, 
				{label:'文档HTML默认保存位置', name:'htmlPath',align:"center",width:200}, 
				{label:'图片或上传文件默认路径', width:160,name:'uploadPath', align:"center"},
				{label:'关键字',width:160,name:'keyWord',hidden:true,align:"center"}, 
				{label:'描述',width:80,name:'description',hidden:true,align:"center"},
				{label:'备案号',width:80,name:'icp',hidden:true,align:"center"},
				{label:'管理员',width:80,name:'managerIds',hidden:true,align:"center",sortable:false, resizable:false}, 
				{label:'网站管理员',width:120,name:'managerNames',align:"center",sortable:false, resizable:false}, 
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
					var managerIds = $(this).getCell(id,'managerIds');
					<%
					Map<String, ResourceDto> resourceMap = CmsActivator.getHttpSessionService().getResourceMap();
					boolean add = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_add");
					boolean edit = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_edit");
					boolean delete = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_delete");
					boolean view = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_view");
					boolean set = CmsActivator.getHttpSessionService().isInResourceMap("contentManagement_param_setManager");
					%>
					<%if(set){%>
					if(managerIds.length > 0)
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"编辑管理员\" onclick=\"setManager('"+id+"','"+managerIds+"');\"  /> ";
					else
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"设置管理员\" onclick=\"setManager('"+id+"','"+managerIds+"');\"  /> ";
					<%} %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
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
	function viewById(id){
		fbStart('查看','<%=basePath%>param!view.action?id='+id,670,443);
	}	
	
	function editById(id){
		fbStart('编辑','<%=basePath%>param!edit.action?id='+id,670,573);
	}
	
	function setManager(id,ids){
		fbStart('设置管理员','<%=basePath%>web/content/multiSelector.jsp?objId='+id+"&objIds="+ids,520,400);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function refreshTree(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("确定删除链接")){
			$.post("<%=basePath%>param!delete.action?id="+id,function(data){
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
			showTip('请先选择一个网站',2000);	
		}else if(confirm("确定要删除这些网站")){
			$.post("<%=basePath%>param!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadList();
	        	}
			});
		}
	}
	
	function setWebManager(user,id){
		var ids=",";
		var names = ",";
		for(var i=0 ;i <user.length;i++){
			ids += user[i].id+",";
			names += user[i].name+",";
		}
		names = encodeURIComponent(names);
		$.ajax({
			  "url" : "<%=basePath%>param!setManager.action?ids="+ids+"&id="+id+"&memo="+encodeURIComponent(names),
			  type:"POST",
			  contentType: "application/x-www-form-urlencoded; charset=utf-8",
			  success: function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					reloadList();
				}
			  }
			});
	}
</script>
</head>
<body>
<!--emailtop-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%
				if (CmsActivator.getHttpSessionService().isInResourceMap(
							"contentManagement_param_add")) {
			%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建网站','<%=basePath %>param!add.action',670,573);"><span><img src="core/common/images/emailadd.gif"/></span>添加</li>
			<%} %>
			<%
				if (CmsActivator.getHttpSessionService().isInResourceMap(
							"contentManagement_param_delete")) {
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
