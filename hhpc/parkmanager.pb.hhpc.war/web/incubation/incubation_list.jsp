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
			var info = "${info}";
			$(document).ready(function() {
				$('#resizable').css('height',getTabContentHeight()-28);
				$('#pm_msglist').css('height',getTabContentHeight()-28);
				$("#contentDiv").scrollTop(10);
				$("#contentDiv").height($(this).height()-132);
				$("#pager").css("width",$("#noticeList").width());
				$("#investmentdiv").height($(this).height()-112);
				$(parent.window).resize(function(){
					var height = $(parent.window).height();
					$("body").css("height",height);
					$("#pageDiv").css("top",height-200);
				});
				if(info != 'WINDOW')
					initMenus();
				else{
					$("#select").attr("disabled","disabled");
				}
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
			
			<%-- function initMenu(){
					<%Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
					boolean flag = false;%>
				var baseMenu = 
				<%
					boolean baseMenu = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allView")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_allEdit")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_allPrint");
				if(baseMenu) {%> 	
					[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_allView")){
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
				%>,<%}flag = true;%>
			    {
					text: "<%=resourceMap.get("pb_project_allPrint").getName() %>",
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
					boolean pb_project_newStatus = PbActivator.getHttpSessionService().isInResourceMap("pb_project_newStatus");
					boolean pb_project_allSubmission = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allSubmission");
					boolean pb_project_allComplete = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allComplete");
					boolean pb_project_allSleep = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allSleep");
					boolean pb_project_allWakeup = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allWakeup");
					boolean pb_project_allDisagree = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allDisagree");
					boolean statusSet = pb_project_newStatus || pb_project_allSubmission || pb_project_allComplete || pb_project_allSleep || pb_project_allWakeup || pb_project_allDisagree;
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
					}
					 <%
					 }
					 if(pb_project_allSubmission){
						 if(pb_project_newStatus){
					 %>
					 ,<%}%>{
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
					}
					 <%}
					 if(pb_project_allComplete){
						 if(pb_project_newStatus||pb_project_allSubmission){
					 %>
					 ,<%}%>{
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
					} <%}
					 if(pb_project_allSleep){
						 if(pb_project_newStatus||pb_project_allSubmission|| pb_project_allComplete){
					 %>
					 ,<%}%>{
						text: "睡眠",
						classname: "smarty_sleep",
						func: function() {
							if(confirm("确定要设为睡眠?")){
								$.post("<%=basePath%>investment!sleep.action?id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						}
					}<%}
					 if(pb_project_allDisagree){
						 if(pb_project_newStatus||pb_project_allSubmission|| pb_project_allComplete || pb_project_allSleep){
							 %>
							 ,<%}%>{
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
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_countersign_begin")){
					if(flag){
				%>,<%}%>
			   {
				text: "发起会签",
				classname: "smarty_menu_ico0",
				func: function() {
					var id=$(this).find("input").val();
					$.post("<%=basePath%>investmentProcess!checkExist.action?id="+$(this).find("input").val(),function(data){
						if(data.result.success){
							fbStart("新建会签","<%=basePath%>investmentProcess!add.action?id="+id,700,268);
						}else{
							showTip("您已经发起过该项目会签！！！");
						}
					});
					
					
				}
			}
			   <%}%>]<%}else{%>""<%}%>;
			   
			   var deleteMenu = 
				   <%
				   	boolean delete = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allDelete");
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
												getOpener().location.href='<%=basePath%>investment!list.action';
											}else{
						        			getOpener().location.href='<%=basePath%>investment!list.action?id='+data.prevId;
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
			     	boolean submit = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allSubmitEnter");
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
			   
			    var otherMenu = [
			    	<%
			    		boolean allView = PbActivator.getHttpSessionService().isInResourceMap("pb_project_allView");
			    		if(allView){
						flag = true;
					%>    
				    [{
						text: "<%=resourceMap.get("pb_project_allView").getName() %>",
						classname: "smarty_menu_view",
						func: function() {
							openRight($(this).find("input").val());
						}
					}]
				    <%}else{%>""<%}%>];
			   	
				var newMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(importMenu){%>,importMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var sleepMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var APPROVALMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var DISAGREEMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var PARKMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				var AGREEMenu = [<%if(baseMenu){%>baseMenu<%}%><%if(status){%>,setUpMenu<%}%><%if(submit){%>,submitMenu<%}%><%if(delete){%>,deleteMenu<%}%>];
				
				$(".investmenttrNEW").smartMenu(newMenu,{name:'menu1'});
				$(".investmenttrSLEEP").smartMenu(sleepMenu,{name:'menu2'});
				$(".investmenttrAPPROVAL").smartMenu(APPROVALMenu,{name:'menu3'});
				$(".investmenttrDISAGREE").smartMenu(DISAGREEMenu,{name:'menu4'});
				$(".investmenttrPARK").smartMenu(PARKMenu,{name:'menu5'});
				$(".investmenttrAGREE").smartMenu(AGREEMenu,{name:'menu6'});
				
				$(".investmenttrNEW_other").smartMenu(otherMenu,{name:'menu_1'});
				$(".investmenttrSLEEP_other").smartMenu(otherMenu,{name:'menu_2'});
				$(".investmenttrAPPROVAL").smartMenu(APPROVALMenu,{name:'menu3'});
				$(".investmenttrDISAGREE_other").smartMenu(otherMenu,{name:'menu_4'});
				$(".investmenttrPARK_other").smartMenu(otherMenu,{name:'menu_5'});
				$(".investmenttrAGREE_other").smartMenu(otherMenu,{name:'menu_6'});
			}
			 --%>
			//菜单
			function initMenus(){
				<%
				Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
				boolean viewBasic = PbActivator.getHttpSessionService().
						isInResourceMap("pb_project_viewBasic");
				boolean editBasic = PbActivator.getHttpSessionService().
						isInResourceMap("pb_project_editBasic");
				boolean delMenu = PbActivator.getHttpSessionService().
						isInResourceMap("pb_project_delete");
				boolean importMenu = PbActivator.getHttpSessionService().
						isInResourceMap("pb_project_important");
				
				boolean baseMenu = viewBasic||editBasic;
					if(baseMenu){
				%>
				var baseMenu = [
				    <%if(viewBasic){%>
	                {
						text: "查看",
						classname: "smarty_menu_view",
						func: function() {
							openRight($(this).find("input").val());
						}
					},<%}%>
					<%if(editBasic){%>
					{
						text: "编辑",
						classname: "smarty_menu_ico0",
						func: function() {
							fbStart("<%=resourceMap.get("pb_project_editBasic").getName() %>","<%=basePath%>investment!edit.action?id="+$(this).find("input").val(),700,479);
						}
					}<%}%>
				];
				<%}%>
				<%
				if(delMenu){
				%>
				var delMenu = [{
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!delete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload();",2000);
								}
							});
						}
					}
				}];
				<%}%>
				<%if(importMenu){%> 	
					var importMenu = [{
						text: "重要性",
						classname: "smarty_yu_ico0",
						data: [[{
							text: "高",
							classname: "smarty_yu_ico0",
							func: function() {
					            $.post("<%=basePath%>investment!important.action?name=HIGH&id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						},{
							text: "中",
							classname: "smarty_pu_ico0",
							func: function() {
								$.post("<%=basePath%>investment!important.action?name=MIDDLE&id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						},{
							text: "低",
							classname: "smarty_di_ico0",
							func: function() {
								$.post("<%=basePath%>investment!important.action?name=LOW&id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						}]]
					}];
					<%}%>
				
				
				var newMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%><%if(delMenu){%>delMenu<%}%>];
				var sleepMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%><%if(delMenu){%>delMenu<%}%>];
				var APPROVALMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%><%if(delMenu){%>delMenu<%}%>];
				var DISAGREEMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%><%if(delMenu){%>delMenu<%}%>];
				var PARKMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%><%if(delMenu){%>delMenu<%}%>];
				var AGREEMenu = [<%if(baseMenu){%>baseMenu,<%}%><%if(importMenu){%>importMenu,<%}%>];
				$(".investmenttrNEW").smartMenu(newMenu,{name:'menu1'});
				$(".investmenttrSLEEP").smartMenu(sleepMenu,{name:'menu2'});
				$(".investmenttrAPPROVAL").smartMenu(APPROVALMenu,{name:'menu3'});
				$(".investmenttrDISAGREE").smartMenu(DISAGREEMenu,{name:'menu4'});
				$(".investmenttrPARK").smartMenu(PARKMenu,{name:'menu5'});
				$(".investmenttrAGREE").smartMenu(AGREEMenu,{name:'menu6'});
			};
			
			
			
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>investment!list.action";
				url += "?page="+page;
				if($("#name").val()){
					url += "&name="+$("#name").val();
				}
				if(info == 'WINDOW'){
					url += "&type="+$("#type").val();
					url += "&info=WINDOW";
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
				var url = "<%=basePath%>investment!list.action?type="+type;
				getOpener().location.href=url;
			}
			
			function addNew(){
				fbStart('新建入孵申请','<%=basePath %>web/incubation/incubation_add.jsp',700,507);
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
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_add")||
							PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_incubation_add")){%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addNew();"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
					<%}%>
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
											<select id="select" onchange="change()">
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
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td width="17" class="tdleftc"><img src="core/common/images/gthgray.png" /></td>
									<td class="tdcenterL">项目名称</td>
									<td class="tdleftc" style="border-right:0px;" width="95">申请时间</td>
								</tr>
							</table>
							<div id="investmentdiv" style="height:300px;overflow-y:auto;" >
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
								<c:forEach items="${result.value}" var="investment">
								<%
									Investment investment = (Investment)pageContext.getAttribute("investment");
								%>
								<tr onmouseout="this.style.background='#fff';keepHighlight(this)" 
									onmouseover="this.style.background='#f4f4f4';"  
									class="investmenttr${investment.investmentStatus }" 
									style="cursor: pointer;" onclick="openRight(${investment.id});highlight(this);">
									<%
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
									<td class="centertd" style="padding-left: 3px;"><c:if test="${investment.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if></td>
									<td class="lefttd" style="width:220px;" align="center">${investment.name}<input type="hidden" value="${investment.id}" /></td>
									<td class="centertd"><fmt:formatDate value="${investment.createTime}" pattern="yyyy-MM-dd"/></td>
								</tr>
								</c:forEach>
							</table>
							</div>
							<%@include file="../pager.jsp" %>
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
