<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Investment"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
Map<String, ResourceDto> resourceMap = PbActivator.getHttpSessionService().getResourceMap();
int count = 0 ;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<style>
	.uploadify-button {
		background: #f0f0f0 /*url("../core/common/images/emailadd.gif")*/;
		background-position: left center;
		background-repeat: no-repeat;
		border: 1px solid #f0f0f0;;
		color: #333;
		font: 12px Arial, Helvetica, sans-serif;
		/*padding-left:10px;*/
		position: relative;
		text-align: center;
		top: 0px;
		width: 100%;
	}
	
	.emailtop .leftemail ul li span {
		display: inline;
		float: left;
		height: 26px;
		line-height: 26px;
		padding-right: 3px;
		position: relative;
		top: -1px;
	}
	
	.uploadify:hover .uploadify-button {
		background-color: #e4f3ff;
		color: #333;
		background-position: left center;
	}
</style>
<script type="text/javascript">
	$(function(){
		initTip();
		initUploadify();
		$('#investRight_height').css('height',getTabContentHeight()-8);
		$('#investRight_height2').css('height',getTabContentHeight()-12);
		$('#investRight_height3').css('height',getTabContentHeight()-46);
	});
	
	function initUploadify(){
		$("#file").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'crm','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: 105,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: '<span style="top:5px;"><img src="core/common/images/print_btn.gif" /></span>扫描件上传 ', //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess
		});
	}
	function uploadSuccess(file, data, response){
		$("#upFile").show();
		var file = $.parseJSON(data);
		var postData = {"investmentProcessAtt.investmentId":"${id}","investmentProcessAtt.name":file.originalName,"investmentProcessAtt.newName":file.path,"investmentProcessAtt.size":file.size};
		$.post("<%=basePath%>investmentProcessAtt!save.action",postData,function(callbackData){
			showTip(callbackData.result.msg);
			setTimeout("location.reload();",2000);
		});
	}
	function deleteFile(id){
		if(confirm("确定删除？")){
		$.post("<%=basePath %>investmentProcessAtt!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			setTimeout("location.reload();",1000);
		});
		}
	}
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
	function checkForm(){
		if(notNull("name","名称")){
			$("#form1").ajaxSubmit({
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().frames[0].location.reload();parent.fb.end();",2000);
		        	}
		        } 
		    });
		}
	}
	function approvalCallback(){
		location.reload();
	}
</script>

</head>

<body>
<div class="basediv" id="investRight_height">
<div class="divlays" id="investRight_height2" style="margin:0px;">
	<jsp:include page="common_my.jsp">
		<jsp:param value="4" name="index"/>
		<jsp:param value="${id}" name="investmentId"/>
		<jsp:param value="${result.value.investmentStatus}" name="investmentStatus"/>
	</jsp:include>
	<div class="pm_msglist" id="investRight_height3" style="overflow-y:auto;overflow-x:hidden;">
		 
		<div class="emailtop">
			<div class="leftemail">
			<ul>
			<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investmentProcessAtt_save")){ %>
	        	<li onmouseover="this.className='libg'" onmouseout="this.className=''" ><input type="file" id="file"/></li>
	 		<%} %>
			</ul>
		 </div>
			<%-- <div class="leftemail">
				<ul>
				<%	
					Result<Investment> result = (Result<Investment>)request.getAttribute("result");
					Investment investment = result.getValue();
					User user = PbActivator.getSessionUser(request);
					long id = investment.getCreatorId();
				%>
				<%if(user.getId().longValue()==id){ %>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('招商人员意见','<%=basePath%>investment!myBusinessmanSuggestion.action?id='+<%=investment.getId()%>,500, 170);"><span><img src="core/common/images/edit.gif" /></span>招商人员审批</li>
				<%} %>
				 <%  if(investment !=null && investment.getManagerApprovalId() !=null && investment.getManagerApproval().getUserId().longValue()==user.getId().longValue()) {%>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('经理审批','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.managerApprovalId}',500,170);"><span><img src="core/common/images/edit.gif" /></span>创投部经理审批</li>
				<%	} %> 
				<%	if(investment !=null && investment.getDepartmentApprovalId()!=null && investment.getDepartmentApproval().getUserId().longValue()==user.getId().longValue()&&PbActivator.getHttpSessionService().isInResourceMap("pb_proesaApproval_my")) { %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('投资促进部审批','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.departmentApprovalId}',500,170);"><span><img src="core/common/images/edit.gif" /></span><%=resourceMap.get("pb_proesaApproval_my").getName() %></li>
				<%	} %>
				<%	if(investment !=null && investment.getChiefApprovalId()!=null && investment.getChiefApproval().getUserId().longValue()==user.getId().longValue()&&PbActivator.getHttpSessionService().isInResourceMap("pb_headApproval_my")) { %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('分管主任审批','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.chiefApprovalId}',500,170);"><span><img src="core/common/images/edit.gif" /></span><%=resourceMap.get("pb_headApproval_my").getName() %></li>
				<%	} %>
				<%	if(investment !=null && investment.getOfficeApprovalId()!=null && investment.getOfficeApproval().getUserId().longValue()==user.getId().longValue()&&PbActivator.getHttpSessionService().isInResourceMap("pb_officeApproval_my")) { %>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('领导审批','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.officeApprovalId}',500,170);"><span><img src="core/common/images/edit.gif" /></span><%=resourceMap.get("pb_officeApproval_my").getName() %></li>
				<%	} %>
				</ul>
			</div>--%>
		</div> 
		<div id="img">
		<c:if test="${imgSrc ne null }">
			<c:forEach items="${imgSrc }" var="src">
				<img src="core/resources/${src }" alt="" width='740' style="margin: 10px"/>
			</c:forEach>
		</c:if>
		
		</div>
		<%-- <div class="apptable" style=" margin:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleftw" style="height:50px;">招商人员意见 </td>
								<td class="tdleftbg">&nbsp;${result.value.businessmanSuggestion}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div> --%>
		<%-- <c:if test="${result.value.managerApprovalId ne null and result.value.managerApproval.status ne 'UNDETERMINED'}">
		<div class="apptable" style=" margin:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleftw">审批人：</td>
								<td class="tdleftbg">经理审批(${result.value.managerApproval.userName})</td>
							</tr>
							<tr>
								<td class="tdleftw">审批时间：</td>
								<td class="tdleftbg"><fmt:formatDate value="${result.value.managerApproval.approvalTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
							<tr>
								<td class="tdleftw">审批结果：</td>
								<td class="tdleftbg">${result.value.managerApproval.status.title}</td>
							</tr>
							<tr>
								<td class="tdleftw" style="height:50px;">意见 </td>
								<td class="tdleftbg">&nbsp;${result.value.managerApproval.suggestion}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		</c:if>
		<c:if test="${result.value.departmentApprovalId ne null and result.value.departmentApproval.status ne 'UNDETERMINED'}">
		<div class="apptable" style=" margin:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleftw">审批人：</td>
								<td class="tdleftbg">投资创业部(${result.value.departmentApproval.userName})</td>
							</tr>
							<tr>
								<td class="tdleftw">审批时间：</td>
								<td class="tdleftbg"><fmt:formatDate value="${result.value.departmentApproval.approvalTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
							<tr>
								<td class="tdleftw">审批结果：</td>
								<td class="tdleftbg">${result.value.departmentApproval.status.title}</td>
							</tr>
							<tr>
								<td class="tdleftw" style="height:50px;">意见 </td>
								<td class="tdleftbg">&nbsp;${result.value.departmentApproval.suggestion}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		</c:if>
		<c:if test="${result.value.chiefApprovalId ne null and result.value.chiefApproval.status ne 'UNDETERMINED'}">
		<div class="apptable" style=" margin:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleftw">审批人：</td>
								<td class="tdleftbg">分管主任(${result.value.chiefApproval.userName})</td>
							</tr>
							<tr>
								<td class="tdleftw">审批时间：</td>
								<td class="tdleftbg"><fmt:formatDate value="${result.value.chiefApproval.approvalTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
							<tr>
								<td class="tdleftw">审批结果：</td>
								<td class="tdleftbg">${result.value.chiefApproval.status.title}</td>
							</tr>
							<tr>
								<td class="tdleftw" style="height:50px;">意见 </td>
								<td class="tdleftbg">&nbsp;${result.value.chiefApproval.suggestion}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		</c:if>
		<c:if test="${result.value.officeApprovalId ne null and result.value.officeApproval.status ne 'UNDETERMINED'}">
		<div class="apptable" style=" margin:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td >
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100" class="tdleftw">审批人：</td>
								<td class="tdleftbg">领导审批(${result.value.officeApproval.userName})</td>
							</tr>
							<tr>
								<td class="tdleftw">审批时间：</td>
								<td class="tdleftbg"><fmt:formatDate value="${result.value.officeApproval.approvalTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
							<tr>
								<td class="tdleftw">审批结果：</td>
								<td class="tdleftbg">${result.value.officeApproval.status.title}</td>
							</tr>
							<tr>
								<td class="tdleftw" style="height:50px;">意见 </td>
								<td class="tdleftbg">&nbsp;${result.value.officeApproval.suggestion}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		</c:if> --%>
	<c:if test="${imgSrc ne null }">
	<div class="divlays" id="upFile" style="padding:0px 0px 0px 0px;">
			<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
				<c:forEach items="${attList}" var="att">	
						<input type="hidden" id="countNumber"  value="<%=count++ %>" />
						<div class="downlist">
							<img src="core/common/images/downloadico.png" />
							<ul>
								<li>${att.name}<span>(<format:fileSize size="att.size"/>)</span></li>
								<li><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investmentProcessAtt_download")) {%><a href="javascript:void" onclick="downLoad('${att.newName}','${att.name}')">下载</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investmentProcessAtt_edit")) {%><a href="javascript:void(0)" onclick="fbSearch('重命名','<%=basePath %>investmentProcessAtt!edit.action?id=${att.id}',350,75);">重命名</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_investmentProcessAtt_delete")) {%><a href="javascript:void(0)" onclick="deleteFile('${att.id}')">删除</a><%} %></li>
							</ul>
						</div>
				</c:forEach>
			</div>
	</div>	
	</c:if>	
	</div>
	</div>
	</div>
</body>
</html>

