<%@page import="com.wiiy.crm.preferences.enums.CustomerApplyState"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
		initUploadify();
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_edit")){ %>
		if($(".incubated:checked").val()=="NO"){
			$("#apptab").attr("style","display:none");
		}
		<%}%>
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
	
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
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
	function loadCustomerLabel(){
		$.post("<%=basePath%>customerLabel!loadCustomerLabel.action",function(data){
			$("#customerLabelList").children("h1").remove();
			$("#customerLabelList").children("ul").remove();
			data.result.value[data.result.value.length] = {customerCategory:{name:"我的分组"},customerLabelList:data.customerLabelList};
			for(var j = 0; j < data.result.value.length; j++){
				var dto = data.result.value[j];
				var li = $("<li></li>");
				if(dto.customerLabelList.length==0)continue;
				for(var i = 0; i < dto.customerLabelList.length; i++){
					var label = dto.customerLabelList[i];
					li.append($("<a></a>",{href:"javascript:void(0)",click:function(){
						$("#customerLabelList").hide();
						var newLabel = $(this).find("input").val();
						var exist = false;
						$.each($(".customerLabelId"),function(){
							if($(this).val()==newLabel) exist = true;
						});
						if(exist)return;
						$("#labelUl").append(
							$("<li></li>",{
								mouseover:function(){$(this).find('span').show()},
								mouseout:function(){$(this).find('span').hide()}
							}).append($(this).text()).append($("<input type=\"hidden\" name=\"ids\" class=\"customerLabelId\" value=\""+$(this).find("input").val()+"\"/>")
							).append($("<span></span>",{click:function(){$(this).parent().remove();}}).hide())
						);
					}}).append(label.name).append($("<input type=\"hidden\" value=\""+label.id+"\"/>")));
				}
				$("#customerLabelList").append($("<h1></h1>").append(dto.customerCategory.name)).append($("<ul></ul>").append(li)).show();
			}
			if(data.result.value.length==0){
				$("#customerLabelList").append($("<h1></h1>").append("暂无标签")).show();
			}
		});
	}
	function generateCode(){
		$("#code").val(new Date().getTime());
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"customer.code":"required",
				"customer.name":"required",
				"customer.hostName":"required",
				"customer.parkStatus":"required",
				"customer.sourceId":"required",
				"customer.technicId":"required"
			},
			messages: {
				"customer.code":"请输入企业编号",
				"customer.name":"请输入企业名称",
				"customer.hostName":"请选择中心联络员",
				"customer.parkStatus":"请选择入驻状态",
				"customer.technicId":"请选择技术领域",
				"customer.sourceId":"请选择企业来源"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#content").val(CKEDITOR.instances.content.getData());
				var parkStatus = $("#parkStatus").val();
				var parkStatusOld = $("#parkStatusOld").val();
				if(parkStatus!=parkStatusOld){
					var date = (new Date()).format("yyyy-MM-dd");
					$("#time").val(date);
				}
				
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
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedUser(user){
		if(userType==1){
		$("#hostId").val(user.id);
		$("#hostName").val(user.realName);
		}else if(userType==2){
			$("#importId").val(user.id);
			$("#importName").val(user.realName);
		}
	}
	function selectUser(obj){
		userType=obj;
		fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!selectSelf.action',520,400);
	}
	
	function selectGarden(){
		var name = $("#gardenName").val();
		name =encodeURI(name);
		name =encodeURI(name);
		fbStart('选择苗圃项目','<%=basePath %>web/client/gardenSelector.jsp?id='+$("#gardenId").val()+"&name="+name,520,400);

	}
	
	function setSelectedGarden(selectedGarden){
		$("#gardenId").val(selectedGarden.id);
		$("#gardenName").val(selectedGarden.name);
	}
/* 	function changeIncubate(){
		var yesNo = $(".incubated:checked").val();
		var attr1 = $("#tableid>ul>li:eq(3)").css("display");
		var attr2 = $("#tabswitch").css("display");
		var cls = $("#tableid>ul>li:eq(3)").attr("class");
			if(attr1!='none' && cls =='apptabli'){
				if(yesNo=='NO'){
					$("#apptab").attr("style","display:none");
					$("#tabswitch").attr("style","display:none");
				}
			}else if(attr1!='none' && cls=='apptabliover'){
				if(yesNo=='NO'){
					$("#apptab").attr("style","display:none");
					$("#apptab").attr("class","apptabli");
					$("#tabswitch").attr("style","display:none");
					$("#tableid li:eq(0)").attr("style","display:list-item");
					$("#tableid li:eq(0)").attr("class","apptabliover");
					$(".tabswitch:eq(0)").attr("style","display:block");
					$(".tabswitch:eq(0)").attr("style","margin-top:0");
				}
			}else if(attr1=='none'){
				if(yesNo=='YES'){
					$("#apptab").attr("style","display:list-item");
					$("#tabswitch").css({"display":"none","margin-top":"0"});
				} 
			}		
	} */
	
	function checkApplication(){
		var pub = $("#pub").val();
		var state = null;
		if(pub == 'NOAPPLICATION'){
			state = 'APPLYING';
			sendRequest();
		}else if(pub == 'AGREE'){
			state = 'AGREE';
		}else{
			state = 'NOAPPLICATION';
		}
		sendRequest(state);
	}
	
	function sendRequest(state){
		if(state == undefined){
			return;
		}
		var content = CKEDITOR.instances.content.document.getBody().getText();
		$("#contentV").val(content);
		content = $("#contentV").val().replace(/(^\s*)|(\s*$)/g, "");
		if(content =='' && state != 'NOAPPLICATION'){
			showTip("请输入企业宣传内容",2000);
			var ed = CKEDITOR.instances.content;
			$(ed).focus();
		}else{
			if(state == 'AGREE'){
				state = 'NOAPPLICATION';
			}
			var id = $("input[name='customer.id']").val();
			$("#contentV").val(CKEDITOR.instances.content.getData());
			content = CKEDITOR.instances.content.getData();
			$('#form2').ajaxSubmit({ 
		        dataType: 'json',
		        data: {'state':state,'id':id},
		        success: function(data){
		        	 if(data.result.success){
						   showTip("更改企业申请状态成功",2000);
						   $("#pub").val(state);
						   $("#content").val(content);
						   if(state == 'NOAPPLICATION'){
							   $("#applyBtn").text("立即申请");
							   $("#applyState").html('未申请');
							   CKEDITOR.instances.content.setReadOnly(false);
						   }else{
							   $("#applyBtn").text("取消申请");
							   $("#applyState").html('申请中');
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
	#fixedTable{
		table-layout:fixed;
	}
</style>
</head>

<body>
<form action="<%=basePath %>customer!changeApplyState.action" method="post" name="form2" id="form2">
	<input name="customer.content" id="contentV" value="${result.value.content}" type="hidden"/>
</form>
<form action="<%=basePath %>customer!update.action" method="post" name="form1" id="form1">
	<input id="time" name="customer.time" value="${result.value.time}" type="hidden"/>
	<input id="ids" name="ids" value="${ids}" type="hidden"/>
	<input id="agreementName" name="incubationInfo.agreementName" value="${result.value.incubationInfo.agreementName}" type="hidden"/>
	<input id="pub" name="customer.pub" type="hidden" value="${result.value.pub }"/>
	<input name="customer.id" value="${result.value.id}" type="hidden"/>
	<input name="customerInfo.id" value="${result.value.customerInfo.id}" type="hidden"/>
	<input name="incubationInfo.id" value="${result.value.incubationInfo.id}" type="hidden"/>
	<div class="basediv">
		<div class="titlebg">企业基本信息</div>
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
					<td colspan="3" class="layerright"><input id="name" name="customer.name" type="text" class="inputauto" value="${result.value.name}"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业编号：</td>
					<td width="35%" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="code" name="customer.code" type="text" class="inputauto" value="${result.value.code}"/></td>
								<td width="80" align="center"><img src="core/common/images/auto.gif" width="75" height="22" style="cursor:pointer;" onclick="generateCode()"/></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">简称：</td>
					<td width="35%" class="layerright"><input id="shortName" name="customer.shortName" type="text" class="inputauto" value="${result.value.shortName}"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>入驻状态：</td>
					<td class="layerright"><input id="parkStatusOld" type="hidden" value="${result.value.parkStatus }"/><enum:select id="parkStatus" name="customer.parkStatus" type="com.wiiy.crm.preferences.enums.ParkStatusEnum" checked="result.value.parkStatus"/></td>
					<td class="layertdleft100"><span class="psred">*</span>产业类别：</td>
					<td class="layerright"><dd:select id="technicId" name="customer.technicId" key="crm.0002" checked="result.value.technicId"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业来源：</td>
					<td class="layerright"><dd:select id="sourceId" name="customer.sourceId" key="crm.0003" checked="result.value.sourceId"/></td>
					<td class="layertdleft100"><span class="psred">*</span>中心联络员：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="hostId" name="customer.hostId" type="hidden" class="inputauto" value="${result.value.hostId}"/><input id="hostName" name="customer.hostName" value="${result.value.hostName}" readonly="readonly" type="text" class="inputauto" onclick="selectUser(1)" /></td>
								<td width="50" ><img style="position: relative;left:-1px;" onclick="selectUser(1)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">苗圃信息：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<input id="gardenId" name="customer.gardenApplyId" value="${result.value.gardenApplyId }" type="hidden" class="inputauto" />
									<input id="gardenName" readonly="readonly" type="text" value="${result.value.gardenApply.projectName }" class="inputauto" onclick="selectGarden()" />
								</td>
								<td width="50"><img style="position: relative;left:-1px;" onclick="selectGarden()" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
					<td class="layertdleft100">所属基地：</td>
					<td class="layerright">
						<enum:select name="customer.base" type="com.wiiy.crm.preferences.enums.CustomerBaseEnum" checked="result.value.base" />
					</td>
				</tr>
				<%-- <tr>
					<td class="layertdleft100"><span class="psred">*</span>是否孵化企业：</td>
					<td width="35%" class="layerright" id="incubate" onclick="changeIncubate()"><enum:radio defaultValue="NO" styleClass="incubated" name="customer.incubated" type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="result.value.incubated"/></td>
					<td class="layertdleft100"><span class="psred">*</span>引进人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="importId" name="customer.importId" type="hidden" class="inputauto" value="${result.value.importId}"/><input id="importName" name="customer.importName" value="${result.value.importName}" readonly="readonly" type="text" class="inputauto" onclick="selectUser(2)" /></td>
								<td width="25" ><img style="position: relative;left:-1px;" onclick="selectUser(2)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr> --%>
				<tr>
					<td class="layertdleft100">企业类型：</td>
					<td colspan="3" style="white-space:nowrap;" class="layerright" ><dd:checkbox name="enterpriseTypeId" checked="typeIds" key="crm.0030"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">企业标签：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="28">
									<img src="core/common/images/outdiv.gif" width="20" height="22" style="cursor:pointer;" onclick="loadCustomerLabel();" />
									<div class="company_label" style="display:none;overflow-x: hidden;overflow-y:scroll;height:200px;" id="customerLabelList">
										<div class="titlebg"><span style="float:right"><img src="core/common/images/companyclose.gif" onclick="$(this).parent().parent().parent().hide()" style="cursor:pointer;" /></span>企业标签</div>
										<h1>专业分类</h1>
										<ul>
											<li><a href="javascript:void(0)">水处理</a><a href="javascript:void(0)">空气处理</a><a href="javascript:void(0)">其它环保</a><a href="javascript:void(0)">电子信息</a></li>
										</ul>
										<h1>专业分类</h1>
										<ul>
											<li><a href="javascript:void(0)">水处理</a><a href="javascript:void(0)">空气处理</a><a href="javascript:void(0)">其它环保</a><a href="javascript:void(0)">电子信息</a></li>
										</ul>
									</div>
								</td>
								<td class="customerdiv">
								<div style=" width:auto; height:50px; overflow-x:hidden; overflow-y:scroll">
									<ul id="labelUl">
									<c:forEach items="${result.value.labelRefs}" var="labelRef">
										<li onmouseout="$(this).find('span').hide()" onmouseover="$(this).find('span').show()">${labelRef.customerLabel.name}<input type="hidden" name="ids" class="customerLabelId" value="${labelRef.customerLabel.id}"/><span style="display: none;" onclick="$(this).parent().remove()"></span></li>
									</c:forEach>
									</ul>
								</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div>
		<div class="apptab" id="tableid">
			<ul>
				<%int flag=-1;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_edit")){
				flag++;
				%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">公司信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_edit")){flag++; %>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">注册信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_edit")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">招商信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_edit")){flag++; %>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">孵化信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_edit")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业资质</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_application_add")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业宣传</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_edit")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">其它</li>
				<%} %>
			</ul>
		</div>
		<%int flag2=-1;
		if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_edit")){flag2++; %>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_edit")){ flag2++;%>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_edit")){ flag2++;%>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_edit")){ flag2++;%>
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
						<td rowspan="7" style="vertical-align:top; padding-left:2px;">
							<div style="overflow-y:auto; height:180px;">
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
									<td><input id="incubationEndDate" name="incubationInfo.incubationEndDate" readonly="readonly" value="<fmt:formatDate value="${result.value.incubationInfo.incubationEndDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('incubationEndDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationEndDate');"/></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>入驻场所：</td>
						<td width="35%" class="layerright"><dd:select id="incubateConfigId" name="incubationInfo.incubateConfigId" key="crm.0026" checked="result.value.incubationInfo.incubateConfigId"/></td>
					</tr>
					<tr>
						<td class="layertdleft100">孵化面积：</td>
						<td width="35%" class="layerright"><input name="incubationInfo.incubatorAreas" type="text" class="input100" value="${result.value.incubationInfo.incubatorAreas }"/>平方米</td>					
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>孵化状态：</td>
						<td width="35%" class="layerright">
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_edit")){ flag2++;%>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_application_add")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>">
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
							<textarea id="content" name="customer.content"  class="textareaauto" style="height:100px;margin-top:2px;">${result.value.content }
							</textarea>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_edit")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">公司描述：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;"><textarea name="customerInfo.description"  class="textareaauto" style="height:70px;">${result.value.customerInfo.description}</textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright"><textarea name="customerInfo.memo"  class="textareaauto"  style="height:115px;">${result.value.customerInfo.memo}</textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">最后修改人:</td>
						<td class="layerright">${result.value.modifier}</td>
						<td class="layertdleft100">最后修改时间：</td>
						<td class="layerright"><fmt:formatDate value="${result.value.modifyTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
					</tr>
				</table>
			</div>
		</div>
		<%} %>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
	</div>
</form>
</body>
</html>