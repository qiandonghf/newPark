<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区动力-物业管理</title>
<link href="core/common/style/index.css" rel="stylesheet"
	type="text/css" />
<link href="core/web/newdesktop/style/newindex.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/menu.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>



<script type="text/javascript">
	$(function(){
		initProperty();
		initComplaint();
	});

	function addPropertyTab(title,icon,url){
		parent.addTab(title,icon,url);
	}
	/*处理中的报修*/
	function initProperty(){
		var html="";
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.estate/propertyFix!amounts.action",
		   success	: function(data){
			   var nums = data.result.value.slice(",");
			   for(var i=0;i<data.result.value.length;i++){
				html = "<a href=\"javascript:;\" onclick=\"parent.addTab('所有报修','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.estate\/web\/property\/property_repair_listByType.jsp?status='+'"+nums[i].typeName+"');\" class=\" huise\">处理中的报修(<font class=\"huise\" style=\"color: red;line-height:25px;\">"+nums.length+"</font>)</a>"
			   }
			   if(data.result.value.length==0){
				html = "<a href=\"javascript:;\" onclick=\"parent.addTab('所有报修','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.estate\/web\/property\/property_repair_listByType.jsp?status='+'');\" class=\" huise\">处理中的报修</a>"
			   }
			   $("#propertyType").append(html);
		   }
		});
	}
	function initComplaint(){
		var html="";
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.estate/complaint!amounts.action",
		   success	: function(data){
			   var nums = data.result.value.slice(",");
			   for(var i=0;i<data.result.value.length;i++){
				html = "<a href=\"javascript:;\" onclick=\"parent.addTab('所有投诉','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.estate\/web\/property\/complaint_listByType.jsp?status='+'"+nums[i].typeName+"');\" class=\" huise\">处理中的投诉(<font class=\"huise\" style=\"color: red;line-height:25px;\">"+nums.length+"</font>)</a>"
			   }
			   if(data.result.value.length==0){
				html = "<a href=\"javascript:;\" onclick=\"parent.addTab('所有投诉','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.estate\/web\/property\/complaint_listByType.jsp?status='+'');\" class=\" huise\">处理中的投诉</a>"
			   }
			   $("#complaintType").append(html);
		   }
		});
	}
</script>
</head>
<body>


	<div id="contant2" style="overflow: auto;">

		<div id="news_contenter" class="main"
			style="padding-left: 30px; padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>物业管理</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0501">物业合同</h3>
						<p class="toptext">
							这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong>
										<a href="javascript:;" class="blue" style="text-decoration:none">合同模板</a>
									</strong>
									<span>
										<a href="javascript:;" class="underline huise">物业合同</a>
									</span>
								</p>
							</li>
							<p class="text">
								<strong>
									<a href="javascript:;" class="blue" style="text-decoration:none">合同登记</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">+物业合同</a> 
										<a href="javascript:;" class="huise">新招商客户 (<font>N</font>)</a>
									</span>
							</p>
							<p class="text">
								<strong><a href="javascript:;" class="blue" style="text-decoration:none">提醒</a></strong> <span><a
									href="javascript:;" class="underline  huise">合同到期(<font>N</font>)
								</a> （默认为30天） <a href="javascript:;" class="huise underline ">到期房源(<font>N</font>)
								</a></span>
							</p>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0502">基础物业</h3>
						<p class="toptext">
							这里是物业管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">物业报修</a></strong> 
									<span class="w300th"> 
									<a href="javascript:;" onclick="parent.addTab('所有报修','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/property/property_repair_list.jsp');" class="huise">所有报修</a>
									<span id="propertyType"></span>
									<a href="javascript:;" onclick="fbStart('新建报修','<%=BaseAction.rootLocation%>/department.estate/web/property/property_repair_add.jsp?form=index',800,197);" class="huise">+报修</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">客户投诉</a></strong> 
									<span class="w300th"> 
									<a href="javascript:;" onclick="parent.addTab('所有投诉','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/property/complaint_list.jsp');" class="huise">所有投诉</a>
									<span id="complaintType"></span>
									<a href="javascript:;" onclick="fbStart('新建投诉','<%=BaseAction.rootLocation%>/department.estate/web/property/complaint_add.jsp?form=index',600,222);" class="huise">+投诉</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">车辆管理</a></strong> 
									<span class="w300th">
									<a href="javascript:;" onclick="parent.addTab('车辆管理','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/property/vehicle_list.jsp');" class="huise">车辆管理</a> 
									<a href="javascript:;" onclick="parent.addTab('车位管理','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/property/grage_list.jsp');" class="huise">车位管理</a> 
									</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">库存管理</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="parent.addTab('所有入库','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/chiefadmin/Office_supplies_storage_list.jsp');" class="huise">所有入库</a>
										<a href="javascript:;" onclick="fbStart('新建入库','<%=BaseAction.rootLocation%>/department.estate/web/chiefadmin/Office_supplies_storage_add.jsp?form=index',500,280);" class="huise">+入库</a>
										<a href="javascript:;" onclick="parent.addTab('所有出库','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.estate/web/chiefadmin/Office_supplies_sq.jsp');" class="huise">所有出库</a>
										<a href="javascript:;" onclick="fbStart('新建出库','<%=BaseAction.rootLocation%>/department.estate/web/chiefadmin/Office_supplies_sq_add.jsp?form=index',500,320);"  class="huise">+出库</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">设备</a></strong> <span><a
										href="javascript:;" class="underline huise">+设别</a> <a href="javascript:;"
										class="underline huise">提醒(<font>n</font>)
									</a></span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0503">水电</h3>
						<p class="toptext">
							这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">水电表</a></strong> <span><a
										href="javascript:;" class="underline huise">+水电表</a> <a href="javascript:;"
										class="underline huise on">车未定义</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">费用设置</a></strong> <span><a
										href="javascript:;" class="underline huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">抄表</a></strong> <span><a
										href="javascript:;" class="underline huise">2014年5月水表报表</a> <a href="javascript:;"
										class="underline huise">2014年5月水表报表</a> <a href="javascript:;"
										class="underline huise">2014年5月水表报表</a> <a href="javascript:;"
										class="underline huise">2014年5月水表报表</a></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0504">结算</h3>
						<p class="toptext">
							这里客户管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">提醒</a></strong> <span>
										<a href="javascript:;" class="underline huise">物业(<font>n</font>)</a>
										<a href="javascript:;" class="underline huise">催缴(<font>n</font>)
									</a> （默认为1个月）
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">出账</a></strong> <span><a
										href="javascript:;" class="underline huise">物业费</a> <a href="javascript:;"
										class="underline huise on">公共能耗费</a> <a href="javascript:;"
										class="underline huise">垃圾消运费</a> <a href="javascript:;"
										class="underline huise on">水电费</a> <a href="javascript:;"
										class="underline huise">预缴费</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">结算单</a></strong> <span>
										<a href="javascript:;" class="underline huise"></a>
									</span>
								</p>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
