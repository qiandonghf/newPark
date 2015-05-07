<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/pm_rbase.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
	});
</script>
</head>

<body>
	<div class="titlebg">费用出帐列表</div>
	<div id="container">
		<div class="tips">出帐管理提供园区各种费用的手工或自动出帐维护,园区企业将会获取账单信息，所以在出帐时，务必保证收账单金额的准确性。你也可以根据系统提示的信息及时进行出帐维护。</div>
		<ul class="feeList">
			<li class="feeLi">
				<img  src="core/common/images/fee1.gif" />
				<dl class="feeDetail">
	            	<dt>物业租金出帐</dt>
	                <dd class="about">PM根据园区与企业租赁合同中的资金计划生成出帐清单（包括已经设置了自动出帐的资金计划）。</dd>
	                <dd class="feeResult">PM检测到<strong class="cor_g">${rentDay}天</strong>内出帐信息(物业管理费<strong class="cor_f00">${MANAGE eq null ? 0 : MANAGE}</strong>条，租金<strong class="cor_f00">${RENT eq null ? 0 : RENT}</strong>条，能源损耗费<strong class="cor_f00">${ENERGY eq null ? 0 : ENERGY}</strong>条)</dd>
				</dl>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_checkoutRent")){ %>
				<a href="<%=basePath %>bill!checkoutListBillPlanRent.action" class="btn"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
				<%} %>
			</li>
			<li class="feeLi">
				<img  src="core/common/images/fee2.gif" />
				<dl class="feeDetail">
					<dt>押金出帐</dt>
					<dd class="about">PM根据园区与企业租赁合同中的押金生成出帐清单。</dd>
					<dd class="feeResult">PM检测到<strong class="cor_g">${depositDay}天</strong>内出帐信息(押金<strong class="cor_f00">${deposit eq null ? 0 : deposit}</strong>条)</dd>
				</dl>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_checkoutDeposit")){ %>
				<a href="<%=basePath %>bill!checkoutListDeposit.action" class="btn"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
				<%} %>
			</li>
			<!-- <li class="feeLi">
				<img  src="core/common/images/fee3.gif" />
				<dl class="feeDetail">
					<dt>水电气费出帐</dt>
					<dd class="about">PM根据水电气抄表标签生成出帐单，如需要进行单表费用结算，请使用房间管理中的临时抄表功能</dd>
					<dd class="feeResult">PM检测到现在<strong class="cor_f00">1</strong>个标签未出帐</dd>
				</dl>
				<a href="javascript:void(0)" class="btn"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
			</li> -->
			<li class="feeLi">
				<img  src="core/common/images/fee4.gif" />
				<dl class="feeDetail">
					<dt>公共设施费用出帐</dt>
					<dd class="about">PM支持用户自定义费用，如网络费、会议室使用费、广告费等，在生成企业账单 时，会记录费用的计划出帐日期。根据计划出帐日期，生成自定义费用的出帐清单</dd>
					<dd class="feeResult">PM检测到<strong class="cor_g">${facilityDay}天</strong>内计划出帐的自定义费用<strong class="cor_f00">${facilitySum eq null ? 0 : facilitySum}</strong>条,其中：</dd>
				</dl>
				<ul class="feeDeList">
					<%
						Map<String,Integer> facilityMap = (Map<String,Integer>)request.getAttribute("facilityMap");
						for (String key : facilityMap.keySet()) {
							out.println("<li>"+key+"<strong class=\"cor_f00\">"+facilityMap.get(key)+"</strong>条</li>");
						}
					%>
				</ul>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_checkoutFacility")){ %>
				<a href="<%=basePath %>bill!checkoutListBillPlanFacility.action" class="btn"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
				<%} %>
			</li>
		</ul>
	</div>
</body>
</html>
