<%@page import="com.wiiy.pb.entity.MeterLabelRecord"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>报表打印</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.pb/web/style/print.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	function exportData(){
		$("#exportDataFrame").attr("src", "<%=basePath%>selfLabelRecord!export.action?lableType=${lableType}&labelId=${labelId}");
	}
</script>
</head>

<body>
<iframe id="exportDataFrame" src="about:blank" style="display:none" width="0px" height="0px"></iframe>
<div class="tablediv">
	<!--tabletitle-->
	<div class="tabletitle"><span>日期：<fmt:formatDate value="<%=new Date()%>"/>  </span>
	${labelName}(<c:if test="${lableType eq 'WATER'}">水表</c:if><c:if test="${lableType eq 'ELECTRICITY'}">电表</c:if><c:if test="${lableType eq 'GAS'}">气表</c:if>)</div>
	<!--//tabletitle-->
  <table border="0" cellpadding="0" cellspacing="0" class="table">
      <tr>
        <td width="40" rowspan="2" >序号</td>
        <td width="80" rowspan="2" >表編号</td>
        <td width="120" rowspan="2" >单位名称</td>
        <td width="40" height="20" rowspan="2">倍数</td>
        <td width="80" height="20" rowspan="2">上期数读(度)</td>
        <td width="80" height="20" rowspan="2">上期抄表时间</td>
        <td width="80" height="20" rowspan="2">本期数读(度)</td>
        <td width="80" height="20" rowspan="2">本期抄表时间</td>
        <td rowspan="2" width="200">备注</td>
      </tr>
      <tr>
      </tr>
      <c:forEach items="${selfLabelRecordList}" var="list" varStatus="status">
	      <tr>
	        <td height="25">${status.index+1}</td>
	        <td>${list.meterOrderNo}</td>
	        <td>${list.buildingName}</td>
	        <td>${list.meterFactor}</td>
	        <td>${list.preReading}</td>
	        <td><fmt:formatDate value="${list.preDate}"/>   </td>
	        <td>${list.curReading}</td>
	        <td><fmt:formatDate value="${list.curDate}"/></td>
	        <td>&nbsp;</td>
	      </tr>
      </c:forEach>
     
    </table>
	<div class="tablefooter"><span></span>制表人：<%=PbActivator.getSessionUser(request).getRealName() %></div>
	<div class="buttondiv" style="width:850px;text-align:left; height:29px; width:100%; text-align:center;">
	  	<label>
	  <!-- 	<input name="Submit" type="button" class="allbtn"  value="导出" onclick="exportData();"/> -->
	  	<input name="Submit" type="button" class="allbtn"  value="打印" onclick="window.print();window.opper=null;window.close()"/>
	  	</label>
	</div>
</div>

</body>
</html>

