<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.core.preferences.enums.ContactTypeEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="format" uri="http://www.wiiy.com/taglib/format" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String url = BaseAction.rootLocation+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.pb/web/style/merchants.css" rel="stylesheet" type="text/css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<script src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript"> 
	$(document).ready(function(){
		initTip();
		initUploadify();
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
		var file = $.parseJSON(data);
		var postData = {"contactAtt.contactId":"${id}","contactAtt.name":file.originalName,"contactAtt.newName":file.path,"contactAtt.size":file.size,"contactAtt.contactType":"${type}"};
		$.post("<%=basePath%>contactAtt!save.action",postData,function(callbackData){
			showTip(callbackData.result.msg);
			setTimeout(function(){
				location.href="<%=basePath%>contact!myView.action?type="+$("#type").val()+"&id="+$("#id").val()+"&tabId=2";
			},2000);
		});
	}

	function viewDetails(type,id){
		if('<%=ContactTypeEnum.INVESTMENTCONTACT%>' == type){
			window.open('<%=BaseAction.rootLocation %>/parkmanager.pb/investmentContact!countersignView.action?id='+id,'招商项目审批联系单','height=500,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
		}else if('<%=ContactTypeEnum.RENTOUTCONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.RENTOUTCONTACT.getTitle()%>','/parkmanager.pb/rentOutContact!countersignView.action?id='+id,800,638);
		}else if('<%=ContactTypeEnum.BUSINESSCENTERCONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.BUSINESSCENTERCONTACT.getTitle()%>','/parkmanager.pb/businessCenterContact!countersignView.action?id='+id,800,638);
		}else if('<%=ContactTypeEnum.TENEMENTCENTERCONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.TENEMENTCENTERCONTACT.getTitle()%>','/parkmanager.pb/tenementCenterContact!countersignView.action?id='+id,800,638);
		}else if('<%=ContactTypeEnum.FINANCECONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.FINANCECONTACT.getTitle()%>','/parkmanager.pb/financeContact!countersignView.action?id='+id,800,638);
		}else if('<%=ContactTypeEnum.CARPORTOUTCONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.CARPORTOUTCONTACT.getTitle()%>','/parkmanager.pb/carportOutContact!countersignView.action?id='+id,800,638);
		}else if('<%=ContactTypeEnum.CUSTOMERSERVICECONTACT%>' == type){
			fbStart('<%=ContactTypeEnum.CUSTOMERSERVICECONTACT.getTitle()%>','/parkmanager.pb/customerServiceContact!countersignView.action?id='+id,800,638);
		}
	}
	function deleteFile(id){
		if(confirm("确定删除？")){
			$.post("<%=basePath %>contactAtt!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
				setTimeout("location.reload();",1000);
			});
			}
		}
		function downLoadFile(path,name){
			location.href="<%=BaseAction.rootLocation %>/core/resources/"+path+"?name="+name;
		}
		function openAtt(path){
			var src = "<%=basePath%>contactAtt!attImage.action?imgPath="+path;
			fbStart("扫描件",src,800,638);
		}
		function print(){
			var type = $("#type").val();
			var id = $("#id").val();
			if('<%=ContactTypeEnum.INVESTMENTCONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/investmentContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.RENTOUTCONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/rentOutContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.BUSINESSCENTERCONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/businessCenterContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.TENEMENTCENTERCONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/tenementCenterContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.FINANCECONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/financeContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.CARPORTOUTCONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/carportOutContact!print.action?id="+id;
			}else if('<%=ContactTypeEnum.CUSTOMERSERVICECONTACT%>' == type){
				location.href = "<%=url%>parkmanager.pb/customerServiceContact!print.action?id="+id;
			}
		}
</script>
<style>
h1 { font:bold 16px/32px ''; height:32px; text-align:center;}
ul.listStyle1 li{ margin:5px; background:#f8f8f8; padding:5px 10px;}
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

</head>
<body>
<input type="hidden" id="type" value="${type }"/>
<input type="hidden" id="id" value="${id }"/>
		<!--titlebg-->
			<div class="titlebg">我的联系单</div>
		 <!--//titlebg-->
			<div class="apptab" id="apptab">
				<ul>
					<li class="apptabli<%if((Integer)request.getAttribute("tabId") == 1){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">联系单</li>
					<li class="apptabli<%if((Integer)request.getAttribute("tabId") == 2){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">扫描件</li>
				</ul>
			</div>
<!--baseDiv-->
		<div class="basediv tabswitch" style="margin:0px;<%if((Integer)request.getAttribute("tabId")==2){ %>display:none;<%} %>" id="textname">
			<!--appname应用信息-->
			<div class="appname">
                <!--leftemail-->
                <div class="emailtop">
                <div class="leftemail">
                    <ul>
                       <li onmouseover="this.className='libg'" onmouseout="this.className=''" class=""><a href="javascript:void(0);" onclick="print()" target="_blank"><span style="top: 3px;"><img src="core/common/images/print_btn.gif"/></span>打印</a></li>
                    </ul>
                </div>
                </div>
	<!--//leftemail-->
              
			    <form id="form1" name="form1" method="post" action="">
			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td class="layertdleft100">类型：</td>
                      <td class="layerright"> ${dto.type.title}</td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">发起人：</td>
                      <td class="layerright">  ${dto.userName }</td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">发起时间：</td>
                      <td class="layerright">  <fmt:formatDate pattern="yyyy-MM-dd" value="${dto.create_time}"/></td>
                    </tr>
                    <tr>
                      <td class="layertdleft100">联系单状态：</td>
                      <td class="layerright">  ${dto.status.title }</td>
                    </tr>
                  </table>
                </form>
		    </div>
			<!--appname-->
			<div class="buttondivpage btnView11">
				   <a href="javascript:void(0);" onclick="viewDetails('${dto.type}',${dto.id })">查看详情</a>
			</div>
             <div class="appname">
                <div class="titlebg">轨迹：</div>
                <div style="height:120px;overflow-x:hidden;overflow-y:scroll">
                <ul class="listStyle1">
                <c:forEach items="${contactLogList}" var="contactLog">
                <li>${contactLog.creator }  <fmt:formatDate pattern="yyyy-MM-dd" value="${contactLog.createTime }"/>  ${contactLog.content }</li>
                </c:forEach>
            </ul>
            </div>
           </div>
		</div>
		<!--//baseDiv-->
		
		<!-- baseDiv -->
	<div class="basediv tabswitch" style="margin: 0px;<%if((Integer)request.getAttribute("tabId")==1){ %>display:none;<%} %>" id="textname">
		<div class="appname" style="overflow-x:hidden;overflow-y:scorll; heaight:330px">
		 <div class="emailtop">
                <div class="leftemail">
                    <ul>
                        
                       <li onmouseover="this.className='libg'" onmouseout="this.className=''" ><input type="file" id="file"/></li>
                    
                    </ul>
                </div>
                </div>
			<div class="divlays" id="upFile" style="padding: 2px 5px 10px 5px;<c:if test="${fn:length(contactAttList) eq 0 }">display:none</c:if>"  >
				<div class="emaildown"
					style="margin-top: 5px; border-bottom: 1px solid #e4e4e4; border-left: 1px solid #e4e4e4; border-right: 1px solid #e4e4e4;">
					<!--外框-->
					<div style="display: block;">
					<c:forEach items="${contactAttList }" var="att">
						<div class="downlistleft">
							<img src="core/common/images/print.png">
								<ul>
									<li>${att.name }<span>(<format:fileSize size="att.size"/>)</span></li>
									<li><a href="javascript:void(0)" onclick="downLoadFile('${att.newName}','${att.name}');">下载</a><a
										href="javascript:void(0)" onclick="openAtt('${att.newName}')">打开</a><a href="javascript:void(0)" onclick="deleteFile('${att.id}')">删除</a>
										<a href="javascript:void(0)"></a></li>
								</ul>
						</div>
						</c:forEach>
						<div class="hackbox"></div>
					</div>
					<!--外框-->
					<div class="hackbox"></div>
				</div>
			</div>
		</div>
	</div>
	<!--//baseDiv-->
</body>
</html>
