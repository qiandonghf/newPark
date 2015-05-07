<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.ContractReview"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="format" uri="http://www.wiiy.com/taglib/format" %>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation
			+ path + "/";
	String uploadPath = BaseAction.rootLocation
			+ "/";
	int count = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>入驻企业流程联系单</title>

<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet"
	type="text/css" />
<link href="parkmanager.pb/web/style/merchants.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css"
	href="core/common/uploadify-v3.1/uploadify.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript"
	src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

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
	function pageheight(nameid){//获取屏幕高度
		var bodyh=window.parent.document.documentElement.clientHeight-85;
		var bodyw=window.parent.document.documentElement.clientWidth-360;
		document.getElementById(nameid).style.height=bodyh+"px";
		document.getElementById(nameid).style.width=bodyw+"px";
	}
	$(document).ready(function() {
		pageheight('pm_msglist');
		initTip();
		initUploadify();
		if($("#countNumber").val() ==undefined){
			$("#upFile").hide();
		}
		
	});
	
	function initUploadify(){
		$("#file").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'crm','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath%>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: 105,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: '<span style="top:5px;"><img src="core/common/images/print_btn.gif" /></span>扫描件上传 ', //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.attachments.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.attachments.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: uploadSuccess
		});
	}
	function uploadSuccess(file, data, response){
		$("#upFile").show();
		var file = $.parseJSON(data);
		var postData = {"contractReviewAtt.contractReviewId":"${result.value.id}","contractReviewAtt.name":file.originalName,"contractReviewAtt.newName":file.path,"contractReviewAtt.size" : file.size};
		$.post("<%=basePath%>contractReviewAtt!save.action", postData,
				function(callbackData) {
					showTip(callbackData.result.msg);
					setTimeout("location.reload();", 2000);
		});
	}
	function deleteFile(id) {
		$.post("<%=basePath%>contractReviewAtt!delete.action?id=" + id,
				function(data) {
					showTip(data.result.msg,2000);
					setTimeout("location.reload();",1000);
		});
	}
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
</script>
</head>
<body>
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover"><a
				href="javascript:void(0);" target="app">合同会签审核单</a></li>
		</ul>
	</div>

	
		<div class="emailtop">
			<!--leftemail-->
			<div class="leftemail">
				<ul>
				<%	
						Result<ContractReview> result = (Result<ContractReview>)request.getAttribute("result");
						ContractReview contractReview = result.getValue();
						User user = PbActivator.getSessionUser(request);
					%>
					<%  if(contractReview.getJbId() !=null && contractReview.getJb().getUserId().longValue()==user.getId().longValue()) {%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('经办','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.jbId}',500,170);" class=""><span style="top:5px;"><img src="core/common/images/edit.gif"  /></span>经办</li>
					<%	} %>
					<%	if(contractReview.getHqId()!=null && contractReview.getHq().getUserId().longValue()==user.getId().longValue()) { %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('会签','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.hqId}',500,170);" class=""><span style="top:5px;"><img src="core/common/images/edit.gif" /></span>会签</li>
					<%	} %>
					<%	if(contractReview.getShId()!=null && contractReview.getSh().getUserId().longValue()==user.getId().longValue()) { %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('审核','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.shId}',500,170);" class=""><span style="top:5px;"><img src="core/common/images/edit.gif" /></span>审核</li>
					<%	} %>
					<%	if(contractReview.getSpId()!=null && contractReview.getSp().getUserId().longValue()==user.getId().longValue()) { %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('审批','<%=BaseAction.rootLocation %>/core/approval!edit.action?id=${result.value.spId}',500,170);" class=""><span style="top:5px;"><img src="core/common/images/edit.gif" /></span>审批</li>
					<%	} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractReviewAtt_save")){ %>
					<li onmouseover="this.className='libg'"
						onmouseout="this.className=''"><input type="file" id="file" /></li>
<%} %>
				</ul>
			</div>
			<!--//leftemail-->
		</div>
		<!--apptable-->

		<!--apptable-->
		<div style="overflow: scroll; overflow-x: hidden;" id="pm_msglist">
		

		<div class="apptable" style="margin: 2px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">

				<tr>
					<td width="80" class="tdleftw" style="height: 50px;">合同名称：</td>
					<td class="tdleftbg" colspan="7">${result.value.contract.name}</td>
				</tr>
				<tr>
					<td width="80" class="tdleftw">合同号：</td>
					<td class="tdleftbg" width="15%">&nbsp;${result.value.contractNo}</td>
					<td width="80" class="tdleftw">日期：</td>
					<td class="tdleftbg" width="16%">&nbsp;<fmt:formatDate value="${result.value.date}" pattern="yyyy-MM-dd hh:mm"/></td>
					<td width="80" class="tdleftw">部门：</td>
					<td class="tdleftbg" colspan="3">&nbsp;${result.value.department}</td>
					</tr>
						<tr>
						<c:choose> 
				               <c:when test="${result.value.spId!=null and (result.value.sp.suggestion!=null or result.value.sp.status!='UNDETERMINED')}">
				              <td class="tdleftw" style="height:50px;">审批：</td>
				              <td class="tdleftbg" width="15%">&nbsp;${result.value.sp.suggestion}</td>
				              <td class="tdleftw">审批人：</td>
				               <td class="tdleftbg">&nbsp;${result.value.sp.userName }</td>
				              <td class="tdleftw">审批时间：</td>
				              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.sp.approvalTime }" pattern="yyyy-MM-dd"/></td>
				              <td class="tdleftw">审批结果：</td>
				              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.sp.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.sp.status == 'AGREE'}">同意</c:if><c:if test="${result.value.sp.status == 'DISAGREE'}">不同意</c:if></td>
				              </c:when>
				              <c:otherwise>
				             <td class="tdleftw" style="height:50px;">审批：</td>
				              <td class="tdleftbg" colspan="7">&nbsp;${result.value.sp.suggestion}</td>
				              </c:otherwise>
             		   </c:choose>
						</tr>
						<tr>
						<c:choose> 
				               <c:when test="${result.value.shId!=null and (result.value.sh.suggestion!=null or result.value.sh.status!='UNDETERMINED')}">
				              <td class="tdleftw" style="height:50px;">审核：</td>
				              <td class="tdleftbg" width="15%">&nbsp;${result.value.sh.suggestion}</td>
				              <td class="tdleftw">审批人：</td>
				               <td class="tdleftbg">&nbsp;${result.value.sh.userName }</td>
				              <td class="tdleftw">审批时间：</td>
				              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.sh.approvalTime }" pattern="yyyy-MM-dd"/></td>
				              <td class="tdleftw">审批结果：</td>
				              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.sh.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.sh.status == 'AGREE'}">同意</c:if><c:if test="${result.value.sh.status == 'DISAGREE'}">不同意</c:if></td>
				              </c:when>
				              <c:otherwise>
				             <td class="tdleftw" style="height:50px;">审核：</td>
				              <td class="tdleftbg" colspan="7">&nbsp;${result.value.sh.suggestion}</td>
				              </c:otherwise>
             		   </c:choose>
						</tr>
						<tr>
						<c:choose> 
				               <c:when test="${result.value.hqId!=null and (result.value.hq.suggestion!=null or result.value.hq.status!='UNDETERMINED')}">
				              <td class="tdleftw" style="height:50px;">会签：</td>
				              <td class="tdleftbg" width="15%">&nbsp;${result.value.hq.suggestion}</td>
				              <td class="tdleftw">审批人：</td>
				               <td class="tdleftbg" width="16%">&nbsp;${result.value.hq.userName }</td>
				              <td class="tdleftw">审批时间：</td>
				              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.hq.approvalTime }" pattern="yyyy-MM-dd"/></td>
				              <td class="tdleftw">审批结果：</td>
				              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.hq.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.hq.status == 'AGREE'}">同意</c:if><c:if test="${result.value.hq.status == 'DISAGREE'}">不同意</c:if></td>
				              </c:when>
				              <c:otherwise>
				             <td class="tdleftw" style="height:50px;">会签：</td>
				              <td class="tdleftbg" colspan="7">&nbsp;${result.value.hq.suggestion}</td>
				              </c:otherwise>
             		   </c:choose>
						</tr>
						<tr>
						<c:choose> 
				               <c:when test="${result.value.jbId!=null and (result.value.jb.suggestion!=null or result.value.jb.status!='UNDETERMINED')}">
				              <td class="tdleftw" style="height:50px;">经办：</td>
				              <td class="tdleftbg" width="15%">&nbsp;${result.value.jb.suggestion}</td>
				              <td class="tdleftw">审批人：</td>
				               <td class="tdleftbg">&nbsp;${result.value.jb.userName }</td>
				              <td class="tdleftw">审批时间：</td>
				              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.jb.approvalTime }" pattern="yyyy-MM-dd"/></td>
				              <td class="tdleftw">审批结果：</td>
				              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.jb.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.jb.status == 'AGREE'}">同意</c:if><c:if test="${result.value.jb.status == 'DISAGREE'}">不同意</c:if></td>
				              </c:when>
				              <c:otherwise>
				             <td class="tdleftw" style="height:50px;">经办：</td>
				              <td class="tdleftbg" colspan="7">&nbsp;${result.value.jb.suggestion}</td>
				              </c:otherwise>
             		   </c:choose>
						</tr>
			</table>
		</div>
		<div class="table_footer" align="left" style="margin-top:15px">此单签署完毕后，与合同递交办公室备案</div>

		<div class="divlays" id="upFile" style="padding: 0px 2px 2px 2px;">
			<div class="emaildown"
				style="margin-top: 5px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; border-right: 1px solid #e4e4e4;">
				<c:forEach items="${attList}" var="att">
					<input type="hidden" id="countNumber" value="<%=count++%>" />
					<div class="downlist">
						<img src="core/common/images/downloadico.png" />
						<ul>
							<li>${att.name}<span>(<format:fileSize
										size="att.size" />)
							</span></li>
							<li><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractReviewAtt_download")) {%><a href="javascript:void" onclick="downLoad('${att.newName}','${att.name}')">下载</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractReviewAtt_edit")) {%><a href="javascript:void(0)" onclick="fbSearch('重命名','<%=basePath %>contractReviewAtt!edit.action?id=${att.id}',350,75);">重命名</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractReviewAtt_delete")) {%><a href="javascript:void(0)" onclick="deleteFile('${att.id}')">删除</a><%}%></li>	
						</ul>
					</div>
				</c:forEach>
			</div>
		
		<!--//apptable-->
		</div>
	</div>
</body>
</html>
