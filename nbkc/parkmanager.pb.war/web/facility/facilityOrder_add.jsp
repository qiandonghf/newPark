<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@page import="com.wiiy.crm.entity.*"%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>


<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
		initUploadify();
	});
	function initUploadify(){
		$("#file").uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.attachments.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.attachments.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response) {//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
				$("#contractPath").val($.parseJSON(data).path);
				$("#contractPathName").append($.parseJSON(data).name);
				$("#contractPathName").append($("<img />",{style:'padding-left:5px;',src:'core/common/images/locking.jpg',click:function(){
					deleteContractPath();
				}}));
			},
			'onSelect' : function(file) {
				deleteContractPath();
	        }
		});
	}
	function deleteContractPath(){
		$("#contractPathName").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#contractPath").val()+"-d");
		$("#contractPath").val("");
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"customerName":"required",
				"startTime":"required",
				"endTime":"required",
				"facilityOrder.status":"required"
			},
			messages: {
				"customerName":"请选择企业",
				"startTime":"请输入使用时间起",
				"endTime":"请输入使用时间止",
				"facilityOrder.status":"请选择状态"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#facilityOrderStartTime").val($("#startTime").val()+" "+$("#startHour").val()+":"+$("#startMinute").val()+":00");
				$("#facilityOrderEndTime").val($("#endTime").val()+" "+$("#endHour").val()+":"+$("#endMinute").val()+":00");
				if($("#facilityOrderEndTime").val()>=$("#facilityOrderStartTime").val()){
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout("getOpener().frames[0].reloadOrderList();parent.fb.end();", 2000);
				        	}
				        } 
				    });
				} else {
					showTip("使用时间止必须大于使用时间起");
				}
			}
		});
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
		loadContract(customer.id);
	}
	function loadContract(id){
		$.post("<%=basePath %>contract!loadContractByCustomerId.action?id="+id,function(data){
			if(data.result.success){
				var list = data.result.value;
				var contractId = $("#contractId");
				contractId.empty();
				contractId.append($("<option></option>",{value:""}).append("---请选择---"));
				for(var i = 0; i < list.length; i++){
					var contract = list[i];
					contractId.append($("<option></option>",{value:contract.id}).append(contract.name));
				}
			}
		});
	}
	
</script>
</head>

<body>
<form action="<%=basePath %>facilityOrder!save.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${param.facilityId}" name="facilityOrder.facilityId"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业名称：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="customerId" name="facilityOrder.customerId" type="hidden" class="inputauto" /><input readonly="readonly" id="customerName" name="customerName" type="text" class="inputauto" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);"/></td>
								<td width="25"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);" style="cursor:pointer;"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">使用时间起：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="150">
									<input readonly="readonly" id="startTime" name="startTime" type="text" class="inputauto" onclick="showCalendar('startTime')"/>
									<input id="facilityOrderStartTime" name="facilityOrder.startTime" type="hidden" value="test"/>
								</td>
								<td width="20"><img id="startTimeIcon" src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startTime')"/></td>
								<td>
									<select id="startHour">
										<c:forEach begin="0" end="23" var="s">
											<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
										</c:forEach>
									</select>&nbsp;时
									<select id="startMinute">
										<c:forEach begin="0" end="59" var="s" step="5">
											<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
										</c:forEach>
									</select>&nbsp;分
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">使用时间止：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="150">
									<input readonly="readonly" id="endTime" name="endTime" type="text" class="inputauto" onclick="showCalendar('endTime')"/>
									<input id="facilityOrderEndTime" name="facilityOrder.endTime" type="hidden" value="test"/>
								</td>
								<td width="20"><img id="endTimeIcon" src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('endTime')"/></td>
								<td>
									<select id="endHour">
										<c:forEach begin="0" end="23" var="s">
											<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
										</c:forEach>
									</select>&nbsp;时
									<select id="endMinute">
										<c:forEach begin="0" end="59" var="s" step="5">
											<option value="<c:if test="${s<10}">0</c:if>${s}">${s}</option>
										</c:forEach>
									</select>&nbsp;分
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
			      <td class="layertdleft100">合同：</td>
			      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			        <tr>
			          <td width="25"><label>
			            <select name="facilityOrder.contractId" id="contractId">
				            <option>------请选择------</option>
			            	
			            </select>
			          </label></td>
			        </tr>
			        <tr>
			          <td style="color:#999">如需签订合同，请先录入合同信息。<br />
						  然后再选择关联设施的使用情况记录。</td>
			        </tr>
			      </table></td>
			    </tr>
				
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><textarea name="facilityOrder.memo" rows="6" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div>
</form>
</body>
</html>