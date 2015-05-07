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
				"meterNo":"required",
				"roomMeterFee.ratio":"required",
				"roomMeterFee.type":"required"
			},
			messages: {
				"roomMeterFee.priceType":"请选择价格类型",
				"roomMeterFee.price":"请选择或填写价格",
				"meterNo":"请选择水电表",
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
	
	function setSelectedMeter(meter){
		$("#meterNo").val(meter.orderNo);
		$("#meterId").val(meter.id);
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
<form action="<%=basePath %>roomMeterFee!save.action" method="post" name="form1" id="form1">
<input type="hidden" name="roomMeterFee.meterId" id="meterId" value=""/>
<input type="hidden" name="roomMeterFee.roomId" value="${param.id }"/>
<!--basediv-->
<div class="basediv">
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>水电表：</td>
	      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tbody>
	          <tr>
	            <td><input type="text" id="meterNo" name="meterNo"  class="inputauto" onclick="fbStart('选择水电表','<%=basePath%>web/property/meter_select2.jsp',520,420);"/></td> 
	            <td width="25" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择水电表','<%=basePath%>web/property/meter_select2.jsp',520,420);" /></td>
	          </tr>
	        </tbody>
	      </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>价格：</td>
        <td class="layerright">
        <input name="price" type="radio" value="1" onclick="checkradio();" checked="checked"/>
			统一&nbsp;&nbsp;&nbsp;
		<input name="price" type="radio" value="2" onclick="checkradio();" />
			<input id="priceType" type="hidden" name="roomMeterFee.priceType" value="UNIFY"/>
			自定义 <input id="fee" name="roomMeterFee.price" value="" type="text" class="inputauto" style="width:50px;" disabled="disabled" /></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>是否公摊：</td>
        <td class="layerright">
      		<enum:radio name="roomMeterFee.share" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO" />
	  	</td>
      </tr>
       
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>系数：</td>
        <td class="layerright"><input name="roomMeterFee.ratio" type="text" class="inputauto" style="width:100px;" />&nbsp;%</td>
      </tr>
      
      <tr>
       <td class="layertdleft100"><span class="psred">*</span>费用类型：</td>
        <td class="layerright">
      		<enum:select name="roomMeterFee.type" type="com.wiiy.pb.preferences.enums.MeterTypeEnum"/>
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
