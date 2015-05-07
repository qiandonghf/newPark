<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="format" uri="http://www.wiiy.com/taglib/format" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
int count = 0 ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>合同到期审批单</title>

<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.pb/web/style/merchants.css" rel="stylesheet" type="text/css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
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
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
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
		var postData = {"contractExpireApprovalAtt.contractExpireApprovalId":"${result.value.id}","contractExpireApprovalAtt.name":file.originalName,"contractExpireApprovalAtt.newName":file.path,"contractExpireApprovalAtt.size":file.size};
		$.post("<%=basePath%>contractExpireApprovalAtt!save.action",postData,function(callbackData){
			showTip(callbackData.result.msg);
			setTimeout("location.reload();",2000);
		});
	}
	function deleteFile(id){
		if(confirm("确定删除？")){
		$.post("<%=basePath %>contractExpireApprovalAtt!delete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
			setTimeout("location.reload();",1000);
		});
		}
	}
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
</script>
</head>
<body>
<div class="apptab" id="tableid">
	<ul>
        <li class="apptabliover" ><a href="javascript:void(0);" target="app">合同到期审批单</a></li>
	</ul>
</div>
	<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpireAtt_save")){ %>
        	<li onmouseover="this.className='libg'" onmouseout="this.className=''" ><input type="file" id="file"/></li>
        <%} %>
		</ul>
	</div>
</div>
 <div style="overflow:scroll; overflow-x:hidden;" id="pm_msglist">
<div class="apptable" style=" margin:2px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            	<th colspan="8" class="tdleftw">提交部门意见</th>
                </tr>
            <tr>
            	<td width="150"  style="height:70px;" class="tdleftw">招商部：</td>
            	<td class="tdleftbg" colspan="7">
                	${result.value.businessmanSuggestion}
                </td>
           	</tr>
            <tr>
            	<th colspan="8" class="tdleftw">会签部门意见</th>
                </tr>
            <tr>
              <c:choose> 
               <c:when test="${result.value.gcbApprovalId!=null and (result.value.gcb.suggestion!=null or result.value.gcb.status!='UNDETERMINED')}">
              <td class="tdleftw" style="height:50px;">工程部：</td>
              <td class="tdleftbg" width="10%">&nbsp;${result.value.gcb.suggestion}</td>
              <td class="tdleftw">审批人：</td>
               <td class="tdleftbg">&nbsp;${result.value.gcb.userName }</td>
              <td class="tdleftw">审批时间：</td>
              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.gcb.approvalTime }" pattern="yyyy-MM-dd"/></td>
              <td class="tdleftw">审批结果：</td>
              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.gcb.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.gcb.status == 'AGREE'}">同意</c:if><c:if test="${result.value.gcb.status == 'DISAGREE'}">不同意</c:if></td>
              </c:when>
              <c:otherwise>
             <td class="tdleftw" style="height:50px;">工程部：</td>
              <td class="tdleftbg" colspan="7">&nbsp;${result.value.gcb.suggestion}</td>
              </c:otherwise>
              </c:choose>
             </tr>
            <tr>
             <c:choose> 
             <c:when test="${result.value.cwzjApprovalId!=null and (result.value.cwzjApproval.suggestion!=null or result.value.cwzjApproval.status!='UNDETERMINED')}">
              <td class="tdleftw" style="height:50px;">财务总监（审核）：</td>
              <td class="tdleftbg" width="10%">&nbsp;${result.value.cwzjApproval.suggestion}</td>
              <td class="tdleftw">审批人：</td>
               <td class="tdleftbg">&nbsp;${result.value.cwzjApproval.userName }</td>
              <td class="tdleftw">审批时间：</td>
              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.cwzjApproval.approvalTime }" pattern="yyyy-MM-dd"/></td>
              <td class="tdleftw">审批结果：</td>
              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.cwzjApproval.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.cwzjApproval.status == 'AGREE'}">同意</c:if><c:if test="${result.value.cwzjApproval.status == 'DISAGREE'}">不同意</c:if></td>
              </c:when>
              <c:otherwise>
             <td class="tdleftw" style="height:50px;">财务总监（审核）：</td>
              <td class="tdleftbg" colspan="7">&nbsp;${result.value.cwzjApproval.suggestion}</td>
              </c:otherwise>
              </c:choose>
            </tr>
            <tr>
              <c:choose> 
             <c:when test="${result.value.zjlApprovalId!=null and (result.value.zjlApproval.suggestion!=null or result.value.zjlApproval.status!='UNDETERMINED')}">
              <td class="tdleftw" style="height:50px;">总经理（审核）：</td>
              <td class="tdleftbg" width="10%" >&nbsp;${result.value.zjlApproval.suggestion}</td>
              <td class="tdleftw">审批人：</td>
               <td class="tdleftbg">&nbsp;${result.value.zjlApproval.userName }</td>
              <td class="tdleftw">审批时间：</td>
              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.zjlApproval.approvalTime }" pattern="yyyy-MM-dd"/></td>
              <td class="tdleftw">审批结果：</td>
              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.zjlApproval.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.zjlApproval.status == 'AGREE'}">同意</c:if><c:if test="${result.value.zjlApproval.status == 'DISAGREE'}">不同意</c:if></td>
              </c:when>
              <c:otherwise>
             <td class="tdleftw" style="height:50px;">总经理（审核）：</td>
              <td class="tdleftbg" colspan="7">&nbsp;${result.value.zjlApproval.suggestion}</td>
              </c:otherwise>
              </c:choose>
            </tr>
             <tr>
              <c:choose> 
             <c:when test="${result.value.cwbApprovalId!=null and (result.value.cwbApproval.suggestion!=null or result.value.cwbApproval.status!='UNDETERMINED')}">
              <td class="tdleftw" style="height:50px;">财务部（结算）：</td>
              <td class="tdleftbg" width="10%">&nbsp;${result.value.cwbApproval.suggestion}</td>
              <td class="tdleftw">审批人：</td>
               <td class="tdleftbg">&nbsp;${result.value.cwbApproval.userName }</td>
              <td class="tdleftw">审批时间：</td>
              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.cwbApproval.approvalTime }" pattern="yyyy-MM-dd"/></td>
              <td class="tdleftw">审批结果：</td>
              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.cwbApproval.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.cwbApproval.status == 'AGREE'}">同意</c:if><c:if test="${result.value.cwbApproval.status == 'DISAGREE'}">不同意</c:if></td>
              </c:when>
              <c:otherwise>
             <td class="tdleftw" style="height:50px;">财务部（结算）：</td>
              <td class="tdleftbg" colspan="7">&nbsp;${result.value.cwbApproval.suggestion}</td>
              </c:otherwise>
              </c:choose>
            </tr>
             <tr>
             <c:choose> 
             <c:when test="${result.value.khApprovalId!=null and (result.value.kh.suggestion!=null or result.value.kh.status!='UNDETERMINED')}">
              <td class="tdleftw" style="height:50px;">客户确认：</td>
              <td class="tdleftbg" width="10%">&nbsp;${result.value.kh.suggestion}</td>
              <td class="tdleftw">审批人：</td>
               <td class="tdleftbg">&nbsp;${result.value.kh.userName }</td>
              <td class="tdleftw">审批时间：</td>
              <td class="tdleftbg" >&nbsp;<fmt:formatDate value="${result.value.kh.approvalTime }" pattern="yyyy-MM-dd"/></td>
              <td class="tdleftw">审批结果：</td>
              <td class="tdleftbg" width="10%">&nbsp;<c:if test="${result.value.kh.status == 'UNDETERMINED'}"></c:if><c:if test="${result.value.kh.status == 'AGREE'}">同意</c:if><c:if test="${result.value.kh.status == 'DISAGREE'}">不同意</c:if></td>
              </c:when>
              <c:otherwise>
             <td class="tdleftw" style="height:50px;">客户确认：</td>
              <td class="tdleftbg" colspan="7">&nbsp;${result.value.kh.suggestion}</td>
              </c:otherwise>
              </c:choose>
            </tr>
          </table>
          </div>
  <div class="table_footer"></div>
  <div class="divlays" id="upFile" style="padding:2px;">
		<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
			<c:forEach items="${attList}" var="att">	
					<input type="hidden" id="countNumber"  value="<%=count++ %>" />
					<div class="downlist">
						<img src="core/common/images/downloadico.png" />
						<ul>
							<li>${att.name}<span>(<format:fileSize size="att.size"/>)</span></li>
							<li><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpireAtt_download")) {%><a href="javascript:void" onclick="downLoad('${att.newName}','${att.name}')">下载</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpireAtt_edit")) {%><a href="javascript:void(0)" onclick="fbSearch('重命名','<%=basePath %>ContractExpireApprovalAtt!edit.action?id=${att.id}',350,75);">重命名</a><%}%><%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractExpireAtt_delete")) {%><a href="javascript:void(0)" onclick="deleteFile('${att.id}')">删除</a><%}%></li>
						</ul>
					</div>
			</c:forEach>
		</div>
  </div>
  <!--//apptable-->
</div>
</body>
</html>
