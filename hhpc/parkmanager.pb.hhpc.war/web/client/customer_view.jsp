<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initCustomerModifyLogList();
		initPolicyList();
		initRewardList();
		initRiskCapitalList();
		parent.document.getElementById("fbCaption").innerHTML="${result.value.name}";
		if("${result.value.pub}" != 'APPLYING'){
			$("#agreeBtn").hide();
		}
	});
	function reloadPolicyList(){
		$("#policyList").trigger("reloadGrid");
	}
	function reloadRewardList(){
		$("#rewardList").trigger("reloadGrid");
	}
	function initRewardList(){
		$("#rewardList").jqGrid({
	    	url:'<%=basePath%>reward!list.action',
			colModel: [
			    {label:'企业', name:'customer.name',sortable:false, align:"center",width:40}, 
				{label:'奖励类型', name:'type.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'奖金', name:'bonus',sortable:false, align:"center",width:40}, 
			    {label:'奖励日期', name:'rewardDate',sortable:false, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'详细说明', name:'memo',sortable:false, align:"center",width:40} 
			    <%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			    ,{label:'管理', name:'manager',sortable:false, align:"center",width:30}
			    <%} %>
			],
			height: 200,
			forceFit: true,
			width: 768,
			rowNum: 0,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewRewardById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editRewardById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteRewardById("+id+");\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewRewardById(id){
		fbStart('查看奖励',"<%=basePath%>reward!view.action?id="+id,500,206);
	}
	
	function editRewardById(id){
		fbStart('修改奖励',"<%=basePath%>reward!edit.action?id="+id,500,235);
	}
	function deleteRewardById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>reward!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadRewardList();
			});
		}
	}
	
	function initPolicyList(){
		$("#policyList").jqGrid({
	    	url:'<%=basePath%>customerPolicy!list.action',
			colModel: [
				{label:'年度', name:'policy.year',sortable:false, align:"center",width:40}, 
			    {label:'过期', name:'overdue.title',sortable:false, align:"center",width:40}, 
			    {label:'类型', name:'policy.type.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'内容', name:'content',sortable:false, align:"center"}
			    <%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			    ,{label:'管理', name:'manager',sortable:false, align:"center",width:30}
			    <%} %>
			],
			height: 200,
			forceFit: true,
			width: 768,
			rowNum: 0,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
					content += "<img src=\"core/common/images/time.png\" width=\"14\" height=\"14\" title=\"设置为过期\" onclick=\"editPolicyById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deletePolicyById("+id+");\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function editPolicyById(id){
		$.post("<%=basePath%>customerPolicy!overdue.action?id="+id,function(data){
			reloadPolicyList();
		});	
	}
	function deletePolicyById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerPolicy!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadPolicyList();
			});
		}
	}
	function reloadModifyLogList(){
		$("#customerModifyLogList").trigger("reloadGrid");
	}
	function initCustomerModifyLogList(){
		$("#customerModifyLogList").jqGrid({
	    	url:'<%=basePath%>customerModifyLog!list.action',
			colModel: [
				{label:'变更信息', name:'content',sortable:false, align:"center",formatter:contect}, 
			    {label:'变更时间', name:'modifyTime',sortable:false, align:"center",width:40,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"}, 
			    {label:'操作人', name:'creator',sortable:false, align:"center",width:40},
			    {label:'管理', name:'manager',sortable:false, align:"center",width:30}
			],
			height: 200,
			forceFit: true,
			width: 768,
			rowNum: 0,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewLogById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editLogById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteLogById("+id+");\"  /> ";
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	
	function contect(cellvalue,options,rowObject){
	   	if(cellvalue.length > 15){
			cellvalue = cellvalue.substring(0,14)+"......";
	   	}
	   	return cellvalue;
	}
	
	function viewLogById(id){
		fbStart('查看变更信息',"<%=basePath%>customerModifyLog!view.action?id="+id,500,300);
	}
	function editLogById(id){
		fbStart('编辑变更信息',"<%=basePath%>customerModifyLog!edit.action?id="+id,500,250);
	}
	function deleteLogById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerModifyLog!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				$("#customerModifyLogList").trigger("reloadGrid");
			});
		}
	}
	
	function initRiskCapitalList(){
		$("#riskCapitalList").jqGrid({
	    	url:'<%=basePath%>customerRiskCapital!list.action',
			colModel: [
				{label:'机构名称', name:'orgName',sortable:false, align:"center",width:120}, 
			    {label:'金额', name:'money',sortable:false, align:"center",width:120}, 
			    {label:'币种', name:'currencyType.dataValue',sortable:false, align:"center",width:40}, 
			    {label:'时间', name:'time',sortable:false, align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
			    {label:'备注', name:'memo',sortable:false,hidden:true, align:"center"}
			    <%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
			    ,{label:'管理', name:'manager',sortable:false, align:"center",width:80}
			    <%} %>
			],
			height: 200,
			forceFit: true,
			width: 768,
			rowNum: 0,
			postData:{filters:generateSearchFilters("customerId","eq",'${result.value.id}',"long")},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewRiskById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editRiskById("+id+");\"  /> ";
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteRiskById("+id+");\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		});
	}
	function viewRiskById(id){
		fbStart('查看风险投资',"<%=basePath%>customerRiskCapital!view.action?id="+id,600,151);
	}
	function editRiskById(id){
		fbStart('编辑风险投资',"<%=basePath%>customerRiskCapital!edit.action?id="+id,600,177);
	}
	function deleteRiskById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>customerRiskCapital!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				reloadRiskCapitalList();
			});
		}
	}
	function reloadRiskCapitalList(){
		$("#riskCapitalList").trigger("reloadGrid");
	}
	
	
	function checkApplication(){
		var pub = $("#pub").val();
		var state = null;
		if(pub == 'NOAPPLICATION'){
			state = 'APPLYING';
			sendRequest();
		}else{
			state = 'NOAPPLICATION';
		}
		sendRequest(state);
	}
	function agreeApplication(){
		sendRequest('AGREE');
	}
	function sendRequest(state){
		if(state == undefined){
			return;
		}
		var content = CKEDITOR.instances.content.document.getBody().getText();
		$("#content").val(content);
		content = $("#content").val().replace(/(^\s*)|(\s*$)/g, "");
		if(content =='' && state != 'AGREE'){
			showTip("请输入企业宣传内容",2000);
			var ed = CKEDITOR.instances.content;
			$(ed).focus();
		}else{
			var id = "${result.value.id}";
			$("#content").val(CKEDITOR.instances.content.getData());
			content = CKEDITOR.instances.content.getData();
			$.ajax({
				   type: "POST",
				   url: "<%=basePath %>customer!changeApplyState.action",
				   data: "content="+content+"&id="+id+"&state="+state,
				   success: function(msg){
					   if(msg.result.success){
						   showTip("更改企业申请状态成功",2000);
						   $("#pub").val(state);
						   $("#content").val(content);
						   if(state == 'NOAPPLICATION'){
							   $("#applyBtn").text("立即申请");
							   $("#applyState").html('未申请');
							   $("#agreeBtn").hide();
							   CKEDITOR.instances.content.setReadOnly(false);
						   }else if(state == 'AGREE'){
							   $("#applyState").html('申请通过');
							   $("#agreeBtn").hide();
							   CKEDITOR.instances.content.setReadOnly(true);
						   }else{
							   $("#applyBtn").text("取消申请");
							   $("#applyState").html('申请中');
							   $("#agreeBtn").show();
							   CKEDITOR.instances.content.setReadOnly(true);
						   }
					   }else{
						   showTip("更改企业申请状态失败",2000);
					   }
				   }
			});
		}
	}
</script>
<style>
	#fixedTable{
		table-layout:fixed;
	}
	.pm_view_left{
		z-index:1;
	}
	.STYLE1 {
		border:1px solid #AD5F00;
		background-color:#FF9000;
		color:#fff;
		width:100px;
		line-height:18px;
	}
	.STYLE2 {
		border:1px solid #AD5F00;
		background-color:#fff;
		color:#FF9000;
		width:100px;
		line-height:18px;
	}
</style>
</head>
<body>
<div class="basediv">
	<input id="pub" name="customer.pub" type="hidden" value="${result.value.pub }"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="140" valign="top">
				<jsp:include page="../customer_view_common.jsp">
					<jsp:param value="0" name="index"/>
					<jsp:param value="${result.value.id}" name="customerId"/>
					<jsp:param value="${result.value.gardenApplyId}" name="gardenApplyId"/>
					<jsp:param value="${desktop }" name="desktop"/>
				</jsp:include>
			</td>
			<td valign="top" style="background:#eaeced ">
				<div class="pm_view_right" style="width:680px;height: 480px;">
					<div class="basediv" style="margin:0px;">
						<div class="titlebg">基本信息</div>
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">中心联络员：</td>
									<td class="layerright">${result.value.hostName}</td>
									<td class="layertdleft100">企业编号：</td>
									<td width="35%" class="layerright">${result.value.code}</td>
								</tr>
								<tr>
									<td class="layertdleft100">产业类别：</td>
									<td class="layerright">${result.value.technic.dataValue}</td>
									<td class="layertdleft100">企业来源：</td>
									<td class="layerright">${result.value.source.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">入驻状态：</td>
									<td class="layerright">${result.value.parkStatus.title}</td>
									<td class="layertdleft100">苗圃信息：</td>
									<td class="layerright">${result.value.gardenApply.projectName }</td>
								</tr>
								<tr>
									<td class="layertdleft100">企业标签:</td>
									<td class="layerright"><div style="width:auto; height:30px; overflow-x:hidden; overflow-y:scroll"><c:forEach items="${result.value.labelRefs}" var="labelRef">${labelRef.customerLabel.name}&nbsp;</c:forEach></div></td>
									<td class="layertdleft100">是否发布到网页：</td>
									<td class="layerright">
										${result.value.pub.title }
									</td>
								</tr>
							</table>
						</div>
						<div class="hackbox"></div>
					</div>
					<div class="apptab" id="tableid">
						<ul>
						<% int flag=-1;
						if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_view")){flag++;
						%>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">公司信息</li>
						<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">注册信息</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">招商信息</li>
							<%} %>
							<c:if test="${result.value.incubated.title eq '是' }">
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">孵化信息</li>
							<%} %>
							</c:if>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业资质</li>
							<%} %>
						<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_changeMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">变更信息</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policyMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">政策信息</li>
							<%} %> --%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_accountMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">账户信息</li>
							<%} %>
						<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_reward_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">奖励管理</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerRiskCapital_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">风险投资</li>
							<%} %> --%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerApplication_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业宣传</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">其它</li>
							<%} %>
						</ul>
					</div>
					<%int flag2=-1;
					if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_view")){flag2++;%>					
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">联系地址：</td>
									<td class="layerright" width="20%">${result.value.customerInfo.address}</td>
									<td rowspan="6" style="vertical-align:top; padding-left:2px;">
				        				<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="layertdleft100" style="text-align:left; padding-left:10px;">企业总人数：</td>
												<td class="layerright" colspan="3">${result.value.customerInfo.userCount }</td>
											</tr>
											<tr>
											  <td class="layertdleft100" style="text-indent:10px;"><span style="float:left;">其中</span>博士后：</td>
											<td class="layerright">${result.value.customerInfo.userbsh }</td>
											<td class="layertdleft100">博士：</td>
											<td class="layerright">${result.value.customerInfo.userbs }</td>
											</tr>
											<tr>
											  <td class="layertdleft100">硕士：</td>
											  <td class="layerright">${result.value.customerInfo.userss }</td>
											<td class="layertdleft100">本科：</td>
											<td class="layerright">${result.value.customerInfo.userbk }</td>
											</tr>
											<tr>
											  <td class="layertdleft100">高级职称：</td>
											  <td class="layerright">${result.value.customerInfo.usergj }</td>
											<td class="layertdleft100">中级职称：</td>
											<td class="layerright">${result.value.customerInfo.userzj }</td>
											</tr>
											<tr>
											  <td class="layertdleft100">初级职称：</td>
											  <td class="layerright">${result.value.customerInfo.usercj }</td>
											<td class="layertdleft100">其他：</td>
											<td class="layerright">${result.value.customerInfo.userqt }</td>
											</tr>
											<tr>
											  <td class="layertdleft100">留学生：</td>
											  <td class="layerright" colspan="3">${result.value.customerInfo.userlxs }</td>
											</tr>
			        					</table>
			        				</td>
								</tr>
								<tr>
									<td class="layertdleft100">办公电话：</td>
									<td class="layerright">${result.value.customerInfo.officePhone}</td>
								</tr>
								<tr>
									<td class="layertdleft100">传真：</td>
									<td class="layerright">${result.value.customerInfo.fax}</td>
								</tr>
								<tr>
									<td class="layertdleft100">邮编：</td>
									<td class="layerright">${result.value.customerInfo.zipCode}</td>
								</tr>
								<tr>
									<td class="layertdleft100">网址：</td>
									<td class="layerright">${result.value.customerInfo.webSite}</td>
								</tr>
								<tr>
									<td class="layertdleft100">E-mail：</td>
									<td class="layerright">${result.value.customerInfo.email}</td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">注册时间：</td>
									<td class="layerright" width="35%"><fmt:formatDate value="${result.value.customerInfo.regTime}" pattern="yyyy-MM-dd"/></td>
									<td class="layertdleft100">注册类型：</td>
									<td class="layerright">${result.value.customerInfo.regType.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">注册资本：</td>
									<td class="layerright"><fmt:formatNumber value="${result.value.customerInfo.regCapital}" pattern="#0.00"/> 万元  币种：${result.value.customerInfo.currencyType.dataValue}</td>
									<td class="layertdleft100">工商注册号：</td>
									<td class="layerright">${result.value.customerInfo.businessNumber}</td>
								</tr>
								<tr>
									<td class="layertdleft100">国税登记号：</td>
									<td class="layerright">${result.value.customerInfo.taxNumberG}</td>
									<td class="layertdleft100">组织机构代码：</td>
									<td class="layerright">${result.value.customerInfo.organizationNumber}</td>
								</tr>
								<tr>
									<td class="layertdleft100">法定代表人：</td>
									<td class="layerright">${result.value.customerInfo.legalPerson}</td>
									<td class="layertdleft100">地税登记号：</td>
									<td class="layerright">${result.value.customerInfo.taxNumberD}</td>
								</tr>
								<tr>
									<td class="layertdleft100">证件类型：</td>
									<td class="layerright">${result.value.customerInfo.documentType.dataValue}</td>
									<td class="layertdleft100">E-mail：</td>
									<td class="layerright">${result.value.customerInfo.regMail}</td>
								</tr>
								<tr>
									<td class="layertdleft100">证件号：</td>
									<td class="layerright">${result.value.customerInfo.documentNumber}</td>
									<td class="layertdleft100">移动电话：</td>
									<td class="layerright">${result.value.customerInfo.cellphone}</td>
								</tr>
								<tr>
									<td class="layertdleft100">注册地址：</td>
									<td class="layerright">${result.value.customerInfo.regAddress}</td>
									<td class="layertdleft100">营业截至日期：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.customerInfo.businessExpireDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
					    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
							        <td class="layertdleft100" style="white-space:nowrap;">企业实际注资：</td>
							        <td class="layerright" width="35%">${result.value.customerInfo.realCapital } 万元</td>
							        <td class="layertdleft100">一般纳税人：</td>
									<td class="layerright"  width="35%">${result.value.customerInfo.ybnsr.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">引进时间：</td>
									<td class="layerright">
										<fmt:formatDate value="${result.value.parkTime}" pattern="yyyy-MM-dd"/>
					        		</td>
									<td class="layertdleft100">自营进出口权：</td>
									<td class="layerright">${result.value.customerInfo.zyjck.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">上报类型：</td>
									<td class="layerright">${result.value.reportType.title}</td>
									<td class="layertdleft100">是否园区内：</td>
									<td class="layerright">${result.value.customerInfo.inPark.title}</td>
								</tr>
								<tr>
									<td class="layertdleft100">纳税所在地：</td>
									<td class="layerright">${result.value.customerInfo.taxAddress.dataValue }</td>
									<td class="layertdleft100">是否大厦内：</td>
									<td class="layerright">${result.value.customerInfo.inBuild.title }</td>
								</tr>
								<tr>
									<td class="layertdleft100">股东构成：</td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;"><div style="height: 20px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.shareholder }</div></td>
								</tr>
								<tr>
									<td class="layertdleft100">经营地址：</td>
									<td colspan="3" class="layerright" ><div style="height: 20px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.address }</div></td>
								</tr>
								<tr>
									<td class="layertdleft100">经营范围：</td>
									<td colspan="3" class="layerright"><div style="overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.businessScope}</div></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<c:if test="${result.value.incubated.title eq '是' }">
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">孵化日期起：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.incubationInfo.incubationStartDate}" pattern="yyyy-MM-dd"/></td>
									<td rowspan="7" style="vertical-align:top; padding-left:2px;">
										<div style="overflow-y:auto;">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" style="white-space:nowrap;">
												<tr>
									                <td class="layertdleft100"><strong>孵化过程：</strong></td>
									                <td class="layerright">&nbsp;</td>
												</tr>
												<c:forEach items="${incubationRoutes }" var="incubationRoute" varStatus="status">
													<tr>
														<td class="layertdleft100">${incubationRoute.route.dataValue }：</td>
														<td class="layerright">
															<fmt:formatDate value="${incubationRoute.time}" pattern="yyyy-MM-dd"/>
														</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化日期止：</td>
									<td class="layerright"><fmt:formatDate value="${result.value.incubationInfo.incubationEndDate}" pattern="yyyy-MM-dd"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">入驻场所：</td>
									<td class="layerright">${result.value.incubationInfo.incubateConfig.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化状态：</td>
									<td width="35%" class="layerright">
										${result.value.incubationInfo.statusName}
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化协议:</td>
									<td class="layerright">
										<a target="_blank" href="core/resources/${result.value.incubationInfo.agreementDocu}">${result.value.incubationInfo.agreementName}</a>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					</c:if>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<c:forEach items="${customerQualifications }" var="customerQualification" varStatus="status">
									<c:if test="${(status.index+2)%2 eq 0}"><tr></c:if>
										<c:if test="${(status.index+1)%2 gt 0}">
											<td class="layertdleft100" style="white-space:nowrap;">${customerQualification.qualification.dataValue }：</td>
											<td class="layerright">
												<fmt:formatDate value="${customerQualification.time}" pattern="yyyy-MM-dd"/>
											</td>
										</c:if>
										<c:if test="${(status.index+1)%2 eq 0}">
											<td class="layertdleft100" style="white-space:nowrap;">${customerQualification.qualification.dataValue }：</td>
											<td class="layerright">
												<fmt:formatDate value="${customerQualification.time}" pattern="yyyy-MM-dd"/>
											</td>
										</c:if>
									<c:if test="${(status.index+2)%2 gt 0}"></tr></c:if>
								</c:forEach>
							</table>
						</div>
					</div>
					<%} %>
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_changeMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建变更信息','<%=basePath %>customerModifyLog!add.action?id=${result.value.id}',550,250);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<table id="customerModifyLogList" width="100%"><tr><td/></tr></table>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policyMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建政策信息','<%=basePath %>customerPolicy!add.action?id=${result.value.id}',550,300);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<%} %>
						<table id="policyList" width="100%"><tr><td/></tr></table>
					</div>
					<%} %> --%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_accountMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;height:160px;overflow-x:hidden;overflow-y:auto; ">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">账户名称：</td>
									<td class="layerright" style="padding-bottom:2px;">${user.username}</td>
								</tr>
								<tr>
									<td class="layertdleft100">真实姓名：</td>
									<td class="layerright" style="padding-bottom:2px;">${user.realName}</td>
								</tr>
								<tr>
									<td class="layertdleft100">最后登录IP：</td>
									<td class="layerright">${user.lastIp}</td>
								</tr>
								<tr>
									<td class="layertdleft100">最后登录时间：</td>
									<td class="layerright"><fmt:formatDate value="${user.lastLoginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">公司描述：</td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.description}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100">备注：</td>
									<td colspan="3" class="layerright"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.memo}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100" style="white-space:nowrap;">最后修改人:</td>
									<td class="layerright" width="35%" >${result.value.modifier}</td>
									<td class="layertdleft100">最后修改时间：</td>
									<td class="layerright" width="35%" ><fmt:formatDate value="${result.value.modifyTime}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %> --%>
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerRiskCapital_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建风险投资','<%=basePath %>customer!addRiskCapital.action?id=${result.value.id}',600,177);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<%} %>
						<table id="riskCapitalList" width="100%"><tr><td/></tr></table>
					</div>
					<%} %> --%>
					<!-- 企业宣传 -->
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerApplication_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table id="fixedTable" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr style="padding-bottom:2px;">
									<td class="layertdleft100">申请状态：</td>
									<td class="layerright" id="applyState">${result.value.pub.title }</td>
									<td class="layertdleft100" >申请宣传：</td>
									<td class="layerright">
										<button id="applyBtn" type="button" class="STYLE1" 
										onmouseover="this.className='STYLE2'" 
										onmouseout="this.className='STYLE1'"
										onclick="checkApplication();">
										<c:choose>
											<c:when test="${result.value.pub eq 'NOAPPLICATION'}">
												立即申请
											</c:when>
											<c:otherwise>
												撤回申请
											</c:otherwise>
										</c:choose>
										</button>
										<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_application_agree")){%>
										<button id="agreeBtn" type="button" class="STYLE1" 
										onmouseover="this.className='STYLE2'" 
										onmouseout="this.className='STYLE1'"
										onclick="agreeApplication();">同意申请</button>
										<%}%>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">企业宣传内容:<div style="font-style: italic;text-align: left;">说明：将在创业中心网站和微信公众号"杭州高新滙"上发布</div></td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;">
										<c:set value="${result.value.pub }" var="pub"></c:set>
										<textarea id="content" name="customer.content"  class="textareaauto" style="height:100px;margin-top:2px;">${result.value.content }</textarea>
										<script type="text/javascript">
											CKEDITOR.replace('content',{height:80});
											CKEDITOR.on('instanceReady', function (e) {
											<%
											String pub = pageContext.getAttribute("pub").toString(); 
											if(!"NOAPPLICATION".equals(pub)){%>
											CKEDITOR.instances.content.setReadOnly(true);
											<%}%>
											});
										</script>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">公司描述：</td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.description}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100">备注：</td>
									<td colspan="3" class="layerright"><div style="height: 75px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word; ">${result.value.customerInfo.memo}</div></td>
								</tr>
								<tr>
									<td class="layertdleft100" style="white-space:nowrap;">最后修改人:</td>
									<td class="layerright" width="35%" >${result.value.modifier}</td>
									<td class="layertdleft100">最后修改时间：</td>
									<td class="layerright" width="35%" ><fmt:formatDate value="${result.value.modifyTime}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
<div style="height: 5px;"></div>
</body>
</html>