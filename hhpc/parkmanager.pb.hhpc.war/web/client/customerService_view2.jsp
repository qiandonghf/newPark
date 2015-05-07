<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
			$(function(){
				initTip();
				$('#investRight_height').css('height',getTabContentHeight()-8);
				$('#investRight_height2').css('height',getTabContentHeight()-12);
				$('#investRight_height3').css('height',getTabContentHeight()-46);
				initList();
			});
			
			function initList(){
				$("#list").jqGrid({
			    	url:'<%=basePath%>customerServiceTrack!list.action',
					colModel: [
						{label:'处理人', name:'user.realName', align:"center"}, 
						{label:'服务时间',width:80, name:'handleTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
					    {label:'内容', name:'content', align:"center",width:300,formatter:formContent}, 
					    {label:'操作',width:45, name:'manager', align:"center", sortable:false, resizable:false}
					],
					height: getTabContentHeight()-230,
					width: document.documentElement.clientWidth-20,
					shrinkToFit: false,
					multiselect: false,
					postData:{filters:generateSearchFilters("serviceId","eq","${result.value.id}","long")},
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerServiceTrack_delete")){ %>
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
							<%}%>
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					}
				});
			}
			
			function formContent(cellvalue,options,rowObject){
				var span = "<span title='"+cellvalue+"'>";
				if(cellvalue.length>15){
					cellvalue = cellvalue.substring(0,15)+"....";
				}
				span += cellvalue;
				return span;
			}
			
			function reloadList(){
				$("#list").trigger("reloadGrid");
			}
			
			function deleteById(id){
				if(confirm("确认要删除？")){
					$.post("<%=basePath%>customerServiceTrack!delete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							/* location.reload(); */
							reloadList();
						}
					});
				}
			}
</script>
<style>
h1 {
	font: bold 16px/32px '';
	height: 32px;
	text-align: center;
}
</style>
</head>
<body style="padding-bottom: 2px;">
	<div class="basediv" id="investRight_height">
		<div class="divlays" id="investRight_height2" style="margin:0px;">
			<jsp:include page="common.jsp">
				<jsp:param value="1" name="index"/>
			</jsp:include>
			<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
			</div>
		</div>
	</div>
	<%-- <div id="pm_msglist" class="pm_msglist" style="overflow: scroll; overflow-x: hidden;border-bottom: 0;">
		<h1>企业服务联系单</h1>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy2">
			<tbody>
				<tr>
					<th>企业名称：</th>
					<td colspan="3">${result.value.customer.name }</td>
				</tr>
				<tr>
					<th>联系人：</th>
					<td>${result.value.contect}</td>
					<th>服务类型：</th>
					<td>${result.value.type.dataValue }</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th>联系电话：</th>
					<td>${result.value.phone }</td>
					<th>受理开始日期：</th>
					<td><fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd" /></td>
					
				</tr>
				<tr>
					<th>受理人：</th>
					<td>${result.value.user.username }</td>
					<th>受理结束日期：</th>
					<td><fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd" /></td>
				</tr>
				<tr>
					<th>服务结果：</th>
					<td>${result.value.result.title }</td>
					<th>状态：</th>
					<td>${result.value.status.title }</td>
				</tr>
				<tr>
					<th>情况说明：</th>
					<td colspan="3"><div style="height:40px;overflow-y:auto; overflow-x:hidden; ">${result.value.description}</div></td>
				</tr>
				<tr>
					<th>企业意见及建议：</th>
					<td colspan="3"><div style="height:40px;overflow-y:auto; overflow-x:hidden; ">${result.value.suggest}</div></td>
				</tr>
			</tbody>
		</table>

		
	</div> --%>
</body>
</html>
