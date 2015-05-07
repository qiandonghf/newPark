<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
		initUploadify();
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_add")){ %>
		$("#apptab").attr("style","display:none");
		<%}%>
	});
	
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
				$("#agreementDocuName").append($.parseJSON(data).name);
				$("#agreementName").append($.parseJSON(data).originalName);
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
		$.post("<%=basePath%>customer!generateCode.action",function(data){
			if(data.result.success){
				$("#code").val(data.result.value);
			}
		});
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"customer.code":"required",
				"customer.name":"required",
				"customer.shortName":"required",
				"customer.hostName":"required",
				"customer.importName":"required",
				"customer.parkStatus":"required",
				"customer.sourceId":"required",
				"customer.technicId":"required"
			},
			messages: {
				"customer.code":"请输入企业编号",
				"customer.name": "请输入企业名称",
				"customer.shortName":"请输入简称",
				"customer.hostName":"请选择跟踪人员",
				"customer.importName":"请选择引进人员",
				"customer.parkStatus":"请选择入驻状态",
				"customer.technicId":"请选择技术领域",
				"customer.sourceId":"请选择企业来源"
			},
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
						showTip("请选择孵化状态");
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
				var statusId = $("#status").val();
				statusId = statusId.replace("crm.00","");
				$("#statusId").val(statusId);
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
	function changeIncubate(){
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
	}
</script>
</head>

<body>
<form action="<%=basePath %>customer!save.action" method="post" name="form1" id="form1">
	<input id="ids" name="ids" type="hidden"/>
	<input id="agreementName" name="incubationInfo.agreementName" type="hidden"/>
	<%--zhf--%>
	<div id="scrollDiv" style=" position:relative;">			
	<div class="basediv">
		<div class="titlebg">企业基本信息</div>
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
					<td width="35%" class="layerright"><input id="name" name="customer.name" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred">*</span>企业编号：</td>
					<td width="35%" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="code" name="customer.code" type="text" class="inputauto" /></td>
								<td width="80" align="center"><img src="core/common/images/auto.gif" width="75" height="22" style="cursor:pointer;" onclick="generateCode()"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>简称：</td>
					<td width="35%" class="layerright"><input id="shortName" name="customer.shortName" type="text" class="inputauto" /></td>
					<td class="layertdleft100"><span class="psred">*</span>入驻状态：</td>
					<td class="layerright"><enum:select id="parkStatus" name="customer.parkStatus" type="com.wiiy.crm.preferences.enums.ParkStatusEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>产业类别：</td>
					<td class="layerright"><dd:select id="technicId" name="customer.technicId" key="crm.0002"/></td>
					<td class="layertdleft100"><span class="psred">*</span>企业来源：</td>
					<td class="layerright"><dd:select id="sourceId" name="customer.sourceId" key="crm.0003"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">企业性质：</td>
					<td class="layerright"><enum:select id="type" name="customer.type" type="com.wiiy.crm.preferences.enums.CustomerTypeEnum"/></td>
					<td class="layertdleft100"><span class="psred">*</span>跟踪人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="hostId" name="customer.hostId" type="hidden" class="inputauto" /><input id="hostName" name="customer.hostName" readonly="readonly" type="text" class="inputauto" onclick="selectUser(1)" /></td>
								<td width="25"><img style="position: relative;left:-1px;" onclick="selectUser(1)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>是否孵化企业：</td>
					<td width="35%" class="layerright" id="incubate" onclick="changeIncubate()"><enum:radio styleClass="incubated" name="customer.incubated"  type="com.wiiy.commons.preferences.enums.BooleanEnum" checked="NO"/></td>
					<td class="layertdleft100"><span class="psred">*</span>引进人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="importId" name="customer.importId" type="hidden" class="inputauto" /><input id="importName" name="customer.importName" readonly="readonly" type="text" class="inputauto" onclick="selectUser(2)" /></td>
								<td width="25"><img style="position: relative;left:-1px;" onclick="selectUser(2)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">企业类型：</td>
					<td colspan="3" style="white-space:nowrap;" class="layerright"><dd:checkbox name="enterpriseTypeId" key="crm.0030"/></td>
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
									<ul id="labelUl"></ul>
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
	<div style="height:260px;">
		<div class="apptab" id="tableid">
			<ul>
				<%int flag=-1;
				if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_add")){
				flag++;
				%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">公司信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_add")){flag++; %>
				<li class="apptabli<%if(flag==0){ %>over<%} %>"  onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">注册信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_add")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">招商信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_add")){flag++; %>
				<li id="apptab" class="apptabli<%if(flag==0){ %>over<%} %>"  onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">孵化信息</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_add")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">企业资质</li>
				<%} %>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_add")){ flag++;%>
				<li class="apptabli<%if(flag==0){ %>over<%} %>" onclick="tabSwitch('apptabli','apptabliover','tabswitch',<%=flag%>)">其它</li>
				<%} %>
			</ul>
		</div>
		<%int flag2=-1;
		if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_add")){flag2++; %>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays" style="margin:0px;">
		    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">联系地址：</td>
						<td width="25%" class="layerright"><input name="customerInfo.address" type="text" class="inputauto"/></td>
						<td rowspan="6" style="vertical-align:top; padding-left:2px;">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				              <tr>
				                <td class="layertdleft100" style="text-align:left; padding-left:10px;">企业总人数：</td>
				                <td class="layerright" colspan="3"><label><input name="customerInfo.userCount" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				              </tr>
				              <tr>
				                <td class="layertdleft100" style="text-indent:10px;"><span style="float:left;">其中</span>博士后：</td>
				                <td class="layerright"><label><input name="customerInfo.userbsh" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				                <td class="layertdleft100">博士：</td>
				                <td class="layerright"><label><input name="customerInfo.userbs" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				                
				              </tr>
				              <tr>
				                <td class="layertdleft100">硕士：</td>
				                <td class="layerright"><label><input name="customerInfo.userss" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				                <td class="layertdleft100">本科：</td>
				                <td class="layerright"><label><input name="customerInfo.userbk" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				              </tr>
				              <tr>
				                <td class="layertdleft100">高级职称：</td>
				                <td class="layerright"><label><input name="customerInfo.usergj" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				                <td class="layertdleft100">中级职称：</td>
				                <td class="layerright"><label><input name="customerInfo.userzj" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')" /></label></td>
				              </tr>
				              <tr>
				                <td class="layertdleft100">初级职称：</td>
				                <td class="layerright"><label><input name="customerInfo.usercj" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				                <td class="layertdleft100">其他：</td>
				                <td class="layerright"><label><input name="customerInfo.userqt" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				              </tr>
				              <tr>
				                <td class="layertdleft100">留学生：</td>
				                <td class="layerright" colspan="3"><label><input name="customerInfo.userlxs" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d]/g,'')"/></label></td>
				              </tr>
				            </table>
				        </td>
        			</tr>
      				<tr>
						<td class="layertdleft100">办公电话：</td>
						<td width="25%" class="layerright"><input name="customerInfo.officePhone" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">传真：</td>
						<td width="25%" class="layerright"><input name="customerInfo.fax" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">邮编：</td>
						<td width="25%" class="layerright"><input name="customerInfo.zipCode" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">网址：</td>
						<td width="25%" class="layerright"><input name="customerInfo.webSite" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">E-mail：</td>
						<td width="25%" class="layerright"><input name="customerInfo.email" type="text" class="inputauto" /></td>
					</tr>
				</table>
			</div>
		</div>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_registerMessage_add")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">注册时间：</td>
						<td width="35%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="regTime" name="customerInfo.regTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('regTime');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('regTime');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100">注册类型：</td>
						<td width="35%" class="layerright"><dd:select name="customerInfo.regTypeId" key="crm.0004"/></td>
					</tr>
					<tr>
						<td class="layertdleft100">注册资本：</td>
						<td class="layerright">
							<input name="customerInfo.regCapital" type="text" class="inputauto" style="width:100px;"/> 万元 <dd:select name="customerInfo.currencyTypeId" key="crm.0005"/>
						</td>
						<td class="layertdleft100">工商注册号：</td>
						<td class="layerright"><input name="customerInfo.businessNumber" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">组织机构代码：</td>
						<td class="layerright"><input name="customerInfo.organizationNumber" type="text" class="inputauto" /></td>
						<td class="layertdleft100">法定代表人：</td>
						<td class="layerright"><input name="customerInfo.legalPerson" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">国税登记号：</td>
						<td width="35%" class="layerright"><input id="taxNumberG" name="customerInfo.taxNumberG" type="text" class="inputauto" /></td>
						<td class="layertdleft100">地税登记号：</td>
						<td width="35%" class="layerright"><input id="taxNumberD" name="customerInfo.taxNumberD" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">证件类型：</td>
						<td class="layerright"><dd:select name="customerInfo.documentTypeId" key="crm.0006"/></td>
						<td class="layertdleft100">E-mail：</td>
						<td class="layerright"><input name="customerInfo.regMail" type="text" class="inputauto" /></td>						
					</tr>
					<tr>
						<td class="layertdleft100">证件号：</td>
						<td class="layerright"><input name="customerInfo.documentNumber" type="text" class="inputauto" /></td>
						<td class="layertdleft100">移动电话：</td>
						<td class="layerright"><input name="customerInfo.cellphone" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">注册地址：</td>
						<td class="layerright"><input name="customerInfo.regAddress" type="text" class="inputauto" /></td>
						<td class="layertdleft100">营业截至日期：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="businessExpireDate" readonly="readonly" name="customerInfo.businessExpireDate" type="text" class="inputauto" onclick="showCalendar('businessExpireDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('businessExpireDate');"/></td>
								</tr>
		        			</table>
		        		</td>
					</tr>
				</table>
			</div>
		</div>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_canvassMessage_add")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays" style="margin:0px;">
		    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
				        <td class="layertdleft100" style="white-space:nowrap;">企业实际注资：</td>
				        <td width="35%" class="layerright"><input name="customerInfo.realCapital" type="text" class="inputauto" style="width:100px;" /> 万元</td>
				        <td class="layertdleft100">一般纳税人：</td>
						<td width="35%" class="layerright"><enum:radio checked="NO" styleClass="incubated" name="customerInfo.ybnsr" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">引进时间：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="20px;"><input id="parkTime" readonly="readonly" name="customer.parkTime" type="text" class="inputauto" onclick="showCalendar('parkTime');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('parkTime');"/></td>
								</tr>
		        			</table>
		        		</td>
		        		<td class="layertdleft100">自营进出口权：</td>
						<td width="35%" class="layerright"><enum:radio checked="NO" styleClass="incubated" name="customerInfo.zyjck" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">上报类型：</td>
						<td class="layerright"><enum:select id="reportType" name="customer.reportType" type="com.wiiy.crm.preferences.enums.CustomerRouteTypeEnum"/></td>
						<td class="layertdleft100">是否园区内：</td>
						<td width="35%" class="layerright"><enum:radio checked="NO" name="customerInfo.inPark" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">纳税所在地：</td>
						<td width="35%" class="layerright"><dd:select id="taxAddressId" name="customerInfo.taxAddressId" key="crm.0028"/></td>
						<td class="layertdleft100">是否大厦内：</td>
						<td width="35%" class="layerright"><enum:radio checked="NO" name="customerInfo.inBuild" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">股东构成：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;"><textarea id="shareholder" name="customerInfo.shareholder" class="textareaauto" style="height:20px;"></textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">经营地址：</td>
						<td colspan="3" class="layerright" ><textarea name="customerInfo.managerAddress"  class="textareaauto" style="height:20px;"></textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">经营范围：</td>
						<td colspan="3" class="layerright">
						<textarea name="customerInfo.businessScope"  class="textareaauto"  style="height:40px;"></textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_hatchMessage_add")){ flag2++;%>
		<div id="tabswitch" class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>" id="textname">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>孵化日期起：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="20"><input id="incubationStartDate" readonly="readonly" name="incubationInfo.incubationStartDate" type="text" class="inputauto" onclick="showCalendar('incubationStartDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationStartDate');"/></td>
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
									<c:forEach items="${incubationRouteList }" var="route" varStatus="status">
										<tr>
											<td class="layertdleft100">${route.dataValue }：</td>
											<td class="layerright">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><input class="incubationRoute" type="hidden" name="incubationRouteId" value="${route.id }"/><input id="routeTime${status.index }" readonly="readonly" name="incubationRouteTime" type="text" class="data inputauto" onclick="showCalendar('routeTime${status.index }');"/></td>
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
									<td width="20"><input id="incubationEndDate" readonly="readonly" name="incubationInfo.incubationEndDate" type="text" class="inputauto" onclick="showCalendar('incubationEndDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationEndDate');"/></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>入驻场所：</td>
						<td width="35%" class="layerright"><dd:select id="incubateConfigId" name="incubationInfo.incubateConfigId" key="crm.0026"/></td>					
					</tr>
					<tr>
						<td class="layertdleft100">孵化面积：</td>
						<td width="35%" class="layerright"><input name="incubationInfo.incubatorAreas"  type="text" class="input100"/>平方米</td>					
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>孵化状态：</td>
						<td width="35%" class="layerright"><input type="hidden" id="statusName" name="incubationInfo.statusName" value=""/><dd:select id="status" key="crm.0025"/><input type="hidden" id="statusId" name="incubationInfo.statusId" value=""/></td>
					</tr>
					<tr>
						<td class="layertdleft100">孵化协议：</td>
						<td class="layerright">
							<table><tr><td><input id="file" type="file" /><input id="agreementDocu" name="incubationInfo.agreementDocu" type="hidden" /></td><td style="padding-left:5px;" id="agreementDocuName"></td></tr></table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_aptitude_add")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="white-space:nowrap;">
					<c:forEach items="${customerQualificationList }" var="customerQualification" varStatus="status">
						<c:if test="${(status.index+2)%2 eq 0}"><tr></c:if>
							<c:if test="${(status.index+1)%2 gt 0}">
								<td class="layertdleft100">${customerQualification.dataValue }：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><input class="customerQualification" type="hidden" name="customerQualificationId" value="${customerQualification.id }"/><input id="custimerQualification${status.index }" readonly="readonly" name="custimerQualificationTime" type="text" class="data inputauto" onclick="showCalendar('custimerQualification${status.index }');"/></td>
											<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('custimerQualification${status.index }');"/></td>
										</tr>	
									</table>
								</td>
							</c:if>
							<c:if test="${(status.index+1)%2 eq 0}">
								<td class="layertdleft100">${customerQualification.dataValue }：</td>
								<td class="layerright">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><input class="customerQualification" type="hidden" name="customerQualificationId" value="${customerQualification.id }"/><input id="customerQualification${status.index }" readonly="readonly" name="custimerQualificationTime" type="text" class="data inputauto" onclick="showCalendar('customerQualification${status.index }');"/></td>
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
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_other_add")){ flag2++;%>
		<div class="basediv tabswitch" style="margin-top:0px;<%if(flag2!=0){ %>display:none;<%} %>">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">公司描述：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;"><textarea name="customerInfo.description"  class="textareaauto" style="height:70px;"></textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright"><textarea name="customerInfo.memo"  class="textareaauto"  style="height:115px;"></textarea></td>
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
	</div>
</form>
</body>
</html>