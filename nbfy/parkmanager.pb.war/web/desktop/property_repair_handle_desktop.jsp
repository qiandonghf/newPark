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
			        		setTimeout('parent.fb.end();$(".iframe:eq(2)").load("/parkmanager.pb/propertyFix!workBenchPropertyFixList.action");', 2000);
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
      <td class="layertdleft100">完工日期：</td>
      <td class="layerright" width="150">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="50"><fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/> 
	          </td>
	          
	        </tr>
	      </table>
      </td>
      <td class="layertdleft100">维修人员：</td>
      <td><span class="layerright">
        ${result.value.maintainer}
      </span></td>
      <td class="layertdleft100">人工费用：</td>
      <td class="layerright">
       <fmt:formatNumber value="${result.value.laborCosts}" pattern="#0.00"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">维修难度：</td>
      <td class="layerright">	
      	<c:if test="${ result.value.difficulty eq 'High'}">高</c:if>
      	<c:if test="${ result.value.difficulty eq 'Medium'}">中</c:if>
      	<c:if test="${ result.value.difficulty eq 'Low'}">低</c:if>
      </td>
      <td class="layertdleft100">满意程度：</td>
      <td class="layerright" width="150px">
      <c:if test="${result.value.satisficing eq 'VerySatisfied'}">非常满意</c:if>
      <c:if test="${result.value.satisficing eq 'Satisfied'}">满意</c:if>
      <c:if test="${result.value.satisficing eq 'Dissatisfied'}">不满意</c:if>
      <c:if test="${result.value.satisficing eq 'VeryDissatisfied'}">很不满意</c:if>
    	  
	</td>
      <td class="layertdleft100">材料费用：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.materialCosts}" pattern="#0.00"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">处理状态：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">
      		<c:if test="${result.value.status eq 'FINISHED'}">&nbsp;完成</c:if> 
      		<c:if test="${result.value.status eq 'HANGUP'}">&nbsp;挂起</c:if> 
      </td>
    </tr>
    
    <tr>
      <td class="layertdleft100">维修结果：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">${result.value.result}</td>
    </tr>
    <tr>
      <td class="layertdleft100">整改意见：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;"><label>
        ${result.value.rectification}
      </label></td>
    </tr>
   
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="buttondiv">
  
  </div>
</form>
</body>
</html>
