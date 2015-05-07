<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区动力-销售管理</title>
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
 		initLevelEnum();
 		/* initLevels(); */
 		initContect();
 		//所有
 		initLevels(false);
 		//我的
 		initLevels(true);
 		initSubscribe();
 	});
 	
 	
 	function initLevelEnum(){
 		$("#levelEnum").children().eq(0).remove();
 		$("#levelEnum").hide();
 		var children = $("#levelEnum").children();
 		var html = "";
 		$(children).each(function(i){
 			var txt = $(this).val();
 			html+= '<a href=\"javascript:;\" onclick=\"addTabList(this,\'customer\',\''+txt+'\')\" class=\"huise\">客户'+txt+'</a>';
 		});
 		if(html != ''){
 			$("#levelList").html(html);
 		}
 	}

	function addNewTab(obj,type,content,width,height,actionName){
		if(!actionName) actionName = 'department.sale';
		var title = "新建"+$(obj).text().substr(1);
		var url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type+"_add.jsp";
		if(type == 'contract')
			url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type+"_add_by_id.jsp";
		if(content){
			url += "?type="+content;
		}
		fbStart(title,url,width,height);
	}
	
	function addTabList(obj,type,content,msg,actionName,type2){
		if(!actionName) actionName = 'department.sale';
		if(!type2) type2 = type;
		var title = "";
		if(obj)
		 	title = $(obj).text();
		if(msg)
		    title = msg;
		if(title.indexOf("(") != -1)
			title = title.substr(0,title.indexOf("("));
		var icon = 'core/common/images/console.png';
		var url = "<%=BaseAction.rootLocation%>/department.sale/web/"+type+"/"+type2+"_list.jsp";
		if(content){
			url += "?type="+content;
		}
		parent.addTab(title,icon,url);
	}
	
	function view(obj,type,id){
		var title = $(obj).text();
		var width = 760;
		var height = 419;
		fbStart(title,'<%=BaseAction.rootLocation%>/department.sale/'+type+'!view.action?id='+id,width,height);
	}
	
	/*项目列表*/
	function loadProjectList(create){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.sale/project!loadProjectData.action",
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
		   url		: "<%=BaseAction.rootLocation%>/department.sale/billPlanRent!remindCount.action",
		   success	: function(data){
			   $("#remindCount").text(data.result.value);
		   }
		});
	}
	
	//区分所有的和我的等级
	function initLevels(type){
		$.ajax({
			 type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.sale/customer!levels.action?who="+type,
			   success	: function(data){
				   /* var nums = data.result.value.slice(",");
				   for(var i = 0;i < 4;i++){
					   if(nums != 0){
						   $(".level").eq(i).text(nums[i]);
					   }
				   } */
				   var map = data.result.value;
				   var nums = new Array();
				   nums.push(map.A);
				   nums.push(map.B);
				   nums.push(map.C);
				   nums.push(map.D);
				   for(var i = 0;i < nums.length;i++){
					   if(type){
						   $(".level").eq(4+i).text(nums[i]);
					   }else{
						   $(".level").eq(i).text(nums[i]);
					   }
				   }			
			   }
		});
	}
	
	function initContect(){
		$.ajax({
			   type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.sale/contectInfo!contects.action",
			   success	: function(data){
				   var nums = data.result.value.slice(",");
				   for(var i = 0;i < 7;i++){
					  $(".contect").eq(i).text(nums[i]);
					  $(".contect").eq(i+7).text(nums[i+7]);
				   }
			   }
			});
	}
	function initSubscribe(){
		var html="预订提醒";
		$.ajax({
			   type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.sale/residential!listAll.action",
			   success	: function(data){
				if(data.result.value!=0){
					var n=data.result.value;
					html+="<font style=\"color:blue;line-height:25px;\">("+n+")</font>"
					$("#subscribeId").append(html);
				}else{
					$("#subscribeId").append(html);
				}				  
			   }
			});
	}
	
	/*重新加载*/
	function reloadList(type){
		switch(type){
		case 'contectInfo':
			addTabList(null,type,type,'销售线索');
			break;
		case 'registration':
			addTabList(null,type,null,'预订');
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
	function addSubscribeTab(title,icon,url){
		parent.addTab(title,icon,url);
	}
	
</script>
<style>
	.mainnewslist ul li.main2 p.text span font{
		line-height: 23px;
	}
</style>
</head>
<body>
	<div id="contant2" style="overflow: auto;">
		<div id="news_contenter" class="main" style="padding-left: 30px;padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>销售管理</strong><span class="subtitle">ParkSale</span><br />
					<span class="toptitle_bg">这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg01">销售机会</h3>
						<p class="toptext">
							这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" onclick="" class="blue">销售线索</a></strong> <span>
									<a href="javascript:;" onclick="addTabList(this,'contectInfo',null,null,null,'contectInfo');" class="underline huise">所有</a>
									<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&own=my',null,null,'contectInfo');" class="underline huise">我的</a>
									<a href="javascript:;" onclick="addNewTab(this,'contectInfo','contectInfo',520,320);" class="underline huise">+来电</a> 
									<a href="javascript:;" onclick="addNewTab(this,'contectInfo','contectInfo',520,320);" class="underline huise">+来访</a>

									<a href="javascript:;" onclick="fbStart('新建回访记录','<%=BaseAction.rootLocation %>/department.sale/web/contectInfo/repeatedViste_add.jsp?form=index',480,200);" class="underline huise on">+回访记录</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" onclick=""  class="blue">意向客户</a></strong> 
									<span id="levelList" class="w300th">
									<span style="clear:both;"></span>
									    <a href="javascript:;" onclick="addTabList(this,'customer',null,null,null,'customer')" class="huise">所有</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','A',null,null,'customer')" class="huise">客户A(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','B',null,null,'customer')" class="huise">客户B(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','C',null,null,'customer')" class="huise">客户C(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','D',null,null,'customer')" class="huise">客户D(<font class="level" style="color: blue">0</font>)</a>
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'customer','null&own=my',null,null,'customer')" class="huise">我的</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','A&own=my',null,null,'customer')" class="huise">客户A(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','B&own=my',null,null,'customer')" class="huise">客户B(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','C&own=my',null,null,'customer')" class="huise">客户C(<font class="level" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'customer','D&own=my',null,null,'customer')" class="huise">客户D(<font class="level" style="color: blue">0</font>)</a>
									</span>
									<%-- <enum:select id="levelEnum" type="com.wiiy.sale.preferences.enums.CustomerLevelEnum" /> --%>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">跟进提醒</a></strong>
									<span class="w300th">
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','contectInfo',null,null);" class="huise">所有:</a>
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=7',null,null,'contectInfo');" class="huise">7天未联系(<font class="contect">0</font>)</a>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=15',null,null,'contectInfo');" class="huise">15天未联系(<font class="contect">0</font>)</a>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=30',null,null,'contectInfo');" class="huise">30天未联系(<font class="contect">0</font>)</a> 
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=7',null,null,'contectInfo');" class="huise">7天需联系(<font class="contect">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=15',null,null,'contectInfo');" class="huise">15天需联系(<font class="contect">0</font>)</a>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=30',null,null,'contectInfo');" class="huise">30天需联系(<font class="contect">0</font>)</a>  
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&day=7',null,null,'contectInfo');" class="huise">7天联系过(<font class="contect">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&own=my',null,null);" class="huise">我的:</a>
									<span style="clear:both;"></span>
										 <a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=7&own=my',null,null,'contectInfo');" class="huise">7天未联系(<font class="contect">0</font>)</a> 
										 <a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=15&own=my',null,null,'contectInfo');" class="huise">15天未联系(<font class="contect">0</font>)</a> 
										 <a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=30&own=my',null,null,'contectInfo');"  class="huise">30天未联系(<font class="contect">0</font>)</a> 
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=7&own=my',null,null,'contectInfo');" class="huise">7天需联系(<font class="contect">0</font>)</a> 
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=15&own=my',null,null,'contectInfo');" class="huise">15天需联系(<font class="contect">0</font>)</a>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&state=NORMAL&day=30&own=my',null,null,'contectInfo');" class="huise">30天需联系(<font class="contect">0</font>)</a>
									<span style="clear:both;"></span>
										<a href="javascript:;" onclick="addTabList(this,'contectInfo','null&day=7&own=my',null,null,'contectInfo');" class="huise">7天联系过(<font class="contect">0</font>)</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">机会关怀</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">生日关怀</a> 
										<a href="javascript:;" class="underline huise on">节日关怀</a>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg02">销售管理</h3>
						<p class="toptext">
							这里是销售管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong>
										<a href="javascript:;" onclick="addTabList(this,'registration');" class="blue" style="text-decoration:none">预定</a>
									</strong>
									<span class="w300th">
										<a href="javascript:;"  onclick="fbStart('新建住宅','<%=BaseAction.rootLocation %>/department.sale/web/subscribe/subscribe_residential_add.jsp?DepartmentEnum=SALE&&subscribeType=RESIDENTIAL',620,332);" class="huise">+住宅</a>
										<a href="javascript:;"  onclick="fbStart('新建商铺','<%=BaseAction.rootLocation %>/department.sale/web/subscribe/subscribe_residential_add.jsp?DepartmentEnum=SALE&&subscribeType=SHOP',620,332);" class="huise">+商铺</a>
										<a href="javascript:;" class="huise">+车位</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'contract','XSHT');" style="text-decoration:none">销售合同</a></strong>
							    	<span><a href="javascript:;" onclick="addNewTab(this,'contract','XSHT',650,485);" class="huise">+合同</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">提醒</a></strong> 
									<span class="w300th">
										<a id="subscribeId" href="javascript:;" onclick="parent.addTab('所有预订','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation%>/department.sale/web/subscribe/subscribe_residential_list.jsp');" class="huise"></a>
										<a href="javascript:;" class="huise">结算提醒(<font>N</font>)</a> 
										<a href="javascript:;" class="huise">催缴提醒(<font>N</font>)</a> 
										<a href="javascript:;" class="huise">(默认为15天)</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">近期签约</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">住宅(<font>N</font>)</a> 
										<a href="javascript:;" class="underline huise on">商铺(<font>N</font>)</a> 
										<a href="javascript:;" class="underline huise">车位(<font>N</font>)</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">销售统计</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">住宅</a> 
										<a href="javascript:;" class="underline huise on">商铺</a> 
										<a href="javascript:;" class="underline huise">车位</a>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg03">租赁管理</h3>
						<p class="toptext">
							这里是租赁管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" onclick="addTabList(this,'contract','ZLHT');">租赁合同</a></strong> 
									<span><a href="javascript:;" onclick="addNewTab(this,'contract','ZLHT',650,485);" class="underline huise">+合同</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">提醒</a></strong> 
									<span><a href="javascript:;" class="underline huise on">+结算提醒(<font>N</font>)</a></span>
								</p>
							</li>
						</ul>
					</div>

				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg04">楼宇管理</h3>
						<p class="toptext">这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue">楼宇管理</a></strong> 
									<span>
										<a href="javascript:;" onclick="parent.addTab('楼宇管理','core/common/images/console.png','<%=BaseAction.rootLocation%>/project/park!list.action?department=SALE');" class="underline huise">楼宇房源定义</a> 
										<%-- <a href="javascript:;" onclick="fbStart('房源定义','<%=BaseAction.rootLocation %>/project/room!addRoom.action?department=SALE',800,463);" class="underline huise">房源定义</a> --%> 
										<a href="javascript:;" class="underline huise on">车位定义</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" onclick="parent.addTab('房源','core/common/images/console.png','<%=BaseAction.rootLocation%>/project/web/building/building_room_list.jsp?department=SALE');" class="blue">房源</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">置空住宅</a> 
										<a href="javascript:;" class="underline huise on">置空商铺</a> 
										<a href="javascript:;" class="underline huise">置空车位</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">定价</a></strong> 
									<span><a href="javascript:;" class="huise"></a></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg05">客户管理</h3>
						<p class="toptext">这里客户管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" onclick="addTabList(this,'customer')" class="blue">客户</a></strong> 
									<span><a href="javascript:;" onclick="addNewTab(this,'customer',null,700,520)" class="underline huise on">+客户</a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">客户关怀</a></strong> 
									<span>
										<a href="javascript:;" class="underline huise">生日关怀</a> 
										<a href="javascript:;" class="underline huise on">节日关怀</a>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg06">辅助</h3>
						<p class="toptext">
							这里是辅助的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>

						<ul>
							<li class="main2">
								<p class="text">
									<strong class="fourtext num"><a href="javascript:;" class="blue">销售公告</a>(<font>N</font>)</strong>
									<span><a href="javascript:;" class="underline huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">附件材料</a></strong> 
									<span><a href="javascript:;" class="underline huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">业务转交</a></strong> 
									<span><a href="javascript:;" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">销售总览</a></strong> 
									<span><a href="javascript:;" class="underline huise"></a></span>
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
