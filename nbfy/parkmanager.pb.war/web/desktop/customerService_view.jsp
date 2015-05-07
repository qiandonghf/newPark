<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
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
				initList();
			});
			
			function initList(){
				$("#list").jqGrid({
			    	url:'<%=basePath%>customerServiceTrack!list.action',
					colModel: [
						{label:'处理人', name:'user.realName', align:"center"}, 
						{label:'服务时间',width:80, name:'handleTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
					    {label:'内容', name:'content', align:"center",width:425}
					],
					height: 110,
					width: document.documentElement.clientWidth,
					shrinkToFit: false,
					multiselect: false,
					postData:{filters:generateSearchFilters("serviceId","eq","${result.value.id}","long")}
				});
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
<body>
	<div id="pm_msglist" class="pm_msglist" >
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

		<div class="" style="padding: 5px 0 0;">
			<p style="height: 25px; padding: 0 15px; font: bold 12px/25px ''; background: #f0f0f0; border: 1px solid #D9D9D9; border-bottom: none;">服务轨迹</p>
			<div>
				<table id="list" class="jqGridList"><tr><td/></tr></table>
			</div>
		</div>
	</div>
</body>
</html>
