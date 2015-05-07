<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		//initCustomerModifyLogList();
		//initPolicyList();
		//initRewardList();
		//initRiskCapitalList();
		initUploadify();
		initForm();
		parent.document.getElementById("fbCaption").innerHTML="${result.value.name}";
		if("${result.value.pub}" != 'APPLYING'){
			$("#agreeBtn").hide();
		}
		initUploadify2("fileUpload");
		if($("#photos").val()!=""){
			var arr = $("#photos").val();
			$("#imageList").append($("<td width='60'><img src='core/resources/"+arr+"' width='50' height='50' />"));
			$("#imageList").append($("<td width='25' valign='bottom'></td>").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
				$(this).attr("src","core/resources/"+arr+"-d");
				$(this).parent().prev().remove();
				$(this).parent().remove();
				deletePic();
			}})));
		}
	});
	
	function initUploadify2(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'queueID'			: uploadify.queueID, //和存放队列的DIV的id一致 
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess,//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
			'onSelect' : function(file) {
				deletePic();
	        }
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#photos").val($.parseJSON(data).path);
		$("#imageList").append($("<td width='60'><img src='core/resources/"+$.parseJSON(data).path+"' width='50' height='50'/>"));
		$("#imageList").append($("<td width='25' valign='bottom'></td>").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$(this).attr("src","core/resources/"+$.parseJSON(data).path+"-d");
			$(this).parent().prev().remove();
			$(this).parent().remove();
		}})));
	}
	function deletePic(){
		$("#imageList").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#photos").val()+"-d");
		$("#photos").val("");
	}
	
	function initUploadify(){
		$("#file").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'crm','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "支持格式:jpg/gif/jpeg/png/bmp/tif/txt/doc/zip/rar/pdf",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.jpg;*.gif;*.jpeg;*.png;*.bmp;*.tif;*.txt;*.doc;*.zip;*.rar;*.pdf;",//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response) {//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
				$("#agreementDocu").val($.parseJSON(data).path);
				$("#agreementDocuName").append($.parseJSON(data).originalName);
				$("#agreementName").val($.parseJSON(data).originalName);
				$("#agreementDocuName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
					deleteAgreementDocu();
				}}));
			},
			'onSelect' : function(file) {
				deleteAgreementDocu();
	        }
		});
	}
	function deleteAgreementDocu(){
		$("#agreementDocuName").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#agreementDocu").val()+"-d");
		$("#agreementDocu").val("");
	}
	function reloadPolicyList(){
		$("#policyList").trigger("reloadGrid");
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
			height: 110,
			forceFit: true,
			width: 698,
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
				{label:'变更信息', name:'content',sortable:false, align:"center"}, 
			    {label:'变更时间', name:'modifyLogTime',sortable:false, align:"center",width:40,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"}, 
			    {label:'操作人', name:'creator',sortable:false, align:"center",width:40},
			    {label:'管理', name:'manager',sortable:false, align:"center",width:30}
			],
			height: 110,
			forceFit: true,
			width: 698,
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
			height: 110,
			forceFit: true,
			width: 698,
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
	
	function initForm(){
		$("#form1").validate({
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($(".incubated:checked").val()=='YES'){
					if($("#incubationStartDate").val()==''){
						tabSwitch('apptabli','apptabliover','tabswitch',3);
						showTip("请输入孵化日期起");
						return;
					}
					if($("#incubationEndDate").val()==''){
						tabSwitch('apptabli','apptabliover','tabswitch',3);
						showTip("请输入孵化日期止");
						return;
					}
					if($("#status").val()==''){
						tabSwitch('apptabli','apptabliover','tabswitch',3);
						showTip("请输入孵化状态");
						return;
					}
					$("#statusName").val($("#status option:selected").text());
					if($("#incubationEndDate").val()<$("#incubationStartDate").val()){
						tabSwitch('apptabli','apptabliover','tabswitch',3);
						showTip("孵化日期止不能小于孵化日期起");
						return;
					}
					if($("#incubateConfigId").val()==''){
						tabSwitch('apptabli','apptabliover','tabswitch',3);
						showTip("请选择入驻场所");
						return;
					}
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("location.reload()", 2000);
			        	}
			        } 
			    });
			}
		});
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
<form  action="<%=basePath %>customer!update.action" method="post" name="form1" id="form1">
<input id="pub" name="customer.pub" type="hidden" value="${result.value.pub }"/>
<input name="customer.id" value="${result.value.id}" type="hidden"/>
<input name="customerInfo.id" value="${result.value.customerInfo.id}" type="hidden"/>
<input name="incubationInfo.id" value="${result.value.incubationInfo.id}" type="hidden"/>
<c:forEach items="${result.value.labelRefs}" var="labelRef">
<input type="hidden" name="ids" class="customerLabelId" value="${labelRef.customerLabel.id}"/>
</c:forEach>
<div class="basediv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="140" valign="top">
				<jsp:include page="../customer_view_common2.jsp">
					<jsp:param value="0" name="index"/>
					<jsp:param value="${result.value.id}" name="customerId"/>
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
									<%-- <td class="layertdleft100">引进人：</td>
									<td class="layerright">${result.value.importName}</td> --%>
									
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
									<td class="layertdleft100">创业类型：</td>
									<td class="layerright">${result.value.enterpriseType.dataValue}</td>
								</tr>
								<tr>
									<td class="layertdleft100">企业标签:</td>
									<td class="layerright"><div style="width:auto; height:30px; overflow-x:hidden; overflow-y:scroll"><c:forEach items="${result.value.labelRefs}" var="labelRef">${labelRef.customerLabel.name}&nbsp;</c:forEach></div></td>
								</tr>
							</table>
						</div>
						<div class="hackbox"></div>
					</div>
					<div class="apptab" id="tableid">
						<ul>
						<% int flag=-1;
						if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerMessage_view")){flag++;
						%>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">公司信息</li>
						<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_registerMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">注册信息</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_canvassMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">招商信息</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_hatchMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">孵化信息</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_aptitude_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业资质</li>
							<%} %>
						<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("ps_changeMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">变更信息</li>
							<%} %> 
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_policyMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">政策信息</li>
							<%} %>--%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_accountMessage_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">账户信息</li>
							<%} %>
						<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_reward_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">奖励管理</li>
						<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerRiskCapital_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">风险投资</li>
							<%} %> --%>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerApplication_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业宣传</li>
							<%} %>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_other_view")){flag++; %>
							<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">其它</li>
							<%} %>
						</ul>
					</div>
<%int flag2=-1;
if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerMessage_view")){flag2++;%>					
					<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
					    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100">联系地址：</td>
									<td width="25%" class="layerright"><input name="customerInfo.address" value="${result.value.customerInfo.address}" type="text" class="inputauto"/></td>
									<td rowspan="6" style="vertical-align:top; padding-left:2px;">
							        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
							              <tr>
							                <td class="layertdleft100" style="text-align:left; padding-left:10px;">企业总人数：</td>
							                <td class="layerright" colspan="3"><label><input name="customerInfo.userCount" value="${result.value.customerInfo.userCount }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							              </tr>
							              <tr>
							                <td class="layertdleft100" style="text-indent:10px;"><span style="float:left;">其中</span>博士后：</td>
							                <td class="layerright"><label><input name="customerInfo.userbsh" value="${result.value.customerInfo.userbsh }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							                <td class="layertdleft100">博士：</td>
							                <td class="layerright"><label><input name="customerInfo.userbs" value="${result.value.customerInfo.userbs }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							              </tr>
							              <tr>
							                <td class="layertdleft100">硕士：</td>
							                <td class="layerright"><label><input name="customerInfo.userss" value="${result.value.customerInfo.userss }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							                <td class="layertdleft100">本科：</td>
							                <td class="layerright"><label><input name="customerInfo.userbk" value="${result.value.customerInfo.userbk }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							              </tr>
							              <tr>
							                <td class="layertdleft100">高级职称：</td>
							                <td class="layerright"><label><input name="customerInfo.usergj" value="${result.value.customerInfo.usergj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							                <td class="layertdleft100">中级职称：</td>
							                <td class="layerright"><label><input name="customerInfo.userzj" value="${result.value.customerInfo.userzj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')" /></label></td>
							              </tr>
							              <tr>
							                <td class="layertdleft100">初级职称：</td>
							                <td class="layerright"><label><input name="customerInfo.usercj" value="${result.value.customerInfo.usercj }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							                <td class="layertdleft100">其他：</td>
							                <td class="layerright"><label><input name="customerInfo.userqt" value="${result.value.customerInfo.userqt }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							              </tr>
							              <tr>
							                <td class="layertdleft100">留学生：</td>
							                <td class="layerright" colspan="3"><label><input name="customerInfo.userlxs" value="${result.value.customerInfo.userlxs }" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
							              </tr>
							            </table>
							        </td>
								</tr>
								<tr>
									<td class="layertdleft100">办公电话：</td>
									<td><input name="customerInfo.officePhone" value="${result.value.customerInfo.officePhone}" type="text" class="input220" /></td>
								</tr>
								<tr>
									<td class="layertdleft100">传真：</td>
									<td><input name="customerInfo.fax" value="${result.value.customerInfo.fax}" type="text" class="input220" /></td>
								</tr>
								<tr>
									<td class="layertdleft100">邮编：</td>
									<td><input name="customerInfo.zipCode" value="${result.value.customerInfo.zipCode}" type="text" class="input220" /></td>
								</tr>
								<tr>
									<td class="layertdleft100">网址：</td>
									<td><input name="customerInfo.webSite" value="${result.value.customerInfo.webSite}" type="text" class="input220" /></td>
								</tr>
								<tr>
									<td class="layertdleft100">E-mail：</td>
									<td><input name="customerInfo.email" value="${result.value.customerInfo.email}" type="text" class="input220" /></td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_registerMessage_view")){flag2++; %>
						<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
							<div class="divlays" style="margin:0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td class="layertdleft100">注册时间：</td>
										<td width="35%" class="layerright">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input id="regTime" name="customerInfo.regTime" readonly="readonly" value="<fmt:formatDate value="${result.value.customerInfo.regTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('regTime');"/></td>
													<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('regTime');"/></td>
												</tr>
											</table>
										</td>
										<td class="layertdleft100">注册类型：</td>
										<td width="35%" class="layerright"><dd:select name="customerInfo.regTypeId" key="crm.0004" checked="result.value.customerInfo.regTypeId"/></td>
									</tr>
									<tr>
										<td class="layertdleft100">注册资本：</td>
										<td class="layerright"><input name="customerInfo.regCapital" value="<fmt:formatNumber value="${result.value.customerInfo.regCapital}" pattern="#0.00"/>" type="text" style="width:100px;" class="inputauto" /> 万元  <dd:select name="customerInfo.currencyTypeId" checked="result.value.customerInfo.currencyTypeId" key="crm.0005"/></td>
										<td class="layertdleft100">工商注册号：</td>
										<td class="layerright"><input name="customerInfo.businessNumber" value="${result.value.customerInfo.businessNumber}" type="text" class="inputauto" /></td>
									</tr>
									<tr>
										<td class="layertdleft100">组织机构代码：</td>
										<td class="layerright"><input name="customerInfo.organizationNumber" value="${result.value.customerInfo.organizationNumber}" type="text" class="inputauto" /></td>
										<td class="layertdleft100">国税登记号：</td>
										<td width="35%" class="layerright"><input id="taxNumberG" name="customerInfo.taxNumberG" value="${result.value.customerInfo.taxNumberG }" type="text" class="inputauto" /></td>
									</tr>
									<tr>
										<td class="layertdleft100">法定代表人：</td>
										<td class="layerright"><input name="customerInfo.legalPerson" value="${result.value.customerInfo.legalPerson}" type="text" class="inputauto" /></td>
										<td class="layertdleft100">地税登记号：</td>
										<td width="35%" class="layerright"><input id="taxNumberD" name="customerInfo.taxNumberD" value="${result.value.customerInfo.taxNumberD }" type="text" class="inputauto" /></td>
									</tr>
									<tr>
										<td class="layertdleft100">证件类型：</td>
										<td class="layerright"><dd:select name="customerInfo.documentTypeId" key="crm.0006" checked="result.value.customerInfo.documentTypeId"/></td>
										<td class="layertdleft100">E-mail：</td>
										<td class="layerright"><input name="customerInfo.regMail" value="${result.value.customerInfo.regMail}" type="text" class="inputauto" /></td>
									</tr>
									<tr>
										<td class="layertdleft100">证件号：</td>
										<td class="layerright"><input name="customerInfo.documentNumber" value="${result.value.customerInfo.documentNumber}" type="text" class="inputauto" /></td>
										<td class="layertdleft100">移动电话：</td>
										<td class="layerright"><input name="customerInfo.cellphone" value="${result.value.customerInfo.cellphone}" type="text" class="inputauto" /></td>
									</tr>
									<tr>
										<td class="layertdleft100">注册地址：</td>
										<td class="layerright"><input name="customerInfo.regAddress" value="${result.value.customerInfo.regAddress}" type="text" class="inputauto" /></td>
										<td class="layertdleft100">营业截至日期：</td>
										<td class="layerright">
											<table width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td><input id="businessExpireDate" readonly="readonly" name="customerInfo.businessExpireDate" value="<fmt:formatDate value="${result.value.customerInfo.businessExpireDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('businessExpireDate');"/></td>
													<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('businessExpireDate');"/></td>
												</tr>
						        			</table>
						        		</td>
									</tr>
								</table>
							</div>
						</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_canvassMessage_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
					    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
							        <td class="layertdleft100" style="white-space:nowrap;">企业实际注资：</td>
							        <td width="35%" class="layerright"><input name="customerInfo.realCapital" value="${result.value.customerInfo.realCapital }" type="text" class="inputauto" style="width:100px;" /> 万元</td>
							        <td class="layertdleft100">一般纳税人：</td>
									<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.ybnsr" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.ybnsr"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">引进时间：</td>
									<td class="layerright">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="20px;"><input id="parkTime" readonly="readonly" value="<fmt:formatDate value="${result.value.parkTime}" pattern="yyyy-MM-dd"/>" name="customer.parkTime" type="text" class="inputauto" onclick="showCalendar('parkTime');"/></td>
												<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('parkTime');"/></td>
											</tr>
					        			</table>
					        		</td>
									<td class="layertdleft100">自营进出口权：</td>
									<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.zyjck" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.zyjck"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">上报类型：</td>
									<td class="layerright"><enum:select id="reportType" name="customer.reportType" type="com.wiiy.crm.preferences.enums.CustomerRouteTypeEnum" checked="result.value.reportType"/></td>
									<td class="layertdleft100">是否园区内：</td>
									<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.inPark" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.inPark"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">纳税所在地：</td>
									<td width="35%" class="layerright"><dd:select id="taxAddressId" name="customerInfo.taxAddressId" key="crm.0028" checked="result.value.customerInfo.taxAddressId"/></td>
									<td class="layertdleft100">是否大厦内：</td>
									<td width="35%" class="layerright"><enum:radio styleClass="incubated" name="customerInfo.inBuild" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.customerInfo.inBuild"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">股东构成：</td>
									<td colspan="3" class="layerright" style="padding-bottom:2px;"><textarea id="shareholder" name="customerInfo.shareholder" class="textareaauto" style="height:20px;">${result.value.customerInfo.shareholder }</textarea></td>
								</tr>
								<tr>
									<td class="layertdleft100">经营地址：</td>
									<td colspan="3" class="layerright" ><textarea name="customerInfo.managerAddress"  class="textareaauto" style="height:20px;">${result.value.customerInfo.managerAddress }</textarea></td>
								</tr>
								<tr>
									<td class="layertdleft100">经营范围：</td>
									<td colspan="3"  class="layerright">
									<textarea name="customerInfo.businessScope"  class="textareaauto"  style="height:40px;">${result.value.customerInfo.businessScope}</textarea>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_hatchMessage_view")){flag2++; %>
					<div id="tabswitch" class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<div class="divlays" style="margin:0px;">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="layertdleft100"><span class="psred">*</span>孵化日期起：</td>
									<td class="layerright">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="20"><input id="incubationStartDate" readonly="readonly" name="incubationInfo.incubationStartDate" value="<fmt:formatDate value="${result.value.incubationInfo.incubationStartDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('incubationStartDate');"/></td>
												<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationStartDate');"/></td>
											</tr>
										</table>
									</td>
									<td rowspan="7" style="vertical-align:top; padding-left:1px;">
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
															<table width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><input class="incubationRoute" type="hidden" name="incubationRouteId" value="${incubationRoute.id }"/><input id="routeTime${status.index }" readonly="readonly" name="incubationRouteTime" value="<fmt:formatDate value="${incubationRoute.time}" pattern="yyyy-MM-dd"/>" type="text" class="data inputauto" onclick="showCalendar('routeTime${status.index }');"/></td>
																	<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('routeTime${status.index }');"/></td>
																</tr>
															</table>
														</td>
													</tr>
												</c:forEach>
									        </table>
									    </div>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100"><span class="psred">*</span>孵化日期止：</td>
									<td class="layerright">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="20"><input id="incubationEndDate" name="incubationInfo.incubationEndDate" readonly="readonly" value="<fmt:formatDate value="${result.value.incubationInfo.incubationEndDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('incubationEndDate');"/></td>
												<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationEndDate');"/></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100"><span class="psred">*</span>入驻场所：</td>
									<td width="30%" class="layerright"><dd:select id="incubateConfigId" name="incubationInfo.incubateConfigId" key="crm.0026" checked="result.value.incubationInfo.incubateConfigId"/></td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化面积：</td>
									<td width="30%" class="layerright"><input name="incubationInfo.incubatorAreas" type="text" class="input100" value="${result.value.incubationInfo.incubatorAreas }"/>平方米</td>					
								</tr>
								<tr>
									<td class="layertdleft100"><span class="psred">*</span>孵化状态：</td>
									<td width="30%" class="layerright">
									<input type="hidden" id="statusName" name="incubationInfo.statusName" value=""/>
										<select id="status" name="incubationInfo.statusId">
											<option value="">---请选择---</option>
											<c:forEach items="${incubationRoutes }" var="incubationRoute">
												<option value="${incubationRoute.id}" <c:if test="${incubationRoute.id eq result.value.incubationInfo.statusId }">selected="selected"</c:if> >${incubationRoute.route.dataValue}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="layertdleft100">孵化协议：</td>
									<td class="layerright">
										<table><tr><td><input id="file" type="file" /><input id="agreementDocu" name="incubationInfo.agreementDocu" type="hidden" value="${result.value.incubationInfo.agreementDocu}"/></td><td style="padding-left:5px;" id="agreementDocuName">${fn:replace(result.value.incubationInfo.agreementName,'attachments/crm/','')}<c:if test="${fn:length(result.value.incubationInfo.agreementDocu)>0}"><img src="core/common/images/locking.jpg" style="padding-left: 5px;" onclick="deleteAgreementDocu(this)"/></c:if></td></tr></table>
									</td>
								</tr>		
							</table>
						</div>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_aptitude_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="white-space:nowrap;">
					<c:forEach items="${customerQualifications }" var="customerQualification" varStatus="status">
						<c:if test="${(status.index+2)%2 eq 0}"><tr></c:if>
							<c:if test="${(status.index+1)%2 gt 0}">
								<td class="layertdleft100">${customerQualification.qualification.dataValue }：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><input class="customerQualification" type="hidden" name="customerQualificationId" value="${customerQualification.id }"/><input id="customerQualification${status.index }" name="custimerQualificationTime" value="<fmt:formatDate value="${customerQualification.time}" pattern="yyyy-MM-dd"/>" type="text" class="data inputauto" readonly="readonly" onclick="showCalendar('customerQualification${status.index }');"/></td>
											<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('customerQualification${status.index }');"/></td>
										</tr>
									</table>
								</td>
							</c:if>
							<c:if test="${(status.index+1)%2 eq 0}">
								<td class="layertdleft100">${customerQualification.qualification.dataValue }：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><input class="customerQualification" type="hidden" name="customerQualificationId" value="${customerQualification.id }"/><input id="customerQualification${status.index }" name="custimerQualificationTime" type="text" value="<fmt:formatDate value="${customerQualification.time}" pattern="yyyy-MM-dd"/>" class="data inputauto" readonly="readonly" onclick="showCalendar('customerQualification${status.index }');"/></td>
											<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('customerQualification${status.index }');"/></td>
										</tr>	
									</table>
								</td>
							</c:if>
						<c:if test="${(status.index+2)%2 gt 0}"></tr></c:if>
					</c:forEach>
				</table>
			</div>
		</div>
					<%} %>
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("ps_changeMessage_view")){flag2++; %>
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
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_policyMessage_view")){flag2++; %>
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
					<%} %>--%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_accountMessage_view")){flag2++; %>
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
					<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_reward_view")){flag2++; %>
					<div class="basediv tabswitch" style="margin:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
						<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建奖励','<%=basePath %>reward!add.action?id=${result.value.id}',550,235);"><span><img src="core/common/images/emailadd.gif" /></span>新建</li>
								</ul>
							</div>
						</div>
						<%} %>
						<table id="rewardList" width="100%"><tr><td/></tr></table>
					</div>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerRiskCapital_view")){flag2++; %>
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
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_customerApplication_view")){flag2++; %>
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
							      <td class="layertdleft100">logo：</td>
							      <td class="layerright">
							      <table border="0" cellspacing="0" cellpadding="0">
							      <tr>
							      <td height="60" width="100"> <input type="file" id="fileUpload" /><input type="hidden" id="photos" name="customer.logo"  value="${result.value.logo }" /> <div id="fileQueue"></div> </td>
							      <td>
								      <table  border="0" cellspacing="0" cellpadding="0">
								      	<tr id="imageList"></tr>
								      </table>
							      </td>
							      </tr>
							      </table>
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
					
					<%if(PbActivator.getHttpSessionService().isInResourceMap("ps_other_view")){flag2++; %>
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
					<div class="buttondiv">
						<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
</form>
<div style="height: 5px;"></div>
</body>
</html>