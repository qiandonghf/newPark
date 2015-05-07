<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"reward.customer.name":"required",
				"reward.typeId":"required",
				"reward.bonus":"required",
				"reward.rewardDate":"required"
			},
			messages: {
				"reward.customer.name":"请选择企业",
				"reward.typeId":"请选择类型",
				"reward.bonus":"请填写金额",
				"reward.rewardDate":"请选日期"
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
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>
<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td class="layerright">
          ${result.value.customer.name}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">奖励类型：</td>
      <td class="layerright">${result.value.type.dataValue }</td>
    </tr>
    <tr>
      <td class="layertdleft100">金额：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.bonus }" pattern="#0.00"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>日期：</td>
      <td class="layerright"><fmt:formatDate value='${result.value.rewardDate}' pattern='yyyy-MM-dd'/></td>
    </tr>
    <tr>
      <td class="layertdleft100">详细说明：</td>
      <td class="layerright">
           <div style="height:80px;overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
       		 ${result.value.memo}
       	   </div>
     </td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
