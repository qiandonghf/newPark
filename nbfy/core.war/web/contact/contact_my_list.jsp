<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.preferences.enums.ContactTypeEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<style type="text/css">
			.highlight {
				background: #f4f4f4
			}
</style>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript"> 
	function pageheight(nameid1,height1,nameid2,height2){//获取屏幕高度
		var bodyh=window.parent.document.documentElement.clientHeight-height1;
		var bodyh1=window.parent.document.documentElement.clientHeight-height2;
		var bodyw=window.parent.document.documentElement.clientWidth-590;
		document.getElementById(nameid1).style.height=bodyh+"px";
		document.getElementById(nameid2).style.height=bodyh1+"px";
		//document.getElementById(nameid2).style.width=bodyw+"px";
	}
	$(document).ready(function() {
		pageheight('resizable',88,'pm_msglist',91);
		$('#contactdiv').css('height',getTabContentHeight()-58);
		initTip();
		afterList();
		 //右击菜单
		initMenu();
	});
 
	function initMenu(){
		var imageMenuData = [
		                  	  [{
		                  			text: "打开",
		                  			classname: "smarty_menu_view",
		                  			func: function() {
		                  				var type = $(this).find("input").val();
		                  				var id = $(this).find("input").next().val();
		                  				openRight(type,id);
		                  			}
		                  		},{
		                  			text: "编辑",
		                  			classname: "smarty_menu_ico0",
		                  			func: function() {
		                  				var type = $(this).find("input").val();
		                  				var id = $(this).find("input").next().val();
		                  			  /* fbStart('编辑联系单','parkmanager.pb/web/client/applicationadd.html',700,538); */
		                  			  edit(type,id);
		                  			}
		                  		},{
		                  			text: "打印",
		                  			classname: "smarty_print",
		                  			func: function() {
		                  			  
		                  			}
		                  		}
		                  		
		                  		],[
		                  		{
		                  			text: "受理",
		                  			classname: "smarty_menu_acceptance",
		                  			func: function() {
		                  				
		                  			}
		                  		},
		                  		{
		                  			text: "关闭",
		                  			classname: "smarty_menu_close",
		                  			func: function() {
		                  				
		                  			}
		                  		},
		                  		{
		                  			text: "挂起",
		                  			classname: "smarty_suspend",
		                  			func: function() {
		                  				
		                  			}
		                  		},
		                  		{
		                  			text: "发送",
		                  			classname: "smarty_send",
		                  			func: function() {
		                  				
		                  			}
		                  		}
		                  		]
		                  	  ,[
		                  		{
		                  			text: "已解决",
		                  			classname: "smarty_menu_finish",
		                  			func: function() {
		                  				
		                  			}
		                  		},
		                  		{
		                  			text: "未解决",
		                  			classname: "smarty_menu_failed",
		                  			func: function() {
		                  				
		                  			}
		                  		},
		                  		{
		                  			text: "部分解决",
		                  			classname: "smarty_menu_part",
		                  			func: function() {
		                  				
		                  			}
		                  		}
		                  		],
		                  		[
		                  	  {
		                  			text: "删除",
		                  			classname: "smarty_menu_ico2",
		                  			func: function() {
		                  				if(confirm("你确定要删除")){
		                  					var type = $(this).find("input").val();
		                  					var id = $(this).find("input").next().val();
		                  					if(type == '<%=ContactTypeEnum.INVESTMENTCONTACT%>'){
		                  						$.post("<%=url%>parkmanager.pb/investmentContact!delete.action?id="+id,function(data){
		                  							showTip(data.result.msg,2000);
		                  							if(data.result.success){
		                  								setTimeout("location.reload()", 2000);
		                  							}
		                  						});
		                  					}
		                  				}
		                  			}
		                  		}
		                  		
		                  		]
		                  	];
		   	
		   	$(".investmentContact").smartMenu(imageMenuData1,{name:'table1'});
		   	$(".rentOutContact").smartMenu(imageMenuData2,{name:'table2'});
		   	$(".businessCenterContact").smartMenu(imageMenuData3,{name:'table3'});
		   	$(".tenementCenterContact").smartMenu(imageMenuData4,{name:'table4'});
		   	$(".financeContact").smartMenu(imageMenuData5,{name:'table5'});
		    $(".carportOutContact").smartMenu(imageMenuData6,{name:'table6'});
		    $(".customerServiceContact").smartMenu(imageMenuData7,{name:'table7'});
	}
	
	function afterList(){
		if($("#afterType").val()!='' && $("#afterId").val()!=''){
			openRight($("#afterType").val(),$("#afterId").val());
		}
	}
	function openRight(type,id){
		var currentTime = new Date().getTime();
		var src = "<%=basePath%>contact!myView.action?type="+type+"& id="+id+"&currentTime="+currentTime;
		$("#pm_msglist").attr("src",src);
	}
	function edit(type,id){
		if(type == '<%=ContactTypeEnum.INVESTMENTCONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/investmentContact!edit.action?id='+id,700,538);
		}else if(type == '<%=ContactTypeEnum.RENTOUTCONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/rentOutContact!edit.action?id='+id,500,438);
		}else if(type == '<%=ContactTypeEnum.BUSINESSCENTERCONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/businessCenterContact!edit.action?id='+id,500,438);
		}else if(type == '<%=ContactTypeEnum.TENEMENTCENTERCONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/tenementCenterContact!edit.action?id='+id,500,438);
		}else if(type == '<%=ContactTypeEnum.FINANCECONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/financeContact!edit.action?id='+id,500,438);
		}else if(type == '<%=ContactTypeEnum.CARPORTOUTCONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/carportOutContact!edit.action?id='+id,600,538);
		}else if(type == '<%=ContactTypeEnum.CUSTOMERSERVICECONTACT%>'){
			fbStart('编辑联系单','/parkmanager.pb/customerServiceContact!edit.action?id='+id,600,538);
		}
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
	function slide(id){
		if($('#'+id).is(':hidden')){
			$('#'+id).slideDown();
		}else{
			$('#'+id).slideUp();
		}	   
	}
 	function jumpPage(page){
		var url = "<%=basePath%>contact!listMyAll.action";
		url += "?page="+page;
		url = encodeURI(url);
		location.href=url;
	}
 	function reloadList(type,id){
 		var currentTime = new Date().getTime();
 		var src = "<%=basePath%>contact!listMyAll.action?type="+type+"& id ="+id+"& currentTime="+currentTime;
 		this.location.href=src;
 	}
 	function setSelectedUser(user){
		var type = $("#afterType").val();
		var id= $("#afterId").val();
		var receiveId = user.id;
		var approvalType = $("#approvalType").val();
		if(type == 'INVESTMENTCONTACT'){
			var url="<%=url%>parkmanager.pb/investmentContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'RENTOUTCONTACT'){
			var url="<%=url%>parkmanager.pb/rentOutContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'BUSINESSCENTERCONTACT'){
			var url="<%=url%>parkmanager.pb/businessCenterContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'TENEMENTCENTERCONTACT'){
			var url="<%=url%>parkmanager.pb/tenementCenterContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'FINANCECONTACT'){
			var url="<%=url%>parkmanager.pb/financeContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'CARPORTOUTCONTACT'){
			var url="<%=url%>parkmanager.pb/carportOutContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
			});
		}else if(type == 'CUSTOMERSERVICECONTACT'){
			var url="<%=url%>parkmanager.pb/customerServiceContact!send.action?id="+id+"&receiveId="+receiveId+"&approvalType="+approvalType;
			$.post(url,function(data){
				showTip(data.result.msg,2000);
				setTimeout(function(){
					var src = "<%=basePath%>contact!listMyAll.action?type="+$("#afterType").val()+"& id ="+$("#afterId").val();
			 		this.location.href=src;
					
				},2000);
			});
		}
	}
 	function refresh(){
 		this.location.href="<%=basePath%>contact!listMyAll.action";
 	}
 	function mySearch(typeEnum,title){
	 	$("#contactType").val(title);
	 	$("#contactEnum").val(typeEnum);
 	}
 	function myRefresh(){
 		this.location.href="<%=basePath%>contact!listMyAll.action?type="+$("#contactEnum").val();
 	}
</script>
<jsp:include page="investment_contact_menu.jsp" />
<jsp:include page="rentOut_contact_menu.jsp" />
<jsp:include page="businessCenter_contact_menu.jsp" />
<jsp:include page="tenementCenter_contact_menu.jsp" />
<jsp:include page="finance_contact_menu.jsp" />
<jsp:include page="carportOut_contact_menu.jsp" />
<jsp:include page="customerService_contact_menu.jsp" />
</head>
 
<body>
	<input id="approvalType" type="hidden" name="approvalType" />
	<input id="afterType" value="${type }" type="hidden" />
	<input id="afterId" value="${id }" type="hidden" />
	<div class="emailtop">
		<!--leftemail-->
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="companylabel();" class=""><span><img src="core/common/images/emailadd.gif" width="15" height="13"></span>新建<em class="em"><img src="core/common/images/arrow.png"></em> <!--meterlayer-->
					<div class="company_label newCustomerForm" id="company_label" style="display: none; left: 5px; top: 26px;z-index: 99999;">
						<div class="titlebg">
							<span style="float: right"><img src="core/common/images/companyclose.gif" style="cursor: pointer;" /></span>联系单
						</div>
						<ul>
							<li><c:forEach items="${typeEnums }" var="typeEnum">
										<c:if test="${typeEnum eq 'INVESTMENTCONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/investment_contact_add.jsp',600,338);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'RENTOUTCONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/rentOut_contact_add.jsp',600,338);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'BUSINESSCENTERCONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/businessCenter_contact_add.jsp',500,156);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'TENEMENTCENTERCONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/tenementCenter_contact_add.jsp',500,338);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'FINANCECONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/finance_contact_add.jsp',500,338);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'CARPORTOUTCONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/carportOut_contact_add.jsp',600,338);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
										<c:if test="${typeEnum eq 'CUSTOMERSERVICECONTACT' }">
											<a href="javascript:void(0)" title="${typeEnum.title }"
												onclick="fbStart('${typeEnum.title}','/parkmanager.pb/web/contact/customerService_contact_add.jsp',700,200);">
												<c:choose>
													<c:when test="${fn:length(typeEnum.title)>6 }">
												${fn:substring(typeEnum.title,0,6) }...
											</c:when>
													<c:otherwise>
												${typeEnum.title }
											</c:otherwise>
												</c:choose>
											</a>
										</c:if>
								</c:forEach></li>
						</ul>
					</div> <!--meterlayer--></li>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="refresh()"><span><img src="core/common/images/refresh3.png" /></span>刷新</li>
			</ul>
		</div>
		<!--//leftemail-->
	</div>
	<!--container-->
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="355" valign="top" id="fee_lefts">
					<div class="write_list" style="border-right: 1px solid #ddd; border-bottom: none; width: 355px;" id="resizable">
						<div class="searchdiv">
							<form id="form2" name="form2" method="post" action="">
								<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="85">联系单类型：</td>
											<td width="180"><table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody>
														<tr>
															<td>
																	<input  id="contactEnum" name="contactEnum"  type="hidden" class="data inputauto"/>
																	<input onkeyup="$('#customerEnum').val('')" id="contactType" name="contactType" readonly="readonly"  type="text" class="data inputauto"/>
															</td>
															<td width="25" align="center" onclick="companylabel2();"><img style="cursor: pointer;" src="core/common/images/outdiv.gif" width="20" height="22"  />
																<div class="company_label2 newCustomerForm" id="company_label2" style="display: none; left: 0px; top: 55px; z-index: 99999;">
																	<div class="titlebg">
																		<span style="float: right"><img src="core/common/images/companyclose.gif" style="cursor: pointer;" /></span>联系单
																	</div>
																	<h1>分类1</h1>
																	<ul>
																		<li style="line-height: 26px;"><c:forEach items="${typeEnums }" var="typeEnum">
																				<c:if test="${typeEnum eq 'INVESTMENTCONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'RENTOUTCONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'BUSINESSCENTERCONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'TENEMENTCENTERCONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'FINANCECONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'CARPORTOUTCONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																				<c:if test="${typeEnum eq 'CUSTOMERSERVICECONTACT' }">
																					<a href="javascript:void(0)" title="${typeEnum.title }" onclick="mySearch('${typeEnum }','${typeEnum.title }');">
																						<c:choose>
																							<c:when test="${fn:length(typeEnum.title)>6 }">
																								${fn:substring(typeEnum.title,0,6) }...
																							</c:when>
																							<c:otherwise>
																								${typeEnum.title }
																							</c:otherwise>
																						</c:choose>
																					</a>
																				</c:if>
																			</c:forEach></li>
																	</ul>
																</div></td>
														</tr>
													</tbody>
												</table></td>

											<td align=""><input name="Submit" type="button" onclick="myRefresh()" class="search_cx" value=" " /></td>
										</tr>
									</tbody>
								</table>
							</form>
						</div>
						<!--merter_fee-->
						<div id="contactdiv" style="overflow-x: hidden; overflow-y: auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								id="lsittable">
								<tr>
									<td class="tdcenterL">联系单</td>
									<td align="center" class="tdleftc">发起人</td>
									<td align="center" class="tdleftc">最后处理时间</td>
									<td width="35" class="tdrightc"><img
										src="core/common/images/rightgray.png" width="7" height="7"></td>
								</tr>
								<c:forEach items="${dtoList }" var="dto">
									<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff';keepHighlight(this)" style="cursor: pointer;" onclick="openRight('${dto.type}',${dto.id });highlight(this);"
										<c:if test="${dto.type eq 'INVESTMENTCONTACT' }">class="investmentContact"</c:if>
										<c:if test="${dto.type eq 'RENTOUTCONTACT' }">class="rentOutContact"</c:if>
										<c:if test="${dto.type eq 'BUSINESSCENTERCONTACT' }">class="businessCenterContact"</c:if>
										<c:if test="${dto.type eq 'TENEMENTCENTERCONTACT' }">class="tenementCenterContact"</c:if>
										<c:if test="${dto.type eq 'FINANCECONTACT' }">class="financeContact"</c:if>
										<c:if test="${dto.type eq 'CARPORTOUTCONTACT' }">class="carportOutContact"</c:if>
										<c:if test="${dto.type eq 'CUSTOMERSERVICECONTACT' }">class="customerServiceContact"</c:if>>
										<td class="lefttd">${dto.type.title }<input type="hidden"
											id="type" value="${dto.type }" /><input type="hidden" id="id"
											value="${dto.id }" /></td>
										<td align="center" class="centertd">${dto.userName }</td>
										<td align="center" class="centertd"><fmt:formatDate pattern="yyyy-MM-dd" value="${dto.modify_time }" /></td>
										<td class="centertd"><c:if test="${dto.status eq 'SUSPEND' }">
												<img src="core/common/images/gth.png" width="7" height="7" title="挂起" alt="挂起" />
											</c:if> <%-- <c:if test="${dto.status eq 'ACCEPT' }">
	                		<img src="core/common/images/rightgray.png" width="7" height="7" title="受理" alt="受理"/>
	                	</c:if> --%> <c:if test="${dto.status eq 'CLOSE' }">
												<img src="core/common/images/rightgreen.png" width="7" height="7" title="完成" alt="完成" />
											</c:if></td>
									</tr>
								</c:forEach>
							</table>
							<!--分页开始-->
							<%@include file="../pager.jsp"%>
							<!--分页结束-->
						</div>
					</div>
				</td>
				<td valign="top">
					<!--table切换开始--> <!--//table切换开始-->
					<div class="msglist" style="border-color: #fff;">
						<iframe src="core/web/contact/contact_index.jsp" frameborder="0" id="pm_msglist" width="100%" name="app"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!--//container-->
</body>

</html>
