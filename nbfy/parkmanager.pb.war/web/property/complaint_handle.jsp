<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				"complaint.status":"required",
				"complaint.accepter":"required"
			},
			messages: {
				"complaint.status":"请选择受理状态",
				"complaint.accepter":"请填写受理人"
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
</script>
</head>

<body>
<form action="<%=basePath %>complaint!update.action" method="post" name="form1" id="form1">
<input type="hidden" value="${result.value.id }" name="complaint.id"/>
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">投诉信息</div>
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉人：</td>
      <td class="layerright" width="180">${result.value.name }</td>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright">${result.value.tel }</td>
    </tr>
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td colspan="3" class="layerright">${result.value.customer.name }</td>
      </tr>
    <tr>
      <td class="layertdleft100">重要程度：</td>
      <td colspan="5" class="layerright">${result.value.importance.title }</td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉对象：</td>
      <td colspan="5" class="layerright">${result.value.complaintObject }</td>
    </tr>
  
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>投诉内容：</td>
      <td colspan="5" class="layerright"><label>
        ${result.value.content }
      </label></td>
    </tr>
  </table>
</div>
	<div class="hackbox"></div>
</div>
<div class="basediv">
	<div class="titlebg">
    处理结果</div>
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>受理状态：</td>
      <td class="layerright" style="padding-bottom:2px;">
		<enum:radio name="complaint.status" type="com.wiiy.pb.preferences.enums.ComplaintAcceptStatusEnum" checked="result.value.status" />
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>受理人：</td>
      <td class="layerright" style="padding-bottom:2px;"><input name="complaint.accepter" value="${result.value.accepter }" type="text" class="input170" style="margin:0;" /></td>
      </tr>
    <tr>
      <td class="layertdleft100">处理结果：</td>
      <td class="layerright" style="padding-bottom:2px;"><textarea name="complaint.result" style="height:50px;" class="textareaauto">${result.value.result }</textarea></td>
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
