<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body style=" background:#fff">
<div class="basediv">
  <div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    	<tr>
        <td class="layertdleft100">状态：</td>
        <td class="layerright">
        	<search:choose dataType="com.wiiy.pb.preferences.enums.RoomStatusEnum" field="status" op="eq">
           		 	<enum:select type="com.wiiy.pb.preferences.enums.RoomStatusEnum" styleClass="data"/>
           	</search:choose>
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">房间：</td>
        <td class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="10">
          		<tr>
            		<td width="310">
            			<search:input dataType="string" field="name" op="cn" inputClass="inputauto"/>
            		</td>
            		<td>&nbsp;</td>
          		</tr>
       		</table> 
       		<label></label>
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">所在楼宇：</td>
        <td class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="10">
          		<tr>
            		<td width="310">
            			<search:input dataType="string" field="building.name" op="cn" inputClass="inputauto"/>
            		</td>
            		<td>&nbsp;</td>
          		</tr>
       		</table> 
       		<label></label>
       	</td>
      </tr>
        <tr>
        <td class="layertdleft100">楼层：</td>
        <td class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="10">
          		<tr>
            		<td width="310">
            			<search:input dataType="string" field="floor.name" op="cn" inputClass="inputauto"/>
            		</td>
            		<td>&nbsp;</td>
          		</tr>
       		</table> 
       		<label></label>
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">建筑面积：</td>
        <td class="layerright">
        	<table width="100%" border="0" cellspacing="0" cellpadding="10">
          		<tr>
            		<td width="310">
            			<search:choose dataType="java.math.BigDecimal" field="buildingArea" op="eq">
							<input class="data inputauto" id="buildingArea"/>
						</search:choose>
            		</td>
            		<td>&nbsp;</td>
          		</tr>
       		</table> 
       		<label></label>
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">企业名称：</td>
        <td class="layerright">
	        <table border="0" cellspacing="0" cellpadding="0">
	          	<tr>
	            	<td width="310">
	            		 <search:input  dataType="string" field="customerName" op="cn" inputClass="inputauto" />
	            	</td>
	          	</tr>
	        </table>
        </td>
      </tr>
       <tr>
        <td class="layertdleft100">合同到期：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
          <tr>
            <td width="310"><table width="100%" border="0" cellspacing="0" cellpadding="10">
				<tr>
					<td width="120">
						<search:choose dataType="java.util.Date" field="endDate" op="eq">
							<input class="data inputauto" id="endDate" onclick="return showCalendar('endDate')"/>
						</search:choose>
					</td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('endDate')"/></td>
					<td align="center">&nbsp;</td>
				</tr>
			</table></td>
            <td>&nbsp;</td>
          </tr>
        </table>
        <label></label></td>
      </tr>
      <tr>
        <td class="layertdleft100">优惠率：</td>
        <td class="layerright">
	        <table border="0" cellspacing="0" cellpadding="0">
	          	<tr>
	            	<td width="310">
	            		 <search:input  dataType="string" field="discountRate" op="cn" inputClass="inputauto" />
	            	</td>
	          	</tr>
	        </table>
        </td>
      </tr>
	  <tr>
        <td class="layertdleft100">房间位置：</td>
        <td class="layerright">
	        <table border="0" cellspacing="0" cellpadding="0">
	          	<tr>
	            	<td width="310">
	            		 <search:input  dataType="string" field="location" op="cn" inputClass="inputauto" />
	            	</td>
	          	</tr>
	        </table>
        </td>
      </tr>
    </table>
  </div>
  <div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="search_cx" value="" onclick="search()"/>
  </label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
