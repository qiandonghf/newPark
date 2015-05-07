<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat();
request.setAttribute("date",now);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/portal.css"/>
<style type="text/css">
		.onlyOne {
			padding:0 19px 0 5px; 
			overflow:hidden; 
			color:#333; 
			text-decoration:none; 
			line-height:22px; 
			cursor:pointer;
			background:url(../../core/common/images/btn_bg.png);
		}
</style>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/portal/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript" src="core/common/portal/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/portal/jquery.portal.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">

</script>
</head>

<body>
	<div class="gWel-main-recommand-cont"
		style="padding: 0px; margin-bottom: 20px;">
		<div class="gWel-main-recommand-box2">
			<div class="lt">
				<%int flag1=-1; %>
				<ul class="console-menu2" id="console-menu">
					<c:if test="${not empty accessibleModuleMenuIds['oa_notice']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('notice',this)"><div
								class="console-btn2 csIcon09">
								<i id="notice" class="badge"></i><span>公告</span>
							</div></li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['pb_checkout']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('bill_out',this)"><div
								class="console-btn2 csIcon01">
								<i id="feeTypeList" class="badge"></i><span>出帐</span>
							</div></li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['pb_billClose']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('bill_out_list',this)"><div
								class="console-btn2 csIcon02">
								<i id="billList" class="badge"></i><span>结算</span>
							</div></li>
					</c:if>
					<%-- <c:if
						test="${not empty accessibleModuleMenuIds['pb_customerServiceContact']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('contact',this)"><div
								class="console-btn2 csIcon03">
								<i class="badge" id="contactList"></i><span>联系单</span>
							</div></li>
					</c:if> --%>
					<c:if test="${not empty accessibleModuleMenuIds['pb_repair']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('propertyFix',this)"><div
								class="console-btn2 csIcon04">
								<i class="badge" id="pm_propertyRepairslist"></i><span>物业报修</span>
							</div></li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_dataReport_parkLog']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('log',this)"><div
								class="console-btn2 csIcon06" id="log">
								<span>园区日志</span>
							</div></li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_contract_dueRemind']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('contractCounts',this)"><div
								class="console-btn2 csIcon07">
								<i id="contractCounts" class="badge"></i><span>合同到期</span>
							</div></li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_workBenchCustomer_list']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('enter',this)"><div
								class="console-btn2 csIcon08">
								<span>入驻迁出</span>
							</div></li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['oa_workBenchArchives_list']}">
						<%flag1++; %>
						<li class="<%if(flag1==0){%>on<%}%>"
							onclick="changeSrc('staffExpire',this)"><div
								class="console-btn2 csIcon11">
								<i id="archivesCounts" class="badge"></i><span>劳动合同</span>
							</div></li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['park_info_report']}">
					<%flag1++; %>
					<li class="<%if(flag1==0){%>on<%}%>" onclick="changeSrc('report',this)">
						<div class="console-btn2 csIcon10">
							<i id="reportCounts" class="badge"></i><span>数据上报</span>
						</div>
					</li>
					</c:if>
					
					<!-- 设备提醒 -->
					<c:if test="${not empty accessibleModuleMenuIds['pb_deviceReport']}">
					<%flag1++; %>
					<li class="<%if(flag1==0){%>on<%}%>" onclick="changeSrc('deviceReport',this)">
						<div class="console-btn2 csIcon10">
							<i id="deviceReportCounts" class="badge"></i><span>设备提醒</span>
						</div>
					</li>
					</c:if>
				</ul>
			</div>
			<div class="rt" id="div_right">
				<%int flag=-1; %>
				<ul class="console-cont-list" id="console-cont-list">
					<c:if test="${not empty accessibleModuleMenuIds['oa_notice']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div>
								<div class="gWel-info-more">
									<!-- <div class="gWel-info-more-nav">
								<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
					             	<div class="gWel-info-more-nav-aText" style="width:170px;">公告</div>
					         	</div>
					      	</div> -->
									<div class="gWel-info-more-line"></div>
									<div class="gWel-info-more-cnt">
										<ul class="list_sy_1_min" id="noticeList">

										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'公告管理','<%=BaseAction.rootLocation %>/parkmanager.oa/web/information/notice_list.jsp')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['pb_checkout']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div class="gWel-info-more">
								<!-- <div class="gWel-info-more-nav">
						    <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
						        <div class="gWel-info-more-nav-aText">出账</div>
						    </div>
						</div> -->
								<div class="gWel-info-more-line"></div>
								<ul class="feeList">
									<li class="feeLi"><img src="core/common/images/fee1.gif" />
										<dl class="feeDetail">
											<dt>物业租金出账</dt>
											<dd class="about">PM根据园区与企业租赁合同中的资金计划生成出账清单（包括已经设置了自动出账的资金计划）。</dd>
											<dd class="feeResult">
												PM检测到<strong class="cor_g" id="rentDay"></strong>内出账信息(物业管理费<strong
													class="cor_f00" id="manage"></strong>条，租金<strong
													class="cor_f00" id="rent"></strong>条，能源损耗费<strong
													class="cor_f00" id="energy"></strong>条)
											</dd>
										</dl> <br />
									<br /> <a href="javascript:void(0)" title=""
										onclick="parent.addTab(parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListBillPlanRent.action?askedFromDesktop=yes')"
										class="btn" target="_parent"><img
											src="core/common/images/czbtn.png" width="75" height="22"
											border="0" /></a></li>
									<li class="feeLi"><img src="core/common/images/fee2.gif" />
										<dl class="feeDetail">
											<dt>押金出账</dt>
											<dd class="about">PM根据园区与企业租赁合同中的押金生成出账清单（包括已经设置了自动出账的资金计划）。</dd>
											<dd class="feeResult">
												PM检测到<strong class="cor_g" id="depositDay"></strong>内出账信息(押金<strong
													class="cor_f00" id="deposit"></strong>条)
											</dd>
										</dl> <br />
									<br /> <a href="javascript:void(0)" title=""
										onclick="parent.addTab(parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListDeposit.action?askedFromDesktop=yes')"
										class="btn" target="_parent"><img
											src="core/common/images/czbtn.png" width="75" height="22"
											border="0" /></a></li>
									<li class="feeLi"><img src="core/common/images/fee4.gif" />
										<dl class="feeDetail">
											<dt>公共设施费用出账</dt>
											<dd class="about">PM支持用户自定义费用，如网络费、会议室使用费、广告费等，在生成企业账单
												时，会记录费用的计划出账日期。根据计划出账日期，生成自定义费用的出账清单</dd>
											<dd class="feeResult">
												PM检测到<strong class="cor_g" id="facilityDay"></strong>内计划出账的自定义费用<strong
													class="cor_f00" id="facilitySum"></strong>条,其中：
											</dd>
										</dl>
										<ul class="feeDeList" id="feeDeList">
										</ul> <br />
									<br /> <a href="javascript:void(0)" title=""
										onclick="parent.addTab(parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListBillPlanFacility.action?askedFromDesktop=yes')"
										class="btn" target="_parent"><img
											src="core/common/images/czbtn.png" width="75" height="22"
											border="0" /></a></li>
								</ul>
							</div>
						</li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['pb_billClose']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div class="gWel-info-more">
								<div class="gWel-info-more-nav" id="tab">
									<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
										<div class="gWel-info-more-nav-aText">收款</div>
									</div>
									<div class="gWel-info-more-nav-a">
										<div class="gWel-info-more-nav-aText">付款</div>
									</div>
								</div>
								<div class="gWel-info-more-line"></div>
								<div class="gWel-cont-list">
									<div class="gWel-info-more-cnt" style="display: block;">
										<div class="tip tip5_tip" style="margin-top: 8px;">
											<div class="calculate">
												共<a href="javascript:void(0)" title="" id="billCountIn"></a>笔费用需要收款&nbsp;&nbsp;&nbsp;&nbsp;应收总计：<a
													href="javascript:void(0)" title="" id="receiveCount">￥0</a>万元
											</div>
										</div>
										<ul id="billInList" class="list_sy_1_min">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action')">查看全部&gt;&gt;</a>
										</p>
									</div>
									<div class="gWel-info-more-cnt">
										<div class="tip tip5_tip" style="margin-top: 8px;">
											<div class="calculate">
												共<a href="javascript:void(0)" title="" id="billCountOut"></a>笔费用需要付款&nbsp;&nbsp;&nbsp;&nbsp;应付总计：<a
													href="javascript:void(0)" title="" id="payCount">￥0</a>万元
											</div>
										</div>
										<ul id="billOutList" class="list_sy_1_min">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
					<%-- <c:if
						test="${not empty accessibleModuleMenuIds['pb_customerServiceContact']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div class="gWel-info-more">
								<!-- <div class="gWel-info-more-nav">
                               <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
                                   <div class="gWel-info-more-nav-aText">客服联系单</div>
                               </div>
                           </div> -->
								<div class="gWel-info-more-line"></div>
								<div class="gWel-info-more-cnt">
									<ul class="list_sy_2" id="customerServiceList">
									</ul>
									<ul class="explain_list">
										<li><img src="core/common/images/sign_01.gif" />灰色为完成</li>
										<li><img src="core/common/images/sign_04.gif" />绿色为处理中</li>
										<li><img src="core/common/images/sign_02.gif" />红色为挂起</li>
									</ul>
									<p class="console-list-more">
										<a href="javascript:void(0);" title=""
											onclick="parent.addTab(parent.parent.parent,'客服联系单','<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!list.action')">查看全部&gt;&gt;</a>
									</p>
								</div>
							</div>
						</li>
					</c:if> --%>
					<c:if test="${not empty accessibleModuleMenuIds['pb_repair']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div class="gWel-info-more">
								<!-- <div class="gWel-info-more-nav">
					      <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
					          <div class="gWel-info-more-nav-aText">物业报修</div>
					      </div>
					  </div> -->
								<div class="gWel-info-more-line"></div>

								<div class="gWel-info-more-cnt">

									<ul class="list_sy_2" id="propertyFixList">
									</ul>
									<ul class="explain_list">
										<li><img src="core/common/images/sign_01.gif" />灰色为完成</li>
										<li><img src="core/common/images/sign_04.gif" />绿色为处理中</li>
										<li><img src="core/common/images/sign_02.gif" />红色为挂起</li>
									</ul>
									<p class="console-list-more">
										<a href="javascript:void(0);" title=""
											onclick="parent.addTab(parent.parent.parent.parent,'物业报修','<%=BaseAction.rootLocation %>/parkmanager.pb/web/property/property_repair_list.jsp')">查看全部&gt;&gt;</a>
									</p>
								</div>
							</div>
						</li>
					</c:if>

					<c:if
						test="${not empty accessibleModuleMenuIds['pb_dataReport_parkLog']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div class="gWel-info-more">
								<!-- <div class="gWel-info-more-nav">
							<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:150px;">
								<div class="gWel-info-more-nav-aText" style="width:150px;">园区日志（30天内）</div>
							</div>
						</div> -->
								<div class="gWel-info-more-line"></div>
								<div class="gWel-info-more-cnt">
									<ul class="list_sy_1_min" id="parkLogList">
									</ul>
									<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="myAddTab(parent.parent.parent.parent,'园区日志','<%=BaseAction.rootLocation %>/parkmanager.pb/web/contract/contract_log_list.jsp','/parkmanager.pb/web/images/date_edit.png')">查看全部&gt;&gt;</a>
												</p>
								</div>
							</div>
						</li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_contract_dueRemind']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div>
								<div class="gWel-info-more">
									<!-- <div class="gWel-info-more-nav">
								<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
					             	<div class="gWel-info-more-nav-aText" style="width:170px;">合同到期提醒（30天内）</div>
					         	</div>
					      	</div> -->
									<div class="gWel-info-more-line"></div>
									<div class="gWel-info-more-cnt">
										<ul class="list_sy_1_min" id="contractList">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'合同到期','<%=BaseAction.rootLocation %>/parkmanager.pb/web/contract/contract_listByEndDate.jsp')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_workBenchCustomer_list']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div>
								<div class="gWel-info-more">
									<!-- <div class="gWel-info-more-nav">
					            <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
					                <div class="gWel-info-more-nav-aText" style="width:170px;">入驻/迁出企业（30天内）</div>
					            </div>
					        </div> -->
									<div class="gWel-info-more-line"></div>
									<div>
										<ul class="list_sy_1_min2" id="customerList">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'企业信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/client/customer_list.jsp')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
					<c:if
						test="${not empty accessibleModuleMenuIds['oa_workBenchArchives_list']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div>
								<div class="gWel-info-more">
									<!-- <div class="gWel-info-more-nav">
								<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
					             	<div class="gWel-info-more-nav-aText" style="width:170px;">员工合同到期</div>
					         	</div>
					      	</div> -->
									<div class="gWel-info-more-line"></div>
									<div class="gWel-info-more-cnt">
										<ul class="list_sy_1_min" id="staffExpireList">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'在职人员档案管理','<%=BaseAction.rootLocation %>/parkmanager.oa/archives!listIn.action')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
					<c:if test="${not empty accessibleModuleMenuIds['park_info_report']}">
					<%flag++; %>
					<li class="li <%if(flag==0){ %>on<%} %>">
						<div>
							<div class="gWel-info-more">
								<div class="gWel-info-more-line"></div>
								<div class="gWel-info-more-cnt">
									<ul class="list_sy_1_min" id="reportList">
									</ul>
									<p class="console-list-more" id="reportListMore">
									</p>
								</div>
							</div>
						</div>
					</li>
					</c:if>
					
					<!-- 设备提醒 -->
					<c:if
						test="${not empty accessibleModuleMenuIds['pb_deviceReport']}">
						<%flag++; %>
						<li class="li <%if(flag==0){ %>on<%} %>">
							<div>
								<div class="gWel-info-more">
									<div class="gWel-info-more-line"></div>
									<div class="gWel-info-more-cnt">
										<ul class="list_sy_1_min" id="deviceList">
										</ul>
										<p class="console-list-more">
											<a href="javascript:void(0)" title=""
												onclick="parent.addTab(parent.parent.parent.parent,'设备提醒','<%=BaseAction.rootLocation %>/parkmanager.pb/web/property/deviceReport_list.jsp')">查看全部&gt;&gt;</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	function tabChange(tabbtn,tabpannel,tabclass){
	
		 var $div_li =tabbtn;
	
		 $div_li.click(function(){
	
		$(this).addClass(tabclass)
	
		 .siblings().removeClass(tabclass);
	
		 var index = $div_li.index(this);
	
		$(tabpannel)
	
		.eq(index).show()
	
		.siblings().hide();
	
		});
	
			}
	
		//JS调用：触发器，切换容器，当前状态
		tabChange($("#right-tab .gWel-info-more-nav-a"),$("#right-cont .list_sy_5"),"gWel-info-more-nav-a-on");
		tabChange($("#console-menu li"),$("#console-cont-list .li"),"on");
		tabChange($("#tab .gWel-info-more-nav-a"),$(".gWel-cont-list .gWel-info-more-cnt"),"gWel-info-more-nav-a-on");
</script>
</body>
</html>
