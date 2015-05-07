<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.crm.entity.CustomerService"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Pragma" content="no-cache" /> 
		<meta http-equiv="Cache-Control" content="no-cache" /> 
		<meta http-equiv="Expires" content="0" /> 
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
		            {
						text: "打开",
						classname: "smarty_menu_view",
						func: function() {
							openRight($(this).find("input").val());
						}
					},
					{
						text: "编辑",
						classname: "smarty_menu_ico0",
						func: function() {
							fbStart("基本信息编辑","<%=basePath%>customerService!edit.action?id="+$(this).find("input").val(),700,308);
						}
					},
					{
						text: "打印",
						classname: "smarty_print",
						func: function() {
							location.href="<%=basePath%>customerService!print.action?id="+$(this).find("input").val();
						}
					}],
					[
					    {
							text: "重要性",
							classname: "smarty_yu_ico0",
							data: [[{
								text: "高",
								classname: "smarty_yu_ico0",
								func: function() {
						            $.post("<%=basePath%>customerService!chagePriority.action?priority=HIGH&id="+$(this).find("input").val(),function(){
										location.reload();
									});
								}
							},{
								text: "中",
								classname: "smarty_pu_ico0",
								func: function() {
									$.post("<%=basePath%>customerService!chagePriority.action?priority=MIDDLE&id="+$(this).find("input").val(),function(){
										location.reload();
									});
								}
							},{
								text: "低",
								classname: "smarty_di_ico0",
								func: function() {
									$.post("<%=basePath%>customerService!chagePriority.action?priority=LOW&id="+$(this).find("input").val(),function(){
										location.reload();
									});
								}
							}]]
						}
					    ],
					[{
						text: "状态",
						classname: "smarty_menu_statusSet",
						data: [[{
							text: "受理",
							classname: "smarty_menu_acceptance",
							func: function() {
								var id = $(this).find("input").val();
								$.post("<%=basePath%>customerService!accept.action?id="+id,function(){
									location.href = '<%=basePath%>customerService!list.action?id='+id;
								});
							}
						},
						   {
							text: "关闭",
							classname: "smarty_menu_close",
							func: function() {
								var id = $(this).find("input").val();
								$.post("<%=basePath%>customerService!serviceClosed.action?id="+$(this).find("input").val(),function(){
									location.href = '<%=basePath%>customerService!list.action?id='+id;
								});
							}
						},
						   {
							text: "挂起",
							classname: "smarty_suspend",
							func: function() {
								var id = $(this).find("input").val();
								$.post("<%=basePath%>customerService!suspend.action?id="+$(this).find("input").val(),function(){
									location.href = '<%=basePath%>customerService!list.action?id='+id;
								});
							}
						}]]
						}],[
					      {
				    	  	text: "服务结果",
							classname: "smarty_menu_finish",
							data: [[{
								text: "已解决",
								classname: "smarty_menu_finish",
								func: function() {
									var id = $(this).find("input").val();
									$.post("<%=basePath%>customerService!solved.action?id="+$(this).find("input").val(),function(){
										location.href = '<%=basePath%>customerService!list.action?id='+id;
									});
								}
							},
						      {
								text: "未解决",
								classname: "smarty_menu_failed",
								func: function() {
									var id = $(this).find("input").val();
									$.post("<%=basePath%>customerService!unsolved.action?id="+$(this).find("input").val(),function(){
										location.href = '<%=basePath%>customerService!list.action?id='+id;
									});
								}
							},
					      {
							text: "部分解决",
							classname: "smarty_menu_part",
							func: function() {
								var id = $(this).find("input").val();
								$.post("<%=basePath%>customerService!partSolved.action?id="+$(this).find("input").val(),function(){
									location.href = '<%=basePath%>customerService!list.action?id='+id;
								});
							}}]]
						}],
						[
						{
							text: "转交",
							classname: "smarty_send",
							func: function() {
								$("#customerServiceId").val($(this).find("input").val());
								fbStart('选择接收人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
							}
						   },
				            {
								text: "短信",
								classname: "smarty_menu_msg",
								func: function() {
									addTab("发送短信",'<%=BaseAction.rootLocation %>/parkmanager.oa/web/communication/sms.jsp','/parkmanager.oa/web/images/oaico/msg_03_min.png');
								}
							},
							{
								text: "邮件",
								classname: "smarty_menu_email",
								func: function() {
									window.open('<%=BaseAction.rootLocation %>/parkmanager.oa/mail!sendMail.action?type=1&folder=2','新建邮件','height=500,width=700,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
								}
							}
					],
			         [{
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
			
			function addTab(plugin,url,iconUrl){
				var tabs = parent.parent.$('#tt');
				if (tabs.tabs('exists',plugin)){
					tabs.tabs('select', plugin);
					var tab = tabs.tabs('getSelected');
					tabs.tabs('update', {
						tab: tab,
						options: {
							content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>'
						}
					});
					var span = tabs.find("span:contains('"+plugin+"')");
					span.addClass("tabs-with-icon");
				} else {
					var icon = parent.parent.$(".tt:contains('"+plugin+"')").prev().find("img").attr("src");
					if(typeof(icon) == "undefined"){
						icon = iconUrl;
					}
					tabs.tabs('add',{
						title:plugin,
						iconCls:'icon-reload',
						content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
						closable:true
					});
					var span = tabs.find("span:contains('"+plugin+"')");
					span.next().css("background","url('"+icon+"') no-repeat");
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
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建联系单','<%=basePath %>web/client/customerService_add.jsp',700,203);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
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
											<input type="hidden" id="customerId"/><input onkeyup="$('#customerId').val('')" id="customerName" value="${name }" type="text" class="data inputauto"/>
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
									<td class="tdcenterL">&nbsp;</td>
									<td class="tdcenterL">企业名称</td>
									<td class="tdcenterL" width="80">服务类型</td>
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
									<%
										String priorityColor = "";
										if(customerService.getPriority()!=null){
											switch(customerService.getPriority()){
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
									<td class="centertd" style="padding-left: 3px;"><c:if test="${customerService.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if></td>
									<td class="lefttd">
									<c:if test="${not empty customerService.customer }">
									<c:choose>
									<c:when test="${fn:length(customerService.customer.name)>10 }">
									<span title="${customerService.customer.name }">${fn:substring(customerService.customer.name,0,10) }...</span>
									</c:when>
									<c:otherwise>${customerService.customer.name }</c:otherwise>
									</c:choose>
									</c:if>
									<c:if test="${empty customerService.customer }">
									<c:choose>
									<c:when test="${fn:length(customerService.customerName)>10 }">
									<span title="${customerService.customerName }">${fn:substring(customerService.customerName,0,10) }...</span>
									</c:when>
									<c:otherwise>${customerService.customerName }</c:otherwise>
									</c:choose>
									</c:if>
									<input type="hidden" value="${customerService.id}" />
									</td>
									<td class="lefttd">${customerService.type.dataValue}</td>
									<td class="centertd"><fmt:formatDate value="${customerService.modifyTime}" pattern="yyyy-MM-dd"/></td>
									<td class="centertd"><c:if test="${customerService.status ne null}"><img src="core/common/images/<%=statusColor %>.png" width="<%=width %>" title="${customerService.status.title }" height="<%=height %>" /></c:if></td>
								</tr>
								</c:forEach>
							</table>
							<div style="position:fixed;bottom:0px;width:355px;border-right: 1px solid #ddd;background:#f2f2f2;">
								<%@include file="../pager.jsp" %>
							</div>
						</div>
						</div>
					</td>
					<td valign="top">
						<iframe src="" scrolling="no" frameborder="0" id="pm_msglist" width="100%" name="app"></iframe>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
