<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<form action="<%=basePath %>reward!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="350"><input id="customerId" name="reward.customerId" type="hidden" /><input id="customerName" name="customer.name" readonly="readonly" class="inputauto" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,391);"/></td>
            <td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,391);"/></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>奖励类型：</td>
      <td class="layerright"><dd:select name="reward.typeId" key="pb.0012" id="typeId"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>金额：</td>
      <td class="layerright"><input name="reward.bonus" type="text" class="input120" onkeyup="value=value.replace(/[^\d\.]/g,'');"/>(万元)</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>日期：</td>
      <td class="layerright"><table width="92" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="70"><input name="reward.rewardDate" type="text" class="inputauto" id="rewardDate" readonly="readonly" onclick="return showCalendar('rewardDate');"/></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('rewardDate');"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">详细说明：</td>
      <td class="layerright"><label>
      <textarea name="reward.memo"  style="height:80px;" class="textareaauto" id="starttime2322"></textarea>
      </label></td>
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
