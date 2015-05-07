<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

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
				"roomMeterFee.priceType":"required",
				"roomMeterFee.price":"required",
				"roomMeterFee.ratio":"required",
				"roomMeterFee.type":"required"
			},
			messages: {
				"roomMeterFee.priceType":"请选择价格类型",
				"roomMeterFee.price":"请选择或填写价格",
				"roomMeterFee.ratio":"请填写系数",
				"roomMeterFee.type":"请选择费用类型"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#fee").val()!=""){
					if(!checkDouble('fee','价格')){
						return false;
					}
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().frames[0].reloadList();fb.end();",2000);
			        	}
			        } 
			    });
			}
		});
	}
	
	function checkradio(){ 
		var item = $(":checked");
		var len=item.length; 
		if(len>0){ 
		 if($(":radio:checked").val()==2){
		 	$("#fee").attr("disabled",false);
		 	$("#priceType").val("CUSTOMIZE");
		 }else if($(":radio:checked").val()==1){
		 	$("#fee").attr("disabled",true);
		 	$("#fee").val("");
		 	$("#priceType").val("UNIFY");
		 }
		} 
	} 
</script>
</head>
<body>
<form action="<%=basePath %>roomMeterFee!update.action" method="post" name="form1" id="form1">
<input type="hidden" value="${roomMeterFee.id }" name="roomMeterFee.id"/>
<!--basediv-->
<div class="basediv">
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">水电表：</td>
	      <td class="layerright">
	      	${roomMeterFee.meter.orderNo }
	      </td>
      </tr>
      <tr>
        <td class="layertdleft100">价格：</td>
        <td class="layerright">
        <input name="price" type="radio" value="1" onclick="checkradio();" <c:if test="${roomMeterFee.priceType == 'UNIFY' }"> checked="checked"</c:if>/>
			统一&nbsp;&nbsp;&nbsp;
		<input name="price" type="radio" value="2" onclick="checkradio();" <c:if test="${roomMeterFee.priceType == 'CUSTOMIZE' }"> checked="checked"</c:if>/>
			<input id="priceType" type="hidden" name="roomMeterFee.priceType" value="${roomMeterFee.priceType }"/>
			自定义 <input id="fee" name="roomMeterFee.price" value="${roomMeterFee.price }" type="text" class="inputauto" style="width:50px;" disabled="disabled" /></td>
      </tr>
      <tr>
        <td class="layertdleft100">是否公摊：</td>
        <td class="layerright">
      		<enum:radio name="roomMeterFee.share" checked="roomMeterFee.share" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO" />
	  	</td>
      </tr>
       
      <tr>
        <td class="layertdleft100">系数：</td>
        <td class="layerright"><input name="roomMeterFee.ratio" value="${roomMeterFee.ratio }" type="text" class="inputauto" style="width:100px;" />&nbsp;%</td>
      </tr>
      
      <tr>
       <td class="layertdleft100">费用类型：</td>
        <td class="layerright">
      		<enum:select name="roomMeterFee.type" checked="roomMeterFee.type" type="com.wiiy.pb.preferences.enums.MeterTypeEnum"/>
	  	</td>
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
