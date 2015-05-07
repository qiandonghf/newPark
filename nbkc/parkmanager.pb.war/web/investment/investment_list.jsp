<%@page import="com.wiiy.core.dto.ResourceDto"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
		<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
		<style type="text/css">
			.highlight {
				background: #f4f4f4
			}
		</style>
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#resizable').css('height',getTabContentHeight()-28);
				$('#pm_msglist').css('height',getTabContentHeight()-28);
				$('#investmentdiv').css('height',getTabContentHeight()-58);
				initMenu();
				initTip();
				initSelect();
			});
			
			function initSelect(){
				var type=$("#type").val();
				if(type=="ALL"){
					$("select >option:eq(0)").attr("selected","selected");
				}else if(type=="NEW"){
					$("select >option:eq(1)").attr("selected","selected");
				}else if(type=="SLEEP"){
					$("select >option:eq(2)").attr("selected","selected");
				}else if(type=="APPROVAL"){
					$("select >option:eq(3)").attr("selected","selected");
				}else if(type=="DISAGREE"){
					$("select >option:eq(4)").attr("selected","selected");
				}else if(type=="PARK"){
					$("select >option:eq(5)").attr("selected","selected");
				}
			}
			
			function openRight(id){
				var currentTime = new Date();//添加一个时间戳，避免二次请求被浏览器忽略
				$("#pm_msglist").attr("src","<%=basePath%>investment!view.action?id="+id+"&currentTime="+currentTime);
			}
			
			function initMenu(){
				var menu = 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_allEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_allPrint")){%>
					[[
				<%
				Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
				boolean flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allView")){
					flag = true;
				%>
				    {
					text: "<%=resourceMap.get("pb_project_allView").getName() %>",
					classname: "smarty_menu_view",
					func: function() {
						openRight($(this).find("input").val());
					}
				}
				<%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allEdit")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				{
					text: "<%=resourceMap.get("pb_project_allEdit").getName() %>",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!edit.action?id="+$(this).find("input").val(),700,538);
					}
				}
				<%}%>
				<%
					if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allPrint")){
						if(flag){
							%>,<%
						}
						flag = true;
				%>
				{
					text: "<%=resourceMap.get("pb_project_allPrint").getName() %>",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!print.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				]]
				<%}else{%>""<%}%>	
					;
				$(".investmenttr").smartMenu(menu,{name:'menu'});
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>investment!list.action";
				url += "?page="+page;
				if($("#name").val()){
					url += "&name="+$("#name").val();
				}
				url = encodeURI(url);
				location.href=url;
			}
			function approvalCallback(){
				window.frames[0].location.reload();
			}
			function highlight(el){
				$(el).addClass("highlight");
				$(el).siblings().removeClass("highlight").css("background","#fff");
			}
			function keepHighlight(el){
				if($(el).hasClass("highlight")){
					$(el).css("background","#f4f4f4");
				}
			}
			function setSelectedUser(user){
				var type = $("#approvalType").val();
				var investmentId = $("#investmentId").val();
				var url = "<%=basePath%>investment!"+type+"Approval.action?id="+investmentId+"&userId="+user.id;
				$.post(url,function(data){
					showTip(data.result.msg,2000);
				});
			}
			
			function reloadPage(cusId){
				location.reload();
				openRight(cusId);
			}
			
			function change(){
				var type = $("select :selected").val();
				var url = "<%=basePath%>investment!listByType.action?type="+type;
				getOpener().location.href=url;
			}
		</script>
	</head>

	<body>
		<input type="hidden" id="approvalType"/>
		<input type="hidden" id="investmentId"/>
		<input type="hidden" id="type" value="${type }"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.reload()"><span><img src="core/common/images/refresh3.png" /></span>刷新</li>
					<%-- <li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建申请单','<%=basePath %>web/investment/investment_add.jsp',700,538);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li> --%>
				</ul>
			</div>
		</div>
		<div id="container">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="355" valign="top" id="fee_lefts">
						<div class="write_list" style="border-right:1px solid #ddd; width:355px;" id="resizable">
							<div class="searchdiv">
								<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="65">项目名称： </td>
										<td width="100"><input id="name" name="name" type="text" class="inputauto" value="${name}"/></td>
										<td>&nbsp;</td>
										<td width="80">
											<select onchange="change()">
												<option value="ALL">所有项目</option>
												<option value="NEW">洽谈项目</option>
												<option value="SLEEP">睡眠项目</option>
												<option value="APPROVAL">审批项目</option>
												<option value="DISAGREE">否决项目</option>
												<option value="PARK">落户项目</option>
											</select>
										</td>
										<td width="80" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()" /></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
							<div id="investmentdiv" style="overflow-x: hidden;overflow-y:auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td width="17" class="tdleftc"><img src="core/common/images/gthgray.png" /></td>
									<td class="tdcenterL">项目名称</td>
									<td class="tdleftc" width="95">最后处理时间</td>
								</tr>
								<c:forEach items="${result.value}" var="investment">
								<tr onmouseover="this.style.background='#f4f4f4';" onmouseout="this.style.background='#fff';keepHighlight(this)" class="investmenttr" style="cursor: pointer;" onclick="openRight(${investment.id});highlight(this);">
									<%  Investment investment = (Investment)pageContext.getAttribute("investment");
										String priorityColor = "";
										if(investment.getPriority()!=null){
											switch(investment.getPriority()){
												case LOW:
													priorityColor = "blue";
													break;
												case MIDDLE:
													priorityColor = "yellow";
													break;
												case HIGH:
													priorityColor = "red";
													break;
											}
										}
									%>
									<td class="centertd"><c:if test="${investment.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if></td>
									<td class="lefttd">${investment.name}<input type="hidden" value="${investment.id}" /><input type="hidden" value="${investment.regInfo.organizationNumber}" /></td>
									<td class="centertd"><fmt:formatDate value="${investment.modifyTime}" pattern="yyyy-MM-dd"/></td>
								</tr>
								</c:forEach>
							</table>
							<%@include file="../pager.jsp" %>
						</div>
						</div>
					</td>
					<td valign="top">
						<iframe src="<%=basePath %>web/investment/investment_index.jsp" scrolling="no" frameborder="0" id="pm_msglist" width="100%" name="app"></iframe>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
