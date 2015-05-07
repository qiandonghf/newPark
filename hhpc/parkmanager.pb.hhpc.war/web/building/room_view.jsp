<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=BaseAction.rootLocation %>/"/>
		<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
		<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
	</head>

	<body style="background:#fff;">
		<div class="pm_msglist">
			<div class="basediv" style="height:182px;">
			<div class="divlays">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  style="white-space:nowrap;">
                      <tr>
                        <td class="layertdleft100">所在园区：</td>
                        <td class="layerright" width="23%">${result.value.building.park.name}</td>
                        <td class="layertdleft100">楼宇名称：</td>
                        <td class="layerright" width="16%">${result.value.building.name}</td>
                        <td class="layertdleft100">性质：</td>
                        <td class="layerright" width="16%">${result.value.kind.dataValue}</td>
                      </tr>
                      <tr>
                        <td class="layertdleft100">所在楼层：</td>
                        <td class="layerright">${result.value.floor.name }</td>
                        <td class="layertdleft100">房间名称：</td>
                        <td class="layerright">${result.value.name }</td>
                        <td class="layertdleft100">状态：</td>
                        <td class="layerright">${result.value.status.title }</td>
                      </tr>
                      <tr>
                        <td class="layertdleft100">用途：</td>
                        <td class="layerright">${result.value.type.dataValue }</td>
                        <td class="layertdleft100">实用面积：</td>
                        <td class="layerright"><fmt:formatNumber value="${result.value.realArea}" pattern="#0.00"/> ㎡</td>
                        <%-- <td class="layertdleft100">优惠说明：</td>
                        <td class="layerright">${result.value.discountRate }</td> --%>
                      	<td class="layertdleft100">预定公司：</td>
                        <td class="layerright">${result.value.reserveCompanyName}</td>
                      </tr>
                      <tr>
                        <td class="layertdleft100">建筑面积：</td>
                        <td class="layerright"><fmt:formatNumber value="${result.value.buildingArea}" pattern="#0.00"/> ㎡</td>
                      	<td class="layertdleft100">位置：</td>
                        <td class="layerright">${result.value.location }</td>
                        <td class="layertdleft100">租金区间：</td>
                        <td class="layerright"><fmt:formatNumber value="${result.value.rentStart}" pattern="#0.00"/> -- <fmt:formatNumber value="${result.value.rentEnd}" pattern="#0.00"/> (元/月/平米)</td>
                      </tr>
                  </table></td>
                </tr>
              </table>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td class="layertdleft100">优惠说明：</td>
                  <td class="layerright" width="85%"><div style="height: 34px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.discountRate }</div></td>
                </tr>
              </table>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td class="layertdleft100">房间介绍：</td>
                  <td class="layerright" width="85%"><div style="height: 34px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.summary }</div></td>
                </tr>
              </table>
			  </div>
			  </div>
	  </div>
	</body>
</html>
