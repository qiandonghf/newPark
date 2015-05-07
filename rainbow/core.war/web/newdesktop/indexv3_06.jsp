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
<title>园区动力-工程管理</title>
<link href="core/common/style/index.css" rel="stylesheet" type="text/css" />
<link href="core/web/newdesktop/style/newindex.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/menu.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

<script type="text/javascript">
	function addNewTab(obj,type,content){
		var width = 620;
		var height = 411;
		switch(type){
		case "customer":
			width = 700;
			height = 422;
			break;
		case "contract":
			width = 650;
			height = 485;
			break;
		}
		var title = "新建"+$(obj).text().substr(1);
		var url = "<%=BaseAction.rootLocation%>/department.engineering/web/"+type+"/"+type+"_add.jsp?from=index";
		if(type == 'contract')
			url = "<%=BaseAction.rootLocation%>/department.engineering/web/"+type+"/"+type+"_add_by_id.jsp?from=index";
		if(content){
			url += "&type="+content;
		}
		fbStart(title,url,width,height);
	}
	
	function addTabList(obj,type,content,msg){
		var title = "";
		if(obj)
		 title = $(obj).text();
		if(msg)
		 title = msg;
		var icon = 'core/common/images/console.png';
		var url = "<%=BaseAction.rootLocation%>/department.engineering/web/"+type+"/"+type+"_list.jsp";
		if(content){
			url += "?type="+content;
		}
		parent.addTab(title,icon,url);
	}
	
	function view(obj,type,id){
		var title = $(obj).text();
		var width = 760;
		var height = 419;
		fbStart(title,'<%=BaseAction.rootLocation%>/department.engineering/'+type+'!view.action?id='+id,width,height);
	}
	
	$(function(){
		loadProjectList(true);
		initCount();
	});
	
	/*项目列表*/
	function loadProjectList(create){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.engineering/project!loadProjectData.action",
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
	
	function initCount(){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.engineering/billPlanRent!remindCount.action",
		   success	: function(data){
			   $("#remindCount").text(data.result.value);
		   }
		});
	}
	
	/*重新加载*/
	function reloadList(type){
		switch(type){
		case 'project':
			loadProjectList(false);
			break;
		case 'customer':
			 addTabList(null,type,null,'客户');
			break;
		case 'supplier':
			 addTabList(null,'customer',type,'供应商');
			break;
		case 'contract':
			 addTabList(null,'contract',null,'工程合同');
			break;
		}
	}
</script>
</head>
<body>
	<div id="contant2" style="overflow: auto;">
		<div id="news_contenter" class="main" style="padding-left: 30px;padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>工程管理</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理，这里是总园区的工程管理， </span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0601">项目管理</h3>
						<p class="toptext"> 这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
						  <li class="main2">
							<p class="text">
							    <strong><a href="javascript:;" class="blue" onclick="addTabList(this,'project');">工程部项目</a></strong>
							    <span><a href="javascript:;" onclick="addNewTab(this,'project');" class="underline huise">+项目</a></span>
						    </p>
						    <div id="projectList"></div>
						  </li>
						</ul>
					</div>
					<div class="mainnewslist">
		    			<h3 class="title bg0602">客商管理</h3>
		   				<p class="toptext"> 这里是工程管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
						  		<p class="text">
						    		<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'customer');">客户</a></strong> 
						    		<span><a href="javascript:;" class="underline huise" onclick="addNewTab(this,'customer','customer');">+客户</a></span>
						    	</p> 
								<p class="text">
						    		<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'customer','supplier');">供应商</a></strong> 
						    		<span><a href="javascript:;" class="underline huise" onclick="addNewTab(this,'customer','supplier');">+供应商</a></span>
						    	</p> 
							</li>
						</ul>
		    		</div>
		     		<div class="mainnewslist">      
						<h3 class="title bg0603">合同管理</h3>
						<p class="toptext"> 这里是租赁管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
						    		<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'contract');">工程合同</a></strong> 
						    		<span><a href="javascript:;" class="underline huise" onclick="addNewTab(this,'contract','contract');">+合同</a></span>
						    	</p> 
			 					<p class="text">
			    					<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'remind');">计划付款提醒</a>(<font id="remindCount">N</font>)</strong> <span class="nolink">(默认为15天)</span> 
			    				</p>  
								<p class="text">
									<strong><a href="javascript:;" class="blue">合同进度控制</a></strong> <span class="nolink">(显示与合同严重不符的合同列表)</span> 
								</p> 
							</li>
						</ul>
		    		</div>
		  		</div>
				<div class="mainright"> 
		    		<div class="mainnewslist">
			    		<h3 class="title bg0604">辅助管理</h3>
			    		<p class="toptext"> 这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong ><a href="javascript:;" class="blue">工程文档</a></strong> 
									<span ><a href="javascript:;" class="underline huise"></a> </span>
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
