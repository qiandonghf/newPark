<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.core.entity.User"%>
<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
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
<title>园区动力-招商管理</title>
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
	
	function initLevelEnum(){
		$("#level").children().eq(0).remove();
		$("#level").hide();
		var children = $("#level").children();
		var html = "";
		$(children).each(function(i){
			var txt = $(this).text();
			var type = $(this).val();
			html+= '<a href=\"javascript:;\" onclick=\"addTabList(this,\'client\',\''+txt+'\',\''+type+'\',\'\',\'investmentContectInfo\')\" class=\"huise\">'+txt+'</a>';
		});
		if(html != ''){
			$("#levelList").html(html);
		}
	}

	$(function(){
		initTip();
		initCount('warnCount','contract!warnCount');
		//所有线索
		initInfos(false,'investmentContectInfo!contectInfos');
		//我的线索
		initInfos(true,'investmentContectInfo!contectInfos');
		//所有跟进
		initContect('countNotContectAll','investmentContectInfo!countNotContectAll');
		initContect('countNotContectMy','investmentContectInfo!countNotContectMy');
		initContect('countNeedContectAll','investmentContectInfo!countNeedContectAll');
		initContect('countNeedContectMy','investmentContectInfo!countNeedContectMy');
		initContect('countHadContectAll','investmentContectInfo!countHadContectAll');
		initContect('countHadContectMy','investmentContectInfo!countHadContectMy');
		initLevelEnum();
		/* initCount('remindCount','billPlanRent!remindCount');
		initCount('expireCount','contract!expireCount');
		initCount('recentCount','contract!recentCount'); */
		initCount('dueContract','contract!dueCount');
		initCount('rentoffContract','contract!rentoffCount');
		initCount('reletContract','contract!reletCount');
		initCount('rentoffBail','bail!bail');
		initCount('reletBail','bail!bail');
		initCount('registCount','registrationBook!registCount');//预订提醒数量
		initCount('executeCounts','contract!executeContractCounts');//待执行合同数量
		initRemindCount();//结算提醒数量(remindCount,BUSINESS_ZJ,BUSINESS_YJ,BUSINESS_GKF)
		initBillRemindCount();//账单催缴提醒数量
	});
	
	function initBillRemindCount(){
		$.ajax({
			   type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.business/businessBillRemind!initRemindCount.action",
			   success	: function(data){
				   if(data.result!=null){
					   var map = data.result.value;
					   var totalCount = 0;
					   for(var key in map){
						   $("#"+key+"2").html(map[key]);
						   totalCount += map[key];
					   }
					   $("#remindCount2").html(totalCount);
				   }
			   }
			});
	}
	
	function initRemindCount(){
		$.ajax({
			   type		: "POST",
			   url		: "<%=BaseAction.rootLocation%>/department.business/billPlanRent!initRemindCount.action",
			   success	: function(data){
				   if(data.result!=null){
					   var map = data.result.value;
					   var totalCount = 0;
					   for(var key in map){
						   $("#"+key).html(map[key]);
						   totalCount += map[key];
					   }
					   $("#remindCount").html(totalCount);
				   }
			   }
			});
	}
	
	function addNewTab(obj,type,content,width,height,actionName,type2){
		if(!actionName) actionName = 'department.business';
		if(!type2) type2 = type;
		var title = "新建"+$(obj).text();
		if($(obj).text().indexOf("+") != -1){
			title = "新建"+$(obj).text().substr(1);
		}
		var url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type+"_add.jsp";
		if(type == 'client'){
			url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type2+"_add.jsp";
		}
		if(type == 'contract')
			url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type2;
		if(content){
			url += "?type="+content;
		}
		fbStart(title,url,width,height);
	}
	
	function addTabList(obj,type,content,msg,actionName,type2){
		if(!actionName) actionName = 'department.business';
		if(!type2) type2 = type;
		var title = "";
		if(obj)
		 	title = $(obj).text();
		if(title.indexOf("(") != -1){
			title = title.substr(0,title.indexOf("("));
			title ="线索";
		}
		if(msg)
		 title = msg;
		var icon = 'core/common/images/console.png';
		var url = "<%=BaseAction.rootLocation%>/"+actionName+"/web/"+type+"/"+type2+"_list.jsp";
		if(content){
			url += "?type="+content;
		}
		parent.addTab(title,icon,url);
	}
	
	function addCustomTab(title,icon,url){
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
	
	function initCount(id,actionName){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/"+actionName+".action",
		   success	: function(data){
			   $("#"+id).text(data.result.value);
		   }
		});
	}
	
	function initContect(id,actionName){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/"+actionName+".action",
		   success	: function(data){
			   $("#"+id+"7").text(data.data7);
			   $("#"+id+"15").text(data.data15);
			   $("#"+id+"30").text(data.data30);
		   }

		});
	}


	//区分所有的和我的线索等级
	function initInfos(type,actionName){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/"+actionName+".action?who="+type,
		   success	: function(data){
			   var map = data.result.value;
			   var nums = new Array();
			   nums.push(map.A);
			   nums.push(map.B);
			   nums.push(map.C);
			   nums.push(map.D);
			   for(var i = 0;i < nums.length;i++){
				   if(type){
					   $(".info").eq(4+i).text(nums[i]);
				   }else{
					   $(".info").eq(i).text(nums[i]);
				   }
			   }			  
		   } 
		});
	}
	

	/*线索统计*/
	function opportunityStatic(){
		var url = '<%=BaseAction.rootLocation%>/department.business/investmentContectInfo!opportunityStatistic.action';
		window.open(url,'线索统计','height=500,width=820,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
	}
	
	/*重新加载*/
	function reloadList(type){
		switch(type){
		case 'contectInfo':
			addTabList(null,type,null,'销售线索');
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
		}
		location.reload();
	}
	
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
	
	function addCustomer(id){
		var url = '<%=BaseAction.rootLocation %>/department.business/investment!addCustomer.action?id='+id;
		setTimeout(function(){fbStart('新建',url,700,519);},100);
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

		<div id="news_contenter" class="main" style="padding-left: 30px; padding-top: 10px;">

			<div class="toptitle">
				<p>
					<strong>招商管理</strong><span class="subtitle">ParkBusiness</span><br />
					<span class="toptitle_bg">这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0201">招商机会</h3>
						<p class="toptext">
							这里是招商机会的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">招商线索</a></strong> 
									<span class="w300th">
									<!--权限判断,admin登录都可以看到,自己登录只能看到自己的  -->
										<a href="javascript:;"  onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp');" class="huise">所有线索</a>
										<a href="javascript:;"  onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes');" class="huise">我的线索</a>
										<a href="javascript:;"  onclick="fbStart('新建来电','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_add.jsp?contectType=LD',550,320);" class="huise">+来电</a>
										<a href="javascript:;"  onclick="fbStart('新建来电','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_add.jsp?contectType=LF',550,320);" class="huise">+来访</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">线索等级</a></strong> 
									<span id="levelList" class="w300th">
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp');" class="huise">所有</a>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?enumLevel=A');" class="huise">A(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?enumLevel=B');" class="huise">B(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?enumLevel=C');" class="huise">C(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?enumLevel=D');" class="huise">D(<font class="info" style="color: blue">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes');" class="huise">我的</a>
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&enumLevel=A');" class="huise">A(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&enumLevel=B');" class="huise">B(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&enumLevel=C');" class="huise">C(<font class="info" style="color: blue">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&enumLevel=D');" class="huise">D(<font class="info" style="color: blue">0</font>)</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">线索跟进</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp');" class="huise">所有:</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=7&sCommentType=NOT');" class="huise">7天未联系(<font id="countNotContectAll7">0</font>)</a>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=15&sCommentType=NOT');" class="huise">15天未联系(<font id="countNotContectAll15">0</font>)</a>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=30&sCommentType=NOT');" class="huise">30天未联系(<font id="countNotContectAll30">0</font>)</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=7&sCommentType=NEED');" class="huise">7天需联系(<font id="countNeedContectAll7">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=15&sCommentType=NEED');" class="huise">15天需联系(<font id="countNeedContectAll15">0</font>)</a>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=30&sCommentType=NEED');" class="huise">30天需联系(<font id="countNeedContectAll30">0</font>)</a>  
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('所有线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?iDay=7&sCommentType=HAD');" class="huise">7天联系过(<font id="countHadContectAll7">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes');" class="huise">我的:</a>
										<span style="clear:both;"></span>
										 <a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=7&sCommentType=NOT');" class="huise">7天未联系(<font id="countNotContectMy7">0</font>)</a> 
										 <a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=15&sCommentType=NOT');" class="huise">15天未联系(<font id="countNotContectMy15">0</font>)</a> 
										 <a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=30&sCommentType=NOT');" class="huise">30天未联系(<font id="countNotContectMy30">0</font>)</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=7&sCommentType=NEED');" class="huise">7天需联系(<font id="countNeedContectMy7">0</font>)</a> 
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=15&sCommentType=NEED');" class="huise">15天需联系(<font id="countNeedContectMy15">0</font>)</a>
										<a href="javascript:;" onclick="parent.addTab('我的线索','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=30&sCommentType=NEED');" class="huise">30天需联系(<font id="countNeedContectMy30">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('我的线索	','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/client/investmentContectInfo_list.jsp?my=yes&iDay=7&sCommentType=HAD');" class="huise">7天联系过(<font id="countHadContectMy7">0</font>)</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">招商预订</a></strong>
									<span class="w300th">
										<a href="javascript:;"  onclick="parent.addTab('所有预订','/department.synthesis/web/images/icon/sealdj_min.png','<%=BaseAction.rootLocation %>/department.business/web/registration/registration_list.jsp');" class="huise">所有预订</a>
										<a href="javascript:;"  onclick="fbStart('新建预订','<%=BaseAction.rootLocation %>/department.business/web/registration/registration_add.jsp?form=index',620,360);" class="huise">+预订</a>
										<a href="javascript:;"  onclick="parent.addTab('所有预订','/department.synthesis/web/images/icon/sealdj_min.png','<%=BaseAction.rootLocation %>/department.business/web/registration/registration_list.jsp?type=remind');" class="huise">预订提醒(<font id="registCount">0</font>)</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">招商项目</a></strong>
									<span class="w300th">
										<!-- 权限判断，显示所有/我的 -->
										<a href="javascript:;"  onclick="parent.addTab('所有项目','/department.business/web/images/icon/projectadmin_01_min.png','<%=BaseAction.rootLocation %>/department.business/investment!list.action');" class="huise">所有项目</a> 
										<a href="javascript:;"  onclick="fbStart('新建项目','<%=BaseAction.rootLocation %>/department.business/web/investment/investment_my_add.jsp?form=index',720,538);" class="huise">+项目</a> 
										<a href="javascript:;"  onclick="fbStart('新建项目跟进','<%=BaseAction.rootLocation %>/department.business/web/investment/investmentLog_add2.jsp?form=index',500,320);" class="huise">+项目跟进</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;"  onclick="parent.addTab('我的项目','/department.business/web/images/icon/projectadmin_02_min.png','<%=BaseAction.rootLocation %>/department.business/investment!myList.action');" class="huise">我的项目</a> 
										<a href="javascript:;"  onclick="fbStart('新建项目','<%=BaseAction.rootLocation %>/department.business/web/investment/investment_my_add.jsp?form=index',720,538);" class="huise">+项目</a> 
										<a href="javascript:;"  onclick="fbStart('新建项目跟进','<%=BaseAction.rootLocation %>/department.business/web/investment/investmentLog_add2.jsp?form=index',500,320);" class="huise">+项目跟进</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">招商统计</a></strong> 
									<span><a href="javascript:;" onclick="opportunityStatic()" class="huise">机会统计</a> </span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0202">合同管理</h3>
						<p class="toptext">
							这里是合同管理的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">标准合同</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="downLoad('attachments/oa/201412191501499.doc','大厦合同');" class="huise">大厦合同</a> 
										<a href="javascript:;" onclick="downLoad('attachments/oa/201412191501499.doc','厂房合同');" class="huise">厂房合同</a> 
										<a href="javascript:;" onclick="downLoad('attachments/oa/201412191501499.doc','虚拟合同');" class="huise">虚拟合同</a> 
										<a href="javascript:;" onclick="downLoad('attachments/oa/201412191501499.doc','终止协议');" class="huise">终止协议</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">合同客户</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="addTabList(this,'client','business','','','customer')" class="huise">所有客户</a> 
										<a href="javascript:;" onclick="fbStart('项目选择','<%=BaseAction.rootLocation %>/department.business/investment!select.action?type=import',520,400);" class="huise">导入客户</a> 
									</span>
								</p>
								<p class="text">
						    		<strong><a href="javascript:;" class="blue" style="text-decoration:none">合同信息</a></strong> 
									<span class="w300th">
							    		<a href="javascript:;" onclick="addTabList(this,'contract',null,'所有合同');" class="huise">所有合同</a>
							    		<a href="javascript:;" onclick="addTabList(this,'contract','execute','所有合同');" class="huise">待生效合同(<font class="info" id="executeCounts" style="color: blue">0</font>)</a>
										<span style="clear:both;"></span>
							    		<a href="javascript:;" onclick="addNewTab(this,'contract','DSZLHT',750,493,null,'contract_add_customer_rent_1.jsp');" class="huise">+大厦租赁合同</a>
							    		<a href="javascript:;" onclick="addNewTab(this,'contract','CFZLHT',750,493,null,'contract_add_customer_rent_2.jsp');" class="huise">+厂房租赁合同</a>
										<a href="javascript:;" onclick="addNewTab(this,'contract','FHXY',750,493,null,'contract_add_customer_rent_3.jsp');" class="huise">+虚拟合同</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('到期合同','/department.business/web/images/icon/contract_07_min.png','<%=BaseAction.rootLocation %>/department.business/web/contract/contract_listByEndDate.jsp');" class="huise">到期合同(<font id="dueContract" style="color: blue">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('退租合同','/department.business/web/images/icon/contract_04_min.png','<%=BaseAction.rootLocation %>/department.business/web/contract/contract_listByParkStatus.jsp');" class="huise on">退租合同(<font id="rentoffContract" style="color: blue">0</font>)</a> <span class="spanhuise">（默认为30天）</span>
										<a href="javascript:;" onclick="parent.addTab('退租登记','/department.business/web/images/icon/contract_04_min.png','<%=BaseAction.rootLocation %>/department.business/web/bail/bail_list.jsp?');" class="huise">退租登记(<font id="rentoffBail" style="color: blue">0</font>)</a>
										<span style="clear:both;"></span>
										<a href="javascript:;" onclick="parent.addTab('续租合同','/department.business/web/images/icon/contract_05_min.png','<%=BaseAction.rootLocation %>/department.business/web/contract/contract_listRelet.jsp');" class="huise">续租合同(<font id="reletContract" style="color: blue">0</font>)</a><span class="spanhuise">（默认为30天）</span>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">提醒</a></strong> 
									<span class="w300th">
										<a href="javascript:;" class="huise" onclick="parent.addTab('结算提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/bill!checkoutListBillPlanRent.action');">结算提醒(<font id="remindCount">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('结算提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/bill!checkoutListBillPlanRent.action?feeType=BUSINESS_ZJ');">招商租金(<font id="BUSINESS_ZJ">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('结算提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/bill!checkoutListBillPlanRent.action?feeType=BUSINESS_YJ');">招商押金(<font id="BUSINESS_YJ">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('结算提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/bill!checkoutListBillPlanRent.action?feeType=BUSINESS_GKF');">招商挂靠费(<font id="BUSINESS_GKF">0</font>)</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" class="huise" onclick="parent.addTab('催缴提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/bill/billRemind_list.jsp');">催缴提醒(<font id="remindCount2">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('催缴提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/bill/billRemind_list.jsp?feeType=BUSINESS_ZJ');">招商租金(<font id="BUSINESS_ZJ2">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('催缴提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/bill/billRemind_list.jsp?feeType=BUSINESS_YJ');">招商押金(<font id="BUSINESS_YJ2">0</font>)</a> 
										<a href="javascript:;" class="huise" onclick="parent.addTab('催缴提醒','/department.business/web/images/icon/account_01_min.png','<%=BaseAction.rootLocation %>/department.business/web/bill/billRemind_list.jsp?feeType=BUSINESS_GKF');">招商挂靠费(<font id="BUSINESS_GKF2">0</font>)</a> 
										<span style="clear:both;"></span>
										<a href="javascript:;" class="huise" onclick="addTabList(this,'contract',null,'合同到期',null,'contractWarn');">合同到期(<font id="warnCount">N</font>)</a>
										<span class="spanhuise">（默认为30天）</span> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">近期签约</a></strong> 
									<span class="w300th">
										<a href="javascript:;" class="huise" onclick="addTabList(this,'contract','recent','租赁合同');">租赁合同(<font id="recentCount">0</font>)</a> 
										<span class="spanhuise">（默认为15天）</span> 
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">合同统计</a></strong> 
									<span class="w300th">
										<a href="javascript:;" class="huise">客户收费情况表</a> 
										<a href="javascript:;" class="huise">费用情况报表</a> 
									</span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0203">房源管理</h3>
						<p class="toptext">这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">楼宇管理</a></strong> 
									<span>
										<a href="javascript:;" onclick="parent.addTab('楼宇管理','core/common/images/console.png','<%=BaseAction.rootLocation%>/project/park!list.action?department=BUSINESS');" class="huise">楼宇房源定义</a>
										<%-- <a href="javascript:;" onclick="fbStart('房源定义','<%=BaseAction.rootLocation %>/project/room!addRoom.action?department=BUSINESS',800,463);" class="huise">房源定义</a> --%>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">租空房源</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="parent.addTab('置空单元','/project/web/images/icon/house_03_min.png','<%=BaseAction.rootLocation%>/project/web/building/building_roomIdle_list.jsp');" class="huise">置空</a>
										<a href="javascript:;" onclick="parent.addTab('到期单元','/project/web/images/icon/house_04_min.png','<%=BaseAction.rootLocation%>/project/web/building/building_roomExpires_list.jsp?type=expire');" class="huise">到期</a> <span class="spanhuise">（30天内）</span>
										<a href="javascript:;" onclick="parent.addTab('占用单元','/project/web/images/icon/house_02_min.png','<%=BaseAction.rootLocation%>/project/web/building/building_room_list.jsp?type=occupy');" class="huise">占用</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">租赁统计</a></strong> 
									<span>
										<a href="javascript:;" onclick="parent.addTab('楼宇总览','/project/web/images/icon/house_05_min.png','<%=BaseAction.rootLocation%>/project/building!buildingCensus.action');" class="huise">楼宇总览</a> 
										<a href="javascript:;" onclick="parent.addTab('出租率统计','/project/web/images/icon/house_05_min.png','<%=BaseAction.rootLocation%>/project/building!buildingRent.action');" class="huise">出租率统计</a> 
										<a href="javascript:;" onclick="parent.addTab('出租明细表','/project/web/images/icon/house_05_min.png','<%=BaseAction.rootLocation%>/project/room!rentDetail.action');" class="huise">出租明细表</a> 
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0204">辅助</h3>
						<p class="toptext">这里是辅助的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字介绍，文字介绍稍后提供，这里是招商机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong class="fourtext num"><a href="javascript:;" class="blue" style="text-decoration:none">销售公告</a>(<font>N</font>)</strong>
									<span><a href="javascript:;" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue" style="text-decoration:none">附件材料</a></strong> 
									<span><a href="javascript:;" onclick="parent.addTab('招商材料','/project/web/images/icon/house_03_min.png','<%=BaseAction.rootLocation%>/parkmanager.cms/web/document/share_document_list.jsp?type=business');" class="huise">招商材料</a></span>
								</p>
								<p class="text">
									<strong>
									<a href="javascript:;" class="blue" style="text-decoration:none">业务转交</a></strong> 
									<span>
										<a href="javascript:;" onclick="fbStart('指派转交','<%=BaseAction.rootLocation %>/department.business/web/investment/assigneTo.jsp',430,130);" class="huise">指派转交</a>
									</span>
								</p>
								<p class="text">
									<strong>
									<a href="javascript:;" class="blue" style="text-decoration:none">模板定义</a></strong> 
									<span>
										<a href="javascript:;" onclick="parent.addTab('合同模板','/department.business/web/images/icon/contract_05_min.png','<%=BaseAction.rootLocation %>/department.business/web/contract/contractTemplate_list.jsp');" class="huise">所有模板</a>
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
