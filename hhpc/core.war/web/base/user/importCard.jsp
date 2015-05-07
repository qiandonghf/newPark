<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script>
$(document).ready(function() {
	initTip();
});
function doImportCard() {
	if (trim($("#groupName").val()) == "") {
		showTip("名称不能为空", 1000);
		return;
	}
	getOpener().importCardWithGroup($("#groupName").val());
	fb.end();
}
</script>
</head>

<body>
<form id="importCardForm" name="importCardForm" method="post" action="">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft">名称：</td>
      <td class="layerright"><label>
        <input id="groupName" name="groupName" type="text" class="inputauto" />
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
  <label>
  <input name="Submit" type="button" class="savebtn" value="" onclick="doImportCard()"/>
  </label>
  <input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/>
</div>
</form>
</body>
</html>
