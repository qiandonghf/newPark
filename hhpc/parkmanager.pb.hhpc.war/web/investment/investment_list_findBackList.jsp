<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
		<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
		<style type="text/css">
			.highlight {
				background: #f4f4f4
			}
			#pageDiv{
				position:absolute;
				width:690px;
				bottom:4px;
			}
		</style>
		<script type="text/javascript">
			/* $(document).ready(function() {
				$("#container").css('height',getTabContentHeight()-28);
			}); */
			function searchAll(){
				$("#name").val("");
				jumpPage(1);
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>investment!loadRmiBlackList.action?id="+$(this).find("input").val();
				url += "?page="+page;
				if($("#name").val()){
					url += "&name="+$("#name").val();
				}
				url = encodeURI(url);
				location.href=url;
			}
		</script>
	</head>

	<body bgcolor="#eeeeee">
		<div style="border: #c3c3c3 1px solid;margin: 4px;background: #fff;" >
		<div id="container" style="height:396px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="355" valign="top" id="fee_lefts">
						<div class="write_list" style="border-right:1px solid #ddd; width:100%;" id="resizable">
							<div class="searchdiv">
								<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="65">名称： </td>
										<td width="180"><input id="name" name="name" type="text" class="inputauto" value=""/></td>
										<td width="80" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()" /></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
							<div id="investmentdiv" style="overflow-x: hidden;overflow-y:auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class="tdcenter" width="50%" align="center" >详细信息</td>
									<td class="tdcenter" width="30%" align="center" >信息来源</td>
									<td class="tdcenter" width="20%" align="center" >时间</td>
								</tr>
								<c:if test="${pager.records gt 0 }">
									<c:forEach items="${result.value}" var="dto">
										<tr class="investmenttr">
											<td class="lefttd" align="center">${dto.content}</td>
											<td class="lefttd" align="center">${dto.incubatorName}</td>
											<td class="lefttd" align="center">${dto.inTime}</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${connect }">
									<c:if test="${pager.records eq 0 }">
										<tr class="investmenttr">
											<td colspan="3" class="lefttd" align="center">没有对应黑名单信息,<a href="javascript:void(0);" onclick="searchAll();">查看所有</a></td>
										</tr>
									</c:if>
								</c:if>
								<c:if test="${connect==false }">
									<tr class="investmenttr">
										<td colspan="3" class="lefttd" align="center"><span style="color: red;">远程连接受限</span></td>
									</tr>
								</c:if>
							</table>
							<div id="pageDiv">
								<%@include file="../pager.jsp" %>
							</div>
						</div>
					</div>
					</td>
				</tr>
			</table>
		</div>
		</div>
		<div style="padding-bottom: 4px;">
		</div>
	</body>
</html>
