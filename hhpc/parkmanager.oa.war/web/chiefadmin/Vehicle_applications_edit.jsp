<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
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
				"carApply.licenseNo":"required",
				"carApply.status":"required",
				"carApply.applyDate":"required",
				"carApply.distance":"number",
				"carApply.oil":"number",
				"carApply.reason":"required"
			},
			messages: {
				"carApply.licenseNo":"请选择车牌号",
				"carApply.status":"请选择审批状态",
				"carApply.applyDate":"请选择申请时间",
				"carApply.distance":"请正确填写里程",
				"carApply.oil":"请正确填写油耗",
				"carApply.reason":"请填写原因"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(notNull("applyDate","申请时间") && notNull("startDate","开始时间")){
					if($("#applyDate").val()>$("#startDate").val()){
						showTip("开始时间不能小于申请时间",2000);
						return;
					}
				}
				if(notNull("startDate","开始时间") && notNull("endDate","结束时间")){
					if($("#startDate").val()>$("#endDate").val()){
						showTip("结束时间不能小于开始时间",5000);
						return;
					}
				}
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
		$("#carLicenseNo").val(licenseNo);
	}
	
	function setSelectedUsers(users){
		var ids = "";
		var names = "";
		for(var i = 0; i < users.length; i++){
			ids += users[i].id+",";
			names += users[i].name+",";
		}
		ids = deleteLastCharWhenMatching(ids,",");
		$("#ids").val(ids);
		names = deleteLastCharWhenMatching(names,",");
		$("#applyer").val(names);
	}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>carApply!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      	<td class="layertdleft100"><span class="psred">*</span>车牌号:</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="146">
          	<input id="id" name="carApply.id" type="hidden" value="${result.value.id}"/>
            <input id="carLicenseNo" name="carApply.licenseNo" value="${result.value.licenseNo}" type="text" class="inputauto" onclick="fbStart('车辆选择','<%=basePath%>car!carSelect.action',400,235);"/>
             <input id="carId" name="carApply.carId" type="hidden" value="${result.value.carId}"/>
          </td>
          <td><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('车辆选择','<%=basePath%>car!carSelect.action',400,235);"/></td>
		  <td></td>
        </tr>
      </table></td>
       </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">用车人：</td>
      <td width="33%" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="193">
          	<input id="applyer" name="carApply.usePersons" value="${result.value.usePersons}" readonly="readonly" type="text" class="inputauto" onclick="fbStart('选择用车人','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);"/></td>
          <td width="20" align="center">
          	<img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择用车人','<%=BaseAction.rootLocation %>/core/user!select2.action',520,400);"/></td>
        </tr>
      </table></td>
      <td class="layertdleft100"><span class="psred">*</span>申请人：</td>
      <td class="layerright">${result.value.creator}
      		<input type="hidden" name="carApply.creator" value="${result.value.creator}"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>审批状态：</td>
      <td class="layerright">
      	${result.value.status.title}  
      </td>
      <td class="layertdleft100"><span class="psred">*</span>申请时间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="120"><input id="applyDate" name="carApply.applyDate" value="<fmt:formatDate value="${result.value.applyDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('applyDate', 'y-mm-dd');"/></td>
           <td width="20" align="center"><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('applyDate', 'y-mm-dd');"/></td>
           <td></td>
         </tr>
       </table></td>
    </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>原因：</td>
      <td class="layerright" style="padding-bottom:2px;"><textarea name="carApply.reason" style="width:418px;"  rows="5" class="textareaauto">${result.value.reason}</textarea></td>
    </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">开始时间： </td>
      <td width="33%"  class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="150"><input id="startDate" name="carApply.startDate" value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('startDate', 'y-mm-dd');"/></td>
            <td><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('startDate', 'y-mm-dd');"/></td>
            <td></td>
          </tr>
        </table></td>
      <td class="layertdleft100">结束时间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="120"><input id="endDate" name="carApply.endDate" value="<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('endDate', 'y-mm-dd');"/></td>
            <td width="20" align="center"><img src="core/common/images/timeico.gif" style="relative; left:-1px;" width="20" height="22" onclick="return showCalendar('endDate', 'y-mm-dd');"/></td>
            <td></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">里程：</td>
      <td width="33%"  class="layerright"><input name="carApply.distance" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.distance}" pattern="#0.00"/>"/></td>
	   <td class="layertdleft100">油耗：</td>
      <td  class="layerright"><input name="carApply.oil" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.oil}" pattern="#0.00"/>"/></td>
    </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">备注：</td>
      <td  class="layerright"><textarea name="carApply.memo"  style="width:418px;" rows="3" class="textareaauto">${result.value.memo}</textarea></td>
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
