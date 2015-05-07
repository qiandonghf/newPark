<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css"/>

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
			'formData'			: {'module':'pb','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeTimeout'		: uploadify.removeTimeout, //上传完成移除出队列 默认true
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response) {//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
				$("#photosList").append($("<td></td>").append($("<input type='hidden' class='photo' value='"+$.parseJSON(data).path+"'/>")).append("<img src='core/resources/"+$.parseJSON(data).path+"' width='50' height='50' class='productimg' />"));
				$("#photosList").append($("<td></td>",{valign:"bottom"}).append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
					$(this).parent().prev().remove();
					$(this).parent().remove();
					$.post("<%=BaseAction.rootLocation %>/core/resources/"+$.parseJSON(data).path+"-d");
					checkPhotosDisplay();
				}})));
				checkPhotosDisplay();
			}
		});
	}
	function checkPhotosDisplay(){
		if($("#photosList").children().size()==0){
			$("#photosTr").hide();
			fb.resize();
		} else if($("#photosTr").is(":hidden")){
			$("#photosTr").show();
			fb.resize();
		}
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"facility.name":{
					required: true,
					word: true,
					maxlength: 50,
					minlength: 2
				},
				"facility.parkId":"required",
				"facility.price":"positivenumber",
				"facility.status":"required"
			},
			messages: {
				"facility.name":{
					required: "请输入名称",
					minlength: $.format("姓名不能少于{0}个字符"),
					maxlength: $.format("姓名不能多于{0}个字符")
				},
				"facility.parkId":"请选择园区",
				"facility.price":"请输入正确的单价",
				"facility.status":"请选择状态"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($(".bcharge:checked").val()=='YES'){
					if(checkSelect("checkType","结算类型") && checkSelect("billingMethod","计费类型") && notNull("price","单价")){
						toSubmit(form);
					}
				} else {
					toSubmit(form);
				}
				
			}
		});
	}
	function toSubmit(form){
		var photos = "";
		$(".photo").each(function(){
			photos += $(this).val()+",";
		});
		deleteLastCharWhenMatching(photos,",");
		$("#photos").val(photos);
		$(form).ajaxSubmit({
	        dataType: 'json',		        
	        success: function(data){
        		showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		getOpener().selectBuilding(data.result.value.id,data.result.value.type);
	        		setTimeout("parent.fb.end();",2000);
	        		//getOpener().initTree();
	        	}
	        } 
	    });
	}
	function loadBuildingByParkId(parkId){
		$.post("<%=basePath%>building!loadBuildingByParkId.action?id="+parkId,function(data){
			if(data.result.success){
				var select = $("#buildingId");
				select.empty();
				select.append($("<option></option>",{value:""}).append("----请选择----"));
				for(var i = 0; i < data.result.value.length; i++){
					var building = data.result.value[i];
					select.append($("<option></option>",{value:building.id}).append(building.name));
				}
			}
		});
	}
</script>
</head>

<body>
<form action="<%=basePath %>facility!save.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${type}" name="facility.type"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>设施名称：</td>
					<td colspan="3" class="layerright"><input name="facility.name" type="text" class="inputauto" /></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>园区：</td>
					<td class="layerright">
						<select onchange="loadBuildingByParkId(this.value)" name="facility.parkId">
							<option value="">----请选择----</option>
							<c:forEach items="${parkList}" var="park">
								<option value="${park.id}">${park.name}</option>
							</c:forEach>
						</select>
					</td>
					<td class="layertdleft100">楼宇：</td>
					<td class="layerright"><select id="buildingId" name="facility.buildingId"><option value="">----请选择----</option></select></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>状态：</td>
					<td class="layerright"><enum:select name="facility.status" type="com.wiiy.pb.preferences.enums.FacilityStatusEnum"/></td>
					<td class="layertdleft100"><span class="psred">*</span>是否收费：</td>
					<td width="182" class="layerright"><enum:radio styleClass="bcharge" name="facility.bcharge" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>结算类型：</td>
					<td class="layerright"><enum:select id="checkType" name="facility.checkType" type="com.wiiy.pb.preferences.enums.CheckOutTypeEnum"/></td>
					<td class="layertdleft100"><span class="psred">*</span>计费类型：</td>
					<td width="182" class="layerright"><enum:select id="billingMethod" name="facility.billingMethod" type="com.wiiy.pb.preferences.enums.BillingMethodEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>单价：</td>
					<td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td><input id="price" name="facility.price" type="text" class="inputauto" /></td><td width="25" align="center">元</td></tr></table></td>
					<td class="layertdleft100">是否独享资源：</td>
					<td width="182" class="layerright"><enum:radio name="facility.bshare" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">上传图片：</td>
					<td colspan="3" class="layerright"><input id="file" type="file" class="inputauto" /><input id="photos" name="facility.photos" type="hidden" class="inputauto" /></td>
				</tr>
				<tr id="photosTr" style="display: none;">
					<td class="layertdleft100">图片浏览：</td>
					<td colspan="3" class="layerright">
						<div style="width:300px; overflow-x:auto; overflow-y:hidden; height:80px; margin-bottom:2px;">
							<table border="0" cellspacing="0" cellpadding="10">
								<tr id="photosList"></tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">公共设施介绍：</td>
					<td colspan="3" class="layerright"><textarea name="facility.summary" rows="6" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>