<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
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
<div class="basediv" style="height:215px; overflow-y:auto; overflow-x:hidden">
  <!--divlays-->
  <div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">项目名称：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
            <td>&nbsp;</td>
          </tr>
        </table>          <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">企业名称：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><search:input  dataType="string" field="customer.name" op="cn" inputClass="inputauto" /></td>
            <td>&nbsp;</td>
          </tr>
        </table>          <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">申报年度：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310">
              <search:choose dataType="int" field="applyYear" op="eq">
		        <select name="projectApply.applyYear" id="applyYear" class="data">
			        <option value="">----请选择----</option>
			        <option value="2011">2011</option>
			        <option value="2012">2012</option>
			        <option value="2013">2013</option>
			        <option value="2014">2014</option>
			        <option value="2015">2015</option>
			        <option value="2016">2016</option>
			        <option value="2017">2017</option>
			        <option value="2018">2018</option>
			        <option value="2019">2019</option>
			        <option value="2020">2020</option>
	            </select>
        	</search:choose>
            </td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">申报类型：</td>
        <td class="layerright">
         <search:choose dataType="string" field="applyTypeId" op="eq">
        		<dd:select styleClass="data" key="crm.0007" />
        	</search:choose>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">申报状态：</td>
        <td class="layerright">
        <search:choose dataType="com.wiiy.crm.preferences.enums.ProjectApplyStatusEnum" field="applyState" op="eq">
      		<enum:select type="com.wiiy.crm.preferences.enums.ProjectApplyStatusEnum" styleClass="data"/>
      	</search:choose>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">是否验收：</td>
        <td class="layerright">
        <search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="checked" op="eq">
			<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
		</search:choose>
        </td>
      </tr>
     
      <tr>
        <td class="layertdleft100">验收日期：</td>
        <td colspan="3" class="layerright">
        <table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="120">
            <search:choose dataType="java.util.Date" field="checkTime" op="ge">
            	<input id="checkTime1" class="data inputauto" readonly="readonly" onclick="return showCalendar('checkTime1')"/>
            </search:choose>
            </td>
            <td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('checkTime');"/></td>
             <td width="10" align="center">-</td>
            <td width="120">
            <search:choose dataType="java.util.Date" field="checkTime" op="le">
            	<input id="checkTime2" class="data inputauto" readonly="readonly" onclick="return showCalendar('checkTime2')"/>
            </search:choose>
            </td>
           
            <td width="20"> <img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('checkTimes');"/></td>
            <td></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">申请金额：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="280"><search:input id="amount" dataType="double" field="amount" op="eq" inputClass="inputauto" />
			</td>
            <td>万元</td>
          </tr>
        </table></td>
      </tr>
      
    </table>
  </div>
  <!--//divlays-->
  <div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="search_cx" onclick="search();"/>
  </label>
  <label><input name="Submit2" type="button" class="cancelbtn" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
