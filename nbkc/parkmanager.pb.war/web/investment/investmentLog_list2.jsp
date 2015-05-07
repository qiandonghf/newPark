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
			    	url:'<%=basePath%>investmentLog!list2.action',
					colModel: [
						{label:'项目名称', name:'investment.name', align:"center"}, 
						{label:'交往时间', name:'linkTime', align:"center", width:100, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
						{label:'业务员', name:'userName', width:90, align:"center"}, 
						{label:'联系人', name:'linkMan', width:90, align:"center"}, 
					    {label:'内容', name:'content',  align:"center", formatter:subcontent}, 
					    {label:'管理', name:'manager', width:70, align:"center", resizable:false}
					],
					shrinkToFit: false,
					height: getTabContentHeight()-108,
					width: document.documentElement.clientWidth,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessTrack_view")){%>
							content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
							<%}%>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessTrack_edit")){%>
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
							<%}%>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessTrack_delete")){%>
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
							<%}%>
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					}
				});
			}
			function subcontent(cellvalue, options, rowObject){
				var maxLength = 60;
				if(cellvalue.length>maxLength){
					return cellvalue.substring(0,maxLength)+"...";
				}
				return cellvalue;
			}
			function viewById(id){
				fbStart('招商轨迹','<%=basePath %>investmentLog!view2.action?id='+id,500,295);
			}
			function editById(id){
				fbStart('招商轨迹','<%=basePath %>investmentLog!edit2.action?id='+id,500,295);
			}
			function doSearch(){
				search(getSearchFilters());
			}
			function search(filters){
				$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
			}
			function deleteById(id){
				if(confirm("确定要删吗")){
					$.post("<%=basePath%>investmentLog!delete2.action?id="+id,function(data){
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
					$.post("<%=basePath%>investmentLog!delete2.action?ids="+ids,function(data){
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
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessTrack_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建招商轨迹','<%=basePath %>web/investment/investmentLog_add2.jsp',500,295);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessTrack_delete")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png" /></span>删除</li>
				<%} %>	
				</ul>
			</div>
		</div>
		<div class="searchdiv">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="65">项目名称： </td>
					<td width="180"><search:input dataType="string" field="investment.name" op="cn" inputClass="inputauto"/></td>
					<td width="60" align="right">业务员：</td>
					<td width="105"><search:input dataType="string" field="userName" op="cn" inputClass="inputauto"/></td>
					<td width="50" align="right">时间：</td>
					<td width="120">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><search:choose dataType="java.util.Date" field="linkTime" op="ge"><input id="start" type="text" class="inputauto data" onclick="return showCalendar('start')"/></search:choose></td>
								<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22"  onclick="return showCalendar('start')"/></td>
							</tr>
						</table>
					</td>
					<td width="20" align="center">至</td>
					<td width="120">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><search:choose dataType="java.util.Date" field="linkTime" op="le"><input id="end" type="text" class="inputauto data" onclick="return showCalendar('end')"/></search:choose></td>
								<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22"  onclick="return showCalendar('end')"/></td>
							</tr>
						</table>
					</td>
					<td width="75" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()"/></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div>
		<table id="list" class="jqGridList"><tr><td></td></tr></table>
		<div id="pager"></div>
	</body>
</html>
