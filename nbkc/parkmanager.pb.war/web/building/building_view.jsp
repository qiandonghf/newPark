<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

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
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery.treeview.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		if($("#photo").val()!=""){
			var img = $("#photo").val();			
			$("#img").append($("<img src='core/resources/"+img+"' width='256' />"));
		}
	});
</script>
</head>
<body>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="100%" valign="top">
			<div class="titlebg">楼宇信息</div>
			<div class="apptab" id="tableid">
				<ul>
				<li class="apptabliover"><a href="<%=basePath%>building!view.action?id=${result.value.id}">基本信息</a></li>
					<li class="apptabli" ><a href="<%=basePath%>floor!floorView.action?id=${result.value.id}">楼层视图</a></li>
					<li class="apptabli" ><a href="<%=basePath%>room!listByBuildingId.action?id=${result.value.id}">房间信息</a></li>
				</ul>
			</div>
<!--基本信息-->

<div class="pm_msglist" style="border-bottom:none;">
	<div class="pm_clientbase">
		<ul>
			<li ><strong class="title">${result.value.name }</strong>
				<%-- <div class="ratiodiv">
					<ul>
						<li>使用率</li>
						<li><div class="ratio"><img src="core/common/images/ratio.png" width="<fmt:formatNumber value="${usageRates}" pattern="#"/>" height="12" /></div></li>
						<li><fmt:formatNumber value="${usageRates}" pattern="#.#"/>%</li>
					</ul>
				</div>
				<div class="ratiodiv">
					<ul>
						<li>出租率</li>
						<li><div class="ratio"><img src="core/common/images/ratio.png" width="<fmt:formatNumber value="${occupancy}" pattern="#"/>" height="12" /></div></li>
						<li><fmt:formatNumber value="${occupancy}" pattern="#.#"/>%</li>
					</ul>
				</div> --%>
			</li>
		</ul>
		<div class="hackbox"></div>
	</div>
	<div class="pm_clientbase">
		<div class="ratiodiv">
			<ul>
				<li>使用率</li>
				<li><div class="ratio"><img src="core/common/images/ratio.png" width="<fmt:formatNumber value="${usageRates}" pattern="#"/>px;" height="12" /></div></li>
				<li><fmt:formatNumber value="${usageRates}" pattern="#.#"/>%</li>
			</ul>
		</div>
		<div class="ratiodiv">
			<ul>
				<li>出租率</li>
				<li><div class="ratio"><img src="core/common/images/ratio.png" width="<fmt:formatNumber value="${occupancy}" pattern="#"/>px;" height="12" /></div></li>
				<li><fmt:formatNumber value="${occupancy}" pattern="#.#"/>%</li>
			</ul>
		</div>
	</div>
	<%-- <div class="pm_clientbasedown">
	<ul>
	<li>入驻企业 （<span class="colorblue">${settledEnterprise}</span>）</li>
	<li>欠费企业（<span class="colorred">5</span>）</li>
	<li style="background:none;">合同到期（<span class="colorred">${finishedContract}</span>）</li>
	</ul>
	</div> --%>
	<div class="hackbox"></div>
</div>
<div class="pm_msglist">
<div class="basediv" style="height:305px; overflow-y:auto; overflow-x:hidden">
  <table width="93%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="layertdleft100">楼宇类型：</td>
          <td class="layerright" width="214">${result.value.type.dataValue}</td>
          <td class="layertdleft100">楼宇性质：</td>
          <td class="layerright">${result.value.kind.dataValue}</td>
        </tr>
        <tr>
          <td class="layertdleft100">建筑面积：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.realArea}" pattern="#0.00"/> ㎡</td>
          <td class="layertdleft100">商务面积：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.commericalArea}" pattern="#0.00"/> ㎡</td>
        </tr>
        <tr>
          <td class="layertdleft100">招商方向：</td>
          <td class="layerright">${result.value.investDirection.dataValue}</td>
          <td class="layertdleft100">租金区间：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.rentBegin}" pattern="#0.00"/>--<fmt:formatNumber value="${result.value.rentEnd}" pattern="#0.00"/> 元/月/平米</td>
        </tr>
        <tr>
          <td class="layertdleft100">物业费区间：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.propertyBegin}" pattern="#0.00"/>--<fmt:formatNumber value="${result.value.propertyEnd}" pattern="#0.00"/> 元/月/平米</td>
          <td class="layertdleft100">竣工日期：</td>
          <td class="layerright"><fmt:formatDate value="${result.value.completeDate }" pattern="yyyy-MM-dd"/></td>
        </tr>
        <tr>
          <td class="layertdleft100">地上停车位：</td>
          <td class="layerright">${result.value.upParkingSpaces } 个</td>
          <td class="layertdleft100">地上车位月租金：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.upParkingFee}" pattern="#0.00"/> 元/月</td>
        </tr>
        <tr>
          <td class="layertdleft100">地下停车位：</td>
          <td class="layerright">${result.value.downParkingSpaces } 个</td>
          <td class="layertdleft100">地下车位月租金：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.downParkingFee}" pattern="#0.00"/> 元/月</td>
        </tr>
        <tr>
          <td class="layertdleft100">客梯数量：</td>
          <td class="layerright">${result.value.passengerElevator } 个</td>
          <td class="layertdleft100">小时停车费：</td>
          <td class="layerright"><fmt:formatNumber value="${result.value.hourParkingFee}" pattern="#0.00"/> 元/小时</td>
        </tr>
        <tr>
          <td class="layertdleft100">联系人：</td>
          <td class="layerright">${result.value.contact }</td>
          <td class="layertdleft100">招商热线：</td>
          <td class="layerright">${result.value.investTel}</td>
        </tr>
 	<tr>
     <td class="layertdleft100">装修情况：</td>
      <td class="layerright" width="214">${result.value.decorationSituation.dataValue}</td>
      <td class="layertdleft100">空调设施：</td>
      <td class="layerright">${result.value.airconSituation.dataValue }</td>
    </tr>
    <tr>
      <td class="layertdleft100">货梯数量：</td>
      <td class="layerright">${result.value.cargoElevator } 个</td>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright">${result.value.tel }</td>
    </tr>
    <tr>
       <td class="layertdleft100">地址：</td>
       <td class="layerright">${result.value.address }</td>
    </tr>
    <tr>
    	<td class="layertdleft100">楼宇介绍：</td>
      	<td class="layerright" colspan="3"><div style="height: 50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.summary }</div></td>
    </tr>
    <tr>
    	<td class="layertdleft100">配套设施：</td>
      	<td class="layerright" colspan="3"><div style="height: 50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.supportSituation }</div></td>
    </tr>
    <tr>
    	<td class="layertdleft100">交通情况：</td>
      	<td class="layerright" colspan="3"><div style="height: 50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.trafficSituation }</div></td>
    </tr>
      </table></td>
      <td id="img"><input value="${result.value.photos }" type="hidden" id="photo"/></td>
    </tr>
  </table>
  </div>
</div>
<!--基本信息-->
<!--//msglist-->		
</td>
      </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
