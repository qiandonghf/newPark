<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#billList").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-30);
	});
	
</script>
</head>

<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	        	<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">统计类型</div>
						<div class="datalist">
						 	<ul>
								<li><a href="<%=basePath%>building!buildingCensus.action">日结算报表</a></li>
								<li><a href="<%=basePath%>bill!monthBill.action">月结算报表</a></li>
				                <li><a href="<%=basePath%>room!rentDetail.action">年结算报表</a></li>
				                <li><a href="<%=basePath%>room!rentDetail.action">分户明细表</a></li>
				                <li><a href="<%=basePath%>room!rentDetail.action">物业应收实收统计表</a></li>
						 	</ul>
			          	</div>
					</div>		
				</td>
				<td width="100%" valign="top">
					<div>
						<iframe src="<%=basePath %>web/facility/facility_index.jsp" frameborder="0" id="billList" name="billList" width="100%" height="100%"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
