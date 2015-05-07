<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.crm.entity.CustomerService"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
		<META HTTP-EQUIV="Expires" CONTENT="0"> 
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
		<script type="text/javascript">
			$(document).ready(function() {
				$('#resizable').css('height',getTabContentHeight()-28);
				$('#pm_msglist').css('height',getTabContentHeight()-28);
				$('#customerServicediv').css('height',getTabContentHeight()-58);
				initMenu();
				initTip();
				var id = $("#customerServiceId").val();
				if(id!=null && id!=""){
					openRight(id);
				}
			});
			function openRight(id){
				$("#pm_msglist").attr("src","<%=basePath%>customerService!view.action?id="+id+"&t="+(new Date).valueOf()+"");
				highlight($("#customerService"+id));
				keepHighlight($("#customerService"+id));
			}
			function initMenu(){
				var menu = [[
			<%boolean flag=false;
			if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_view")){flag=true;%>
				             {
					text: "打开",
					classname: "smarty_menu_view",
					func: function() {
						openRight($(this).find("input").val());
					}
				}
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_edit")){
					if(flag){%>,<%}
					flag=true;
					%>
					{
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>customerService!edit.action?id="+$(this).find("input").val(),700,308);
					}
				}
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_print")){
					if(flag){%>,<%}
					flag=true;
					%>
				{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>customerService!print.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				],[
				   <%flag=false;
				   if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_accept")){flag=true;%>
				   {
					text: "受理",
					classname: "smarty_menu_acceptance",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!accept.action?id="+id,function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				<%}%>	
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_closed")){
					if(flag){%>,<%}
					flag=true;%>
				   {
					text: "关闭",
					classname: "smarty_menu_close",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!serviceClosed.action?id="+$(this).find("input").val(),function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				   <%}%>	
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_suspend")){
						if(flag){%>,<%}
						flag=true;%>
				   {
					text: "挂起",
					classname: "smarty_suspend",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!suspend.action?id="+$(this).find("input").val(),function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				   <%}%>	
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_send")){
						if(flag){%>,<%}
						flag=true;%>
				   {
					text: "发送",
					classname: "smarty_send",
					func: function() {
						$("#customerServiceId").val($(this).find("input").val());
						fbStart('选择接收人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
					}
				}
				   <%}%>  
				   ],[
				      <%flag=false;
				      if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_solved")){flag=true;%>
				      {
					text: "已解决",
					classname: "smarty_menu_finish",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!solved.action?id="+$(this).find("input").val(),function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				      <%}%>	
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_unsolved")){
							if(flag){%>,<%}
							flag=true;%>
				      {
					text: "未解决",
					classname: "smarty_menu_failed",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!unsolved.action?id="+$(this).find("input").val(),function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				      <%}%>	
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_partSolved")){
							if(flag){%>,<%}
							flag=true;%>
				      {
					text: "部分解决",
					classname: "smarty_menu_part",
					func: function() {
						var id = $(this).find("input").val();
						$.post("<%=basePath%>customerService!partSolved.action?id="+$(this).find("input").val(),function(){
							location.href = '<%=basePath%>customerService!list.action?id='+id;
						});
					}
				}
				      <%}%>
				      ],[
				         <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_delete")){%>
				         {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>customerService!delete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									location.reload();
								}
							});
						}
					}
				}
				         <%}%>
				         ]];
				$(".customerServicetr").smartMenu(menu,{name:'menu'});
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>customerService!list.action";
				url += "?page="+page;
				if($("#customerName").val()){
					url += "&name="+$("#customerName").val();
				}
				url = encodeURI(url);
				location.href=url;
			}
			
			function setSelectedUser(user){
				var id = $("#customerServiceId").val();
				$.post("<%=basePath%>customerService!send.action?id="+id+"&userId="+user.id,function(data){
					if(data.result.success){
						showTip("发送成功",2000);
						openRight(id);
					}else{
						showTip("发送失败",2000);
					}
				});
			}
			
			function setSelectedCustomer(customer){
				$("#customerId").val(customer.id);
				$("#customerName").val(customer.name);
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
			
		</script>
	</head>

	<body>
		<input id="customerServiceId" value="${id }" type="hidden"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerService_add")){ %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建联系单','<%=basePath %>web/client/customerService_add.jsp',700,200);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
				<%} %>
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
										<td width="65">企业名称： </td>
										<td width="180">
											<input type="hidden" id="customerId"/><input onkeyup="$('#customerId').val('')" id="customerName" type="text" class="data inputauto"/>
										</td>
										<td width="20"><img style="cursor:pointer;" src="core/common/images/outdiv.gif" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
										<td width="80" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()" /></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
							<div id="customerServicediv" style="overflow-x: hidden;overflow-y:auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class="tdcenterL">企业名称</td>
									<td class="tdleftc" width="95">最后处理时间</td>
									<td width="20" class="tdrightc"><img src="core/common/images/rightgray.png" width="7" height="7" /></td>
								</tr>
								<c:forEach items="${result.value}" var="customerService" varStatus="status">
								<c:if test="${status.index == 0}"><input type="hidden" id="customerServiceID" value="${customerService.id }"/></c:if>
								<tr id="customerService${customerService.id }" onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff';keepHighlight(this)" class=customerServicetr style="cursor: pointer;" onclick="openRight(${customerService.id});highlight(this);">
									<%  CustomerService customerService = (CustomerService)pageContext.getAttribute("customerService");
										String statusColor = "";
										int width = 10;
										int height = 10;
										if(customerService.getStatus()!=null){
											switch(customerService.getStatus()){
												case CLOSE:
													statusColor = "close";
													break;
												case ACCEPT:
													statusColor = "acceptance";
													break;
												case PENDING:
													statusColor = "suspend";
													break; 
											}
										}
									%>
									<td class="lefttd">${customerService.customer.name}<input type="hidden" value="${customerService.id}" /></td>
									<td class="centertd"><fmt:formatDate value="${customerService.modifyTime}" pattern="yyyy-MM-dd"/></td>
									<td class="centertd"><c:if test="${customerService.status ne null}"><img src="core/common/images/<%=statusColor %>.png" width="<%=width %>" title="${customerService.status.title }" height="<%=height %>" /></c:if></td>
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
