<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				$("#contentDiv").scrollTop(10);
				$("#pager").css("width",$("#investmentdiv").width());
				$("#contentDiv").height($(this).height()-112);
				
				$(parent.window).resize(function(){
					var height = $(parent.window).height();
					$("body").css("height",height);
					$("#pageDiv").css("top",height);
				});
				initMenu();
				initTip();
				var id=$("#investmentId").val();
				if(id!=null && id!=""){
					openRight(id);
				}
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
				$("#pm_msglist").attr("src","<%=basePath%>investment!myView.action?id="+id+"&currentTime="+currentTime);
			}
			
			function initMenu(){
				<%Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
				boolean flag = false;%>
			var baseMenu = 
			<%
				boolean baseMenu = PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_myImprotant") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySleep") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmission") 
					|| PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")
					||PbActivator.getHttpSessionService().isInResourceMap("pb_countersign_begin")
					||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus");
			if(baseMenu) {%> 	
				[
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
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
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit")){
					if(flag){
						%>,<%
					}
					flag = true;
			%>
		    {
		    	text: "<%=resourceMap.get("pb_project_allEdit").getName() %>",
				classname: "smarty_menu_ico0",
				func: function() {
					fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
				}
			}
		    <%}%>
			<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
			%>,<%}flag = true;%>
		    {
				text: "<%=resourceMap.get("pb_project_myPrint").getName() %>",
				classname: "smarty_print",
				func: function() {
					location.href="<%=basePath%>investment!print.action?id="+$(this).find("input").val();
				}
			}
		    <%}%>]
				<%}else{%>""<%}%>;
			
			var importMenu = 
			<%
			boolean importMenu = PbActivator.getHttpSessionService().isInResourceMap("pb_project_myImprotant");
			if(importMenu){%> 	
				[{
					text: "重要性",
					classname: "smarty_yu_ico0",
					data: [[{
						text: "高",
						classname: "smarty_yu_ico0",
						func: function() {
				            $.post("<%=basePath%>investment!high.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "中",
						classname: "smarty_pu_ico0",
						func: function() {
							$.post("<%=basePath%>investment!middle.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "低",
						classname: "smarty_di_ico0",
						func: function() {
							$.post("<%=basePath%>investment!low.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}]]
				}
			]<%}else{%>""<%}%>;
			
			var setUpMenu = <% flag = false;
				boolean pb_project_newStatus = PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus");
				boolean statusSet = pb_project_newStatus;
				boolean status = statusSet||PbActivator.getHttpSessionService().isInResourceMap("pb_countersign_begin");
				if(status) {%> 	
				[
				<%if(statusSet){
					flag = true;
				%>
			       {
				text: "状态设置",
				classname: "smarty_menu_statusSet"<%if(statusSet){%>,
				data: [[
				 <%
				 	if(pb_project_newStatus){
				 %>
				 {
					text: "洽谈",
					classname: "smarty_menu_negotiation",
					func: function() {
						if(confirm("确认设为洽谈项目？")){
							$.post("<%=basePath%>investment!myNewStatus.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				},
				 {
					text: "审批",
					classname: "smarty_menu_accraditation",
					func: function() {
						if(confirm("确认设为审批项目？")){
							$.post("<%=basePath%>investment!approval.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				},
				 {
					text: "落户",
					classname: "smarty_complete",
					func: function() {
						if(confirm("确认落户？")){
							$.post("<%=basePath%>investment!agree.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				},
				 {
					text: "睡眠",
					classname: "smarty_sleep",
					func: function() {
						if(confirm("确定要设为睡眠?")){
							$.post("<%=basePath%>investment!sleep.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}
				},
				<%--{
					text: "唤醒",
					classname: "smarty_awaken",
					func: function() {
						if(confirm("确定要唤醒?")){
							$.post("<%=basePath%>investment!wakeUp.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}
				},
 				--%>
				{
					text: "否决项目",
					classname: "smarty_regect",
					func: function() {
						if(confirm("确认否决项目？")){
							$.post("<%=basePath%>investment!disagree.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				<%}%>
				]]<%}%>
			}
			<%}%>  
			]<%}else{%>""<%}%>;
		   
		   var deleteMenu = 
			   <%
			   	boolean delete = PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete");
			   	if(delete){%>  
		          [{
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!delete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout(function(){
										if(data.prevId==null){
											getOpener().location.href='<%=basePath%>investment!myList.action';
										}else{
					        				getOpener().location.href='<%=basePath%>investment!myList.action?id='+data.prevId;
										}
					        			fb.end();
					        		},2000);
								}
							});
						}
					}
				}]
		     <%}else{%>""<%}%>;
		          
			     var submitMenu =
			     <%
			     	boolean submit = PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmitEnter");
			     	if(submit){%> 
					  [{
						text: "提交入驻",
						classname: "smarty_settled",
						func: function() {
							if(confirm("确认要提交入驻？")){
								$.post("<%=basePath%>investment!submitSettled.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					}]
			   <%}else{%>""<%}%>;
			   
			   var backListMenu = 
			   <%
		     	boolean inBack = PbActivator.getHttpSessionService().isInResourceMap("pb_inBlackList");
		     	boolean backList = PbActivator.getHttpSessionService().isInResourceMap("pb_BlackList");
		     	boolean back = inBack || backList;
			   if(back){%> 
				  [{
					text: "黑名单设置",
					classname: "smarty_menu_blacklistSet",
					data: [[{
						text: "加入黑名单",
						classname: "smarty_menu_inblack",
						func: function() {
							if(confirm("此操作为不可逆过程，确认加入黑名单？")){
								$.post("<%=basePath%>investment!rmiSaveBlackList.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
								});
							}
						}
					},{
						text: "黑名单查询",
						classname: "smarty_menu_blacklist",
						func: function() {
							fbStart('黑名单查询',"<%=basePath%>investment!loadRmiBlackList.action?id="+$(this).find("input").val(),700,400);
						}
					}
					]]
				}]
		   <%}else{%>""<%}%>;
		   
		   	var iWidth=1024; //弹出窗口的宽度;
			var iHeight=500; //弹出窗口的高度;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		   var approvalMenu = 
				  [{
					text: "审批",
					classname: "smarty_menu_blacklistSet",
					data: [[{
						text: "虚拟",
						classname: "smarty_menu_inblack",
						func: function() {
							var investmentId = $(this).find("input").val();
							openUrl = "<%=BaseAction.rootLocation %>/parkmanager.pf/fictitious!addByInvestmentId.action?inpark=false&investmentId="+investmentId;//弹出窗口的url
							window.open(openUrl,'新建虚拟入驻审批单','top='+iTop+',left='+iLeft+',height='+iHeight+',width='+iWidth+',toolbar=no,menubar=no,scrollbars=yes,resizable=no, location=no,status=no');
						}
					},{
						text: "入驻",
						classname: "smarty_menu_blacklist",
						func: function() {
							var investmentId = $(this).find("input").val();
							openUrl = "<%=BaseAction.rootLocation %>/parkmanager.pf/fictitious!addByInvestmentId.action?inpark=true&investmentId="+investmentId;//弹出窗口的url
							window.open(openUrl,'新建入驻审批单','top='+iTop+',left='+iLeft+',height='+iHeight+',width='+iWidth+',toolbar=no,menubar=no,scrollbars=yes,resizable=no, location=no,status=no');
						}
					}
					]]
				}];
				var newMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(importMenu){%>,importMenu<%}%><%if(status){%>,setUpMenu<%}%>,approvalMenu,<%if(back){%>,backListMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var sleepMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(back){%>,backListMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var APPROVALMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(back){%>,backListMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var DISAGREEMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(back){%>,backListMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var PARKMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(back){%>,backListMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var AGREEMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(submit){%>,submitMenu<%}%><%if(back){%>,backListMenu<%}%>];
			
				$(".investmenttrNEW").smartMenu(newMenu,{name:'menu1'});
				$(".investmenttrSLEEP").smartMenu(sleepMenu,{name:'menu2'});
				$(".investmenttrAPPROVAL").smartMenu(APPROVALMenu,{name:'menu3'});
				$(".investmenttrDISAGREE").smartMenu(DISAGREEMenu,{name:'menu4'});
				$(".investmenttrPARK").smartMenu(PARKMenu,{name:'menu5'});
				$(".investmenttrAGREE").smartMenu(AGREEMenu,{name:'menu6'});
			}
			
			
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>investment!myList.action";
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
				var firstChar = type.charAt(0);
				var upFirstChar = firstChar.toUpperCase();
				type = type.replace(firstChar,upFirstChar);
				var investmentId = $("#investmentId").val();
				var url = "<%=basePath%>investment!my"+type+"Approval.action?id="+investmentId+"&userId="+user.id;
				$.post(url,function(data){
					showTip(data.result.msg,2000);
					location.reload();
				});
			}
			
			function reloadPage(cusId){
				location.reload();
				openRight(cusId);
			}

			function change(){
				var type = $("select :selected").val();
				var url = "<%=basePath%>investment!myListByType.action?type="+type;
				getOpener().location.href=url;
			}
			
			function reloadList(){
			}
		</script>
	</head>

	<body>
		<input type="hidden" id="approvalType"/>
		<input type="hidden" id="investmentId" value="${id }"/>
		<input type="hidden" id="yetInvestmentId" value="${prevId }"/>
		<input type="hidden" id="type" value="${type }"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建申请单','<%=basePath %>web/investment/investment_my_add.jsp',700,538);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="location.reload()"><span><img src="core/common/images/refresh3.png" /></span>刷新</li>
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
							<div id="investmentdiv" style="overflow-x: hidden;overflow-y:hidden;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td width="17" class="tdleftc"><img src="core/common/images/gthgray.png" /></td>
									<td class="tdcenterL">项目名称</td>
									<td class="tdleftc" width="95">最后处理时间</td>
								</tr>
								</table>
								<div id="contentDiv" style="height:300px;overflow-y:auto;" >
									<table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
									<c:forEach items="${result.value}" var="investment">
										<tr onmouseover="this.style.background='#f4f4f4';" onmouseout="this.style.background='#fff';keepHighlight(this)" class="investmenttr${investment.investmentStatus }" style="cursor: pointer;" onclick="openRight(${investment.id});highlight(this);">
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
											<td class="centertd" style="padding-left: 2px;"><c:if test="${investment.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if></td>
											<td class="lefttd" style="padding-left: 10px;"><p>${investment.name}</p><input type="hidden" value="${investment.id}" /><input type="hidden" value="${investment.regInfo.organizationNumber}" /></td>
											<td class="centertd"><fmt:formatDate value="${investment.modifyTime}" pattern="yyyy-MM-dd"/></td>
										</tr>
									</c:forEach>
								</table>
							</div>
							<div id="pageDiv">
								<%@include file="../pager.jsp" %>
							</div>
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
