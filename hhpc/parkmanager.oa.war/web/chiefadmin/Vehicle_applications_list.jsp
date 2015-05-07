<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/><title>无标题文档</title>
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
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>carApply!list.action',
			colModel: [
				{label:'车牌号', name:'licenseNo',align:"center"}, 
				{label:'申请人',width:80,name:'creator',align:"center"}, 
				{label:'用车人',width:80,name:'usePersons',align:"center"}, 
				{label:'开始时间',width:90, name:'startDate',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'结束时间',width:90, name:'endDate',align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				{label:'审批状态', width:80,name:'status.title',align:"center"}, 
				{label:'原因', width:160,name:'reason', align:"center"},
				{label:'申请时间', width:160,name:'applyDate', align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'里程', width:160,name:'distance', align:"center",hidden:true},
				{label:'油耗', width:160,name:'oil', align:"center",hidden:true},
				{label:'备注', width:160,name:'memo', align:"center",hidden:true},
				{label:'审批人Id', width:160,name:'approverId', align:"center",hidden:true},
			    {label:'管理',width:80, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: true,
			multiselect: true,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					if($(this).getCell(id,13)==""){
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"提交申请\" onclick=\"auidtById('"+id+"');\"  /> ";
					}else if($(this).getCell(id,13)==<%=OaActivator.getSessionUser(request).getId()%>){
						content += "<img src=\"core/common/images/profile.gif\" width=\"14\" height=\"14\" title=\"审批\" onclick=\"approve('"+id+"');\"  /> ";
					}
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
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
	
	function auidtById(id){
		if(confirm("是否提交申请?")){
			$("#applyId").val(id);
			fbStart('选择审批人','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
		}
	}
	
	function approve(id){
		if(confirm("是否同意?")){
			$.post("<%=basePath%>carApply!approveCarApply.action?id="+id+"&applyCheck="+1,function(data){
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}else{
			$.post("<%=basePath%>carApply!approveCarApply.action?id="+id+"&applyCheck="+0,function(data){
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	
	function viewById(id){
		fbStart('车辆查看','<%=basePath%>carApply!view.action?id='+id,550,300);
	}	
	
	function editById(id){
		fbStart('车辆编辑','<%=basePath%>carApply!edit.action?id='+id,550,300);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>carApply!delete.action?id="+id,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				}else{
					showTip("没有权限");
				}
			});
		}
	}
	
	function deleteSelected(){
		if(confirm("确定要删吗")){
			var ids = $("#list").jqGrid("getGridParam","selarrrow");
			$.post("<%=basePath%>carApply!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function setSelectedUser(user){
		var id = user.id;
		var name = user.realName;
		$.post("<%=basePath%>carApply!approve.action?approverId="+id+"&approverl="+name+"&id="+$("#applyId").val(),function(data){
			if(data.result.success){
				showTip("送审成功",2000);
				$("#list").trigger("reloadGrid");
			}
		});
		}
</script>
</head>
<body>
<input type="hidden" id="applyId"/>
<!--emailtop-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建车辆申请单','<%=basePath %>web/chiefadmin/Vehicle_applications_add.jsp',550,300);"><span><img src="core/common/images/emailadd.gif"/></span>新建车辆申请单</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		</ul>
	</div>
</div>
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
