<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				"propertyFix.reportTime":"required",
				"propertyFix.reporter":"required",
				"propertyFix.methodId":"required",
				"propertyFix.typeId":"required",
				"propertyFix.orgName":"required",
				"propertyFix.reportAddr":"required"
			},
			messages: {
				"propertyFix.reportTime":"请选择报修日期",
				"propertyFix.reporter":"请填写报修人",
				"propertyFix.methodId":"请选择报修方式",
				"propertyFix.typeId":"请选择报修类型",
				"propertyFix.orgName":"请选择报修部门",
				"propertyFix.reportAddr":"请填写报修地点"
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
<div class="basediv">
	<div class="titlebg">报修信息</div>
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">报修日期：</td>
      <td class="layerright" width="150">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td>
	          	<fmt:formatDate value="${result.value.reportTime}" pattern="yyyy-MM-dd"/>  
	         </td>
	        </tr>
      	</table>
      </td>
      <td class="layertdleft100">接待人员：</td>
      <td class="layerright" width="120">${result.value.receiver}</td>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright" width="120">${result.value.phone}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修方式：</td>
      <td class="layerright" >
      	 ${result.value.method.dataValue}
      </td>
      <td class="layertdleft100">报修类型：</td>
      <td class="layerright">
    	  ${result.value.type.dataValue}
      </td>
      <td class="layertdleft100">报修单号：</td>
      <td class="layerright">${result.value.oddNo}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修人：</td>
      <td class="layerright" colspan="5" width="80%">${result.value.reporter}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修部门：</td>
      <td colspan="5"  class="layerright">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="155"><label>
            ${result.value.orgName}
          </label></td>
          <td width="20"></td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">报修地点：</td>
      <td class="layerright" colspan="5" > ${result.value.reportAddr}</td>
    </tr>
    <tr>
      <td class="layertdleft100">报修原因：</td>
      <td colspan="5" class="layerright">
     	 <div  style="height:50px;overflow-x:hidden; overflow-y:auto;">
       		 ${result.value.reportReason}
       	 </div>
     </td>
    </tr>
  </table>
  <c:if test="${result.value.status ne 'UNSTART'}">
   <c:if test="${result.value.status ne 'HANGIN'}">
	<div class="titlebg">
	    处理情况</div>
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">完工日期：</td>
      <td class="layerright" width="150">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td>
	          	  <fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/>
	          </td>
	          <td></td>
	        </tr>
      </table>
     </td>
      <td class="layertdleft100">维修人员：</td>
      <td width="120" class="layerright">
        ${result.value.maintainer}
      </td>
      <td class="layertdleft100">人工费用：</td>
      <td class="layerright" width="120">
       	<fmt:formatNumber value="${result.value.laborCosts}" pattern="#0.00"/>  
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">维修难度：</td>
      <td class="layerright">	
      	${result.value.difficulty.title}
      </td>
      <td class="layertdleft100">满意程度：</td>
      <td class="layerright">
    	  ${result.value.satisficing.title}
	</td>
      <td class="layertdleft100">材料费用：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.materialCosts}" pattern="#0.00"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">处理状态：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">
      		<c:if test="${result.value.status eq 'FINISHED'}">完成</c:if>
      		<c:if test="${result.value.status eq 'HANGUP'}">挂起</c:if>
      </td>
    </tr>
    
    <tr>
      <td class="layertdleft100">维修结果：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">
	       <div style=" vertical-align:middle;height:50px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
	       		${result.value.result}
	       </div>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">整改意见：</td>
      <td colspan="5" class="layerright" style="padding-bottom:2px;">
      	   <div style=" vertical-align:middle;height:40px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
	       		${result.value.rectification}
	       </div>
      </td>
    </tr>
   
  </table>
</div>
</c:if>
</c:if>
</div>
</div>
<div class="hackbox" style="height:5px;"></div>
</body>
</html>
