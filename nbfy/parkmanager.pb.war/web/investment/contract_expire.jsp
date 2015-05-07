<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.ContractExpireApproval"%>
<%@page import="com.wiiy.core.preferences.enums.CountersignOpenEnum"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="parkmanager.pb/web/style/merchants.css" />
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
				$('#contractExpireApprovaldiv').css('height',getTabContentHeight()-58);
				initMenu();
				initTip();
				var id=$("#contractExpireApprovalId").val();
				if(id!=null && id!=""){
					openRight(id);
				}
			});
			function openRight(id){
				var currentTime = new Date();
				var type="all";
				$("#pm_msglist").attr("src","<%=basePath%>contractExpireApproval!view.action?id="+id+"&currentTime="+currentTime+"&TYPE="+type);
				$("#tableid").attr("href","parkmanager.pb/web/approval/process_flow.html");
			}
			function initMenu(){
				var menu = [[
				       <%boolean flag=false;
				       if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_view")){flag=true;%>      
				             {
					text: "打开",
					classname: "smarty_menu_view",
					func: function() {
						openRight($(this).find("input").val());
					}
				}
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_edit")){
					if(flag){%>,<%}flag=true;%>
				             {
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>contractExpireApproval!edit.action?id="+$(this).find("input").val(),700,538);
					}
				}
				             <%}%>
				             ],[
				             <%flag=false;
				             if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_approval")){flag=true;%>
				                {
					text: "报送审批",
					classname: "smarty_audit0",
					data: [[{
						text: "招商部",
						classname: "smarty_audit1",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							fbStart("招商人员意见","<%=basePath%>contractExpireApproval!businessmanSuggestion.action?id="+$(this).find("input").val(),500, 170);
						}}
					},{
						text: "财务部",
						classname: "smarty_audit2",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							$("#approvalType").val("cwb");
							$("#contractExpireApprovalId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
						}}
					},{
						text: "总经理",
						classname: "smarty_audit5",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							$("#approvalType").val("zjl");
							$("#contractExpireApprovalId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
						}}
					},{
						text: "工程部",
						classname: "smarty_audit3",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							$("#approvalType").val("gcb");
							$("#contractExpireApprovalId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
						}}
					},{
						text: "客户确认",
						classname: "smarty_audit6",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							$("#approvalType").val("kh");
							$("#contractExpireApprovalId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
						}}
					},{
						text: "财务总监",
						classname: "smarty_audit7",
						func: function() {
							var status = $(this).find("input").next().val();
							if(status == "CLOSE"){
								showTip("关闭的会签不能报送审批");
							}else{
							$("#approvalType").val("cwzj");
							$("#contractExpireApprovalId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!select.action',520,400);
						}}
					}]]
				}
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_open")){
						if(flag){%>,<%}flag=true;%>
				                {
					text: "开启会签",
					classname: "smarty_back",
					func: function() {
						if(confirm("确认开启会签？")){
							$.post("<%=basePath%>contractExpireApproval!open.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
	                <%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_close")){
						if(flag){%>,<%}flag=true;%>
				                {
					text: "关闭会签",
					classname: "smarty_menu_finish",
					func: function() {
						if(confirm("确认关闭会签？")){
							$.post("<%=basePath%>contractExpireApproval!close.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				                <%}%>
				                ],[
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpire_delete")){%> 
				                   {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>contractExpireApproval!delete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout(function(){
										if(data.prevId==null){
											getOpener().location.href='<%=basePath%>contractExpireApproval!list.action';
										}else{
					        			getOpener().location.href='<%=basePath%>contractExpireApproval!list.action?id='+data.prevId;
										}
					        			fb.end();
					        		},2000);
								}
							});
						}
					}
				}
				                   <%}%>
				                   ]];
				$(".contractExpireApprovaltr").smartMenu(menu,{name:'menu'});
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>contractExpireApproval!list.action";
				url += "?page="+page;
				if($("#name1").val()){
					url += "&name="+$("#name1").val();
				}
				/* if($("#name").val()){
					url += "&statue="+$("#name").selected().val();
				} */
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
				var contractExpireApprovalId = $("#contractExpireApprovalId").val();
				var url = "<%=basePath%>contractExpireApproval!"+type+"Approval.action?id="+contractExpireApprovalId+"&userId="+user.id;
				$.post(url,function(data){
					showTip(data.result.msg,2000);
					location.reload();
				});
			}
			<%-- function reLoad(){
				if($("#name").val()){}
				location.href="<%=basePath%>contractExpireApproval!list?"
			} --%>
		</script>
</head>

<body>
	<input type="hidden" id="approvalType" />
	<input type="hidden" id="contractExpireApprovalId" value="${id }" />
	<input type="hidden" id="yetcontractExpireApprovalId" value="${prevId }" />
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="doSearch()"><span><img
						src="core/common/images/refresh3.png" /></span>刷新</li>
			</ul>
		</div>
	</div>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="355" valign="top" id="fee_lefts">
					<div class="write_list"
						style="border-right: 1px solid #ddd; width: 355px;" id="resizable">
						<div class="searchdiv">
							<table width="100%" height="25" border="0" cellpadding="0"
								cellspacing="0">
								<tr>
									<td width="65">合同名称：</td>
									<td width="180"><input id="name1" name="name" type="text"
										class="inputauto" value="${name}" /></td>
									<td>&nbsp</td>
									<td width="80" align="center"><input name="Submit"
										type="button" class="search_cx" value="" onclick="doSearch()" /></td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</div>
						<div id="contractExpireApprovaldiv"
							style="overflow-x: hidden; overflow-y: auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="lsittable">
								<tr>
									<td width="17" class="tdleftc"><img
										src="core/common/images/redflag.gif" width="9" height="10" /></td>
									<td class="tdcenterL">合同名称</td>
									<td class="tdleftc">最后处理时间</td>
									<td width="20" class="tdrightc"><img
										src="core/common/images/rightgray.png" width="7" height="7" /></td>
								</tr>
								<c:forEach items="${result.value}" var="contractExpireApproval">
									<tr onmouseover="this.style.background='#f4f4f4'"
										onmouseout="this.style.background='#fff'" class="contractExpireApprovaltr" style="cursor: pointer;" onclick="openRight(${contractExpireApproval.id});highlight(this);">
										<td class="centertd">&nbsp;</td>
										<td class="lefttd"><c:if test="${fn:length(contractExpireApproval.contract.name)>=20}" >${fn:substring(contractExpireApproval.contract.name,0,20) }...</c:if><c:if test="${fn:length(contractExpireApproval.contract.name)<20}" >${contractExpireApproval.contract.name}</c:if><input
											type="hidden" value="${contractExpireApproval.id}" /><input type="hidden" value="${contractExpireApproval.countersignStatus }"/></td>
										<td class="centertd"><fmt:formatDate
												value="${contractExpireApproval.modifyTime}" pattern="yyyy-MM-dd" /></td>
											<c:if test="${contractExpireApproval.countersignStatus=='CLOSE'}">
											<td class="centertd"><img src="core/common/images/rightgreen.png" width="7" alt="完成" title="关闭的" height="7" /></td>
										</c:if>
										<c:if test="${contractExpireApproval.countersignStatus=='UNDONE'}">
											<td width="20" class="centertd"><img src="core/common/images/rightgray.png" width="7" title="开启的" height="7"/></td>
										</c:if>
										<c:if test="${contractExpireApproval.countersignStatus==null}">
											<td class="centertd"></td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
							<%@include file="../pager.jsp"%>
						</div>
					</div>
				</td>
				<td valign="top">
				
	<iframe
						src="<%=basePath%>web/investment/investment_index.jsp"
						scrolling="no" frameborder="0" id="pm_msglist" width="100%"
						name="app"></iframe></td>
			</tr>
		</table>
	</div>
</body>
</html>
