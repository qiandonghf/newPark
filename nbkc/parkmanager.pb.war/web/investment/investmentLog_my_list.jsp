<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.Investment"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/merchants.css"/>
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
		<script type="text/javascript">
			$(function(){
				$('#investRight_height').css('height',getTabContentHeight()-8);
				$('#investRight_height2').css('height',getTabContentHeight()-12);
				$('#investRight_height3').css('height',getTabContentHeight()-46);
				initTip();
				initList();
				jqGridResizeRegister("list");
			});
			function initList(){
				$("#list").jqGrid({
			    	url:'<%=basePath%>investmentLog!myList.action',
					colModel: [
						{label:'交往时间', name:'linkTime', align:"center", width:100, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
						{label:'联系人', name:'linkMan', width:100, align:"center"}, 
					    {label:'内容', name:'content', width:220, align:"center", formatter:subcontent}, 
					    {label:'管理', name:'manager', width:70, align:"center", resizable:false,sortable:false}
					],
					shrinkToFit: false,
					height: getTabContentHeight()-124,
					width: document.documentElement.clientWidth-8,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_track_myView")){%>
							content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
							<%}%>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_track_myEdit")){%>
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
							<%}%>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_track_myDelete")){%>
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
							<%}%>
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					},
					postData: {filters:generateSearchFilters("investmentId","eq",${param.id},"long")}
				});
			}
			function subcontent(cellvalue, options, rowObject){
				//var maxLength = 60;
				//if(cellvalue.length>maxLength){
				//	return cellvalue.substring(0,maxLength)+"...";
				//}
				return cellvalue;
			}
			function viewById(id){
				fbStart('招商轨迹','<%=basePath %>investmentLog!myView.action?id='+id,500,295);
			}
			function editById(id){
				fbStart('招商轨迹','<%=basePath %>investmentLog!myEdit.action?id='+id,500,295);
			}
			function deleteById(id){
				if(confirm("确定要删吗")){
					$.post("<%=basePath%>investmentLog!myDelete.action?id="+id,function(data){
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
					$.post("<%=basePath%>investmentLog!myDelete.action?ids="+ids,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("#list").trigger("reloadGrid");
			        	}
					});
				}
			}
		</script>
	</head>
	<body>
<div class="basediv" id="investRight_height">
	<div class="divlays" style="margin:0px;" id="investRight_height2">
		<jsp:include page="common_my.jsp">
			<jsp:param value="3" name="index"/>
			<jsp:param value="${param.id}" name="investmentId"/>
			<jsp:param value="${param.investmentStatus}" name="investmentStatus"/>
		</jsp:include>
		<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
			<div class="emailtop">
				<div class="leftemail">
					<ul>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_track_myAdd")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建招商轨迹','<%=basePath %>investmentLog!myAdd.action?id=${param.id}',500,295);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_track_myDelete")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png" /></span>删除</li>
					<%} %>
					</ul>
				</div>
			</div>
			<table id="list">
			<tr><td></td></tr></table>
			<div id="pager"></div>
		</div>
	</div>
</div>
</body>
</html>
