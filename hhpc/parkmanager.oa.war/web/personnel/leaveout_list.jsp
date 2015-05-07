<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>leaveRegister!list.action',
			colModel: [
				{label:'申请人',width:120, name:'applicant',align:"center"}, 
				{label:'假别',width:80, name:'leaveType.title',align:"center"}, 
				{label:'申请日期',width:100,name:'applyTime',align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
				{label:'开始时间',width:120,name:'startTime',align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
				{label:'结束时间',width:120,name:'endTime',align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d H:i', newformat: 'Y-m-d H:i'}}, 
				{label:'请假原因', name:'memo',align:"center"}, 
				/* {label:'审批结果', width:80,name:'approvals', align:"center",formatter:formatApprovals}, */
			    {label:'操作',width:70, name:'manager', align:"center", sortable:false, resizable:false}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_leaveRegister_add");
					boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_leaveRegister_edit");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_leaveRegister_del");
					boolean view = OaActivator.getHttpSessionService().isInResourceMap("oa_leaveRegister_view");
					boolean exportData = OaActivator.getHttpSessionService().isInResourceMap("oa_leaveRegister_export");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteAllById('"+id+"');\"  /> ";
					<%} %>
					/* if($(this).getCell(id,8)==""){
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"送审\" onclick=\"approveById('"+id+"');\"  /> ";
						content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					}else{
					} */
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
	
	function approveById(id){
		$("#applyId").val(id);
		fbStart('送审','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
	}
	
	function examineById(id){
		fbStart('审批请假单','<%=basePath%>leaveApproval!approveView.action?id='+id,650,300);
	}
	
	function formatApprovals(cellvalue, options, rowObject){
		var array = $.parseJSON(cellvalue);
		var content = "";
		for(var i = 0; i < array.length; i++){
			content += array[i].username + ":" + array[i].status+"</br>";
		}
		return content;
	}
	
	function setSelectedUser(user){
		var id = user.id;
		var name = user.realName;
		$.post("<%=basePath%>leaveApproval!approve.action?approverId="+id+"&approver="+name+"&applyId="+$("#applyId").val(),function(data){
			if(data.result.success){
				showTip("送审成功",2000);
				$("#list").trigger("reloadGrid");
			}
		});
		}

	function viewById(id){
		fbStart('查看','<%=basePath%>leaveRegister!view.action?id='+id,500,280);
	}	
	
	function editById(id){
		fbStart('编辑','<%=basePath%>leaveRegister!edit.action?id='+id,600,334);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>leaveRegister!delete.action?id="+id,function(data){
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
	
	function deleteAllById(id){
		if(confirm("请假登记已经送审,还是要删除吗")){
			$.post("<%=basePath%>leaveRegister!deleteAll.action?id="+id,function(data){
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
			$.post("<%=basePath%>leaveRegister!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function exportData(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		$("#exportIds").val(ids);
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
</script>
</head>
<body>
<form action="<%=basePath%>leaveRegister!export.action" id="exportForm" method="post">
	<input type="hidden" id="exportIds" name="exportIds" />
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<input type="hidden" id="applyId"/>
<!--emailtop-->
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(add){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('请假单','<%=basePath %>leaveRegister!add.action',650,300);"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
			<%} %>
			<%if(delete){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
			<%} %>
			<%if(exportData){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/database_(start)_16x16.gif"/></span>导出</li>
			<%} %>
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
