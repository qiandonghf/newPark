<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
				"brand.customer.name":"required",
				"brand.name":"required",
				"brand.brandNo":"required",
				"brand.register":"required",
				"brand.startDate":"required",
				"brand.endDate":"required",
				"brand.grantDate":"required"
			},
			messages: {
				"brand.customer.name":"请选择企业",
				"brand.name":"请填写商标名称",
				"brand.brandNo":"请填写商标编号",
				"brand.register":"请填写注册人",
				"brand.startDate":"请选择注册有效开始日期",
				"brand.endDate":"请选择注册有效结束日期",
				"brand.grantDate":"请选择授权日期"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#startDate").val()>$("#endDate").val()){
					showTip("结束日期必须大于开始日期",2000);
					return;
				}
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
<form action="<%=basePath %>brand!update.action" method="post" name="form1" id="form1">
<input type="hidden" value="${result.value.id}" name="brand.id"/>
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
            <td width="350"><input id="customerId" name="brand.customerId" type="hidden" /><input id="customerName" name="brand.customer.name"  value="${result.value.customer.name}"  readonly="readonly" class="inputauto" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,391);"/></td>
            <td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,391);"/></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>商标名称：</td>
      <td class="layerright"><input name="brand.name" type="text" class="input120" value="${result.value.name}"/>  </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>商标编号：</td>
      <td class="layerright"><input name="brand.brandNo" type="text" class="input120" value="${result.value.brandNo}"/>  </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>注册人：</td>
      <td class="layerright"><input name="brand.register" type="text" class="input120" value="${result.value.register}"/>  </td>
    </tr>
	<tr>
      <td class="layertdleft100">注册地址：</td>
      <td class="layerright"><input name="brand.registerAddress" type="text" class="inputauto" value="${result.value.registerAddress}"/></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>注册有效期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10" style="table-layout:fixed;">
          <tbody><tr>
            <td width="70"><input id="startDate" name="brand.startDate" type="text" readonly="readonly" class="inputauto" onclick="return showCalendar('startDate');" value="<fmt:formatDate value='${result.value.startDate}' pattern='yyyy-MM-dd'/>" /></td>
            <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('startDate');"/></td>
            <td width="10" align="center">-</td>
            <td width="70" align="center"><input id="endDate" name="brand.endDate"  readonly="readonly" type="text" class="inputauto" onclick="return showCalendar('endDate');" value="<fmt:formatDate value='${result.value.endDate}' pattern='yyyy-MM-dd'/>" /></td>
            <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('endDate');"/></td>
            <td align="center">&nbsp;</td>
          </tr>
        </tbody></table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>授权日期：</td>
      <td class="layerright"><table width="92" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="70"><input name="brand.grantDate" type="text" readonly="readonly" class="inputauto" id="grantDate" onclick="return showCalendar('grantDate');" value="<fmt:formatDate value='${result.value.grantDate}' pattern='yyyy-MM-dd'/>" /></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('grantDate');"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">详细说明：</td>
      <td class="layerright"><label>
      <textarea name="brand.memo"  style="height:80px;" class="textareaauto">${result.value.memo}</textarea>
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
