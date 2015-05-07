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
				<%boolean flag = false;%>
				var menu1 = 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myImprotant") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySleep") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmission") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")||PbActivator.getHttpSessionService().isInResourceMap("pb_countersign_begin")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){%>	
					[[
				<%
					flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
					flag = true;
				%>            
				{
					text: "打开",
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
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
					}
				}
				<%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!myPrint.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				],[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myImprotant")){%>
				    {
					text: "重要性",
					classname: "smarty_yu_ico0",
					data: [[{
						text: "高",
						classname: "smarty_yu_ico0",
						func: function() {
				            $.post("<%=basePath%>investment!myHigh.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "中",
						classname: "smarty_pu_ico0",
						func: function() {
							$.post("<%=basePath%>investment!myMiddle.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					},{
						text: "低",
						classname: "smarty_di_ico0",
						func: function() {
							$.post("<%=basePath%>investment!myLow.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}]]
				}
				    <%}%>
				    ],[
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySleep")){
					    flag=true;
					%>
				       {
					text: "设为睡眠",
					classname: "smarty_sleep",
					func: function() {
						if(confirm("确定要设为睡眠")){
							$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
								location.reload();
							});
						}
					}
				}
		       <%}%> --%>
			      <%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmission")){
			      if(flag){
			    	  %>,<%
			    	  flag=true;
			      }%>
				       {
					text: "报送审批",
					classname: "smarty_audit",
					data: [[{
						text: "招商人员意见",
						classname: "smarty_audit",
						func: function() {
							fbStart("招商人员意见","<%=basePath%>investment!myBusinessmanSuggestion.action?id="+$(this).find("input").val(),500, 170);
						}
					},{
						text: "经理审核意见",
						classname: "smarty_audit",
						func: function() {
							$("#approvalType").val("manager");
							$("#investmentId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
						}
					}]]
				}
				<%}%>  --%> 
			      <% flag = false;
			      if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){
			    	  flag=true;
			      %>
				       {
					text: "状态设置",
					classname: "smarty_menu_statusSet",
					data: [[{
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
					},{
						text: "审批",
						classname: "smarty_menu_accraditation",
						func: function() {
							if(confirm("确认设为审批项目？")){
								$.post("<%=basePath%>investment!myApproval.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "落户",
						classname: "smarty_complete",
						func: function() {
							if(confirm("确认落户？")){
								$.post("<%=basePath%>investment!myAgree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "睡眠",
						classname: "smarty_sleep",
						func: function() {
							if(confirm("确定要设为睡眠?")){
								$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						}
					},{
						text: "否决项目",
						classname: "smarty_regect",
						func: function() {
							if(confirm("确认否决项目？")){
								$.post("<%=basePath%>investment!myDisagree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					}
					
					
					
					]]
				},
			       {
					text: "黑名单设置",
					classname: "smarty_menu_blacklistSet",
					data: [[{
						text: "加入黑名单",
						classname: "smarty_menu_inblack",
						func: function() {
							if(confirm("确认加入黑名单")){
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
							fbStart("新建会签","<%=basePath%>investmentProcess!add.action?id="+id,700,538);
						}else{
							showTip("您已经发起过该项目会签！！！");
						}
					});
					
					
				}
			}
			   <%}%>
				       ],[
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")){%>  
				          {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!myDelete.action?id="+$(this).find("input").val(),function(data){
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
				}
				     <%}%>     
				          ]]
					<%}else{%>""<%}%>
					;
				
				var menu2 = 
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myWakeUp") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){%>	
					[[
				<%
					flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
					flag = true;
				%>        
				             {
					text: "打开",
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
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
					}
				}
             <%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!myPrint.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				],[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){
			    	  flag=true;
			      %>
				       {
					text: "状态设置",
					classname: "smarty_audit",
					data: [[{
						text: "洽谈",
						classname: "smarty_audit",
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
					},{
						text: "审批",
						classname: "smarty_audit",
						func: function() {
							if(confirm("确认设为审批项目？")){
								$.post("<%=basePath%>investment!myApproval.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "落户",
						classname: "smarty_complete",
						func: function() {
							if(confirm("确认落户？")){
								$.post("<%=basePath%>investment!myAgree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "睡眠",
						classname: "smarty_sleep",
						func: function() {
							if(confirm("确定要设为睡眠?")){
								$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						}
					},{
						text: "否决项目",
						classname: "smarty_regect",
						func: function() {
							if(confirm("确认否决项目？")){
								$.post("<%=basePath%>investment!myDisagree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					}
					
					
					
					]]
				},
			       {
					text: "黑名单设置",
					classname: "smarty_menu_blacklistSet",
					data: [[{
						text: "加入黑名单",
						classname: "smarty_menu_inblack",
						func: function() {
							if(confirm("确认加入黑名单")){
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
				}
				<%}%>  
				   ],[
				 <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")) {%>    
				      {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!myDelete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				<%}%>
				      ]]
				<%}else{%>""<%}%>	
					;
				
				var menu3 = 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmission") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myComplete") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDisagree") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){%>	
					[[
				<%
					 flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
					flag = true;
				%>
				{
					text: "打开",
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
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
					}
				}
				<%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!myPrint.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				],[
				<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmission")){
					flag=true;%>
				   {
					text: "报送审批",
					classname: "smarty_audit",
					data: [[{
						text: "招商人员意见",
						classname: "smarty_audit",
						func: function() {
							fbStart("招商人员意见","<%=basePath%>investment!myBusinessmanSuggestion.action?id="+$(this).find("input").val(),500, 170);
						}
					},{
						text: "经理审核意见",
						classname: "smarty_audit",
						func: function() {
							$("#approvalType").val("manager");
							$("#investmentId").val($(this).find("input").val());
							fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
						}
					}
					]]
				   
				}
				<%}%> --%>
				  <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){
			    	  flag=true;%>
				       {
					text: "状态设置",
					classname: "smarty_audit",
					data: [[{
						text: "洽谈",
						classname: "smarty_audit",
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
					},{
						text: "审批",
						classname: "smarty_audit",
						func: function() {
							if(confirm("确认设为审批项目？")){
								$.post("<%=basePath%>investment!myApproval.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "落户",
						classname: "smarty_complete",
						func: function() {
							if(confirm("确认落户？")){
								$.post("<%=basePath%>investment!myAgree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					},{
						text: "睡眠",
						classname: "smarty_sleep",
						func: function() {
							if(confirm("确定要设为睡眠?")){
								$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
									location.reload();
								});
							}
						}
					},{
						text: "否决项目",
						classname: "smarty_regect",
						func: function() {
							if(confirm("确认否决项目？")){
								$.post("<%=basePath%>investment!myDisagree.action?id="+$(this).find("input").val(),function(data){
									showTip(data.result.msg,2000);
									if(data.result.success){
										setTimeout("location.reload()", 2000);
									}
								});
							}
						}
					}
					]]
				},
			       {
					text: "黑名单设置",
					classname: "smarty_menu_blacklistSet",
					data: [[{
						text: "加入黑名单",
						classname: "smarty_menu_inblack",
						func: function() {
							if(confirm("确认加入黑名单")){
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
				}
				<%}%> 
				   ],[<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")){%>
				   {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!myDelete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				<%}%>
				]]
				<%}else{%>""<%}%>	
					;
				
				var menu4 = 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){%>	
					[[
				<%
					flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
					flag = true;
				%>           
				    {
					text: "打开",
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
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
					}
				}
			    <%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				    {
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!myPrint.action?id="+$(this).find("input").val();
					}
				}
				<%}%>    
				    ],[
<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){
  	  flag=true;
    %>
	       {
		text: "状态设置",
		classname: "smarty_audit",
		data: [[{
			text: "洽谈",
			classname: "smarty_audit",
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
		},{
			text: "审批",
			classname: "smarty_audit",
			func: function() {
				if(confirm("确认设为审批项目？")){
					$.post("<%=basePath%>investment!myApproval.action?id="+$(this).find("input").val(),function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							setTimeout("location.reload()", 2000);
						}
					});
				}
			}
		},{
			text: "落户",
			classname: "smarty_complete",
			func: function() {
				if(confirm("确认落户？")){
					$.post("<%=basePath%>investment!myAgree.action?id="+$(this).find("input").val(),function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							setTimeout("location.reload()", 2000);
						}
					});
				}
			}
		},{
			text: "睡眠",
			classname: "smarty_sleep",
			func: function() {
				if(confirm("确定要设为睡眠?")){
					$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
						location.reload();
					});
				}
			}
		},{
			text: "否决项目",
			classname: "smarty_regect",
			func: function() {
				if(confirm("确认否决项目？")){
					$.post("<%=basePath%>investment!myDisagree.action?id="+$(this).find("input").val(),function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							setTimeout("location.reload()", 2000);
						}
					});
				}
			}
		}
		]]
	},
    {
		text: "黑名单设置",
		classname: "smarty_menu_blacklistSet",
		data: [[{
			text: "加入黑名单",
			classname: "smarty_menu_inblack",
			func: function() {
				if(confirm("确认加入黑名单")){
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
	}
	<%}%>
				       ],[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")){%>       
				       {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("确认要删除？")){
							$.post("<%=basePath%>investment!myDelete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				       <%}%>
				       ]]
					<%}else{%>""<%}%>
					;
				
				var menu5 = 
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myEdit") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmitEnter") || PbActivator.getHttpSessionService().isInResourceMap("pb_countersign_begin") || PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")||PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){%>
					[[
				<%
					flag = false;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myView")){
					flag = true;
				%>            
				             {
					text: "打开",
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
					text: "编辑",
					classname: "smarty_menu_ico0",
					func: function() {
						fbStart("基本信息编辑","<%=basePath%>investment!myEdit.action?id="+$(this).find("input").val(),700,538);
					}
				}
				<%}%>
				<%
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myPrint")){
					if(flag){
						%>,<%
					}
					flag = true;
				%>
				{
					text: "打印",
					classname: "smarty_print",
					func: function() {
						location.href="<%=basePath%>investment!myPrint.action?id="+$(this).find("input").val();
					}
				}
				<%}%>
				],[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_mySubmitEnter")){
					flag=true;%> 
				   {
					text: "提交入驻",
					classname: "smarty_settled",
					func: function() {
						if(confirm("确认要提交入驻？")){
							$.post("<%=basePath%>investment!mySubmitSettled.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				   <%}%>
				   <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myStatus")){
					      if(flag){
					    	  %>,<%
					    	  flag=true;
					      }%>
						       {
							text: "状态设置",
							classname: "smarty_audit",
							data: [[{
								text: "洽谈",
								classname: "smarty_audit",
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
							},{
								text: "审批",
								classname: "smarty_audit",
								func: function() {
									if(confirm("确认设为审批项目？")){
										$.post("<%=basePath%>investment!myApproval.action?id="+$(this).find("input").val(),function(data){
											showTip(data.result.msg,2000);
											if(data.result.success){
												setTimeout("location.reload()", 2000);
											}
										});
									}
								}
							},{
								text: "落户",
								classname: "smarty_complete",
								func: function() {
									if(confirm("确认落户？")){
										$.post("<%=basePath%>investment!myAgree.action?id="+$(this).find("input").val(),function(data){
											showTip(data.result.msg,2000);
											if(data.result.success){
												setTimeout("location.reload()", 2000);
											}
										});
									}
								}
							},{
								text: "睡眠",
								classname: "smarty_sleep",
								func: function() {
									if(confirm("确定要设为睡眠?")){
										$.post("<%=basePath%>investment!mySleep.action?id="+$(this).find("input").val(),function(){
											location.reload();
										});
									}
								}
							},{
								text: "否决项目",
								classname: "smarty_regect",
								func: function() {
									if(confirm("确认否决项目？")){
										$.post("<%=basePath%>investment!myDisagree.action?id="+$(this).find("input").val(),function(data){
											showTip(data.result.msg,2000);
											if(data.result.success){
												setTimeout("location.reload()", 2000);
											}
										});
									}
								}
							}
							
							
							
							]]
						},
					       {
							text: "黑名单设置",
							classname: "smarty_menu_blacklistSet",
							data: [[{
								text: "加入黑名单",
								classname: "smarty_menu_inblack",
								func: function() {
									if(confirm("确认加入黑名单")){
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
						}
						<%}%>
				   ],[
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_myDelete")){%>
				      {
					text: "删除",
					classname: "smarty_menu_ico2",
					func: function() {
						if(confirm("落户项目删除，会删除所有的会签记录，是否删除？")){
								$.post("<%=basePath%>investment!myDelete.action?id="+$(this).find("input").val(),function(data){
								showTip(data.result.msg,2000);
								if(data.result.success){
									setTimeout("location.reload()", 2000);
								}
							});
						}
					}
				}
				      <%}%>
				      ]]
				<%}else{%>""<%}%>	
					;
				$(".investmenttrNEW").smartMenu(menu1,{name:'menu1'});
				$(".investmenttrSLEEP").smartMenu(menu2,{name:'menu2'});
				$(".investmenttrAPPROVAL").smartMenu(menu3,{name:'menu3'});
				$(".investmenttrDISAGREE").smartMenu(menu4,{name:'menu4'});
				$(".investmenttrPARK").smartMenu(menu5,{name:'menu5'});
				$(".investmenttrAGREE").smartMenu(menu5,{name:'menu5'});
				
				
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
							<div id="investmentdiv" style="overflow-x: hidden;overflow-y:auto;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td width="17" class="tdleftc"><img src="core/common/images/gthgray.png" /></td>
									<td class="tdcenterL">项目名称</td>
									<td class="tdleftc" width="95">最后处理时间</td>
								</tr>
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
									<td class="centertd"><c:if test="${investment.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if></td>
									<td class="lefttd">${investment.name}<input type="hidden" value="${investment.id}" /><input type="hidden" value="${investment.regInfo.organizationNumber}" /></td>
									<td class="centertd"><fmt:formatDate value="${investment.modifyTime}" pattern="yyyy-MM-dd"/></td>
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
