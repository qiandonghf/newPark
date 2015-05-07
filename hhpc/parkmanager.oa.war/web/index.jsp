<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>办公管理系统</title>
<link rel="stylesheet" type="text/css" href="core/common/style/index.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/tab.css"/>

<script type="text/javascript" src="core/common/js/index.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript"> 
<!--tab滚动开始-->
$(document).ready(function(){
	initHeight();
	$("#tab_menu").width($(".tabdiv").width()-255);
	$(".sharename").click(function(){
		if($(".share").css("right")=="0px"){
		$(".share").animate({right:"-272px"});
		}else{
		$(".share").animate({right:"0px"});
		}
	});
})
var a=0;
$(document).ready(function(){
  $(".leftframediv").click(function(){
  a=a-100;
  $("#tab_po").animate({left:a+"px"},"slow");
  });

  $(".rightramediv").click(function(){
  a=a+100;
  $("#tab_po").animate({left:a+"px"},"slow");
  });
  
  
  $("#navlist li").each(function(index){
  	$("#navlist li").eq(index).click(function(){
		$(".menu").css({display:"none"});
		$("#navlist li em").removeClass("b1").addClass("b");
		$("#navlist li em").eq(index).removeClass("b").addClass("b1");
		$(".menu").eq(index).css({display:"block"});
	});
  });
  
});
<!--tab滚动结束-->

var tab=null;
$( function() {
	  tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab_po',
		position :"top"
	});
	tab.add( {
		id :'tabIndex0',
		title :"工作台",
		url :"parkmanager.oa/web/work/workbench1.html",
		isClosed :true
	});
});


$(document).ready(function() {
            $("#navlist dd a").each(function(index) {
                $(this).click(
                        function() {
							tab.add({
								id:"tabIndex"+index,
								url: $(this).attr("href"),
								title: $(this).text(),
								isClosed :true
							});
							return false;
                        })
            })
        });

</script>
</head>

<body>

<div class="share">
	<div class="sharename"></div>
	<ul>
		<img id="shareimg" src="core/common/images/im.png" />
	</ul>
	<div class="hackbox"></div>
</div>

<div class="layeroutdiv" id="layeroutid" style="display:none">
<div class="layeroutdivjt"></div>
<div class="layeroutclose"><img src="core/common/images/closebnt.png" onclick="layermenu()" /></div>
<div class="layerout"  >
<!--layercontent-->
<div class="layercontent" >
	
	<h2><span><img src="core/common/images/MinIcons_018.png" width="30" height="30" /></span>PM系统</h2>
	<ul>
		<li><input name="" type="checkbox" value="" />招商管理</li>
		<li><input name="" type="checkbox" value="" />客户管理</li>
		<li><input name="" type="checkbox" value="" />楼于管理</li>
		<li><input name="" type="checkbox" value="" />物业管理</li>
		<li><input name="" type="checkbox" value="" />公共设施</li>
		<li><input name="" type="checkbox" value="" />合同管理</li>
		<li><input name="" type="checkbox" value="" />结算管理</li>
	</ul>
	<h2><span><img src="core/common/images/MinIcons_018.png" width="30" height="30" /></span>OA系统</h2>
	<ul>
		<li><input name="" type="checkbox" value="" />日程任务</li>
		<li><input name="" type="checkbox" value="" />公文管理</li>
		<li><input name="" type="checkbox" value="" />信息管理</li>
		<li><input name="" type="checkbox" value="" />讯通管理</li>
		<li><input name="" type="checkbox" value="" />文档管理</li>
		<li><input name="" type="checkbox" value="" />人事管理</li>
		<li><input name="" type="checkbox" value="" />行政管理</li>
	</ul>
	<h2><span><img src="core/common/images/MinIcons_018.png" width="30" height="30" /></span>CMS系统</h2>
	<ul>
		<li><input name="" type="checkbox" value="" />招商管理</li>
		<li><input name="" type="checkbox" value="" />客户管理</li>
		<li><input name="" type="checkbox" value="" />楼于管理</li>
		<li><input name="" type="checkbox" value="" />物业管理</li>
		<li><input name="" type="checkbox" value="" />公共设施</li>
		<li><input name="" type="checkbox" value="" />合同管理</li>
		<li><input name="" type="checkbox" value="" />结算管理</li>
	</ul>
	<h2><span><img src="core/common/images/MinIcons_018.png" width="30" height="30" /></span>PS系统</h2>
	<ul>
		<li><input name="" type="checkbox" value="" />服务中心</li>
		<li><input name="" type="checkbox" value="" />消息中心</li>
	</ul>
</div>

<!--//layercontent-->
<div class="layerseave"><img src="core/common/images/save.gif" width="75" height="22" /> &nbsp; <img src="core/common/images/cancel.gif" width="75" height="22" onclick="layermenu()" style="cursor:pointer;" /></div>
</div>
</div>

<!--contant-->
<div id="contant">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top">
		<div id="sub" style="display:block;">
			<!--subnav-->
			<div id="subnav">
			<!--topico-->
			<div id="topico">
				<ul>
					<li>
					<span class="ico1" onmousemove="this.className='ico1over'" onmouseout="this.className='ico1'"></span><span class="ico2" onmousemove="this.className='ico2over'" onmouseout="this.className='ico2'"></span><span class="ico3" onmousemove="this.className='ico3over'" onmouseout="this.className='ico3'"></span><span class="ico4" onmousemove="this.className='ico4over'" onmouseout="this.className='ico4'"></span><span class="ico5" onmousemove="this.className='ico5over'" onmouseout="this.className='ico5'"></span><span class="ico6" onmousemove="this.className='ico6over'" onmouseout="this.className='ico6'"></span><span class="ico8" onmousemove="this.className='ico8over'" onmouseout="this.className='ico8'" onclick="layermenu()"></span>
					</li>
				</ul>
			</div>
			<!--//topico-->
			<!--navlist-->
			<div id="navlist">
				<ul>
					<li class="li1" ><em id="em1" class="b"></em><a href="javascript:void(0)">工作台</a>
						<div name="menuid" class="menu"  id="div1" style="display:none; height:0px;"></div>
					</li>
					<li class="li1"><em id="em2" class="b"></em><a href="javascript:void(0)" >日程任务</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div2" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa01.png" width="24" height="16" /></span><a href="javascript:void(0)">任务管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa02.png" width="24" height="16" /></span><a href="parkmanager.oa/web/workmanage/schedule_list.jsp">日程管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa03.png" width="24" height="16"/></span><a href="parkmanager.oa/web/workmanage/work_log_list.html">项目协同管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa04.png" width="24" height="16" /></span><a href="javascript:void(0)">工作汇报</a></dd>
								
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em3" class="b"></em><a href="javascript:void(0)" >公文管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div3" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa05.png" width="24" height="16"/></span><a href="parkmanager.oa/web/documentManage/documentConfig.html">公文配置</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo11" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa06.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo11','spantwo11')">发文管理</a>
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo11" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa07.png" width="24" height="16"/></span><a href="parkmanager.oa/web/documentManage/documentType.html">公文类别、模板管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="javascript:void(0)">发文拟稿</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/documentdraft.html">拟稿管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Departments_list.html">科室审核</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Head_list.html">主管领导签发</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Charge_list.html">分管领导签发</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Proofreading_list.html">发文校对</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Distribution_list.html">文件分发</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Posting_manage_list.html">发文管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Posting_search_list.html">发文查询</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_version_list.html">公文版本管理</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo12" /></span><span class="spanimg"><img src="core/common/images/menulist3-1.gif" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo12','spantwo12')">收文管理</a>
								
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo12" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Pending_receipt.html">公文签收待办</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/receipt_register.html">收文登记</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/receipt_proposed.html">收文拟办</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/Leader_list.html">领导批示</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_distribution.html">文件分发</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_undertake.html">收文承办</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_Monitor.html">收文监控</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_read.html">收文阅读</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="parkmanager.oa/web/documentManage/document_class.html">收文类别</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em4" class="b"></em><a href="javascript:void(0)">信息管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div4" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa08.png" width="24" height="16"/></span><a href="parkmanager.oa/web/news/news_list.html">新闻管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa09.png" width="24" height="16"/></span><a href="parkmanager.oa/web/news/Announcement_list.html">公告管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa010.png" width="24" height="16"/></span><a href="parkmanager.oa/web/news/info_class_list.html">信息分类</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em6" class="b"></em><a href="javascript:void(0)" >通讯管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div6" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa011.png" width="24" height="16"/></span><a href="<%=basePath %>cardGroup!list.action">名片夹</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo10" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa012.png" width="18" height="25"/></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo10','spantwo10')">站内邮件</a>
									<!--三级菜单-->
								<div name="menuidtwo" id="divtwo10" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa013.png" width="24" height="16"/></span><a href="parkmanager.oa/web/communication/write_list.html" target="rightmain">收件箱</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa014.png" width="24" height="16"/></span><a href="parkmanager.oa/web/communication/write_list.html">发件箱</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa015.png" /></span><a href="parkmanager.oa/web/communication/write_list.html">草稿箱</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa015.png" /></span><a href="parkmanager.oa/web/communication/write_list.html">垃圾箱</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa016.png" /></span><a href="javascript:void(0)">外部邮件</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em7" class="b"></em><a href="javascript:void(0)">文档管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div7" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa03.png" /></span><a href="<%=basePath %>web/document/personaldocuments_list.jsp" target="rightmain">个人文档</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa017.png" /></span><a href="<%=basePath %>web/document/share_document_list.jsp" target="rightmain">共享文档</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa018.png" /></span><a href="<%=basePath %>web/document/Folder_Transfer_list.jsp" target="rightmain">文件夹转移</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa019.png" /></span><a href="<%=basePath %>web/document/personaldocuments_view_list.jsp" target="rightmain">查看公共文档</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em8" class="b"></em><a href="javascript:void(0)">人事管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div8" style="display:none;">
							<dl>
								
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo2" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa020.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo2','spantwo2')">考勤设置</a>
									<!--三级菜单-->
								<div name="menuidtwo" id="divtwo2" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa021.png"/></span><a href="parkmanager.oa/web/personnel/holiday_set_list.html" target="rightmain">假期设置</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa022.png"/></span><a href="parkmanager.oa/web/personnel/frequency_list.html" target="rightmain">班次定义</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa023.png"/></span><a href="parkmanager.oa/web/personnel/shifts_list.html" target="rightmain">班制定义</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa024.png"/></span><a href="parkmanager.oa/web/personnel/scheduling_list.html" target="rightmain">排班管理</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa025.png"/></span><a href="parkmanager.oa/web/personnel/attendance_list.html" target="rightmain">考勤信息</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo3" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa026.png"/></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo3','spantwo3')">人力资源</a>
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo3" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa027.png" /></span><a href="parkmanager.oa/web/personnel/job_list.html" target="rightmain">职位管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa028.png" /></span><a href="parkmanager.oa/web/personnel/file_register_list.html" target="rightmain">档案管理</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo4" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa029.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo4','spantwo4')">新酬管理</a>
									<!--三级菜单-->
								<div name="menuidtwo" id="divtwo4" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa030.png" /></span><a href="parkmanager.oa/web/personnel/newpay.html" target="rightmain">新酬项目</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa031.png" /></span><a href="parkmanager.oa/web/personnel/standards_list.html" target="rightmain">标准制定</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa032.png" /></span><a href="parkmanager.oa/web/personnel/fafang_register_add.html" target="rightmain">发放登记</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa033.png" /></span><a href="parkmanager.oa/web/personnel/fafang_register_list.html" target="rightmain">发放审核</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa034.png"/></span><a href="javascript:void(0)">调动管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa035.png" /></span><a href="javascript:void(0)">招聘管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa028.png" /></span><a href="javascript:void(0)">简历管理</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					
					<li class="li1" ><em id="em9" class="b"></em><a href="javascript:void(0)" >行政管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div9" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo5" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa036.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo5','spantwo5')">办公用品</a>
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo5" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa037.png" /></span><a href="<%=basePath %>supplyCategory!list.action" target="rightmain">办公用品管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa038.png" /></span><a href="<%=basePath %>supplyStockIn!list.action" target="rightmain">办公用品入库</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa022.png" /></span><a href="<%=basePath %>web/chiefadmin/Office_supplies_sq.html" target="rightmain">办公用品申请</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa040.png"/></span><a href="javascript:void(0)">出差管理</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo6" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa041.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo6','spantwo6')">外出请假</a>
									<!--三级菜单-->
								<div name="menuidtwo" id="divtwo6" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa042.png"/></span><a href="parkmanager.oa/web/personnel/Leaveout_list.html" target="rightmain">请假登记</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa043.png" /></span><a href="parkmanager.oa/web/personnel/outregister_list.html" target="rightmain">外出登记</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa044.png" /></span><a href="javascript:void(0)">印章管理</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo7" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa045.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo7','spantwo7')">车辆管理</a>
									<!--三级菜单-->
								<div name="menuidtwo" id="divtwo7" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa046.png" /></span><a href="parkmanager.oa/web/chiefadmin/Vehicle_list.html" target="rightmain">车辆管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa047.png" /></span><a href="parkmanager.oa/web/chiefadmin/Vehicle_maintenance_list.html" target="rightmain">车辆维修管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa048.png" /></span><a href="parkmanager.oa/web/chiefadmin/Vehicle_applications_list.html" target="rightmain">车辆申请管理</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa049.png" /></span><a href="javascript:void(0)">接待管理</a></dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo8" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa029.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo8','spantwo8')">固定资产</a>
								
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo8" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa050.png" /></span><a href="parkmanager.oa/web/chiefadmin/oldtype_list.html" target="rightmain">折旧类型管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa030.png" /></span><a href="parkmanager.oa/web/chiefadmin/fixedassets_list.html" target="rightmain">固定资产管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa051.png" /></span><a href="parkmanager.oa/web/chiefadmin/old_list.html" target="rightmain">折旧记录管理</a></dd>
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo9" /></span><span class="spanimg"><img src="parkmanager.oa/web/images/oa052.png" /></span><a href="javascript:void(0)" onclick="menudlistwo('divtwo9','spantwo9')">图书管理</a>
								
								<!--三级菜单-->
								<div name="menuidtwo" id="divtwo9" style="display:block;">
									<dl>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa053.png" /></span><a href="parkmanager.oa/web/chiefadmin/booktype_list.html" target="rightmain">图书类别管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa054.png" /></span><a href="parkmanager.oa/web/chiefadmin/book_list.html" target="rightmain">图书管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa055.png" /></span><a href="parkmanager.oa/web/chiefadmin/borrowing_list.html" target="rightmain">图书借阅管理</a></dd>
										<dd class="menuli"><span class="spanico2"><img src="parkmanager.oa/web/images/oa056.png" /></span><a href="parkmanager.oa/web/chiefadmin/bookreturned_to_list.html" target="rightmain">图书归还管理</a></dd>
										
									</dl>
								</div>
								<!--//三级菜单-->
								</dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/oa034.png" /></span><a href="javascript:void(0)">协同工作</a></dd>
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
					<li class="li1" ><em id="em10" class="b"></em><a href="javascript:void(0)" >项目管理</a>
						<!--二级菜单-->
						<div class="menu" name="menuid" id="div10" style="display:none;">
							<dl>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/page_edit.gif" /></span><a href="javascript:void(0)">招标管理</a></dd>						
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/page_java.gif" /></span><a href="projectadmin/project_Suppliers_list.html">供应商管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/page_package.gif" /></span><a href="projectadmin/contact_list.html">联系人管理</a></dd>
								<dd class="menuli"><span class="spanico"><img src="parkmanager.oa/web/images/page_alert.gif" /></span><a href="projectadmin/project_contract_list.html" >项目管理</a></dd>
								<!--<dd class="menuli"><span class="spanico"><img src="core/common/images/menuone.gif" /></span><a href="projectadmin/contract_admin_list.html" target="rightmain">合同管理</a></dd>-->
							</dl>
						</div>
						<!--//二级菜单-->
					</li>
				</ul>
			</div>
			<!--//navlist-->
			</div>
			
			<!--//subnav-->
		  </div>
		</td>
		<td><div id="subscroll"><img src="core/common/images/scrollleft.gif" width="7" height="45" id="disbtn" onclick="displays();" /></div></td>
        <td valign="top" id="content">
		<div class="tabdivall">
		<!--tabdiv-->
		<div class="tabdiv">
		<div class="rightramediv"><img src="core/common/images/rightframeico.gif" style="cursor:pointer;" /></div>
		<div class="leftframediv"><img src="core/common/images/leftframeico.gif" style="cursor:pointer;" /></div>
		<div id="tab_menu" style=" position:relative;"></div>
		</div>
		<!--//tabdiv-->
		</div>
		<div id="page"></div>
		</td>
      </tr>
  </table>
<!--footer-->
<div id="footer">Copyright ©2010 www.complay.com  |   Tel: 0571-88881234</div>
<!--//footer-->
</div>
<!--//contant-->
</body>
</html>
