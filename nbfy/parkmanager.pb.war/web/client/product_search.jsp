<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body style=" background:#fff">
<!--basediv-->
<div class="basediv">
  <!--divlays-->
  <div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">企业名称：</td>
        <td class="layerright">
        <table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" /></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">产品名称：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">技术领域：</td>
        <td class="layerright">
        <search:choose dataType="string" field="technicId" op="eq">
        		<dd:select styleClass="data" key="crm.0002" />
        	</search:choose>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">产品阶段：</td>
        <td class="layerright">
        <search:choose dataType="string" field="stageId" op="eq">
        	<dd:select styleClass="data" key="crm.0013" />
        	</search:choose>
        </td>
      </tr>
    </table>
  </div>
  <!--//divlays-->
  <div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="search_cx" onclick="search()" />
  </label>
  <label><input name="Submit2" type="button" class="cancelbtn" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
