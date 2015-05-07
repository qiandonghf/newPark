<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.*"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	$(document).ready(function() {
		initTip();
		initList();
	});
	
	function initList(){
		var height;
		<%if(PbActivator.getSessionUser(request).getAdmin() == BooleanEnum.YES ){%>
			height = getTabContentHeight()-75;
		<%}else{%>
			height = getTabContentHeight()-50;
		<%}%>
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>vip!list.action',
			colModel: [
				{label:'编号',width:80, name:'orderId',align:"center"},
				{label:'姓名',width:90,name:'name',align:"center"}, 
				{label:'性别',width:55,name:'gender.title',align:"center"}, 
				{label:'手机',width:110,name:'mobile',align:"center"}, 
				{label:'联系电话',width:110,name:'phone',align:"center"}, 
				{label:'职称',name:'position',align:"center"}, 
				{label:'是否导师',width:90,name:'tutor.title',align:"center"}, 
				{label:'账号', name:'userId', align:"center", hidden:true},
				{label:'出生年月',width:90,name:'birth',align:"center",hidden:true}, 
				{label:'学历',width:90,name:'education',align:"center",hidden:true}, 
				{label:'职务',width:90,name:'job',align:"center",hidden:true}, 
				{label:'就职单位',width:90,name:'nuit',align:"center",hidden:true}, 
			    {label:'管理',width:70,name:'manager',align:"center",sortable:false,resizable:false}
			],
			shrinkToFit: false,
			height: height,
			width: width,		
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";					
					var row = $(this).jqGrid('getRowData',id);
					if(row.userId==''){
						<%if(PbActivator.getHttpSessionService().isInResourceMap("vip_configAccount")){%>
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"设置账号\" onclick=\"createUser('"+id+"');\"  /> ";
						<%}%>
					}else{
						<%if(PbActivator.getHttpSessionService().isInResourceMap("vip_updatePassword")){%>
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"修改密码\" onclick=\"updateAccountPassword('"+row.userId+"');\"  /> ";
						<%}%>
					}
					<%if(PbActivator.getSessionUser(request).getAdmin() == BooleanEnum.YES ){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
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
	
	function createUser(id){
		fbStart('设置账号','<%=basePath %>vip!configAccount.action?id='+id,300,123);
	}
	function updateAccountPassword(userId){
		fbStart('修改密码','<%=basePath %>vip!updatePassword.action?id='+userId,300,95);
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function viewById(id){
		fbStart('查看专家','<%=basePath%>vip!view.action?id='+id,600,400);
	}	
	
	function editById(id){
		fbStart('编辑专家','<%=basePath%>vip!edit.action?id='+id,600,433);
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>vip!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}

function deleteSelected(){
	if(confirm("确定要删吗")){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		$.post("<%=basePath%>vip!delete.action?ids="+ids,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}

function toImportCard() {
	if(confirm("确定要导入名片夹（协会-专家管理）吗")){
		showTip("正在导入全部名片，请稍候...",100000);
		$.post("<%=basePath%>vip!importCard.action",
				function(data){
					showTip(data.result.msg,2000);
		});
	}
 }
</script>
</head>

<body>
<!--emailtop-->
				<%if(PbActivator.getSessionUser(request).getAdmin() == BooleanEnum.YES ){%>
<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建专家','<%=basePath %>web/vip/vip_add.jsp',600,429);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toImportCard()"><span><img src="core/common/images/card.png"/></span>导入名片</li>
				</ul>
			</div>
		</div>
				<%}%>
<!--//emailtop-->
<!--container-->
<div class="msglist" id="msglist">
		<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
		</div>
	</div>
<!--//container-->
</body>
</html>
