<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
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
	});
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"carFix.licenseNo":"required",
				"carFix.fixDate":"required",
				"carFix.carFixTypeId":"required",
				"carFix.reason":"required"
			},
			messages: {
				"carFix.licenseNo":"请选择车牌号",
				"carFix.fixDate":"请选择维护日期",
				"carFix.carFixTypeId":"请选择维修类型",
				"carFix.reason":"请填写维护原因"
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
	
	function setSelectedCar(licenseNo){
		var licenseNo = licenseNo.split('|');
		for(var i=0;i<licenseNo.length;i++){
			$("#carLicenseNo").val(licenseNo[0]);
			$("#carId").val(licenseNo[1]);
		}
	}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>carFix!update.action">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>车牌号：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="153">
          	<input id="id" name="carFix.id" type="hidden" value="${result.value.id}"/>
            <input id="carLicenseNo" name="carFix.licenseNo" value="${result.value.licenseNo}" type="text" class="inputauto" onclick="fbStart('车辆选择','<%=basePath%>car!carSelect.action',400,235);"/>
             <input id="carId" name="carFix.carId" type="hidden" value="${result.value.carId}"/>
          </td>
          <td><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('车辆选择','<%=basePath%>car!carSelect.action',400,235);"/></td>
		  <td></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维护日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        
          <td width="153">
            <input id="fixDate" name="carFix.fixDate" value="<fmt:formatDate value="${result.value.fixDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('fixDate', 'y-mm-dd');"/>
          </td>
          <td><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('fixDate', 'y-mm-dd');"/></td>
          
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100">经办人：</td>
      <td><input name="carFix.operator" type="text" class="input170" value="${result.value.operator}"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维修类型：</td>
      <td class="layerright">
      	<dd:select id="carFixTypeId" name="carFix.carFixTypeId" key="oa.0002" checked="result.value.carFixTypeId"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">费用：</td>
      <td><input name="carFix.fee" type="text" class="input170" value="<fmt:formatNumber value="${result.value.fee}" pattern="#0.00"/>"/> 元</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维护原因：</td>
      <td class="layerright" style="padding-bottom:2px;"><label>
        <textarea name="carFix.reason" rows="5" class="textareaauto">${result.value.reason}</textarea>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright"><label>
        <textarea name="carFix.memo" rows="3" class="textareaauto">${result.value.memo}</textarea>
      </label></td>
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
