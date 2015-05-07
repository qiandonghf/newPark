<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

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
				"complaint.name":"required",
				"complaint.complaintObject":"required",
				"complaint.content":"required"
			},
			messages: {
				"complaint.name":"请填写投诉人",
				"complaint.complaintObject":"请填写投诉对象",
				"complaint.content":"请填写投诉内容"
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
		$("#customerName").val(customer.name);
		$("#customerId").val(customer.id);
	}
	 
</script>
</head>

<body>
<form action="<%=basePath %>complaint!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="complaint.id" value="${result.value.id }"/>
<!--basediv-->
<div class="basediv">
	<div class="titlebg">投诉信息</div>
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉人：</td>
      <td class=""><input name="complaint.name" value="${result.value.name }" type="text" class="input170" /></td>
      <td class="layertdleft100">联系电话：</td>
      <td class=""><input name="complaint.tel" value="${result.value.tel }" type="text" class="input170" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td colspan="5" class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="155"><label>
	            <input id="customerName" type="text" value="${result.value.customer.name }" class="inputauto" />
	            <input id="customerId" name="complaint.customerId" value="${result.value.customerId }" type="hidden"/>
	          </label></td>
	          <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
     </tr>
    <tr>
      <td class="layertdleft100">重要程度：</td>
      <td colspan="5" class="layerright">
      	<enum:radio name="complaint.importance" type="com.wiiy.pb.preferences.enums.ImportanceEnum" checked="result.value.importance" />
      </td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉对象：</td>
      <td colspan="5"><input name="complaint.complaintObject" type="text" class="input170" value="${result.value.complaintObject }" /></td>
    </tr>
  
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉内容：</td>
      <td colspan="5" class="layerright"><label>
        <textarea name="complaint.content" rows="4" class="textareaauto">${result.value.content }</textarea>
      </label></td>
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
