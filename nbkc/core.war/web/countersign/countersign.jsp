<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.entity.Countersign"%>
<%@page import="com.wiiy.core.preferences.enums.CountersignOpenEnum"%>
<%@page import="com.wiiy.core.preferences.enums.CountersignDoneEnum"%>
<%@page import="com.wiiy.core.preferences.enums.CountersignTypeEnum"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation
			+ path + "/";
	String countersignPath = BaseAction.rootLocation
			+ "/";
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
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript">
			$(document).ready(function() {
				$('#resizable').css('height',getTabContentHeight()-28);
				$('#pm_msglist').css('height',getTabContentHeight()-28);
				$('#countersigndiv').css('height',getTabContentHeight()-58);
				initMenu();
				initTip();
				var id=$("#countersignId").val();
				if(id!=null && id!=""){
					openRight(id);
				}
				var checkType=$("#alreadyOrWait").val();
				if(checkType=='<%=CountersignDoneEnum.ALREADY%>'){
					$(":radio:last").attr("checked","checked");
				}else{
					$(":radio:first").attr("checked","checked");
				}
				
				
				$(":radio").change(function(){
				if($(":radio:checked").val()==1){
					location.href="<%=basePath%>countersign!list.action?alreadyOrWait="+'<%=CountersignDoneEnum.WAIT%>';
				}else{
					location.href="<%=basePath%>countersign!list.action?alreadyOrWait="+'<%=CountersignDoneEnum.ALREADY%>';
				}
				});
				
			});
			
			function openRight(id,type){
				var currentTime = new Date();//添加一个时间戳，避免二次请求被浏览器忽略
				if(type == '<%=CountersignTypeEnum.PROCESS%>'){
					$("#pm_msglist").attr("src","<%=countersignPath%>parkmanager.pb/investmentProcess!countersignView.action?id="+id+"&currentTime="+currentTime);	
				}else if(type == '<%=CountersignTypeEnum.EXPIRE%>'){
					$("#pm_msglist").attr("src","<%=countersignPath%>parkmanager.pb/contractExpireApproval!countersignView.action?id="+id+"&currentTime="+currentTime);	
				}else if(type == '<%=CountersignTypeEnum.REVIEW%>'){
					$("#pm_msglist").attr("src","<%=countersignPath%>parkmanager.pb/contractReview!countersignView.action?id="+id+"&currentTime="+currentTime);	
				}
			}
			
			function initMenu(){
				var menu = [[
				             <%if(CoreActivator.getHttpSessionService().isInResourceMap("core_myCountersign_view")){%>
				             {
					text: "打开",
					classname: "smarty_menu_view",
					func: function() {
						openRight($(this).find("input").val(),$(this).find("input").next().val());
					}
				}
				      <%}%>       
				             ],[
<%if(CoreActivator.getHttpSessionService().isInResourceMap("core_myCountersign_agree")){%>        
				                {
					text: "完成审批",
					classname: "smarty_settled",
					func: function() {
						if(confirm("确认完成审批？")){
							$.post("<%=basePath%>countersign!agree.action?id="+$(this).find("input").val()+"&& type="+$(this).find("input").next().val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				                <%}%>
				                ]];
				$(".countersigntr").smartMenu(menu,{name:'menu'});
			}
			function doSearch(){
				jumpPage(1);
			}
			function jumpPage(page){
				var url = "<%=basePath%>countersign!list.action";
				url += "?page="+page;
				/* if($("#name").val()){
					url += "&name="+$("#name").val();
				} */
				url = encodeURI(url);
				location.href=url;
			}
			function approvalCallback(){
				window.frames[0].location.reload();
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
				var countersignId = $("#countersignId").val();
				var url = "<%=basePath%>countersign!"+type+"Approval.action?id="+countersignId+"&userId="+user.id;
				$.post(url,function(data){
					showTip(data.result.msg,2000);
				});
			}
			
			function reloadPage(cusId){
				location.reload();
				openRight(cusId);
			}
		</script>
</head>

<body>
	<input type="hidden" id="approvalType" />
	<input type="hidden" id="alreadyOrWait" value="${alreadyOrWait }"/>
	<%-- <input type="hidden" id="countersignId" value="${id }"/> --%>
	<%-- <input type="hidden" id="yetcountersignId" value="${prevId }"/> --%>
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
							<form id="form2" name="form2" method="post" action="">
								<table width="100%" height="25" border="0" cellpadding="0"
									cellspacing="0">
									<tr>
										<!-- <td width="65">类型： </td>
                <td width="180"><input name="textfield3222" type="text" class="inputauto" /></td>-->
										<td width="65" >会签状态：</td>
										<td width="180" id="status"><input name="textfield3222" type="radio"
											class="" style="vertical-align: middle;" checked="checked" value="1"/>&nbsp;待办&nbsp;&nbsp;&nbsp;&nbsp;<input
											name="textfield3222" type="radio" class=""
											style="vertical-align: middle;" value="2"/>&nbsp;已办</td>
										<!--<td width="80" ><label>
                  <input name="Submit" type="button" class="search_cx" value=" " />
                </label></td>-->
										<td>&nbsp;</td>
									</tr>
								</table>
							</form>

						</div>
						<div id="countersigndiv"
							style="overflow-x: hidden; overflow-y: auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="17" class="tdleftc"><img
										src="core/common/images/redflag.gif" width="9" height="10" /></td>
									<td class="tdcenterL">会签单</td>
									<td class="tdleftc">上报时间</td>
									<td width="20" class="tdrightc"><img src="core/common/images/rightgray.png" width="7" height="7" /></td>
								</tr>

								<c:forEach items="${result.value}" var="countersign">
									<tr onmouseover="this.style.background='#f4f4f4'"
										onmouseout="this.style.background='#fff'" class="countersigntr" style="cursor: pointer;" onclick="openRight(${countersign.countersignId},'${countersign.countersignType}');highlight(this);">
										<td class="centertd">&nbsp;</td>
										<td class="lefttd">${countersign.name}<input type="hidden"  value="${countersign.countersignId}" /><input type="hidden"  value="${countersign.countersignType}" /></td>
										<td class="centertd"><fmt:formatDate
												value="${countersign.modifyTime}" pattern="yyyy-MM-dd" /></td>
										
										<c:if test="${countersign.countersignOpen=='CLOSE'}">
											<td class="centertd"><img src="core/common/images/rightgreen.png" width="7" alt="完成" title="关闭的" height="7" /></td>
										</c:if>
										<c:if test="${countersign.countersignOpen=='UNDONE'}">
											<td width="20" class="centertd"><img src="core/common/images/rightgray.png" width="7" title="开启的" height="7"/></td>
										</c:if>
										<c:if test="${countersign.countersignOpen==null}">
											<td class="centertd"></td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
							<%@include file="../pager.jsp"%>
						</div>
					</div>
				</td>
				<td valign="top"><iframe
						src="<%=basePath%>web/countersign/countersign_index.jsp"
						scrolling="no" frameborder="0" id="pm_msglist" width="100%"
						name="app"></iframe></td>
			</tr>
		</table>
	</div>
</body>
</html>
