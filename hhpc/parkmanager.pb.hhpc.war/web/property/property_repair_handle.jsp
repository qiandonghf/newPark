<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.pb.preferences.enums.PropertyFixStatusEnum"%>
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
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initForm();
	});
	
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"propertyFix.finishTime":"required",
				"propertyFix.status":"required",
				"propertyFix.result":"required",
				"propertyFix.laborCosts":"number",
				"propertyFix.materialCosts":"number"
			},
			messages: {
				"propertyFix.finishTime":"请选择完工日期",
				"propertyFix.status":"请选择处理状态",
				"propertyFix.result":"请填写维修结果",
				"propertyFix.laborCosts":"请正确填写人工费用",
				"propertyFix.materialCosts":"请正确填写材料费用"
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
	
	 function setSelectedOrg(selectedOrg) {
     	$("#orgId").val(selectedOrg.id);
     	$("#orgName").val(selectedOrg.name);
     }
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>propertyFix!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">报修信息</div>
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">报修日期：</td>
      <td class="layerright" width="150">
          	<input name="propertyFix.id" value="${result.value.id}" type="hidden"/>
          	<input id="reportTime"  name="propertyFix.reportTime" value="<fmt:formatDate value="${result.value.reportTime}" pattern="yyyy-MM-dd"/>" type="hidden" class="input100" />
          	<fmt:formatDate value="${result.value.reportTime}" pattern="yyyy-MM-dd"/>
      </td>
      <td class="layertdleft100">接待人员：</td>
      <td class="layerright" width="150"><input name="propertyFix.receiver"  type="hidden" class="input100" value="${result.value.receiver}"/>${result.value.receiver}</td>
	  <td class="layertdleft100">联系电话：</td>
      <td class="layerright"><input name="propertyFix.phone" type="hidden" class="input170" value="${result.value.phone}"/>${result.value.phone}</td>
      
    </tr>
    <tr>
      <td class="layertdleft100">报修方式：</td>
      <td class="layerright">
     	 <input name="propertyFix.methodId" type="hidden"  class="input100" value="${result.value.methodId}"/>${result.value.method.dataValue}
      </td>
      <td class="layertdleft100">报修类型：</td>
      <td class="layerright">
    	   <input name="propertyFix.typeId" type="hidden" class="input100" value="${result.value.typeId}"/>${result.value.type.dataValue}
      </td>
      <td class="layertdleft100">报修单号：</td>
      <td class="layerright"><input name="propertyFix.oddNo" type="hidden" class="input100" value="${result.value.oddNo}"/>${result.value.oddNo}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修人：</td>
      <td class="layerright">
      	<input name="propertyFix.reporter" type="hidden"  class="input100" value="${result.value.reporter}"/>${result.value.reporter}
      	 <input id="customerId" name="propertyFix.customerId" type="hidden" value="${result.value.customerId}"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">报修部门：</td>
      <td colspan="5" class="layerright">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="155"><label>
            <input id="orgName" name="propertyFix.orgName" type="hidden" value="${result.value.orgName}" class="inputauto" />${result.value.orgName}
            <input id="orgId" type="hidden" name="propertyFix.orgId" value="${result.value.orgId}"/>
          </label></td>
          <td width="20"></td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">报修地点：</td>
      <td class="layerright"><input name="propertyFix.reportAddr" type="hidden" class="input170" value="${result.value.reportAddr}"/>${result.value.reportAddr}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修原因：</td>
      <td colspan="5" class="layerright"> 
      	 <div style=" vertical-align:middle;  padding:5px; overflow-x:hidden; overflow-y:auto;">
       		 ${result.value.reportReason}
       		 <input type="hidden" value="${result.value.reportReason}" name="propertyFix.reportReason"/>
       	 </div>
      </td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">
	    处理情况</div>
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>完工日期：</td>
      <td class="layerright" width="150">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="50"><input readonly="readonly" id="finishTime" name="propertyFix.finishTime" value="<fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/>" 
	          	type="text" class="input100" onclick="return showCalendar('finishTime', 'y-mm-dd');"/></td>
	          <td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('finishTime', 'y-mm-dd');"/></td>
	        </tr>
	      </table>
      </td>
      <td class="layertdleft100">维修人员：</td>
      <td><span class="layerright">
        <input name="propertyFix.maintainer" type="text" class="input100" value="${result.value.maintainer}"/>
      </span></td>
      <td class="layertdleft100">人工费用：</td>
      <td class="layerright">
        <input name="propertyFix.laborCosts" type="text" class="input100" value="<fmt:formatNumber value="${result.value.laborCosts}" pattern="#0.00"/>"/>     </td>
    </tr>
    <tr>
      <td class="layertdleft100">维修难度：</td>
      <td class="layerright">	
      	<enum:select type="com.wiiy.pb.preferences.enums.FixDifficultyEnum" 
							     name="propertyFix.difficulty" styleClass="incubated" checked="result.value.difficulty"/>
      </td>
      <td class="layertdleft100">满意程度：</td>
      <td class="layerright">
    	  <enum:select type="com.wiiy.pb.preferences.enums.SatisficingEnum" 
							     name="propertyFix.satisficing" styleClass="incubated" checked="result.value.satisficing"/>
	</td>
      <td class="layertdleft100">材料费用：</td>
      <td class="layerright"><input name="propertyFix.materialCosts" type="text" class="input100" value="<fmt:formatNumber value="${result.value.materialCosts}" pattern="#0.00"/>"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>处理状态：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">
      		<input type="radio" value="<%=PropertyFixStatusEnum.FINISHED%>" <c:if test="${result.value.status eq 'FINISHED'}">checked="checked"</c:if> name="propertyFix.status"/>&nbsp;完成
      		<input type="radio" value="<%=PropertyFixStatusEnum.HANGUP%>" <c:if test="${result.value.status eq 'HANGUP'}">checked="checked"</c:if> name="propertyFix.status"/>&nbsp;挂起
      </td>
    </tr>
    
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维修结果：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;"><textarea style="height:50px;" name="propertyFix.result"  class="textareaauto">${result.value.result}</textarea></td>
    </tr>
    <tr>
      <td class="layertdleft100">整改意见：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;"><label>
        <textarea name="propertyFix.rectification" style="height:40px;" class="textareaauto">${result.value.rectification}</textarea>
      </label></td>
    </tr>
   
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
