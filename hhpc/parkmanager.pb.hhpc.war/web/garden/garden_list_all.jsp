<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
		<script type="text/javascript">
			var applyId = "";
			var currentIndex = 0;
			var source = "${info}";
			$(document).ready(function() {
				initTip();
				$('#resizable').css('height',getTabContentHeight()-28);
				$('#pm_msglist').css('height',getTabContentHeight()-28);
				$("#investmentdiv").height($(this).height()-88);
				if(source != 'WINDOW')
					initMenu();
				$("#fee_lefts").css("border-right","1px solid #ddd");
			});
			
			function addNew(){
            	<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_add") ||
            			PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_apply")){%>
            		if(source == 'WINDOW')
						window.open('<%=basePath%>web/garden/garden_apply_add.jsp?source='+source,'入圃申请','scrollbars=yes,resizable=no,width=730,height=620')
					else
						window.open('<%=basePath%>web/garden/garden_apply_add.jsp?source=CENTER','入圃申请','scrollbars=yes,resizable=no,width=730,height=620')
				<%}else{%>
					showTip("无此权限",2000);
				<%}%>
            }
			
			function edit(id){
				window.open('<%=basePath%>garden!applyEdit.action?id='+id,'编辑申请','scrollbars=yes,resizable=no,width=730,height=620')
			}
			
			function del(id){
				if(confirm("确定要删除吗")){
					$.post("<%=basePath%>garden!applyDelete.action?id="+id,function(data){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("window.location.reload();", 2000);
			        	}
					});
				}
			}
			
			function openRight(id){
				<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_view") ||
            			PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_view")){%>
					currentIndex = 0;
					var currentTime = new Date();//添加一个时间戳，避免二次请求被浏览器忽略
					if(source == 'WINDOW')
						$("#pm_msglist").attr("src","<%=basePath %>garden!applyView.action?info=WINDOW&id="+id+"&currentTime="+currentTime);
					else
						$("#pm_msglist").attr("src","<%=basePath %>garden!applyView.action?id="+id+"&currentTime="+currentTime);
				<%}%>
			}
			
			function initMenu(){
				var imageMenuData = [
	               	  [
	               	   <% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_edit")){
	               	   %>   
	               	   {
	               			text: "编辑",
	               			classname: "smarty_menu_ico0",
	               			func: function() {
	               				if(canDeal(this,"编辑")){
	               					edit($(this).attr("roleid"));
	               				}
	               			}
	               		}<% }
	               			if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_assign")){
	               	   	  %>,{
		               			text: "分配",
		               			classname: "smarty_print",
		               			func: function() {
		               				if(canDeal(this,"分配")){
			               				applyId = $(this).attr("roleid");
			               				fbStart('选择创业导师','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);
		               				}
		               			}
	               			}
	               	   	  <%}%>
	               		]/* ,[{
	               			text: "状态",
	               			classname: "smarty_yu_ico0",
	               			data: [[{
	                           text: "入圃",
	               			classname: "smarty_yu_ico0",
	                           func: function() {
	                              
	                           }
	                       }, {
	                           text: "出苗",
	               			classname: "smarty_pu_ico0",
	                           func: function() {
	                              
	                           }
	                       }, {
	                           text: "消亡",
		               			classname: "smarty_pu_ico0",
		                           func: function() {
		                              
		                           }
		                       }]]
	               		}
	               		] */<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenManager_list_delete")){
		 	                %>,[{
		 	                	text: "删除",
		               			classname: "smarty_menu_ico2",
		               			func: function() {
		               				if(canDeal(this,"删除")){
		               					del($(this).attr("roleid"));
		               				}
		               			}
		 	                }]
		 	               <% }%>
	               	];
				$(".lsittable").smartMenu(imageMenuData,{name:'table'});
			}
			
			function canDeal(obj,txt){
				var projectState = $(obj).attr("projectstate");
   				var applyState = $(obj).attr("applystate");
				if(projectState != 'APPLYING' || applyState != 'EVAL'){
					showTip("当前状态不能执行『"+txt+"』操作",2000);
					return false;
				}
				return true;
			}
			
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>garden!applyList.action";
				url += "?page="+page;
				if($("#name").val()){
					url += "&searchName="+$("#name").val();
				}
				//url = encodeURI(url);
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
			
			function reloadPage(cusId){
				location.reload();
				openRight(cusId);
			}

			function change(){
				var type = $("select :selected").val();
				var url = "<%=basePath%>investment!myListByType.action?type="+type;
				getOpener().location.href=url;
			}
			
			function setSelectedUsers(users){
				var ids = "";
				for(var i = 0; i < users.length; i++){
					ids += users[i].id+",";
				}
				ids = deleteLastCharWhenMatching(ids,",");
				$.post("<%=basePath%>garden!evalSave.action?ids="+ids+"&applyId="+applyId,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("window.frames[0].location.reload();", 2000);
		        	}
				});
			}
			
			function agree (txt){
				$.post("<%=basePath%>garden!agreement.action?id="+applyId+"&isAgree=YES&info="+txt,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("location.reload();", 2000);
		        	}
				});
			}
			
			function reloadMemoList(){
				frames[0].reloadMemoList();
			}
			
		</script>
		<style type="text/css">
			.highlight {
				background: #f4f4f4
			}
			table{
				table-layout:fixed;
			}
			td{
				white-space:nowrap;
				overflow:hidden;
				text-overflow:ellipsis;
			}
		</style>
	</head>
	
	<body>
		<input type="hidden" id="approvalType"/>
		<input type="hidden" id="investmentId" value="${id }"/>
		<input type="hidden" id="yetInvestmentId" value="${prevId }"/>
		<input type="hidden" id="type" value="${type }"/>
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addNew();"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
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
										<td width="100"><input id="name" name="name" type="text" class="inputauto" value="${searchName }"/></td>
										<td width="80" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch()" /></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
							<div id="investmentdiv" style="height:324px;overflow-y:auto;" >
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
								<tr>
									<td width="17" class="tdleftc"><img src="core/common/images/gthgray.png" /></td>
									<td class="tdcenterL" width="170">项目名称</td>
									<td class="tdcenterL" style="text-align:center;padding-left:0px;">评审状态</td>
									<td class="tdcenterL" width="80" style="border-right:0px;">最后处理时间</td>
								</tr>
								<c:forEach items="${result.value}" var="apply">
								<tr onmouseover="this.style.background='#f4f4f4';" 
								    onmouseout="this.style.background='#fff';keepHighlight(this)" 
								    class="lsittable" style="cursor: pointer;"
								    roleid="${apply.id}"
								    projectState="${apply.projectState}" projectStateTile="${apply.projectState.title}"
								    applyState="${apply.applyState}" applyStateTitle="${apply.applyState.title}"
								    onclick="openRight(${apply.id});highlight(this);">
									<td class="centertd">
										<img src="core/common/images/gthgray.png" width="4" height="10" />
									</td>
									<td class="lefttd" title="${apply.projectName}">
										${apply.projectName}
										<input type="hidden" value="${apply.id}" />
									</td>
									<td class="centertd">
										${apply.applyState.title}
									</td>
									<td class="centertd">
										<fmt:formatDate value="${apply.modifyTime}" pattern="yyyy-MM-dd"/>
									</td>
								</tr>
								</c:forEach>
							</table>
							</div>
							<div style="position:fixed;bottom:0px;width:355px;border-right: 1px solid #ddd;background:#f2f2f2;">
								<!--分页开始-->
								<%@include file="../pager.jsp"%>
								<!--分页结束-->
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
