<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/ckeditor/adapters/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
		$(function(){
			initTip();
			initForm();
			initUploadify();
			$( 'textarea.editor' ).ckeditor(function() { /* callback code */ }, { height : '120' });
			$("#promot").change(function(){
				if($(this).val()=="SPECIALDAY"){
					$("#SPECIALDAY").show();
				} else {
					$("#SPECIALDAY").hide();
				}
				if($(this).val()=='' || $(this).val()=="NOPROMOT" || $(this).val()=="NOW"){
					$("#time").hide();
				} else {
					$("#time").show();
				}
			});
		});
		function initForm(){
			$("#form1").validate({
				rules: {
					"task.title":"required",
					"task.endTime":"required",
					"task.status":"required"
				},
				messages: {
					"task.title":"请输入主题",
					"task.endTime":"请选择截止时间",
					"task.status":"请选择状态"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#startTime").val()!=null && $("#endTime").val()<$("#startTime").val()){
						showTip("开始日期不能小于结束日期",3000);
						return;
					}
					if($("#title").val()==""){
						showTip("请输入主题",2000);
						return;
					}
					processDate();
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout("parent.refresh();parent.fb.end();", 2000);
				        	}
				        } 
				    });
				}
			});
		}
		function processDate(){
			$("#taskMemo").val($("#memo").val());
			if($("#SPECIALDAY").is(":hidden")){
				$("#promotDetail").val($("#hour").val());
			} else {
				$("#promotDetail").val($("#date").val()+" "+$("#hour").val());
			}
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
				'onUploadSuccess'	: uploadSuccess
			});
		}
		function uploadSuccess(file, data, response){
			var file = $.parseJSON(data);
			var postData = {"taskAtt.taskId":$("#taskId").val(),"taskAtt.name":file.originalName,"taskAtt.newName":file.path,"taskAtt.size":file.size};
			$.post("<%=basePath%>taskAtt!save.action",postData,function(callbackData){
				var id = callbackData.result.value.id;
				$("#attList").append($("<li></li>",{id:"li"+id}).append($("<label></label>").append(file.originalName).append("<input type='hidden' class='att' value='"+file.path+"'/>")).append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
					deleteAtt(id);
				}})));
			});
		}
		function deleteAtt(id){
			$.post("<%=basePath %>taskAtt!delete.action?id="+id,function(data){
				$("#li"+id).remove();
			});			
		}
		function toSubmit(){
			var validate = $("#form1").validate({
				rules: {
					"task.title":"required",
					"task.status":"required",
					"task.endTime":"required"
				},
				messages: {
					"task.title":"请输入主题",
					"task.status":"请选择状态",
					"task.endTime":"请选择截止时间"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				}
			});
			if(validate.form()){
				if($("#endTime").val()<$("#startTime").val()){
					showTip("开始日期不能小于结束日期",3000);
					return;
				}
				if($("#title").val()==""){
					showTip("请输入主题",2000);
					return;
				}
				processDate();
				$("#form1").ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().setReload();fb.end();", 2000);
			        	}
			        } 
			    });
			}
		}
	</script>
</head>

<body>
<form action="<%=basePath %>task!update.action" method="post" name="form1" id="form1">
	<input type="hidden" name="task.promotDetail" id="promotDetail"/>
	<input type="hidden"  name="task.memo" id="taskMemo"/>
	<input type="hidden" id="taskId" name="task.id" value="${result.value.id}"/>
	<div class="basediv">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toSubmit();"><span><img src="core/common/images/emailadd.gif"/></span>保存并关闭</li>
				</ul>
			</div>
		</div>
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','divlays',0)">任务</li>
				<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','divlays',1)">详细信息</li>
			</ul>
		</div>
		<div class="pm_msglist" style="margin:0 5px 5px 5px;">
		<div class="divlays">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>主题：</td>
					<td colspan="3" class="layerright"><input id="title" name="task.title" type="text" class="inputauto" value="${result.value.title}"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>截止时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><input id="endTime" readonly="readonly" value="<fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/>" name="task.endTime" type="text" class="inputauto" onclick="return showCalendar('endTime')"/></td>
											<td width="20" align="center"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('endTime')"/></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100"><span class="psred">*</span>状态：</td>
					<td class="layerright"><enum:select checked="result.value.status" type="com.wiiy.oa.preferences.enums.TaskStatusEnum" name="task.status"/></td>
				</tr>
				<tr id="endtime">
					<td class="layertdleft100">开始时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><input id="startTime" readonly="readonly" value="<fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/>" name="task.startTime" type="text" class="inputauto" onclick="return showCalendar('startTime')"/></td>
											<td width="20" align="center"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('startTime')"/></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">优先级：</td>
					<td class="layerright"><enum:select checked="result.value.priority" type="com.wiiy.oa.preferences.enums.PriorityEnum" name="task.priority"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">所属部门：</td>
					<td class="layerright">
						<c:forEach items="${taskDepartList}" var="depart">
							<c:set var="exist" value="false"></c:set>
							<c:forEach items="${result.value.departConfigs}" var="config">
								<c:if test="${config.departId eq depart.id}">
									<c:set var="exist" value="true"></c:set>
								</c:if>
							</c:forEach>
							<label><input type="checkbox" name="ids" <c:if test="${exist}">checked="checked"</c:if> value="${depart.id}"/>${depart.name}</label>
						</c:forEach>
					</td>
					<td class="layertdleft100">所属项目：</td>
					<td class="layerright">
						<select name="task.projectId" style="height:22px;">
							<option value="">----请选择----</option>
							<c:forEach items="${taskProjectList}" var="project">
							<option value="${project.id}" <c:if test="${project.id eq result.value.projectId}">selected="selected"</c:if>>${project.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">提醒时间：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="80"><enum:select id="promot" checked="result.value.promot" type="com.wiiy.oa.preferences.enums.PromotEnum" name="task.promot"/></td>
								<%
									Result<Task> result = (Result<Task>)request.getAttribute("result");
									Task task = result.getValue();
									boolean noPromot = false;
									boolean specialday = false;
									if(task.getPromot()!=null)
									switch(task.getPromot()){
									case NOPROMOT:
									case NOW:
										noPromot = true;
										break;
									case SPECIALDAY:
										specialday = true;
										break;
									}
									else noPromot = true;
								%>
								<td width="135" id="SPECIALDAY"  class="layerright" <%if(!noPromot || !specialday){ %>style="display:none;"<% }%>>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><input id="date" type="text" class="inputauto" readonly="readonly" value="${fn:substring(result.value.promotDetail,0,fn:indexOf(result.value.promotDetail,' '))}" onclick="return showCalendar('date')"/></td>
											<td width="20"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('date')"/></td>
										</tr>
									</table>
								</td>
								<td id="time" class="layerright" <%if(noPromot){ %>style="display:none;"<% }%>>
									<select id="hour" style="height:22px;">
										<c:forEach begin="0" end="23" var="s">
											<fmt:formatNumber value="${s}" pattern="00" var="fmtS"/>
											<option value="${fmtS}" <c:if test="${fn:substring(result.value.promotDetail,fn:indexOf(result.value.promotDetail,' ')+1,fn:length(result.value.promotDetail)) eq fmtS}">selected="selected"</c:if> >${fmtS}:00</option>
										</c:forEach>
									</select>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				</tr>
				<tr>
					<td class="layertdleft100">提醒方式：</td>
					<td class="layerright">
						<table border=0 cellspacing=0 cellpadding=0 width="100%">
							<tbody>
								<tr>
									<td width=20><label><input value="<%=BooleanEnum.YES %>" type="checkbox" name="task.sms" <c:if test="${result.value.sms eq 'YES'}">checked="checked"</c:if>/></label></td>
									<td width=30>短信 </td>
									<%-- <td width=20><input value="<%=BooleanEnum.YES %>" type="checkbox" name="task.defaultEmail" <c:if test="${result.value.defaultEmail eq 'YES'}">checked="checked"</c:if>></td>
									<td width=50>内部邮件</td> --%>
									<td width=20><input value="<%=BooleanEnum.YES %>" type="checkbox" name="task.email" <c:if test="${result.value.email eq 'YES'}">checked="checked"</c:if>/></td>
									<td>邮件</td>
									<td>&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">任务描述：</td>
					<td colspan="3" class="layerright" style="padding-bottom:2px;">
						<textarea id="memo" class="editor" style="height:200px;" class="textareaauto">${result.value.memo}</textarea></td>
				</tr>
				<tr>
					<td class="layertdleft100">附件：</td>
					<td class="layerright"><input type="file" id="file"/><input id="photos" name="facility.photos" type="hidden" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100">附件列表：</td>
					<td class="layerright">
					<table border=0 cellspacing=0 cellpadding=0 width="70%"><tr><td style="padding-left:5px;">
						<div id="attList" style="height: 40px;overflow-x:hidden;overflow-y: auto; ">
						<c:forEach items="${result.value.atts}" var="att">
						<li id="li${att.id}"><label>${att.name}<input type="hidden" value="${att.newName}" class="att"/></label><img src="core/common/images/locking.jpg" onclick="deleteAtt(${att.id})"/></li>
						</c:forEach>
						</div>
					</td></tr></table>
					</td>
				</tr>
			</table>
		</div>
		<div class="divlays" name="textname" id="textname" style="display:none">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">创建人：</td>
					<td>&nbsp;${creator}</td>
				</tr>
				<tr id="endtime">
					<td class="layertdleft100">完成时间：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="135">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="120"><input id="finishTime" readonly="readonly" value="<fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/>" name="task.finishTime" type="text" class="inputauto" onclick="return showCalendar('finishTime')"/></td>
											<td width="20" align="center"><img src="core/common/images/timeico.gif" style="position: relative; left:-1px;" width="20" height="22" onclick="return showCalendar('finishTime')"/></td>
											<td>&nbsp; </td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<%-- <tr>
					<td class="layertdleft100">所属部门：</td>
					<td class="layerright">
						<c:forEach items="${taskDepartList}" var="depart">
							<c:set var="exist" value="false"></c:set>
							<c:forEach items="${result.value.departConfigs}" var="config">
								<c:if test="${config.departId eq depart.id}">
									<c:set var="exist" value="true"></c:set>
								</c:if>
							</c:forEach>
							<label><input type="checkbox" name="ids" <c:if test="${exist}">checked="checked"</c:if> value="${depart.id}"/>${depart.name}</label>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">所属项目：</td>
					<td class="layerright">
						<select name="task.projectId" style="height:22px;">
							<option value="">----请选择----</option>
							<c:forEach items="${taskProjectList}" var="project">
							<option value="${project.id}" <c:if test="${project.id eq result.value.projectId}">selected="selected"</c:if>>${project.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr> --%>
				<%--<tr>
					<td class="layertdleft100">重复方式：</td>
					<td class="layerright"><enum:select checked="result.value.repeatType" type="com.wiiy.oa.preferences.enums.RepeatEnum" name="task.repeatType"/></td>
				</tr> --%>
			</table>
			<div class="hackbox"></div>
		</div>
	</div>
</div>
</form>
<div style="height: 5px;"></div>
</body>
</html>
