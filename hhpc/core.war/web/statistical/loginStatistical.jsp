<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>

<script type="text/javascript">
	$(function(){
		$("#content").css("height",getTabContentHeight()-30);
	});
	function doSearch(){
		if(!$("#days").val()){
			$("#days").val(7);
		}
		$("#form").submit();
	}
	
	function showDetails(userId,userName){
		fbStart("用户【"+userName+"】${days}天内账号登录明细",
				'<%=basePath %>statistical!showDetails.action?userId='+userId+"&days="+$("#days").val(),
						650,410);
	}
</script>
</head>
<body>
	<!--container-->
	<div id="container">
		<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
					<li <c:if test="${days==7}">style="background:#e4f3ff"</c:if> onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="$('#days').val(7);doSearch();"><span><img src="core/common/images/meter.gif" /></span>7天内</li>
					<li <c:if test="${days==15}">style="background:#e4f3ff"</c:if> onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="$('#days').val(15);doSearch();"><span><img src="core/common/images/meter.gif" /></span>15天内</li>
					<li <c:if test="${days==30}">style="background:#e4f3ff"</c:if> onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="$('#days').val(30);doSearch();"><span><img src="core/common/images/meter.gif" /></span>30天内</li>
				</ul>
			</div>
			<!--//leftemail-->
		</div>
		<div class="searchdiv">
		<form id="form" action="<%=basePath%>statistical!loginStatistical.action" method="post">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40" align="right">用户： </td>
				<td width="120"><input name="username" class="inputauto" value="${username}"/></td>
				<td width="50" align="right">部门： </td>
				<td width="155">
					<input id="days" type="hidden" name="days" value="${days}"/>
					<select name="orgId" class="data" style="width:150px; height:20px; line-height:20px;">
						<option value="">----请选择----</option>
						<c:forEach items="${orgList}" var="org">
							<option value="${org.id}" <c:if test="${org.id eq orgId}">selected="selected"</c:if>>${org.name}</option>
						</c:forEach>
					</select>
        		</td>
        		<td width="75" align="center"><input name="" type="button" class="searchbtn" onclick="doSearch()"/></td>
        		<td>&nbsp;</td>
        	</tr>
        	</table>
		</form>
		</div>
		<div id="content" style="overflow-y: auto">
			<table width="600" style="margin: 5px 0 0 5px;" border="0" cellspacing="0" cellpadding="10">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="crmtable">
							<tr onmouseout="this.style.background='#fff'" onmouseover="this.style.background='#f4f4f4'">
								<td width="200" class="tdcenter">用户</td>
								<td width="100" class="tdcenter">部门</td>
								<td class="tdcenter">登录次数</td>
								<td class="tdcenter">登录IP</td>
							</tr>
							<c:forEach items="${result.value}" var="dto">
								<tr onmouseout="this.style.background='#fff'" onmouseover="this.style.background='#f4f4f4'" onmousedown="showDetails(${dto.userId},'${dto.username}');">
									<td class="crmcounttd">${dto.username}</td>
									<td class="crmcounttd">${dto.depart}</td>
									<td class="crmcounttd">${dto.loginCount}</td>
									<td class="crmcounttd">${dto.ipCount}</td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!--//container-->
</body>
</html>
