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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initForm();
	});

	function initForm(){
		$("#form1").validate({
			rules: {
				"patent.name":"required",
				"patent.stateId":"required"
			},
			messages: {
				"patent.name":"请输入专利名称",
				"patent.stateId":"请选择专利状态"
				
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if(notNull("applyTime","专利申请日期") && notNull("buyTime","授权购买日期")){
					if($("#buyTime").val()<$("#applyTime").val()){
						showTip("授权购买日期不能小于专利申请日期",5000);
						return;
					}
				}
				if(notNull("expireTime","专利失效日期") && notNull("buyTime","授权购买日期")){
					if($("#expireTime").val()<$("#buyTime").val()){
						showTip("专利失效日期不能小于授权购买日期",5000);
						return;
					}
				}
				if(notNull("applyTime","专利申请日期") && notNull("expireTime","专利失效日期")){
					if($("#expireTime").val()<$("#applyTime").val()){
						showTip("专利失效日期不能小于专利申请日期",5000);
						return;
					}
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadList('patent');parent.fb.end();", 2000);
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
<form action="<%=basePath %>patent!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
	      <td class="layertdleft100">企业名称：</td>
	      <td class="layerright">${result.value.name}<input id="customerId" name="patent.customerId" type="hidden" value="${result.value.id}"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>专利名称：</td>
      <td width="35%" class="layerright"><input name="patent.name" type="text" class="inputauto" id="name" /></td>
      <td class="layertdleft100">专利申请人：</td>
      <td colspan="3" class="layerright"><label>
      <input name="patent.appler" type="text" class="inputauto" id="appler" />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">专利号：</td>
      <td class="layerright"><input name="patent.serialNo" type="text" class="inputauto" id="serialNo" /></td>
      <td class="layertdleft100">专利申请日期：</td>
      <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input name="patent.applyTime" readonly="readonly" type="text" class="inputauto" id="applyTime" onclick="return showCalendar('applyTime');" /></td>
          <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('applyTime');" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">专利类型：</td>
       <td class="layerright">
      	<dd:select id="type" name="patent.typeId" key="crm.0010"/>
     </td>
      <td class="layertdleft100">专利来源：</td>
      <td class="layerright">
      	<dd:select id="source" name="patent.sourceId" key="crm.0012"/>
     </td>
    </tr>
    <tr>
      <td class="layertdleft100">授权购买日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input name="patent.buyTime" readonly="readonly" type="text" class="inputauto" id="buyTime" onclick="return showCalendar('buyTime');"  /></td>
          <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('buyTime');" /></td>
        </tr>
      </table></td>
      <td class="layertdleft100">专利失效日期：</td>
      <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input name="patent.expireTime" readonly="readonly" type="text" class="inputauto" id="expireTime" onclick="return showCalendar('expireTime');" /></td>
          <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('expireTime');"/></td>
        </tr>
      </table></td>
    </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>专利状态：</td>
      <td class="layerright">
      	<dd:select id="state" name="patent.stateId" key="crm.0011"/>
   	  </td>
      <td class="layertdleft100">发布到网站：</td>
      <td class="layerright">
	      <enum:radio name="patent.pub" type="com.wiiy.commons.preferences.enums.BooleanEnum" defaultValue="NO"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">专利摘要：</td>
      <td colspan="3" class="layerright"><textarea id="summery" name="patent.summery"  class="textareaauto" style="height:70px;"></textarea></td>
    </tr>
  </table>
</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value=""/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
