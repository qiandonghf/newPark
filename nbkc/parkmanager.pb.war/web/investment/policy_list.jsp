<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.Investment"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/merchants.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		
		<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
		<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
		
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
				initList();
			});
			function initList(){
				$("#list").jqGrid({
			    	url:'<%=basePath%>policy!list.action',
					colModel: [
						{label:'发布年度', name:'year', width:80, align:"center"}, 
						{label:'类型', name:'type.dataValue', align:"center", width:80}, 
						{label:'启用', name:'usable.title', width:70, align:"center"}, 
					    {label:'内容', name:'content', width:420, align:"center", formatter:subcontent}, 
					    {label:'管理', name:'manager', width:70, align:"center", resizable:false}
					],
					shrinkToFit: false,
					height: getTabContentHeight()-78,
					width: document.documentElement.clientWidth,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policy_view")){%>
							content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policy_edit")){%>
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
						<%}%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policy_delete")){%>
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
						<%}%>
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					}
				});
			}
			function subcontent(cellvalue, options, rowObject){
				var maxLength = 100;
				if(cellvalue.length>maxLength){
					return cellvalue.substring(0,maxLength)+"...";
				}
				return cellvalue;
			}
			function viewById(id){
				fbStart('招商政策','<%=basePath %>policy!view.action?id='+id,500,295);
			}
			function editById(id){
				fbStart('编辑招商政策','<%=basePath %>policy!edit.action?id='+id,500,295);
			}
			function doSearch(){
				search(getSearchFilters());
			}
			function search(filters){
				$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
			}
			function deleteById(id){
				if(confirm("确定要删吗")){
					$.post("<%=basePath%>policy!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("#list").trigger("reloadGrid");
			        	}
					});
				}
			}
			function deleteSelected(){
				var ids = $("#list").jqGrid("getGridParam","selarrrow");
				if(ids!='' && confirm("确定要删吗")){
					$.post("<%=basePath%>policy!delete.action?ids="+ids,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("#list").trigger("reloadGrid");
			        	}
					});
				}
			}
		</script>
	</head>

	<body style="background: #fff">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policy_add")){%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建招商政策','<%=basePath %>web/investment/policy_add.jsp',500,315);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policy_delete")){%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png" /></span>删除</li>
				<%} %>
				</ul>
			</div>
		</div>
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</body>
</html>
