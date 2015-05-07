<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
	<base href="<%=BaseAction.rootLocation %>/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>园区经理V1.02</title>
	<link href="core/common/style/index.css" rel="stylesheet" type="text/css" />
	<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
	<link href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
	<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
	<link href="parkmanager.ps/web/style/user.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="core/common/js/index.js"></script>
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript" src="core/common/js/menu.js"></script>
	<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		<%
			Map<String, ResourceDto> resourceMap = CoreActivator.getHttpSessionService().getResourceMap();
		%>
		var b=0;
		var lastClicked = '';//上次点击的id
		var currentClicked = '';//本次点击id
		function initModule() {
	        $("#moduleList li").each(function(index) {
	        	//index = index-1;
	            $(this).click(function() {
					$(this).addClass("current").siblings().removeClass("current");
					$("#navlist ul:eq(" + index + ")").attr("style", "display:block").siblings().attr("style", "display:none");
					//每次点击都会将聚合按钮状态还原
					$("#ico").removeClass("ico1over").addClass("ico1");
					/* if(index==1){
						$("#contactWay").attr("style", "display:block");
					}else{
						$("#contactWay").attr("style", "display:none");
					} */
				});
	        });
	        $("#moduleList li:first").click();
	        
	    }
		$(document).ready(function() {
			initHeight();
			initTab();
			initConsole();
			//initMenu();
			initModule();
			initTopIconTooltip();
			attachScrollModuleEvent();
			var height = getTabContentHeight();
			$("#navlist").height(height-175); 
			$(".clicked").click(function(){
				var divName = $(this).next().attr("id");
				if($(this).next().is(":hidden")){
					$(this).prev().removeClass("b").addClass("b1");
					currentClicked = divName;
					if(lastClicked != '' && lastClicked != currentClicked){
						$("#"+lastClicked).prev().prev().removeClass("b1").addClass("b");
						$("#"+lastClicked).slideUp();
					}
					if($("#"+lastClicked).is(":hidden")){
						$("#"+lastClicked).hide();
					}
					lastClicked = currentClicked;
				} else {
					$(this).prev().removeClass("b1").addClass("b");
					lastClicked = "";
				}
				$(this).next().slideToggle();
			});
			<%if(CoreActivator.getAppConfig().getConfig("menuFlat").getParameter("flat").equals("active")){%>
				var targetUl = $("#navlist ul:eq(" + ($("#moduleList li").index($(".current"))) + ")");
				targetUl.attr("style", "display:block");
				if(targetUl.siblings().first().css("display")=="none") {
					targetUl.siblings().attr("style", "display:block");
				} else {
					targetUl.siblings().attr("style", "display:none");
				}
			<%}%>
		});
		$(window).resize(function(){
			initHeight();//填写计算页面高度的方法。
		});
		function initTopIconTooltip(){
			$("#topico").find("span").each(function(){
				var className = $(this).attr("class");
				/* $(this).mouseover(function(){
					$(this).removeClass().addClass(className+"over");
				});
				$(this).mouseout(function(){
					$(this).removeClass().addClass(className);
				}); */
			});
		}
		function initConsole(){
			<% if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			<c:if test="${not empty accessibleModuleMenuIds['desktop']}">
			addTab("工作台",'core/common/images/console.png',"<%=basePath%>web/desktop/index.jsp");
			</c:if>
			<%}%>
			<% if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){ %>
			<c:if test="${not empty accessibleModuleMenuIds['5_10000']}">
			addTab("服务中心",'core/common/images/service.png',"<%=BaseAction.rootLocation %>/parkmanager.ps/action!service.action");
			</c:if>
			<%}%>
		}
		function attachScrollModuleEvent(){
			var moduleSize = $(".moduleSize").size();
		  $(".rightarrow").click(function(){
			  b=b+28;
			  if(b<0 || b==0){
				  $(".centerconlist").animate({left:b+"px"},"slow");
			  }else{
				  b = 0;
			  }
			 
		  });
		  $(".leftarrow").click(function(){
			  b=b-28;
			  if(b>-(28*moduleSize)){
				  $(".centerconlist").animate({left:b+"px"},"slow");
			  }else{
				 b=b+28; 
			  }
		  });
		}
		function flatModule(obj) {
			if(obj.className == "ico1"){
				$("#ico").removeClass("ico1").addClass("ico1over");
			}else{
				$("#ico").removeClass("ico1over").addClass("ico1");
			}
			var targetUl = $("#navlist ul:eq(" + ($("#moduleList li").index($(".current"))) + ")");
			targetUl.attr("style", "display:block");
			if(targetUl.siblings().first().css("display")=="none") {
				targetUl.siblings().attr("style", "display:block");
			} else {
				targetUl.siblings().attr("style", "display:none");
			}
		}
		function addTab(title,icon,url){
			var plugin=title;
			if ($('#tt').tabs('exists',plugin)){
				$('#tt').tabs('select', plugin);
			} else{
				$('#tt').tabs('add',{
					title:plugin,
					iconCls:'icon-reload',
					content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
					closable:true
				});
			}
			addTabIcon(plugin,icon);
		}
		function luceneSearch(){
			var url = "<%=basePath%>search.action?keyword="+$("#keyword").val();
			url = encodeURI(url);
			addOrUpdateTab("搜索","core/common/images/search_icon.gif",url);
		}
		function addOrUpdateTab(title,icon,url){
			if ($('#tt').tabs('exists', title)){
				$('#tt').tabs('select', title);
				var tab = $('#tt').tabs('getSelected');
				$('#tt').tabs('update', {
					tab: tab,
					options: {
						content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>'
					}
				});
				var span = $('#tt').find("span:contains('"+title+"')");
				span.addClass("tabs-with-icon");
			} else {
				addTab(title,icon,url);
			}
		}
		function handleKey(){
			if(event.keyCode==13){
				search();
				event.returnValue=false;
			}
		}
		function logout(obj){
			if(confirm("确定要退出")){
				obj.href = 'core/login!logout.action';
			}
		}
		function logout(){
			if(confirm("确定要重新登录")){
				window.location.href = '<%=BaseAction.rootLocation+"/core/"%>login!logout.action';
			}
		}
		
	</script>
</head>

<body>
<div id="header">
	<div id="topnav">
		<div class="leftnav">
			<span title="title" class="span1"><a href="#">园区导航</a></span>
			<span class="username">${user.username}<c:if test="${user.email ne null and user.email ne ''}">[<a href="#">${user.email}</a>]</c:if></span>
			<span class="toplink"><a href="<%=basePath%>index.action">首页</a>|</span>
			<span class="setup"><a id="selfConfig" href="javascript:void(0)" onclick="addTab('账户设置','core/common/images/console.png','core/web/account/core_user_edit.jsp')">账户设置</a></span>
		</div>
		<div class="rightnav"><a href="#">关于</a>|<a href="javascript:void(0)" onclick="fbStart('修改密码','core/self!passwordReset.action',350,150);">修改密码</a>|<a href="javascript:void(0)" onclick="fbLockScreen('锁屏','core/login!lockScreen.action',350,215);">锁屏</a>|<a href="javascript:void();" onclick="logout(this);" target="_top">退出</a></div>
	</div>
	<div id="headerdown">
		<div id="logo"><img src="core/common/images/logo_zjuspnb.gif" height="60" /></div>
		<div id="nav" style="display:none">
			<ul>
				<c:forEach items="${resourceList}" var="module" varStatus="rowStatus">
					<c:if test="${not empty accessibleModuleMenuIds[module.idSpace]}">
						<li class="nav1">
							<span></span><a href="javascript:void(0)">${module.name}</a>
						</li>
					</c:if>
				</c:forEach>
			</ul>
			<div class="hackbox"></div>
		</div>
		<div id="search">
			<div class="stop">
				<!-- <ul>
					<li><a href="javascript:void(0)" class="stopfont">文章</a></li>
					<li><a href="javascript:void(0)">文档</a></li>
					<li><a href="javascript:void(0)">附件</a></li>
				</ul> -->
			</div>
			<form id="form1" name="form1" method="post" action="">
				<ul>
					<li><label><input id="keyword" name="keyword" type="text" class="inputs" onkeydown="handleKey()"/></label></li>
					<li><label><input name="Submit" type="button" class="btn" value=""  onclick="luceneSearch()"/></label></li>
				</ul>  
			</form>
		</div>
	</div>
</div>
<div id="contant">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<div id="sub" style="display:block;">
					<div id="subnav">
						<div id="topico">
							<ul>
								<li>
									<span title="菜单聚合" id="ico" class="ico1" onclick="flatModule(this);"></span>
									<c:if test="${not empty accessibleModuleMenuIds['desktop']}">
										<span title="工作台" class="ico2" onclick="addTab('工作台','core/common/images/console.png','<%=basePath%>web/desktop/index.jsp');"></span>
									</c:if>
									<span title="锁屏" class="ico3" onclick="fbLockScreen('锁屏','core/login!lockScreen.action',350,215);"></span>
									<c:if test="${not empty accessibleModuleMenuIds['oa_message_sendMessage']}">
										<span title="短信" class="ico4" onclick="addTab('发送短信','parkmanager.oa/web/images/m_sms_min.png','<%=BaseAction.rootLocation %>/parkmanager.oa/web/communication/sms.jsp');"></span>
									</c:if>
									<c:if test="${not empty accessibleModuleMenuIds['oa_mail_inbox']}">
										<span title="邮件" class="ico5" onclick="addTab('收件箱','parkmanager.oa/web/images/oaico/msg_12_min.png','<%=BaseAction.rootLocation %>/parkmanager.oa/mail!list.action');"></span>
									</c:if>
									<c:if test="${not empty accessibleModuleMenuIds['oa_schedule_tasking']}">
										<span title="任务分配" class="ico6" onclick="addTab('任务分配','/parkmanager.oa/web/images/oaico/task_01_min.png','<%=BaseAction.rootLocation %>/parkmanager.oa/web/task2/task_list1.jsp');"></span>
									</c:if>
								</li>
							</ul>
						</div>
						<div id="navlist" style="overflow-y: auto">
							<c:forEach var="module" items="${resourceList}" varStatus="moduleRowStatus">
								<c:if test="${module.display}">
								<c:if test="${not empty accessibleModuleMenuIds[module.idSpace]}">
									
									<ul <c:if test="${not moduleRowStatus.first}">style="display:none"</c:if>>
										<c:forEach var="menu" items="${module.children}" varStatus="rowStatus">
											<c:if test="${not empty accessibleModuleMenuIds[menu.idSpace]}">
												<li class="li1">
													<c:if test="${menu.idSpace=='ps_service_center'}">
	                                            		<c:if test="${fn:length(menu.children)==0}"><a href="javascript:void(0)" onclick="addTab('服务中心','core/common/images/service.png','<%=BaseAction.rootLocation %>/parkmanager.ps/action!service.action');">${menu.name}</a></c:if>
	                                            		<c:if test="${fn:length(menu.children)>0}"><a href="javascript:void(0)" onclick="addTab('服务中心','core/common/images/service.png','<%=BaseAction.rootLocation %>/parkmanager.ps/action!service.action');">${menu.name}</a>
															<div class="pmmenu" id="div${moduleRowStatus.count}${rowStatus.count}" style="display:none"/>
														</c:if>
													</c:if>
													<c:if test="${menu.idSpace=='ps_msgCenter'}">
	                                            		<c:if test="${fn:length(menu.children)==0}"><a href="javascript:void(0)" onclick="addTab('消息中心','core/common/images/messageCenter.png','<%=BaseAction.rootLocation %>/parkmanager.oa/mail!list.action');">${menu.name}</a></c:if>
	                                            		<c:if test="${fn:length(menu.children)>0}"><a href="javascript:void(0)" onclick="addTab('消息中心','core/common/images/messageCenter.png','<%=BaseAction.rootLocation %>/parkmanager.oa/mail!list.action');">${menu.name}</a>
															<div class="pmmenu" id="div${moduleRowStatus.count}${rowStatus.count}" style="display:none"/>
														</c:if>
													</c:if>
                                            		<em id="em${moduleRowStatus.count}${rowStatus.count}" class="b"></em>
                                            		<c:if test="${fn:length(menu.children)==0}"><a class="tt" href="${menu.uri}">${menu.name}</a></c:if>
                                            		<c:if test="${fn:length(menu.children)>0}"><a class="clicked" href="${menu.uri}">${menu.name}</a>
													<div class="pmmenu" id="div${moduleRowStatus.count}${rowStatus.count}" style="display:none">
														<dl>
															<c:forEach var="subMenu" items="${menu.children}" varStatus="subRowStatus">
																<c:if test="${not empty accessibleModuleMenuIds[subMenu.idSpace]}">
																	<c:if test="${fn:length(subMenu.children)==0  && subMenu.type ne 'operation'}">
																		<dd class="menuli">
																			<span class="spanico"><img src="${subMenu.icon}"/></span>
																			<a class="tt" id="subMenu${subMenu.idSpace}" href="${subMenu.uri}">${subMenu.name}</a>
																		</dd>
																	</c:if>
																	<c:if test="${fn:length(subMenu.children) > 0 && subMenu.children[0].type eq 'operation'}">
																		<dd class="menuli">
																			<span class="spanico"><img src="${subMenu.icon}"/></span>
																			<a class="tt" id="subMenu${subMenu.idSpace}" href="${subMenu.uri}">${subMenu.name}</a>
																		</dd>
																	</c:if>
																	<c:if test="${fn:length(subMenu.children) > 0 && subMenu.children[0].type ne 'operation'}">
																		<dd class="menuli">
																			<span class="spanimgarrow"><img src="core/common/images/closeds.gif" /></span>
																			<span class="spanimg"><img src="${subMenu.icon}"/></span>
																			<a href="javascript:void(0);" onclick="menuHandle(this)">${subMenu.name}</a>
																			<div name="menuidtwo" id="divtwo${moduleRowStatus.count}${rowStatus.count}${subRowStatus.count}" style="display:none;">
																				<dl>
																					<c:forEach var="thirdMenu" items="${subMenu.children}" varStatus="thirdRowStatus">
																					<c:if test="${not empty accessibleModuleMenuIds[thirdMenu.idSpace]}">
																						<dd class="menuli">
																							<span class="spanico2"><img src="${thirdMenu.icon}"/></span>
																							<a class="tt" id="subMenu${thirdMenu.idSpace}" href="${thirdMenu.uri}">${thirdMenu.name}</a>
																						</dd>
																					</c:if>
																					</c:forEach>
																				</dl>
																			</div>
																		</dd>
																	</c:if>
																</c:if>
															</c:forEach>
														</dl>
													</div>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
								</c:if>
							</c:forEach>
						</div>
						<%if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){ %>
						<div id="contactWay" class="userleft">
							<h1></h1>
							<ul>
								<li>${contactWay}</li>
							</ul>
							<div style="height:20px;"></div>
						</div>
						<%} %>
					</div>
					<div class="sildebottom">
						<div class="leftarrow"><img src="core/common/images/indexarrowleft.png" /></div>
						<div class="centercon">
							<div class="centerconlist" id="moduleList">
								<ul>
									<c:forEach items="${resourceList}" var="module" varStatus="rowStatus">
									<c:if test="${module.display}">
									<c:if test="${not empty accessibleModuleMenuIds[module.idSpace]}">
									<li><img class="moduleSize" title="${module.name}" src="${module.icon}" /><input value="${module.display}" type="hidden"/></li>
									</c:if>
									</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="rightarrow"><img src="core/common/images/indexarrowright.png" /></div>
					</div>
				</div>
			</td>
			<td>
				<div id="subscroll">
					<img id="disbtn" src="core/common/images/scrollleft.gif" onclick="leftHandle();"/>
				</div>
			</td>
			<td id="content">
				<div id="tt"></div>
			</td>
		</tr>
	</table>
	<div id="footer">Copyright ©2012 www.sanlue.com.cn | TEL:0571-85613587</div>
</div>
<script type="text/javascript">
function reloadNoticeList(){
	var tab = parent.$("#tt").tabs("getSelected");
	var desktop = parent.window.frames[parent.parent.$('#tt').tabs('getTabIndex',tab)];
 	desktop.frames[0].initNoticeList();
}
</script>
</body>
</html>

