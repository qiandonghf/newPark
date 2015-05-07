<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
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
	var height = getTabContentHeight()-75;
	var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
	$("#list").jqGrid({
    	url:'<%=basePath%>supplyApply!listAll.action',
		colModel: [
			{label:'商品名称', name:'supply.name',width:"105", align:"center"}, 
			{label:'申请日期', name:'applyTime',width:"85", align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
		    {label:'申请号', name:'id', width:"75", align:"center"}, 
		    {label:'申请数量', name:'amount',width:"100", align:"center",formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}},
		    {label:'申请人', name:'applyer', width:"90",align:"center"},
		    {label:'备注', name:'memo', width:"100",align:"center"},
		  /* 	{label:'审批状态', name:'status.title', width:"90", align:"center"},  
			{label:'审批人Id', width:160,name:'approverId', align:"center",hidden:true},*/
		    {label:'操作', name:'manager', align:"center", width:"50",resizable:false}
		],
		shrinkToFit: false,
		height: height,
		width: width,
		multiselect: true,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
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
function auidtById(id){
	if(confirm("是否提交申请?")){
		$("#applyId").val(id);
		fbStart('选择审批人','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
	}
}

function approve(id){
	if(confirm("是否同意?")){
		$.post("<%=basePath%>supplyApply!approveApply.action?id="+id+"&applyCheck="+1,function(data){
        	if(data.result.success){
        		showTip(data.result.msg,2000);
        		$("#list").trigger("reloadGrid");
        	}
		});
	}else{
		$.post("<%=basePath%>supplyApply!approveApply.action?id="+id+"&applyCheck="+0,function(data){
			if(!data.result.success){
				showTip(data.result.msg,2000);
        		$("#list").trigger("reloadGrid");
        	}
		});
	}
}
function viewById(id){
	fbStart('查看','<%=basePath%>supplyApply!view.action?id='+id,400,200);
}

function editById(id){
	fbStart('编辑申请单','<%=basePath %>supplyApply!edit.action?id='+id,500,200);
}
function deleteById(id){
	if(confirm("确定要删吗")){
		$.post("<%=basePath%>supplyApply!delete.action?id="+id,function(data){
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

function deleteByIds(){
	var ids = $("#list").jqGrid("getGridParam","selarrrow");
	if(ids!='' && confirm("确定要删吗")){
		$.post("<%=basePath%>supplyApply!delete.action?ids="+ids,function(data){
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

function reloadList(){
	$("#list").trigger("reloadGrid");
}

function setSelectedUser(user){
	var id = user.id;
	var name = user.realName;
	$.post("<%=basePath%>supplyApply!approve.action?approverId="+id+"&approverl="+name+"&id="+$("#applyId").val(),function(data){
		if(data.result.success){
			showTip("送审成功",2000);
			$("#list").trigger("reloadGrid");
		}
	});
	}
</script>

</head>

<body>
<form action="<%=basePath%>supplyApply!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<input type="hidden" id="applyId"/>
	<!--emailtop-->
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''"
					onclick="fbStart('新建办公用品申请','<%=basePath %>web/chiefadmin/Office_supplies_sq_add.jsp',500,200);"><span><img
						src="core/common/images/emailadd.gif" /></span>新建</li>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="deleteByIds()"><span><img
						src="core/common/images/emaildel.png" /></span>删除</li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
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
