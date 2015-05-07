<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />

<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />

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
			rules: {
				"roomFee.unit":"required",
				"roomFee.amount":"required"
			},
			messages: {
				"roomFee.unit":"请选择费用单位",
				"roomFee.amount":"请填写费用值"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#amount").val() && !checkDoubleValue($("#amount").val())){
					showTip("费用值数据格式不对");
					$("#amount").focus();
					return false;
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        } 
			    });
			}
		});
	}
</script>
</head>

<body style="background: none;">
<form action="<%=basePath %>roomFee!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="roomFee.roomId" value="${id}"/>
<input type="hidden" name="roomFee.id" value="${result.value.id}"/>
	<div class="titlebg">费用信息</div>
	<div class="divlays">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="layertdleft">费用类型：</td>
    <td class="layerright">${name.title}<input name="roomFee.feeType" type="hidden" value="${name}"/></td>
  </tr>
  <tr>
    <td class="layertdleft">费用值：</td>
    <td colspan="3" class="layerright"><input id="amount" name="roomFee.amount" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
  </tr>
  <tr>
    <td class="layertdleft">费用单位：</td>
    <td>
    	&nbsp;<enum:select name="roomFee.unit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum" checked="result.value.unit"/>
    </td>
  </tr>
</table>
	</div>
	<div class="buttondiv" style="border-top:1px solid #ccc; padding-top:5px;">
      <label>
        <input name="Submit" type="submit" class="savebtn" value=""/>
        </label>
      <label>
        <input name="Submit2" type="button" class="cancelbtn" value="" onclick="document.form1.reset();"/>
        </label>
    </div>
</form>
<div class="hackbox"></div>
</div>
</body>
</html>
