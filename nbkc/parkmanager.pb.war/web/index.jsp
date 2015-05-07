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
<title>园区管理系统</title>
<link rel="stylesheet" type="text/css" href="core/common/style/index.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/tab.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/js/index.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initHeight(123);
		initTab();
		initMenu();
	});
</script>
</head>

<body>
<div id="contant">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td rowspan="2" valign="top">
				<div id="sub" style="display:block;">
					<div id="subnav">
						<div id="topico">
							<ul>
								<li>
								<span class="ico1" onmousemove="this.className='ico1over'" onmouseout="this.className='ico1'"></span><span class="ico2" onmousemove="this.className='ico2over'" onmouseout="this.className='ico2'"></span><span class="ico3" onmousemove="this.className='ico3over'" onmouseout="this.className='ico3'"></span><span class="ico4" onmousemove="this.className='ico4over'" onmouseout="this.className='ico4'"></span><span class="ico5" onmousemove="this.className='ico5over'" onmouseout="this.className='ico5'"></span><span class="ico6" onmousemove="this.className='ico6over'" onmouseout="this.className='ico6'"></span><span class="ico7" onmousemove="this.className='ico7over'" onmouseout="this.className='ico7'"></span>					</li>
							</ul>
						</div>
						<div id="navlist">
							<ul>
								<li class="li1"><em id="em1" class="b"></em><a href="javascript:void(0)">工作台</a>
									<div name="menuid" class="pmmenu"  id="div1" style="display:none; height:0px;"></div>
								</li>
								<li class="li1"><em id="em2" class="b"></em><a href="javascript:void(0);" >招商管理</a>
									<div class="pmmenu" name="menuid" id="div2" style="display:none;">
										<dl>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/file.gif" width="16" height="16" /></span><a href="<%=basePath %>investment!list.action" class="tt">招商项目</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/file.gif" width="16" height="16" /></span><a href="<%=basePath %>web/investment/investmentLog_list2.jsp" class="tt">招商轨迹</a></dd>
										</dl>
									</div>
								</li>
								<li class="li1"><em id="em3" class="b"></em><a href="javascript:void(0)" >企业管理</a>
									<div class="pmmenu" name="menuid" id="div3" style="display:none;">
										<dl>
											<dd class="menuli">
												<span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo1" /></span>
												<span class="spanimg"><img src="<%=basePath %>web/images/icon_user.gif" width="16" height="16" /></span>
												<a href="javascript:void(0)" onclick="menuHandle(this)">企业档案</a>
												<div name="menuidtwo" id="divtwo1" style="display:block;">
													<dl>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/icon_user.gif" width="16" height="16" /></span><a href="<%=basePath %>customer!list.action" class="tt">企业档案</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/list_users.gif" width="16" height="16" /></span><a href="<%=basePath %>web/client/contect_list.jsp" class="tt">联系人</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/page_boy.gif" width="16" height="16" /></span><a href="<%=basePath %>web/client/contectInfo_list.jsp" class="tt">交往信息</a></dd>
													</dl>
												</div>
											</dd>
											<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo2" /></span><span class="spanimg"><img src="<%=basePath %>web/images/note.gif" width="16" height="16" /></span><a href="javascript:void(0)" onclick="menuHandle(this)">项目产品</a>
												<div name="menuidtwo" id="divtwo2" style="display:block;">
													<dl>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/options.gif" width="16" height="16" /></span><a href="<%=basePath %>web/client/product_list.jsp" class="tt">项目与产品管理</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/interface_dialog.gif" width="16" height="16" /></span><a href="<%=basePath %>web/client/projectApply_list.jsp" class="tt">项目申报情况</a></dd>
													</dl>
												</div>
										  	</dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/male.gif" width="16" height="16" /></span><a href="<%=basePath %>web/client/staffer_list.jsp" class="tt">主要人员</a></dd>
											<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo3" /></span><span class="spanimg"><img src="<%=basePath %>web/images/save.gif" width="16" height="16" /></span><a href="javascript:void(0)" onclick="menuHandle(this)">知识产权</a>
												<div name="menuidtwo" id="divtwo3" style="display:block;">
													<dl>
														<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="<%=basePath %>web/client/patent_list.jsp" class="tt">专利</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="<%=basePath %>web/client/copyright_list.jsp" class="tt">著作权</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="core/common/images/menuone.gif" /></span><a href="<%=basePath %>web/client/certification_list.jsp" class="tt">认证</a></dd>
													</dl>
												</div>
										  	</dd>
											<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo4"/></span><span class="spanimg"><img src="<%=basePath %>web/images/nIco8.gif" width="18" height="16" /></span><a href="javascript:void(0)" onclick="menuHandle(this)">数据填报</a>
												<div name="menuidtwo" id="divtwo4" style="display:block;">
													<dl>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/table.gif" width="16" height="16" /></span><a href="<%=basePath %>dataTemplate!list.action" class="tt">数据模板设置</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/page_edit.gif" width="16" height="16" /></span><a href="<%=basePath %>dataReportDef!list.action" class="tt">企业数据填报</a></dd>
													</dl>
												</div>
										  	</dd>
											<dd class="menuli">
												<span class="spanico"><img src="<%=basePath %>web/images/nIco9.gif" width="18" height="16" /></span>
												<a href="parkmanager.pb/web/client/client_stat.html" class="tt">统计</a>
											</dd>
										</dl>
									</div>
								</li>
								<li class="li1" ><em id="em7" class="b"></em><a href="javascript:void(0)">合同管理</a>
									<div class="pmmenu" name="menuid" id="div7" style="display:none;">
										<dl>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/page_edit.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/contract/contract_alert.html" class="tt">合同总览</a></dd>
											<dd class="menuli"><span class="spanicotwo"><img src="core/common/images/twomenu.gif" id="spantwo9" /></span><span class="spanimg"><img src="<%=basePath %>web/images/contract.gif" width="16" height="16" /></span><a href="javascript:void(0)" onclick="menuHandle(this)">合同管理</a>
												<div name="menuidtwo" id="divtwo9" style="display:block;">
													<dl>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/page_edit.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/contract/contract_list.html" class="tt">合同信息</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/page_find.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/contract/contract_exam.html" class="tt">合同审批</a></dd>
														<dd class="menuli"><span class="spanico2"><img src="<%=basePath %>web/images/page_text.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/contract/contract_template.html" class="tt">合同模板</a></dd>
													</dl>
												</div>
										  	</dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/page_alert.gif" width="17" height="16" /></span><a href="parkmanager.pb/web/contract/contract_alert.html" class="tt">合同预警</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/page_java.gif" width="17" height="16" /></span><a href="parkmanager.pb/web/contract/contract_expired.html" class="tt">合同过期</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/page_package.gif" width="17" height="16" /></span><a href="parkmanager.pb/web/contract/contract_deposit_list.html" class="tt">保证金</a></dd>
										</dl>
								  	</div>
								</li>
								<li class="li1"><em id="em8" class="b"></em><a href="javascript:void(0)">结算管理</a>
									<div class="pmmenu" name="menuid" id="div8" style="display:none;">
										<dl>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/salary.png" width="16" height="16" /></span><a href="parkmanager.pb/web/bill/bill_checkout.html" class="tt">费用出帐</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/salary.png" width="16" height="16" /></span><a href="parkmanager.pb/web/bill/bill_cost_clearing_list.html" class="tt">费用结算</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/resume.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/bill/bill_calculate.html" class="tt">收费测算</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/attention.gif" width="16" height="16" /></span><a href="parkmanager.pb/web/bill/bill_alert.htm" class="tt">欠费报警</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/star.gif" width="16" height="16" /></span><a href="javascript:void(0)" class="tt">滞纳金</a></dd>
											<dd class="menuli"><span class="spanico"><img src="<%=basePath %>web/images/nIco8.gif" width="16" height="16" /></span><a href="javascript:void(0)" class="tt">结算统计</a></dd>
										</dl>
								  	</div>
								</li>
							</ul>
						</div>
					</div>
				</div>		
			</td>
			<td rowspan="2"><div id="subscroll"><img id="disbtn" src="core/common/images/scrollleft.gif" onclick="leftHandle();" /></div></td>
		</tr>
		<tr>
			<td valign="top" id="content">
				<div id="tt" class="easyui-tabs"></div>
			</td>
   		</tr>
	</table>
	<div id="footer">Copyright ©2010 www.complay.com  |   Tel: 0571-88881234</div>
</div>
</body>
</html>

