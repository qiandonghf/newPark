<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区动力-客户管理</title>
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
		initTypeEnum();
		initCount();
		initOrg();
		initInOut();
		initReportType();
	});
	
	/*入驻迁出*/
	function initInOut(){
		$("#IN").empty();
	  	$("#OUT").empty();
	  	$("#RELET").empty();
		$.ajax({
			   type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.business/contract!inOut.action",
			   success	: function(data){
				   if(data.result!=null){
					   var dtoList = data.result.value;
					   if(dtoList!=null && dtoList.length>0){
						   	var customerIn = "";
						   	var customerOut = "";
						   	var relet = "";
						   for(var i = 0; i< dtoList.length; i++){
							   	if(dtoList[i].type == 'IN'){
								   	customerIn += "<a href=\"javascript:;\" onclick=\"customerView('"+dtoList[i].customerName+"',"+dtoList[i].customerId+")\" class=\"huise\">"+dtoList[i].customerName+"</a>";
							  	}else if(dtoList[i].type == 'OUT'){
							  		customerOut += "<a href=\"javascript:;\" onclick=\"customerView('"+dtoList[i].customerName+"',"+dtoList[i].customerId+")\" class=\"huise\">"+dtoList[i].customerName+"</a>";
							  	}else if(dtoList[i].type == 'RELET'){
							  		relet += "<a href=\"javascript:;\" onclick=\"customerView('"+dtoList[i].customerName+"',"+dtoList[i].customerId+")\" class=\"huise\">"+dtoList[i].customerName+"</a>";
							  	}
						   }
						  	$("#IN").append(customerIn);
						  	$("#OUT").append(customerOut);
						  	$("#RELET").append(relet);
					   }
				   }
			   }
			});
	}
	
	function customerView(name,id){
		var url = "<%=BaseAction.rootLocation%>/department.business/customer!view.action?id="+id;
		fbStart(name,url,870,460);
	}
	
	function initTypeEnum(){
		$("#typeEnum").children().eq(0).remove();
	  	$("#typeEnum").hide();
		var children = $("#typeEnum").children();
		var html = '<a href=\"javascript:;\" onclick=\"addTabList(this,\'client\',\'customer\',\'customer\')\" class=\"huise\">所有客户</a>';
		$(children).each(function(i){
			var txt = $(this).text();
			var type = $(this).val();
			html+= '<a href=\"javascript:;\" onclick=\"addTabList(this,\'client\',\'customer\',\''+type+'\')\" class=\"huise\">'+txt+'</a>';
		});
		if(html != ''){
 			$("#typeList").html(html+$("#typeList").html());
 		} 
	}
	
	function addNewTab(obj,file,type,content,width,height,actionName){
		if(!actionName) actionName = 'department.business';
		var title = "新建"+$(obj).text().substr(1);
		var url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+file+"/"+type+"_add.jsp";
		if(type == 'contract')
			url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+file+"/"+type+"_add_by_id.jsp";
		if(content){
			url += "?type="+content;
		}
		fbStart(title,url,width,height);
	}
	function addCustomServiceTab(title,icon,url){
		parent.addTab(title,icon,url);
	}
	
	function addTabList(obj,file,type,content,msg,actionName){
		if(!actionName) actionName = 'department.business';
		var title = "";
		if(obj)
		 	title = $(obj).text();
		if(msg)
		    title = msg;
		var icon = 'core/common/images/console.png';
		var url = "<%=BaseAction.rootLocation%>/department.business/web/"+file+"/"+type+"_list.jsp";
		if(content){
			url += "?type="+content;
		}
		parent.addTab(title,icon,url);
	}
	
	function view(obj,type,id){
		var title = $(obj).text();
		var width = 760;
		var height = 419;
		fbStart(title,'<%=BaseAction.rootLocation%>/department.business/'+type+'!view.action?id='+id,width,height);
	}
	
	/*项目列表*/
	function loadProjectList(create){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/project!loadProjectData.action",
		   success	: function(data){
			   dealProjects(data.root,create);
		   }
		});
	}
	
	/*处理返回的项目信息*/
	function dealProjects(projects,create){
		var html = "";
		if(create){
			html = $("#projectList").html();
		}
		for(var i = 0; i< projects.length; i++){
			html += "<p class=\"text\">";
			html += "<strong>";
			html += "<a href=\"javascript:;\" onclick=\"view(this,'project',"+projects[i].id+")\" class=\"blue\">"+projects[i].name+"</a>"
			html += "</strong>";
			html += "<span><a href=\"javascript:;\" class=\"underline huise\">整体进度</a></span>";
			html += "</p>";
		}
		$("#projectList").html(html);
	}
	
	/*重新加载*/
	function reloadList(type){
		switch(type){
		case 'contectInfo':
			addTabList(null,type,type,'客户跟进');
			break;
		case 'contect':
			addTabList(null,type,null,'联系人');
			break;		
		case 'customer':
			addTabList(null,type,null,'客户');
			break;			
		case 'ZLHT':	
		 	addTabList(null,'contract',type,'租赁合同');
			break;
		case 'XSHT':
		 	addTabList(null,'contract',type,'销售合同');
			break;
		}
	}
	/*服务类型*/
	function initCount(){	
		var html = "";
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/customerService!amounts.action",
		   success	: function(data){
 			   var nums = data.result.value.slice(",");
			   for(var i = 0;i < data.result.value.length;i++){
				  if(nums[i].amount!=0&&nums[i]!=''){
						html += "<a href=\"javascript:;\" onclick=\"parent.addTab('所有联系单','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/customerService!listType.action?typeId='+'"+nums[i].childId+"');\" class=\" huise\">"+nums[i].typeName+"(<font class=\"amount\" style=\"color: blue\">"+nums[i].amount+"</font>)</a>"
				  }else{
					html += "<a href=\"javascript:;\" onclick=\"parent.addTab('所有联系单','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/customerService!listType.action?typeId='+'"+nums[i].childId+"');\" class=\" huise\">"+nums[i].typeName+"</a>" 
				  }
				  if((i+1)%3==0){
					  html +="<span style=\"clear:both;\"></span>"
				  }
			   }
			   $("#serviceType").html(html);
 		   }
		});
	}
	/*服务机构*/
	function initOrg(){
		var html="";
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/agency!amounts.action",
		   success	: function(data){
			   var nums = data.result.value.slice(",");
			   for(var i = 0;i < data.result.value.length;i++){
				   if(nums[i].amount!=0&&nums[i]!=''){
					   html += "<a href=\"javascript:;\" onclick=\"parent.addTab('所有机构','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/web\/cooperate\/cooperate_list2.jsp?agencyType='+'"+nums[i].name+"');\" class=\" huise\">"+nums[i].value+"(<font class=\"amount\" style=\"color: blue\">"+nums[i].amount+"</font>)</a>"
				   }else{
					   html += "<a href=\"javascript:;\" onclick=\"parent.addTab('所有机构','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/web\/cooperate\/cooperate_list2.jsp?agencyType='+'"+nums[i].name+"');\" class=\" huise\">"+nums[i].value+"</a>"
				   }
			   }
			   $("#orgType").append(html);
		   }
		});
	}
	/*数据填报*/
 	function initReportType(){
 		var html="";
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/dataReport!amounts.action",
		   success	: function(data){
			   var nums = data.result.value.slice(",");
			   for(var i = 0;i < data.result.value.length;i++){
				  if(nums[i].amount!=0&&nums[i]!=''){
						html += "<a href=\"javascript:;\" onclick=\"parent.addTab('"+nums[i].groupName+"','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/dataReport!listGroup.action?groupId='+'"+nums[i].groupId+"');\" class=\" huise\">"+nums[i].groupName+"(<font class=\"amount\" style=\"color: blue\">"+nums[i].amount+"</font>)</a>"
				  }else{
					html += "<a href=\"javascript:;\" onclick=\"parent.addTab('"+nums[i].groupName+"','\/department.business\/web\/images\/icon\/projectadmin_02_min.png','<%=BaseAction.rootLocation %>\/department.business\/dataReport!listGroup.action?groupId='+'"+nums[i].groupId+"');\" class=\" huise\">"+nums[i].groupName+"</a>" 
				  }
				  if((i+1)%3==0){
					  html +="<span style=\"clear:both;\"></span>"
				  }
			   }
			   $("#dataReportType").append(html);
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
					<strong>客户管理</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的客户管理</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0301">客户信息</h3>
						<p class="toptext">
							这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
<!-- 									<strong><a href="javascript:;" onclick="addTabList(this,'client','customer')" class="blue">客户档案</a></strong> -->
									<strong><a href="javascript:;"  class="blue" style="text-decoration:none">客户档案</a></strong>
									<enum:select id="typeEnum" type="com.wiiy.business.preferences.enums.CustomerTypeEnum" />
									<span id="typeList" class="w300th"> 
										<a href="javascript:;" onclick="fbStart('新建客户','<%=BaseAction.rootLocation %>/department.business/customer!add.action?form=index',700,519);" class="huise">+客户</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('孵化企业','/department.business/web/images/icon/client_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/customer_list.jsp?incubated=YES')" class="huise" style="text-decoration:none">孵化企业</a>
										<a href="javascript:;" onclick="parent.addTab('企业信息','/department.business/web/images/icon/client_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/customer_list.jsp')" class="huise">孵化</a> 
										<a href="javascript:;" onclick="parent.addTab('企业信息','/department.business/web/images/icon/client_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/customer_list.jsp')" class="huise">毕业</a> 
										<a href="javascript:;" onclick="parent.addTab('企业信息','/department.business/web/images/icon/client_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/customer_list.jsp')" class="huise">肄业</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'client','contect');" class="huise">联系人</a>
										<a href="javascript:;" onclick="addTabList(this,'client','staffer');" class="huise">企业人员</a>
										<a href="javascript:;" onclick="addTabList(this,'client','product');" class="huise">项目信息</a>
										<a href="javascript:;" onclick="" class="huise">知识产权</a>
										<span style="clear:both;"></span>
 										<a href="javascript:;" onclick="parent.addTab('所有项目库','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/web/project/project_message.jsp');" class="huise">OnePage</a>
									</span>
								</p>
								<p class="text">
<!-- 									<strong><a href="javascript:;" onclick="addTabList(this,'client','contectInfo')" class="blue" style="text-decoration:none">客户跟进</a></strong> -->
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">客户跟进</a></strong>
									<span> 
										<a href="javascript:;" onclick="addNewTab(this,'client','contectInfo','contectInfo',500,320);" class="underline huise">交往信息</a> 
										<a href="javascript:;" class="underline huise">完善档案</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">客户关怀</a></strong> <span>
										<a href="javascript:;" class="underline huise">生日关怀</a> <a
										href="javascript:;" class="underline huise">节日关怀</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">常用表单</a></strong> <span>
										<a href="javascript:;" class="underline huise">高层次人才表</a> <a
										href="javascript:;" class="underline huise ">孵化企业表</a> <a
										href="javascript:;" class="underline huise">融资项目信息表</a> <a
										href="javascript:;" class="underline huise">知识产权表</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">客户统计</a></strong> <span><a
										href="javascript:;" class="huise"></a> </span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0302">数据填报</h3>
						<p class="toptext">
							这里是销售管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
<!-- 									<strong><a href="javascript:;" onclick="addTabList(this,'dataProperty')" class="blue" style="text-decoration:none">数据项</a></strong> -->
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">数据项&nbsp;&nbsp;&nbsp;</a></strong>
									<span> 
									 <a href="javascript:;" onclick="parent.addTab('数据项','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/web/client/dataProperty_list.jsp');" class="underline huise">定义数据项</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">数据模版</a></strong> 
									<span>
										<a href="javascript:;" onclick="parent.addTab('所有模版','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/dataTemplate!list.action');" class="underline huise">所有模版</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">数据报表</a></strong>
									<span id="test1" class="w300th"> 
										<a href="javascript:;"
											onclick="parent.addTab('所有报表','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/web/client/dataReport_list.jsp');"
											class="huise">所有报表</a> 
										<%-- <a href="javascript:;" onclick="parent.addTab('新建报表','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/dataReport!add.action')" class="huise">+报表</a>  --%>
										<a href="javascript:;" onclick="fbStart('新建报表','<%=BaseAction.rootLocation%>/department.business/dataReport!add.action?form=index',500,208);" class="huise">+报表</a> 
										<span style="clear:both;"></span>
										<span id="dataReportType" class="w300th"></span>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">数据分析</a></strong> 
									<span class="w300th"> 
										<a href="javascript:;"
											onclick="parent.addTab('数据分析','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/analyse!list.action');"
											class="huise">数据分析</a> 
										</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0303">综合提醒</h3>
						<p class="toptext">
							这里是租赁管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">合同到期</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">孵化到期</a></strong> <span>
										<a href="javascript:;" class="underline huise"></a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">知识产权有效期</a></strong>
									<span> <a href="javascript:;" class="underline huise"></a>
									</span>
								</p>
							</li>
						</ul>
					</div>

				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0304">园区日志</h3>
						<p class="toptext">
							这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>

						<ul>
							<li class="main2">
								<p class="text">
									<strong>
										<a href="javascript:;" class="blue">入驻迁出</a>
									</strong>
									<span class="w300th">
										<a href="javascript:;" class="huise" style="text-decoration: none;">最近入驻：</a>
										<span style="clear:both;"></span>
										<span id="IN"><a href="javascript:;" class="huise">企业名称1</a>
									 	<a href="javascript:;" class="huise on">企业名称2</a>
										<a href="javascript:;" class="huise">企业名称3</a> 
										<a href="javascript:;" class="huise on">企业名称4</a> </span>
										<span style="clear:both;"></span>
										<a href="javascript:;" class="huise" style="text-decoration: none;">最近迁出：</a>
										<span style="clear:both;"></span>
										<span id="OUT"><a href="javascript:;" class="huise">企业名称1</a>
									 	<a href="javascript:;" class="huise on">企业名称2</a>
										<a href="javascript:;" class="huise">企业名称3</a> 
										<a href="javascript:;" class="huise on">企业名称4</a></span>
										<span style="clear:both;"></span> 
										<a href="javascript:;" class="huise" style="text-decoration: none;">最近续约：</a>
										<span style="clear:both;"></span>
										<span id="RELET"><a href="javascript:;" class="huise">企业名称1</a>
									 	<a href="javascript:;" class="huise on">企业名称2</a>
										<a href="javascript:;" class="huise">企业名称3</a> 
										<a href="javascript:;" class="huise on">企业名称4</a> </span>
										
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">档案调整</a></strong> 
									<span class="w300th">
										<a href="javascript:;" class="huise">企业名称1</a> 
										<a href="javascript:;" class="huise on">企业名称2</a> 
										<a href="javascript:;" class="huise">企业名称3</a> 
										<a href="javascript:;" class="huise on">企业名称4</a>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0305">客户服务</h3>
						<p class="toptext">
							这里客户管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>

						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">服务联系单</a></strong>
									<span> <a href="javascript:;"
										onclick="parent.addTab('所有联系单','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/customerService!list.action');"
										class="huise">所有联系单</a> <a href="javascript:;"
										onclick="fbStart('新建联系单','<%=BaseAction.rootLocation%>/department.business/web/client/customerService_add.jsp?form=index',700,238);"
										class="underline huise">+联系单</a>
									</span>
								</p>
								<p class="text">
									<strong> <a href="javascript:;" class="blue" style="text-decoration:none">服务类型</a>
									</strong> <span id="serviceType" class="w300th"></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">服务轨迹</a></strong> <span>
										<a href="javascript:;"
										onclick="parent.addTab('所有轨迹','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/customerServiceTrack!listAll.action');"
										class="huise">所有轨迹</a> 
										<!-- <a href="javascript:;" onclick="addTabList(this,'client','customerServiceTrack');" class="underline huise">所有轨迹</a> -->
										<!-- <a href="javascript:;" onclick="addNewTab(this,'client','customerServiceTrack','actionName',450,185);" class="underline huise">+轨迹</a> -->
										<a href="javascript:;"
										onclick="fbStart('新建轨迹','<%=BaseAction.rootLocation%>/department.business/web/client/customerServiceTrack_add.jsp?form=index',450,185);"
										class="underline huise">+轨迹</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">服务机构</a></strong> <span></span>
									<span class="w300th">
								 	<a href="javascript:;"
										onclick="parent.addTab('所有机构','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.business/agency!listAll.action');"
										class="huise">所有机构</a> 
									<a href="javascript:;"
										onclick="fbStart('新建机构','<%=BaseAction.rootLocation%>/department.business/web/cooperate/cooperate_add.jsp?form=index',600,342);"
										class="huise">+机构</a> <span style="clear: both;"></span>
									<span style="clear:both;"></span>
									<span id="orgType" class="w300th"></span>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0306">辅助</h3>
						<p class="toptext">
							这里是辅助的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>

						<ul>
							<li class="main2">
								<p class="text">
									<strong class="fourtext num"><a href="javascript:;" style="text-decoration:none"
										class="blue">销售公告</a>(<font>N</font>)</strong> <span><a
										href="javascript:;" class="underline huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">附件材料</a></strong> <span><a
										href="javascript:;" class="underline huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">业务转交</a></strong> <span><a
										href="javascript:;" class="huise"></a></span>
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
