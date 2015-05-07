<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.InvestmentProcess"%>
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
				$('#investmentProcessdiv').css('height',getTabContentHeight()-58);
				initMenu();
				initTip();
				var id=$("#investmentProcessId").val();
				if(id!=null && id!=""){
					openRight(id);
				}
			});
			function openRight(id){
				var currentTime = new Date();
				$("#pm_msglist").attr("src","<%=basePath%>investmentProcess!view.action?id="+id+"&currentTime="+currentTime);
			}
			function initMenu(){
				var menu = [[{
					text: "打开",
					classname: "smarty_menu_view",
					func: function() {
						openRight($(this).find("input").val());
					}
				},{
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investmentProcess!edit.action?id="+$(this).find("input").val(),700,538);
					}
				},{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investmentProcess!print.action?id="+$(this).find("input").val();
					}
				}],[{
					text: "重要性",
					classname: "smarty_yu_ico0",
					data: [[{
						text: "高",
						classname: "smarty_yu_ico0",
						func: function() {
				            $.post("<%=basePath%>investmentProcess!high.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "中",
						classname: "smarty_pu_ico0",
						func: function() {
							$.post("<%=basePath%>investmentProcess!middle.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "低",
						classname: "smarty_di_ico0",
						func: function() {
							$.post("<%=basePath%>investmentProcess!low.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}]]
				}],[{
					text: "设为睡眠",
					classname: "smarty_pu_ico0",
					func: function() {
						if(confirm("确定要设为睡眠")){
							$.post("<%=basePath%>investmentProcess!sleep.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}
				},{
					text: "报送审批",
					classname: "smarty_audit",
					data: [[{
						text: "招商人员意见",
						classname: "smarty_audit",
						func: function() {
							fbStart("招商人员意见","<%=basePath%>investmentProcess!businessmanSuggestion.action?id="+$(this).find("input").val(),500, 170);
						}
					},{
						text: "投资促进部",
						classname: "smarty_audit",
						func: function() {
							$("#approvalType").val("department");
							$("#investmentProcessId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
						}
					},{
						text: "分管主任",
						classname: "smarty_audit",
						func: function() {
							$("#approvalType").val("chief");
							$("#investmentProcessId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
						}
					},{
						text: "主任办公室",
						classname: "smarty_audit",
						func: function() {
							$("#approvalType").val("office");
							$("#investmentProcessId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
						}
					}]]
				}],[{
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investmentProcess!delete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout(function(){
										if(data.prevId==null){
											getOpener().location.href='<%=basePath%>investmentProcess!list.action';
										}else{
					        			getOpener().location.href='<%=basePath%>investmentProcess!list.action?id='+data.prevId;
										}
					        			fb.end();
					        		},2000);
								}
							});
						}
					}
				}]];
				$(".investmentProcesstr").smartMenu(menu,{name:'menu'});
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>investmentProcess!list.action";
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
				var investmentProcessId = $("#investmentProcessId").val();
				var url = "<%=basePath%>investmentProcess!"+type+"Approval.action?id="+investmentProcessId+"&userId="+user.id;
				$.post(url,function(data){
					showTip(data.result.msg,2000);
					location.reload();
				});
			}
		</script>
	</head>

	<body>
		<input type="hidden" id="approvalType"/>
		<input type="hidden" id="investmentProcessId" value="${id }"/>
		<input type="hidden" id="yetInvestmentProcessId" value="${prevId }"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建合同到期审批单 ','<%=basePath %>web/investment/investment_process_add.jsp',700,538);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="doSearch()"><span><img src="core/common/images/refresh3.png" /></span>刷新</li>
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
										<td width="65">入驻企业： </td>
										<td width="180"><input id="name" name="name" type="text" class="inputauto" value="${name}"/></td>
										<td width="80" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()" /></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
							<div id="investmentProcessdiv" style="overflow-x: hidden;overflow-y:auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td width="17" class="tdleftc"></td>
									<td class="tdcenterL">入驻企业</td>
									<td class="tdleftc" width="95">最后处理时间</td>
								</tr>
								<c:forEach items="${result.value}" var="investmentProcess">
								<tr onmouseover="this.style.background='#f4f4f4';" onmouseout="this.style.background='#fff';keepHighlight(this)" class="investmentProcesstr" style="cursor: pointer;" onclick="openRight(${investmentProcess.id});highlight(this);">
									
									<td class="centertd"></td>
									<td class="lefttd">${investmentProcess.name}<input type="hidden" value="${investmentProcess.id}" /></td>
									<td class="centertd"><fmt:formatDate value="${investmentProcess.modifyTime}" pattern="yyyy-MM-dd"/></td>
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
