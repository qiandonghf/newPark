<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript">

	function submitSelectedCar(){
		var licenseNo = $("input[name='radiobutton']:checked").val();
		try{
			if(typeof(getOpener().eval("setSelectedCar")) == "function"){
				getOpener().setSelectedCar(licenseNo);
			} 
		} catch(e){}
		fb.end();
	}	
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
<!--basediv-->
<div class="basediv">
<!--listdiv-->
<div class="listdiv" style="height:200px;">
  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="36" class="tdleftc"><label>&nbsp; </label></td>
      <td width="130" class="tdcenter">车辆车牌号</td>
      <td width="220" class="tdrightc">厂家型号</td>
    </tr>
	</table>
	<div style="overflow-x:hidden; overflow-y:auto; height:177px; cursor:pointer;">
	<table id="list" width="100%"  border="0" cellspacing="0" cellpadding="0"> 
	
		<c:forEach items="${carList}" var="car">
		    <tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
		      <td width="35" class="centertd">
		    	  <input id="radio" type="radio" name="radiobutton" value="${car.licenseNo}|${car.id}" />
		    	  <input id="id" name="car.id" value="${car.id}" type="hidden"/>
		      </td>
		      <td width="160" class="centertd">${car.licenseNo}</td>
		      <td width="220" class="centertd">${car.factoryModel}</td>
		    </tr>
	    </c:forEach>
  </table>
  </div>
</div>
<!--listdiv-->

</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="button" class="rightbtn" value="" onclick="submitSelectedCar()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
