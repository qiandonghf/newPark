<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<body>
<div>
	<ul class="checkout_list">
		<li>
			<img src="core/common/images/fee1_min.gif" />
			<span>
				物业管理费<a style="text-decoration:none;" href="javascript:void(0)" onclick="addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')"><em>(${MANAGE eq null ? 0 : MANAGE})</em></a>&nbsp;&nbsp;
				租金<a style="text-decoration:none;" href="javascript:void(0)" onclick="addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')"><em>(${RENT eq null ? 0 : RENT})</em></a>&nbsp;&nbsp;
				能源损耗<a style="text-decoration:none;" href="javascript:void(0)" onclick="addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')"><em>(${ENERGY eq null ? 0 : ENERGY})</em></a>
			</span>
		</li>
		<li>
			<img src="core/common/images/fee2_min.gif" />
			<span>
				押金<a style="text-decoration:none;" href="javascript:void(0)" onclick="addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')"><em>(${deposit eq null ? 0 : deposit})</em></em></a>
			</span>
		</li>
		<!-- <li>
			<img src="core/common/images/fee3_min.gif" />
			<span>
				水电气费<a style="text-decoration:none;" href="javascript:void(0)" onclick="addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')"><em>(12)</em></a>
			</span>
		</li> -->
		<li>
			<img src="core/common/images/fee4_min.gif" />
			<span>
				<%
					Map<String,Integer> facilityMap = (Map<String,Integer>)request.getAttribute("facilityMap");
					for (String key : facilityMap.keySet()) {
						out.println(key+"<a style=\"text-decoration:none;\" href=\"javascript:void(0)\" onclick=\"addTab(parent.parent,'费用出账','/parkmanager.pb/bill!checkout.action')\"><em>("+facilityMap.get(key)+")</em></a>");
					}
				%>
			</span>
		</li>
	</ul>
</div>
</body>
</html>