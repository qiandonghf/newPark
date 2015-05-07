<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initForm();
		initUploadify("imageUpload");
	});
	
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'oa','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
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
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	
	function onUploadSuccess(file, data, response) {
		$("#photo").val($.parseJSON(data).path);
		$("#car_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
	}
	
	function removeImagery() {
		var userImagery = $("#car_imagery_img").attr("src");
		$("#car_imagery_img").attr("src", userImagery + "-d");
		$("#car_imagery").val("core/common/images/locking.jpg");
		$("#car_imagery_img").attr("src", "core/common/images/nopic.jpg");
	}
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"car.licenseNo":"required",
				"car.status":"required",
				"car.carTypeId":"required"
			},
			messages: {
				"car.licenseNo":"请输入车牌号码",
				"car.status":"请选择车辆状态",
				"car.carTypeId":"请选择车辆类型"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>car!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="layertdleft100"><span class="psred">*</span>车牌号码：</td>
            <td class="layerright"><input name="car.licenseNo" type="text" class="inputauto" value="${result.value.licenseNo}"/></td>
            </tr>
          <tr>
            <td class="layertdleft100"><span class="psred">*</span>状态：</td>
            <td class="layerright">
          		<enum:select type="com.wiiy.oa.preferences.enums.CarStatusEnum" name="car.status" styleClass="incubated" checked="result.value.status"/>  
            </td>
          </tr>
          <tr>
            <td class="layertdleft100"><span class="psred">*</span>车辆类型：</td>
            <td class="layerright">
            	<dd:select id="carTypeId" name="car.carTypeId" key="oa.0001" checked="result.value.carTypeId"/>
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">厂家型号：</td>
            <td class="layerright">
            	<input name="car.factoryModel" type="text" class="inputauto" value="${result.value.factoryModel}"/>
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">发动机号：</td>
            <td class="layerright">
              <input name="car.engineNumber" type="text" class="inputauto" value="${result.value.engineNumber}"/>
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">购买保险日期：</td>
            <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="175"><input id="insuranceDate" name="car.insuranceDate" type="text" class="inputauto" 
                onclick="return showCalendar('insuranceDate', 'y-mm-dd');" value="<fmt:formatDate value="${result.value.insuranceDate}" pattern="yyyy-MM-dd"/>"/></td>
                <td width="20" align="center"><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('insuranceDate', 'y-mm-dd');"/></td>
				<td></td>
              </tr>
            </table></td>
            </tr>
          <tr>
            <td class="layertdleft100">年审日期：</td>
            <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="175"><input id="annualDate" name="car.annualDate" type="text" class="inputauto" 
                onclick="return showCalendar('annualDate', 'y-mm-dd');" value="<fmt:formatDate value="${result.value.annualDate}" pattern="yyyy-MM-dd"/>"/></td>
                <td width="20" align="center"><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('annualDate', 'y-mm-dd');"/></td>
                <td></td>
              </tr>
            </table></td>
          </tr>

      </table></td>
      <td width="260" valign="top"><table style=" padding-top:3px;" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="186">
		            <c:if test="${result.value.photo!=''}">
		           		<img id="car_imagery_img" class="oa_img" src="core/resources/${result.value.photo}" width="180" height="185" />
		           </c:if>
		           <c:if test="${result.value.photo==''}">
		           		<img id="car_imagery_img" class="oa_img" src="core/common/images/nopic.jpg" width="180" height="185" />
		           </c:if>
            </td>
            <td width="15" valign="bottom"><img id="car_imagery" src="core/common/images/locking.jpg" width="15" height="15"  onclick="removeImagery()"/></td>
            <td valign="top">
            	<img id="imageUpload" src="core/common/images/uploadbtn.png" width="47" height="22" />
            	<input id="photo" type="hidden" name="car.photo" value="${result.value.photo}"/>	
            	<input id="id" type="hidden" name="car.id" value="${result.value.id}"/>
           	</td>
          </tr>
      </table></td>
    </tr>
  </table>
  
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">购置日期：</td>
      <td class="layerright" style="width:193px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="175"><input id="buyDate" name="car.buyDate" type="text" class="inputauto" 
          	onclick="return showCalendar('buyDate', 'y-mm-dd');"  value="<fmt:formatDate value="${result.value.buyDate}" pattern="yyyy-MM-dd"/>"/></td>
          <td width="20" align="center"><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('buyDate', 'y-mm-dd');"/></td>
          <td></td>
        </tr>
      </table></td>
      <td class="layertdleft100">驾驶员：</td>
      <td class="layerright"><input name="car.pilot" type="text" class="inputauto" value="${result.value.pilot}"/></td>
    </tr>
  </table>
  
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright">
      	<textarea name="car.memo" rows="5" class="textareaauto" style="width:468px;" >${result.value.memo}</textarea>
      </td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
