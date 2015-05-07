<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.*"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date d=new Date();
request.setAttribute("scheduledDay", d);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区经理V2.0.0</title>
<link href="core/common/style/index.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/style/user.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content1.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"
	rel="stylesheet" type="text/css" />
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.ps/web/style/user.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="core/common/js/index.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/menu.js"></script>
<script type="text/javascript"
	src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript">
		<%Map<String, ResourceDto> resourceMap = CoreActivator.getHttpSessionService().getResourceMap();%>
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
			//var height = getTabContentHeight();
			//$("#navlist003").attr("height",height-175); 
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
				/* if(targetUl.siblings().first().css("display")=="none") {
					targetUl.siblings().attr("style", "display:block");
				} else {
					targetUl.siblings().attr("style", "display:none");
				} */
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
			<%if(CoreActivator.getSessionUser(request)==null){%>
				document.location.href = "/core/login!logout.action";
				return;
			<%}else{%>
			<%if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){%>
			<c:if test="${not empty accessibleModuleMenuIds['desktop']}">
			addTab("工作台",'core/common/images/console.png',"<%=basePath%>web/desktop/index.jsp");
			</c:if>
			<%}%>
			<%if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){%>
			<c:if test="${not empty accessibleModuleMenuIds['ps_service_center']}">
			addTab("服务中心",'core/common/images/service.png',"<%=BaseAction.rootLocation%>/parkmanager.ps/action!service.action");
			</c:if>
			<%}%>
			<%if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.OTHER)){%>
			<c:if test="${not empty accessibleModuleMenuIds['pb_gardenProject']}">
			addTab("苗圃项目",'/parkmanager.pb/web/images/icon/process_05_min.png',"<%=BaseAction.rootLocation%>/parkmanager.pb/garden!gardenProject.action");
			</c:if>
			<%}%>
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
			/* if(targetUl.siblings().first().css("display")=="none") {
				targetUl.siblings().attr("style", "display:block");
			} else {
				targetUl.siblings().attr("style", "display:none");
			} */
		}
		function addTab(title,icon,url){
			var plugin=title;
			if ($('#tt').tabs('exists',plugin)){
				//$('#tt').tabs('select', plugin);
				$('#tt').tabs('close', plugin);
				$('#tt').tabs('add',{
					title:plugin,
					iconCls:'icon-reload',
					content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight-150)+'" width="100%"></iframe>',
					closable:true
				});
			} else{
				$('#tt').tabs('add',{
					title:plugin,
					iconCls:'icon-reload',
					content: '<iframe src="'+url+'" frameborder="0" height="'+(document.documentElement.clientHeight-150)+'" width="100%"></iframe>',
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
						content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.parent.document.documentElement.clientHeight-157)+'" width="100%"></iframe>'
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
				if("${type}" == 'third'){
					obj.href = 'core/login!logout.action?type=${type}';
				}else{
					obj.href = 'core/login!logout.action';
				}
			}
		}
		function logout(){
			if(confirm("确定要重新登录")){
				if("${type}" == 'third'){
					window.location.href = '<%=BaseAction.rootLocation+"/core/"%>login!logout.action?type=${type}';
				}else{
					window.location.href = '<%=BaseAction.rootLocation+"/core/"%>login!logout.action';
			}
		}
	}

	function topLoadPage(url) {
		for ( var i = 1; i <= 4; i++) {
			$(".navlist" + i).attr("style", "display:none");
			$("#appli" + i).removeClass("current");
			if (i == 4)
				$("#tt").attr("style", "display:none");
			else
				$("#tt" + i).attr("style", "display:none");
		}
		$(".navlist3").attr("style", "display:block");
		$("#appli3").addClass("current");
		loadPage("#tt2", url);

	}
	function changeDiv(no) {
		for ( var i = 1; i <= 4; i++) {
			$(".navlist" + i).attr("style", "display:none");
			$("#appli" + i).removeClass("current");
			if (i == 4) {
				$("#tt").attr("style", "display:none");
				var ifm = $("#tt iframe");
				ifm.each(function(ind, e) {
					e.src = '';
				});
			} else {
				$("#tt" + i).attr("style", "display:none");
				var ifm = $("#tt" + i + " iframe");
				ifm.each(function(ind, e) {
					e.src = '';
				});
				$("#tt" + i).empty();
			}
		}
		if (no == 1) {
			$(".navlist1").attr("style", "display:block");
			$("#appli1").addClass("current");
			$("#tt").attr("style", "display:block");
			closeAllTab();
			initHeight();
			initConsole();
		} else if (no == 2) {
			$(".navlist2").attr("style", "display:block");
			$("#appli2").addClass("current");
			loadPage("#tt1", "/core/web/newdesktop/indexv1_01.jsp");
		} else if (no == 3) {

			$(".navlist3").attr("style", "display:block");
			$("#appli3").addClass("current");
			//loadPage("#tt2","/department.synthesis/web/task2/task_list1.jsp");
			navlist02liChange(2,
					"/department.synthesis/web/task2/task_list1.jsp");

		} else if (no == 4) {
			var height = getTabContentHeight();
			$("#navlist003").height(height - 195);
			$(".navlist4").attr("style", "display:block");
			$("#appli4").addClass("current");

			$("#tt").attr("style", "display:block");
			var found = false;
			$("#navlist003 li").each(function() {
				if (!found && $(this).css('display') == 'block') {
					$(this).find("a")[0].click();
					found = true;
				}
			});

		}
	}
	function navlist02liChange(cur, url) {
		for ( var i = 1; i <= 3; i++) {
			$("#navlist02li" + i).removeClass("on");
		}
		$("#navlist02li" + cur).addClass("on");
		loadPage("#tt2", url);
	}
	function navlist003liChange(tabName, cur, url) {
		for ( var i = 1; i <= 11; i++) {
			$("#navlist003" + i).removeClass("on");
		}
		$("#navlist003" + cur).addClass("on");

		closeAllTab();
		addOrUpdateTab(tabName, "core/common/images/search_icon.gif", url);
	}

	function loadPage(panalName, url) {
		$(panalName).attr("style", "display:block");
		$(panalName)
				.html(
						'<iframe src="'
								+ url
								+ '" frameborder="0" height="'
								+ (parent.parent.document.documentElement.clientHeight - 120)
								+ '" width="100%"></iframe>');
	}
	function closeAllTab() {
		$('#tt').tabs().each(function(index, obj) {
			//获取所有可关闭的选项卡
			for ( var j = $(".tabs-closable", this).length - 1; j >= 0; j--) {
				var tab = $(".tabs-closable", this)[j].innerText;
				//alert(tab);
				$('#tt').tabs('close', tab);
			}
		});
	}

	function changeMenu(obj, tt, url) {
		loadPage(tt, url);
		$(obj).parent().addClass("on");
		$(obj).parent().siblings().removeClass("on");
	}
</script>
</head>

<body>
	<div id="header">
		<div id="topnav">
			<div class="leftnav">
				<span title="title" class="span1"><a href="#">园区导航</a></span> <span
					class="username">${user.username}<c:if
						test="${user.email ne null and user.email ne ''}">[<a
							href="#">${user.email}</a>]</c:if></span> <span class="toplink"><a
					href="<%=basePath%>index.action">首页</a>|</span> <span class="setup"><a
					id="selfConfig" href="javascript:void(0)"
					onclick="addTab('账户设置','core/common/images/console.png','core/web/account/core_user_edit.jsp')">账户设置</a></span>
			</div>
			<div class="rightnav">
				<a href="#">关于</a>|<a href="javascript:void(0)"
					onclick="fbStart('修改密码','core/self!passwordReset.action',350,150);">修改密码</a>|<a
					href="javascript:void(0)"
					onclick="fbLockScreen('锁屏','core/login!lockScreen.action',350,215);">锁屏</a>|<a
					href="javascript:void();" onclick="logout(this);" target="_top">退出</a>
			</div>
		</div>


		<!--headerdown-->
		<div id="headerdown">
			<!--logo-->
			<div id="logo2" style="vertical-align: middle; height: 60px;">
				<img src="core/common/images/loginlogo2.png"
					style="margin-top: 10px;" height="31" width="500" />
			</div>
			<!--//logo-->
			<!--nav-->
			<div id="nav_new">
				<ul id="mini_nav">
					<li class="nav1"><a
						href="parkmanager.oa_new/indexv2_xinxi.html" title="信息"></a></li>
					<li class="nav2"><a
						href="javascript:topLoadPage('/department.synthesis/web/workmanage/workReportIndex.jsp')"
						title="汇报"></a></li>
					<li class="nav3"><a
						href="javascript:topLoadPage('/parkmanager.pf/contact!taskList1.action')"
						title="流程"></a></li>
					<li class="nav4"><a
						href="javascript:topLoadPage('/department.synthesis/web/task2/task_list1.jsp')"
						title="工作"></a></li>
					<li class="nav5"><a
						href="javascript:topLoadPage('/parkmanager.cms/web/document/personaldocuments_list.jsp')"
						title="文档"></a></li>
					<li class="nav6"><a
						href="javascript:topLoadPage('/department.synthesis/mail!list.action')"
						title="邮件"></a></li>
					<li class="nav7"><a
						href="javascript:topLoadPage('/department.synthesis/userSign!viewSignInfo.action')"
						title="考勤"></a></li>
					<li class="nav8"><a href="#" title="搜索"></a></li>
				</ul>
				<div class="hackbox"></div>
			</div>
			<!--//nav-->
			<!--rightpic-->
			<div id="rightpic">
				<div class="time">
					<script language=JavaScript>
						today = new Date();

						function initArray() {

							this.length = initArray.arguments.length

							for ( var i = 0; i < this.length; i++)

								this[i + 1] = initArray.arguments[i]
						}

						var d = new initArray(

						" 星期日",

						" 星期一",

						" 星期二",

						" 星期三",

						" 星期四",

						" 星期五",

						" 星期六");

						document
								.write(

										"<font color=#7f7f7f style='font-size:9pt;font-family: 宋体'> ",

										today.getYear(), "年",

										today.getMonth() + 1, "月",

										today.getDate(), "日",

										d[today.getDay() + 1],

										"</font>");
					</script>
				</div>
				<ul id="rightpics">
					<li class="pic1"><a href="#" title="主页"></a></li>
					<li class="pic2"><a href="#" title="刷新"></a></li>
					<li class="pic3"><a href="#" title="帮助"></a></li>
					<li class="pic4"><a href="#" title="锁定"></a></li>
				</ul>
			</div>
			<!--rightpic-->
		</div>
		<!--//headerdown-->



	</div>
	<div id="contant">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="202">
					<div id="sub" style="display: block; margin-top: 1px;">
						<div id="subnav">
							<div id="topico">
								<ul>
									<li><span title="菜单聚合" id="ico" class="ico1"
										onclick="flatModule(this);"></span> <c:if
											test="${not empty accessibleModuleMenuIds['desktop']}">
											<span title="工作台" class="ico2"
												onclick="addTab('工作台','core/common/images/console.png','<%=basePath%>web/desktop/index.jsp');"></span>
										</c:if> <span title="锁屏" class="ico3"
										onclick="fbLockScreen('锁屏','core/login!lockScreen.action',350,215);"></span>
										<c:if
											test="${not empty accessibleModuleMenuIds['oa_message_sendMessage']}">
											<span title="短信" class="ico4"
												onclick="addTab('发送短信','parkmanager.oa/web/images/m_sms_min.png','<%=BaseAction.rootLocation%>/parkmanager.oa/web/communication/sms.jsp');"></span>
										</c:if> <c:if
											test="${not empty accessibleModuleMenuIds['oa_mail_inbox']}">
											<span title="邮件" class="ico5"
												onclick="addTab('收件箱','parkmanager.oa/web/images/oaico/msg_12_min.png','<%=BaseAction.rootLocation%>/parkmanager.oa/mail!list.action');"></span>
										</c:if> <c:if
											test="${not empty accessibleModuleMenuIds['oa_schedule_tasking']}">
											<span title="任务分配" class="ico6"
												onclick="addTab('任务分配','/parkmanager.oa/web/images/oaico/task_01_min.png','<%=BaseAction.rootLocation%>/parkmanager.oa/web/task2/task_list1.jsp');"></span>
										</c:if></li>
								</ul>
							</div>
							<div id="navlist" class="navlist1"
								style="overflow-y: auto; display: block;">
								<c:forEach var="module" items="${resourceList}"
									varStatus="moduleRowStatus">
									<c:if test="${module.display}">
										<c:if
											test="${not empty accessibleModuleMenuIds[module.idSpace]}">

											<ul<%-- <c:if test="${not moduleRowStatus.first}">style="display:none"</c:if> --%>>
												<c:forEach var="menu" items="${module.children}"
													varStatus="rowStatus">
													<c:if
														test="${not empty accessibleModuleMenuIds[menu.idSpace]}">
														<li class="li1"><c:if
																test="${menu.idSpace=='ps_service_center'}">
																<c:if test="${fn:length(menu.children)==0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('服务中心','core/common/images/service.png','<%=BaseAction.rootLocation%>/parkmanager.ps/action!service.action');">${menu.name}</a>
																</c:if>
																<c:if test="${fn:length(menu.children)>0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('服务中心','core/common/images/service.png','<%=BaseAction.rootLocation%>/parkmanager.ps/action!service.action');">${menu.name}</a>
																	<div class="pmmenu"
																		id="div${moduleRowStatus.count}${rowStatus.count}"
																		style="display: none" />
																</c:if>
															</c:if> <c:if test="${menu.idSpace=='ps_msgCenter'}">
																<c:if test="${fn:length(menu.children)==0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('消息中心','core/common/images/messageCenter.png','<%=BaseAction.rootLocation%>/parkmanager.oa/mail!list.action');">${menu.name}</a>
																</c:if>
																<c:if test="${fn:length(menu.children)>0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('消息中心','core/common/images/messageCenter.png','<%=BaseAction.rootLocation%>/parkmanager.oa/mail!list.action');">${menu.name}</a>
																	<div class="pmmenu"
																		id="div${moduleRowStatus.count}${rowStatus.count}"
																		style="display: none" />
																</c:if>
															</c:if> <c:if test="${menu.idSpace=='pb_projectManagement'}">
																<c:if test="${fn:length(menu.children)==0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('入孵管理','/parkmanager.pb/web/images/icon/projectadmin_01_min.png','<%=BaseAction.rootLocation %>${menu.uri }');">${menu.name}</a>
																</c:if>
																<c:if test="${fn:length(menu.children)>0}">
																	<a href="javascript:void(0)"
																		onclick="addTab('入孵管理','/parkmanager.pb/web/images/icon/projectadmin_01_min.png','<%=BaseAction.rootLocation %>${menu.uri }');">${menu.name}</a>
																	<div class="pmmenu"
																		id="div${moduleRowStatus.count}${rowStatus.count}"
																		style="display: none" />
																</c:if>
															</c:if> <em id="em${moduleRowStatus.count}${rowStatus.count}"
															class="b"></em> <c:if
																test="${fn:length(menu.children)==0}">
																<a class="tt" href="${menu.uri}">${menu.name}</a>
															</c:if> <c:if test="${fn:length(menu.children)>0}">
																<a class="clicked" href="${menu.uri}">${menu.name}</a>
																<div class="pmmenu"
																	id="div${moduleRowStatus.count}${rowStatus.count}"
																	style="display: none">
																	<dl>
																		<c:forEach var="subMenu" items="${menu.children}"
																			varStatus="subRowStatus">
																			<c:if
																				test="${not empty accessibleModuleMenuIds[subMenu.idSpace]}">
																				<c:if
																					test="${fn:length(subMenu.children)==0  && subMenu.type ne 'operation'}">
																					<dd class="menuli">
																						<span class="spanico"><img
																							src="${subMenu.icon}" /></span> <a class="tt"
																							id="subMenu${subMenu.idSpace}"
																							href="${subMenu.uri}">${subMenu.name}</a>
																					</dd>
																				</c:if>
																				<c:if
																					test="${fn:length(subMenu.children) > 0 && subMenu.children[0].type eq 'operation'}">
																					<dd class="menuli">
																						<span class="spanico"><img
																							src="${subMenu.icon}" /></span> <a class="tt"
																							id="subMenu${subMenu.idSpace}"
																							href="${subMenu.uri}">${subMenu.name}</a>
																					</dd>
																				</c:if>
																				<c:if
																					test="${fn:length(subMenu.children) > 0 && subMenu.children[0].type ne 'operation'}">
																					<dd class="menuli">
																						<span class="spanimgarrow"><img
																							src="core/common/images/closeds.gif" /></span> <span
																							class="spanimg"><img src="${subMenu.icon}" /></span>
																						<a href="javascript:void(0);"
																							onclick="menuHandle(this)">${subMenu.name}</a>
																						<div name="menuidtwo"
																							id="divtwo${moduleRowStatus.count}${rowStatus.count}${subRowStatus.count}"
																							style="display: none;">
																							<dl>
																								<c:forEach var="thirdMenu"
																									items="${subMenu.children}"
																									varStatus="thirdRowStatus">
																									<c:if
																										test="${not empty accessibleModuleMenuIds[thirdMenu.idSpace]}">
																										<dd class="menuli">
																											<span class="spanico2"><img
																												src="${thirdMenu.icon}" /></span> <a class="tt"
																												id="subMenu${thirdMenu.idSpace}"
																												href="${thirdMenu.uri}">${thirdMenu.name}</a>
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
															</c:if></li>
													</c:if>
												</c:forEach>
											</ul>
										</c:if>
									</c:if>
								</c:forEach>
							</div>
							<div class="subnav2 navlist2" style="display: none">
								<!--navlist-->
								<div id="navlist01">
									<ul>
										<li class="on"><a href="javascript:void(0)"
											onclick="changeMenu(this,'#tt1','/core/web/newdesktop/indexv1_01.jsp');">园区资讯</a></li>
										<li><a href="javascript:void(0)"
											onclick="changeMenu(this,'#tt1','/core/web/newdesktop/yetopen.html');">园区助手</a></li>
									</ul>
								</div>
								<!--//navlist-->

							</div>

							<div class="subnav2 navlist3" style="display: none">

								<!-- 
				          <div id="wyears"><img src="core/common/images/wnl.gif" width="200" height="175" /> </div>-->


								<div class="schedule">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="300" valign="top">
												<div class="leftdiv" id="resizable">

													<div class="day_calendar">
														<div class="day_calendar_subject">
															<span class="dayleft"
																onmouseover="this.className='dayleftover'"
																onmouseout="this.className='dayleft'"
																onclick="location.href='<%=basePath %>schedule!list.action?monthAction=prev&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"></span>
															<span class="dayright"
																onmouseover="this.className='dayrightover'"
																onmouseout="this.className='dayright'"
																onclick="location.href='<%=basePath %>schedule!list.action?monthAction=next&scheduledDay=<fmt:formatDate value="${scheduledDay}" pattern="yyyy-MM-dd"/>'"></span>
															<fmt:formatDate value="${scheduledDay }"
																pattern="yyyy年M月" />
														</div>
														<table width="100%" class="daytable" border="0"
															cellspacing="0" cellpadding="0">
															<tr>
																<td class="dayth">一</td>
																<td class="dayth">二</td>
																<td class="dayth">三</td>
																<td class="dayth">四</td>
																<td class="dayth">五</td>
																<td class="dayth">六</td>
																<td class="dayth">日</td>
															</tr>
															<c:forEach begin="0" end="5" var="s">
																<tr>
																	<c:forEach items="${result.value}" begin="${s*7}"
																		end="${s*7+6}" var="date">
																		<td
																			class="daytd<c:if test="${date.checkedDay eq true && date.nowDate eq true}">_blue</c:if><c:if test="${date.checkedDay eq true && date.nowDate eq false}">_blue</c:if><c:if test="${date.checkedDay eq false && date.nowDate eq true}">_graybg</c:if><c:if test="${date.schedules ne null}">_active</c:if><c:if test="${date.thisMonth eq false}"> daytdgray</c:if>">
																			<a href="javascript:void(0)"
																			onclick="location.href='<%=basePath %>schedule!list.action?scheduledDay=<fmt:formatDate value="${date.date}" pattern="yyyy-MM-dd"/>'">${date.day}</a>
																		</td>
																	</c:forEach>
																</tr>
															</c:forEach>
														</table>
													</div>
												</div>
											</td>
										</tr>
									</table>
								</div>

								<div id="navlist02" class="dn-navlist"
									style="background: #f0f0f0">
									<ul>
										<!-- <li id="navlist02li1"><a href="javascript:navlist02liChange(1,'/department.synthesis/schedule!list.action')" >日程管理</a></li>
				              <li id="navlist02li2" class="on"><a href="javascript:navlist02liChange(2,'/department.synthesis/web/task2/task_list1.jsp')">任务分配</a></li>
				              <li id="navlist02li3"><a href="javascript:navlist02liChange(3,'/department.synthesis/web/workmanage/workReportIndex.jsp')">工作汇报</a></li>
				               -->

										<li class="li1 a1"><span class="spanico"><img
												src="/core/common/images/dn_icon02.png"></span><a
											href="parkmanager.dn/web/fhqy/fhqy_list.html"
											target="rightmain" id="fhq2">孵化企业</a></li>
										<li class="li1"><span class="spanico"><img
												src="/core/common/images/dn_icon03.png"></span><a
											href="parkmanager.dn/web/xxgl/xxgl_list.html"
											target="rightmain" id="fhq3">消息管理</a></li>
										<li class="li1 "><span class="spanico"><img
												src="/core/common/images/dn_icon04.png"></span><a
											href="parkmanager.dn/web/sjtb/sjtb_list.html"
											target="rightmain" id="fhq41">数据填报</a></li>

									</ul>
								</div>
								<!--//navlist-->
							</div>
							<div class="subnav2 navlist4" style="display: none">
								<div id="navlist003">
									<ul>
										<li class="on" id="navlist0031" style="display: block"><a
											href="javascript:navlist003liChange('销售管理',1,'/core/web/newdesktop/indexv3_01.jsp')"><img
												src="core/common/images/nav3_01.png" width="68" height="74" /></a></li>
										<li id="navlist0032" style="display: block"><a
											href="javascript:navlist003liChange('招商管理',2,'/core/web/newdesktop/indexv3_02.jsp')"><img
												src="core/common/images/nav3_02.png" width="68" height="74" /></a></li>
										<li id="navlist0033" style="display: block"><a
											href="javascript:navlist003liChange('客户管理',3,'/core/web/newdesktop/indexv3_03.jsp')"><img
												src="core/common/images/nav3_03.png" width="68" height="74" /></a></li>
										<li id="navlist0034" style="display: block"><a
											href="javascript:navlist003liChange('结算管理',4,'/core/web/newdesktop/indexv3_04.jsp')"><img
												src="core/common/images/nav3_04.png" width="68" height="74" /></a></li>
										<li id="navlist0035" style="display: block"><a
											href="javascript:navlist003liChange('物业管理',5,'/core/web/newdesktop/indexv3_05.jsp')"><img
												src="core/common/images/nav3_05.png" width="68" height="74" /></a></li>
										<li id="navlist0036" style="display: block"><a
											href="javascript:navlist003liChange('工程管理',6,'/core/web/newdesktop/indexv3_06.jsp')"><img
												src="core/common/images/nav3_06.png" width="68" height="74" /></a></li>
										<li id="navlist0037" style="display: block"><a
											href="javascript:navlist003liChange('办公管理',7,'/core/web/newdesktop/indexv3_07.jsp')"><img
												src="core/common/images/nav3_07.png" width="68" height="74" /></a></li>
										<li id="navlist0038" style="display: block"><a
											href="javascript:navlist003liChange('园区宝',8,'/core/web/newdesktop/indexv3_08.jsp')"><img
												src="core/common/images/nav3_08.png" width="68" height="74" /></a></li>
										<li id="navlist0039" style="display: block"><a
											href="javascript:navlist003liChange('内容管理',9,'/parkmanager.cms/web/desktop/indexv3_09.jsp')"><img
												src="core/common/images/nav3_09.png" width="68" height="74" /></a></li>
										<li id="navlist00310" style="display: block"><a
											href="javascript:navlist003liChange('综合数据',10,'/core/web/newdesktop/indexv3_10.jsp')"><img
												src="core/common/images/nav3_10.png" width="68" height="74" /></a></li>
										<li id="navlist00311" style="display: block"><a
											href="javascript:navlist003liChange('驾驶舱',11,'/core/web/newdesktop/indexv3_11.jsp')"><img
												src="core/common/images/nav3_11.png" width="68" height="74" /></a></li>
										<!-- <li id="navlist00312" style="display: block"><a href="javascript:navlist003liChange('园区窗口',12,'/core/web/newdesktop/indexv3_12.jsp')"><img src="core/common/images/nav3_11.png" width="68" height="74" /></a></li> -->
									</ul>
								</div>

							</div>
							<%
								if(CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)
													||CoreActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.OTHER)){
							%>
							<div id="contactWay" class="userleft">
								<h1></h1>
								<ul>
									<li>${contactWay}</li>
								</ul>
								<div style="height: 20px;"></div>
							</div>
							<%
								}
							%>
						</div>
						<!-- bundle切换按钮 -->
						<!-- <div class="sildebottom">
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
					 -->
						<!--sildebottom-->
						<div class="sildebottom2">
							<div class="leftarrow">
								<!--<img src="core/common/images/indexarrowleft.png" />-->
							</div>
							<div class="centercon">
								<div class="centerconlist2">
									<ul>
										<li id="appli1" class="current"><a
											href="javascript:void(0)" onclick="changeDiv(1)"><img
												title="聚合菜单" src="core/web/newdesktop/images/oa021.png" /></a></li>
										<li id="appli2"><a href="javascript:void(0)"
											onclick="changeDiv(2)"><img title="园区动力"
												src="core/web/newdesktop/images/dongli_ico.png" /></a></li>
										<li id="appli3"><a href="javascript:void(0)"
											onclick="changeDiv(3)"><img title="任务分配"
												src="core/web/newdesktop/images/renwu_ico.png" /></a></li>
										<li id="appli4"><a href="javascript:void(0)"
											onclick="changeDiv(4)"><img title="业务功能"
												src="core/web/newdesktop/images/yewsu_ico.png" /></a></li>
									</ul>
								</div>
							</div>
							<div class="rightarrow">
								<!--<img src="core/common/images/indexarrowright.png" />-->
							</div>
						</div>
						<!--//sildebottom-->

					</div>
				</td>
				<td width="8">
					<div id="subscroll">
						<img id="disbtn" src="core/common/images/scrollleft.gif"
							onclick="leftHandle();" />
					</div>
				</td>
				<td>
					<div id="tt1" style="display: none"></div>
					<!-- 资讯 -->
					<div id="tt2" style="display: none"></div>
					<!-- 工作/任务-->
					<div id="tt3" style="display: none"></div>
					<!-- 备用 -->
					<div id="tt" style="display: none"></div>
					<!-- 工作台/业务系统 -->
				</td>
			</tr>
		</table>
		<div id="footer">Copyright ©2012 www.sanlue.com.cn |
			TEL:0571-85613587</div>
	</div>
	<script type="text/javascript">
		function reloadNoticeList() {
			var tab = parent.$("#tt").tabs("getSelected");
			var desktop = parent.window.frames[parent.parent.$('#tt').tabs(
					'getTabIndex', tab)];
			desktop.frames[0].initNoticeList();
		}
	</script>
</body>
</html>

