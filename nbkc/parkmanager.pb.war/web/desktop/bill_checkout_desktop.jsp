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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>

<body>
	<div class="gWel-info-more">
		<div class="gWel-info-more-nav">
		    <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
		        <div class="gWel-info-more-nav-aText">出账</div>
		    </div>
		</div>
		<div class="gWel-info-more-line"></div>
		<ul class="feeList">
        	<li class="feeLi">
				<img  src="core/common/images/fee1.gif" />
				<dl class="feeDetail">
					<dt>物业租金出账</dt>
				    <dd class="about">PM根据园区与企业租赁合同中的资金计划生成出账清单（包括已经设置了自动出账的资金计划）。</dd>
				    <dd class="feeResult">PM检测到<strong class="cor_g">${rentDay}天</strong>内出账信息(物业管理费<strong class="cor_f00">${MANAGE eq null ? 0 : MANAGE}</strong>条，租金<strong class="cor_f00">${RENT eq null ? 0 : RENT}</strong>条，能源损耗费<strong class="cor_f00">${ENERGY eq null ? 0 : ENERGY}</strong>条)</dd>
				</dl>
				<br/><br/>
				<a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListBillPlanRent.action?askedFromDesktop=yes')" class="btn" target="_parent"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
			</li>
            <li class="feeLi">
				<img  src="core/common/images/fee2.gif" />
				<dl class="feeDetail">
					<dt>押金出账</dt>
					<dd class="about">PM根据园区与企业租赁合同中的押金生成出账清单（包括已经设置了自动出账的资金计划）。</dd>
					<dd class="feeResult">PM检测到<strong class="cor_g">${depositDay}天</strong>内出账信息(押金<strong class="cor_f00">${deposit eq null ? 0 : deposit}</strong>条)</dd>
				</dl>
				<br/><br/>
				<a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListDeposit.action?askedFromDesktop=yes')" class="btn" target="_parent"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
			</li>
            <%-- <li class="feeLi">
                   <img src="core/common/images/fee3.gif">
                   <dl class="feeDetail">
                       <dt>水电气费出账</dt>
                       <dd class="about">PM根据水电气抄表标签生成出账单，如需要进行单表费用结算，请使用房间管理中的临时抄表功能</dd>
                       <dd class="feeResult">PM检测到现在<strong class="cor_f00">1</strong>个标签未出账</dd>
                   </dl>
                   <a href="parkmanager.pb/web/bill/bill_checkout_list3.html" class="btn"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
               </li> --%>                     
                                  
			<li class="feeLi">
				<img  src="core/common/images/fee4.gif" />
				<dl class="feeDetail">
					<dt>公共设施费用出账</dt>
					<dd class="about">PM支持用户自定义费用，如网络费、会议室使用费、广告费等，在生成企业账单 时，会记录费用的计划出账日期。根据计划出账日期，生成自定义费用的出账清单</dd>
					<dd class="feeResult">PM检测到<strong class="cor_g">${facilityDay}天</strong>天内计划出账的自定义费用<strong class="cor_f00">${facilitySum eq null ? 0 : facilitySum}</strong>条,其中：</dd>
				</dl>
				<ul class="feeDeList">
				<%
					Map<String,Integer> facilityMap = (Map<String,Integer>)request.getAttribute("facilityMap");
					for (String key : facilityMap.keySet()) {
						out.println("<li>"+key+"<strong class=\"cor_f00\">"+facilityMap.get(key)+"</strong>条</li>");
					}
				%>
				</ul> 
				<br/><br/>
				<a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用出账','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!checkoutListBillPlanFacility.action?askedFromDesktop=yes')" class="btn" target="_parent"><img src="core/common/images/czbtn.png" width="75" height="22" border="0"></a>
			</li>
		</ul>
                              <%
                              Integer manageCount = (Integer)request.getAttribute("MANAGE");
                              Integer rentCount =(Integer) request.getAttribute("RENT");
                              Integer energyCount =(Integer) request.getAttribute("ENERGY");
                              Integer depositCount =(Integer) request.getAttribute("deposit");
                              Map<String,Integer> facilityMap2 = (Map<String,Integer>)request.getAttribute("facilityMap");
                              Integer countFacility = 0;
                              for (String key : facilityMap2.keySet()) {
                              	if(facilityMap2.get(key)!=null){
                              		countFacility+=facilityMap2.get(key);
                              	}
                              }
                              manageCount = manageCount==null ? 0 : manageCount;
                              rentCount = rentCount==null ? 0 : rentCount;
                              energyCount = energyCount==null ? 0 : energyCount;
                              depositCount = depositCount==null ? 0 : depositCount;
                              Integer billCount = manageCount+rentCount+energyCount+depositCount+countFacility;
                              %>
                              <input id="billCountId" type="hidden" value="<%=billCount%>">
</div>
<script type="text/javascript">
	function getIframeHeight(){
		return document.body.clientHeight;
	}
	parent.document.getElementById("console-cont-list").style.height = document.body.clientHeight;
</script>   
</body>
</html>
