<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>科技园区信息管理系统</title>
	<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/portal/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/portal/themes/icon.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/portal/portal.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
	<link rel="stylesheet" type="text/css" href="core/web/style/oawork.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
	<style type="text/css">
		.title {
			font-size: 16px;
			font-weight: bold;
			padding: 10px 10px;
			background: #eee;
			overflow: hidden;
			border-bottom: 1px solid #ccc;
		}
		.t-list {
			padding: 5px;
		}
		html { /* overflow:auto;*/
			
		}
		.oatask {
		}
		.oatitle a {
			font-size: 12px;
			font-weight: normal;
			color: #06c;
			text-decoration: none;
		}
		.oatask h2 {
			font-size: 12px;
			font-weight: bold;
			color: #666;
			padding: 5px 10px 0;
		}
		.panel-header {
			background: url(../../../core/common/images/oaworkbg.jpg) repeat-x;
			height: 28px;
			line-height: 28px;
			padding: 0 10px;
			color: #316301;
			font-weight: bold;
			border:1px solid #DBDBDB;
			border-bottom:none;
		}
		.panel-body{
			border:1px solid #d8d8d8;
			border-top:none;
		}
		.workheader  {
			border-bottom:none;
		}
		
		.onlyOne {
			padding:0 19px 0 5px; 
			overflow:hidden; 
			color:#333; 
			text-decoration:none; 
			line-height:22px; 
			cursor:pointer;
		}
		
		</style>
	<script type="text/javascript" src="core/common/js/righth.js"></script>
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/portal/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
	<script type="text/javascript" src="core/common/portal/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="core/common/portal/jquery.portal.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			initTip();
			$('#center').height(window.parent.document.documentElement.clientHeight-$('#resizable').height());
			initPortal();
			initWorkbenchTip();
			initWorkArrangeToSign();
	
			$('.user_btn .btn .btn-pnt').click(function(){
				$('.user_btn .oaworklist').slideUp();
				$(this).next().stop(true, false).slideDown();
				return false;
	
			});
		});
		
		$(document).click(function(){
			$('.user_btn .oaworklist').slideUp();
			//$('#meterlayers').hide();
		});
		 
		function initPortal(){
			$('#pp').portal({
				border:false,
				fit:true
			});
			installPanel();
		}
		function installPanel(){
			var widths = new Array(0.35,0.4,0.23);
			var portal = $('#pp');
			$(".desktopItem").each(function(i){
				var this_ = $(this);
				var width = parseInt(portal.width()*widths[i%widths.length]);
				var panel = $(this).panel({
					collapsible:true,
					width:width,
					href:$(this).find(".url").val()+"?width="+width,
					tools:[{
						iconCls:'icon-reload',
						handler:function(){
							this_.panel('open').panel('refresh');
						}
					}]
				});
				portal.portal('add', {
					panel:panel,
					columnIndex:i%3
				});
			});
			setTimeout("$('#pp').portal('resize')", 500);
			
		}
		
		function initWorkbenchTip(){
			$(".dataUrl").each(function(){
				var _this = $(this);
				$.post(_this.val(),function(data){
					if(data.result!=''){
						if(data.result.success){
							_this.next().find("span").text(data.result.value);
						}
					}
				});
			});
		}
		function initWorkArrangeToSign(){
			$(".workArrangeUrl").each(function(){
				var _this = $(this);
				$.post(_this.val(),function(data){
					var rest = data.result.value.rest;
					var workClassList = data.result.value.workClassList;
					if(rest==null && workClassList==null){
						$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
						$("#signin").click(function(){
							showTip('没有设置缺省班制或者没有排班',2000);
						});
						$("#signout").click(function(){
							showTip('没有设置缺省班制或者没有排班',2000);
						});
					}else{
						var signInWorkClassList = "";
						var signOutWorkClassList = "";
						if(rest==null){
							if(data.result.value.workClassList.length==2){
								//如果只有一个班次，则不显示，直接签到或者签退
								$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
								var workClassId = workClassList[0].id;
								var workClassName = workClassList[0].name;
								
								$("#signin").click(function(){
									signInWorkClass(workClassId,workClassName);
								});
								$("#signout").click(function(){
									signOutWorkClass(workClassId,workClassName);
								});
							}else{
								$("#sign2").append("<ul id='signLi2'></ul>");
								$("#sign1").append("<ul id='signLi1'></ul>");
								for(var i=0;i<workClassList.length;i++){
									var workClassId = workClassList[i].id;
									var workClassName = workClassList[i].name;
									var flag = workClassList[i].isSign;
									var type = workClassList[i].type.title;
									if(type=='签到'){
										if(flag){
											signInWorkClassList += "<li class='on'><a href='javascript:void(0)' onclick='signInWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
										}else{
											signInWorkClassList += "<li><a href='javascript:void(0)' onclick='signInWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
										}
									}	
									if(type=='签退'){
										if(flag){
											signOutWorkClassList += "<li class='on'><a href='javascript:void(0)' onclick='signOutWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
										}else{
											signOutWorkClassList += "<li><a href='javascript:void(0)' onclick='signOutWorkClass("+workClassId+",\""+workClassName+"\");'>"+workClassName+"</a></li>";
										}
									}
								}
								$("#signLi1").append(signInWorkClassList);
								$("#signLi2").append(signOutWorkClassList);
							}
						}else{
							$(".btn-pnt").attr("class","onlyOne");//去掉下拉箭头的样式
							$("#signin").click(function(){
								showTip('今天休息，不需要签到',2000);
							});
							$("#signout").click(function(){
								showTip('今天休息，不需要签退',2000);
							});
						}
					}
				});
			});
		}
		
		function signInWorkClass(workClassId,workClassName){
			if(confirm("班次为"+workClassName+",确定要签到吗？")){
				$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/userSign!signIn.action?workClassId="+workClassId,function(data){
		        	if(data.result.success){
		        		showTip('签到成功',2000);
		        	}else{
		        		showTip(data.result.msg,2000);
		        	}
				});
			}
		}
		function signOutWorkClass(workClassId,workClassName){
			if(confirm("班次为"+workClassName+",确定要签退吗？")){
				$.post("<%=BaseAction.rootLocation %>/parkmanager.oa/userSign!signOut.action?workClassId="+workClassId,function(data){
		        	if(data.result.success){
		        		showTip('签退成功',2000);
		        	}else{
		        		showTip(data.result.msg,2000);
		        	}
				});
			}
		}
		
	</script>
</head>
<body class="easyui-layout" >
	<div region="north" border="false" style="height:90px;" class="oaworkbg" id="resizable">
	<div class="workdiv">
		<div class="workheader" style="margin-left: 8px;margin-right:8px" >
			<div class="headerbase">
				<div class="headerbasetext">
					<div class="user_info">
						<p style="width:380px;"><span >${dataStr}，<%=CoreActivator.getSessionUser(request).getRealName()%></span></p>
					</div>
					<div class="user_minute">
						上次登录时间：<%format.applyPattern("yyyy年MM月dd号 HH:mm:ss");out.print(format.format(CoreActivator.getSessionUser(request).getLastLoginTime())); %>
					</div>
					
					 <div class="user_btn">
                    	 <div class="btn" style="margin-right:5px;">
	                      	 <div class="btn-pnt" href="javascript:void(0)" id="signin"><img src="core/common/images/reach.png" />签到</div>
	            		  <!--弹出层-->
				             <div class="oaworklist"  style="display:none;">
				                 <div id="sign1" class="oaworklistcon" >
				                 </div>
				             </div>
			              <!--弹出层-->
	                     </div>
	                     <div class="btn">
	                      	<div class="btn-pnt" href="javascript:void(0)" id="signout"><img src="core/common/images/leave.png" />签退</div>
	                      <!--弹出层-->
	                         <div class="oaworklist"  style=" display:none;">
				             	<div id="sign2" class="oaworklistcon">
				               	</div>
			                 </div>
                          <!--弹出层-->
                        </div>
                   </div>
				</div>
				<div class="user_time">
					今天是：<%format.applyPattern("yyyy年MM月dd号 E");out.print(format.format(now)); %>
				</div>
				<div class="user_task">
					<ul>
						<li>
							<c:forEach items="${coreWorkbenchTipDtoList}" var="coreWorkbenchTipDto">
								<c:if test="${coreWorkbenchTipDto.name ne '签到签退'}">
									<img src="${coreWorkbenchTipDto.icon}" />${coreWorkbenchTipDto.name}<a href="javascript:void(0)" onclick="addTab(parent.parent,'${coreWorkbenchTipDto.name}','<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.url}')"><input type="hidden" class="dataUrl" value="<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.dataUrl}"/><strong>[<span>0</span>]</strong></a>
								</c:if>	
							</c:forEach>
							<c:forEach items="${coreWorkbenchTipDtoList}" var="coreWorkbenchTipDto">
		                        <c:if test="${coreWorkbenchTipDto.name eq '签到签退'}">
									<input type="hidden" class="workArrangeUrl" value="<%=BaseAction.rootLocation %>/${coreWorkbenchTipDto.dataUrl}"/>                         	  
		                        </c:if>
		                    </c:forEach>
						</li>
					</ul>
				</div>	
				</div>
			</div>
		</div>
	</div>
	<div region="center" border="false" id="center" style="margin-left: -2px;padding-right: -10px;">
		<c:forEach items="${desktopItemList}" var="desktop">
			<div>
				<div class="desktopItem" title="${desktop.title}" id="desktop${desktop.id}">
					<input type="hidden" class="url" value="${desktop.url}"/>
					${desktop.memo};
				</div>
			</div>
		</c:forEach>
		<div id="pp" style="position:relative;overflow-x: hidden;overflow-Y: scroll">
			<div style="width: 35%"></div>
			<div style="width: 40%"></div>
			<div style="width: 23%"></div>
		</div>
	</div>
</body>
</html>