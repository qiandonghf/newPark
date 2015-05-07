<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<form action="" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
  <!--divlays-->
  <div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">姓名：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
            <search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
            <td>&nbsp;</td>
          </tr>
        </table>          <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">企业名称：</td>
            <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
           <search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" /></td>
            <td>&nbsp;</td>
          </tr>
        </table>          <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">联系电话：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
			<search:input id="phone" dataType="string" field="phone" op="cn" inputClass="inputauto"/>
			</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
	  <tr>
	    <td class="layertdleft100">毕业学校</td>
	    <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
            	<search:input id="studySchool" dataType="string" field="studySchool" op="cn" inputClass="inputauto"/>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
	    </tr>
	  <tr>
        <td class="layertdleft100">职位：</td>
        <td class="layerright">
		<search:choose dataType="string" field="positionId" op="eq">
     		<dd:select styleClass="data" key="crm.0014" />
		</search:choose>
		</td>
      </tr>
      <tr>
        <td class="layertdleft100">E-mail：</td>
        <td class="layerright">
		<search:input id="email" dataType="string" field="email" op="cn" inputClass="inputauto"/>
		</td>
      </tr>
      <tr>
        <td class="layertdleft100">学位：</td>
        <td class="layerright">
		<search:choose dataType="string" field="degreeId" op="eq">
     		<dd:select styleClass="data" key="crm.0015" />
		</search:choose>
		</td>
      </tr>
     
      <tr>
        <td class="layertdleft100">是否法人：</td>
        <td colspan="3" class="layerright">
        <search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="legal" op="eq">
			<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
		</search:choose>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">是否股东：</td>
        <td colspan="3" class="layerright">
        <search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="stockHolder" op="eq">
			<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
		</search:choose>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">是否留学员：</td>
        <td colspan="3" class="layerright">
        <search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="studyAbroad" op="eq">
			<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
		</search:choose>
        </td>
      </tr>
    </table>
  </div>
  <!--//divlays-->
  <div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv--><!--//basediv-->
<!--basediv--><!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="button" class="search_cx" onclick="search()" />
  </label>
  <label><input name="Submit2" type="button" class="cancelbtn" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
