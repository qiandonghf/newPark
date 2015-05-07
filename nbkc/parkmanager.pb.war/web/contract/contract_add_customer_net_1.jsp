<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.wiiy.core.service.export.DataDictInitService"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum"%>
<%@ page import="com.wiiy.crm.preferences.enums.ContractTypeEnum"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
	<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css" />
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
	<link rel="stylesheet" type="text/css" href="parkmanager.association/web/style/assciation.css" />
	
	
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<script type="text/javascript">
		$(function(){
			initTip();
			initForm();
			loadNetList();
			initDate();
		});
		function initDate(){
			<%Calendar c = Calendar.getInstance();
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
			String startTime = s.format(c.getTime());	
			c.add(Calendar.YEAR, 1);
			c.add(Calendar.DATE, -1);
			String endTime = s.format(c.getTime());
			%>
			var startDate = '<%=startTime%>';
			var endDate = '<%=endTime%>';
			$("#startDate").val(startDate);
			$("#signDate").val(startDate);
			$("#endDate").val(endDate);
			$("#receiveDate").val(startDate);
			
		}
		
		function getCalendarScrollTop(){
			return $("#scrollDiv").scrollTop();
		}
		
		function selectUser(){
			fbStart('选择负责人','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);
		}
		function setSelectedUser(contect){
			$("#managerName").val(contect.name);
			$("#managerId").val(contect.id);
		}
		function selectCustomer(){
			fbStart('选择企业','<%=basePath %>customer!select.action',520,400);
		}
		function setSelectedCustomer(customer){
			$("#customerId").val(customer.id);
			$("#customerName").val(customer.name);
		}
		var facilityList;
		function loadNetList(){
			$.post("<%=basePath%>subjectNetwork!loadNetList.action",function(data){
				facilityList = data.facilityList;
			});
		}
		function checkNetExist(id){
			var exist = false;
			$(".netId").each(function(){
				if($(this).val()==id) exist = true;
			});
			return exist;
		}
		var netRent = false;
		function appendNet(obj){
			var tr = $("<tr></tr>");
			if(checkNetExist(obj.get("facilityId"))){
				alert("已在租赁网络！");
				return false;
			}
			$("#nonData").remove();
			var name = $("<input />",{name:"facilityName",type:"hidden",value:obj.get("facilityName")}).addClass("facilityName");
			var facilityId = $("<input />",{name:"netId",type:"hidden",value:obj.get("facilityId")}).addClass("netId");
			var startDate = $("<input />",{name:"netStartDate",type:"hidden",value:obj.get("startDate")}).addClass("startDate");
			var endDate = $("<input />",{name:"netEndDate",type:"hidden",value:obj.get("endDate")}).addClass("endDate");
			var rentPrice = $("<input />",{name:"price",type:"hidden",value:obj.get("rentPrice")}).addClass("price");
			var priceUnit = $("<input />",{name:"priceUnit",type:"hidden",value:obj.get("priceUnit")}).addClass("priceUnit");
			var netWorkIp = $("<input />",{name:"ip",type:"hidden",value:obj.get("netWorkIp")}).addClass("ip");
			var netWorkPort = $("<input />",{name:"port",type:"hidden",value:obj.get("netWorkPort")}).addClass("port");
			var publicIP = $("<input />",{name:"ipPub",type:"hidden",value:obj.get("publicIP")}).addClass("ipPub");
			
			var facilityName = $("<td></td>").addClass("centertd").append(obj.get("facilityName")).append(name).append(facilityId);
			var unit = "元/月";
			if(obj.get("priceUnit")=='YEAR'){
				unit = "元/年";
			}else if(obj.get("priceUnit")=='ONCE'){
				unit = "一次性";
			}
			var rentPrice2 = $("<td></td>").addClass("centertd").append(obj.get("rentPrice")+"&nbsp;&nbsp;("+unit+")").append(rentPrice).append(priceUnit);
			var time = $("<td></td>").addClass("centertd").append(obj.get("startDate")+"&nbsp;&nbsp至&nbsp;&nbsp"+obj.get("endDate")).append(startDate).append(endDate);
			
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deleteRoom($(this).parent().parent());}}).append($("<img src='core/common/images/del.gif' title='删除'/>"));
			var op = $("<td></td>").addClass("centertd").append(a);
			
			tr.append(facilityName).append(rentPrice2).append(time).append(netWorkIp).append(netWorkPort).append(publicIP).append(op);
			$("#netListTBody").append(tr);
			netRent = true;
		}
	    function checkDouble(el){
	    	$(el).val($(el).val().replace(/[^\d\.]/g,''));
	    }
	    function getCalendarInputTd(id,name,value){
	    	return $("<td></td>",{width:80}).append($("<input />",{id:id,name:name,readonly:"readonly",value:value}).addClass("inputauto").addClass(name).click(function(){showCalendar(id);}));
	    }
	    function getCalendarIconTd(id){
	    	return $("<td></td>",{width:20,align:"center"}).append($("<img />",{src:"core/common/images/timeico.gif"}).css({"position":"relative","left":-3}).click(function(){showCalendar(id);}));
	    }
		function deleteRoom(tr){
			tr.remove();
			calculateTotal("roomArea","totalArea");
		}
		function getPlanId(){
			if($(".planId").size()==0) return 0;
			else return parseInt($(".planId").last().val())+1;
		}
		
		function appendPlan(obj){
			$("#noPlan").remove();
			var tr = $("<tr></tr>");
			var facilityId = $("<input />",{name:"planFacilityId",type:"hidden",value:obj.get("facilityId")}).addClass("planFacilityId");
			var startDate = $("<input />",{name:"planStartDate",type:"hidden",value:obj.get("startDate")}).addClass("startDate");
			var endDate = $("<input />",{name:"planEndDate",type:"hidden",value:obj.get("endDate")}).addClass("endDate");
			var planPayDate = $("<input />",{name:"planPayDate",type:"hidden",value:obj.get("planPayDate")}).addClass("planPayDate");
			var planFee = $("<input />",{name:"planFee",type:"hidden",value:obj.get("planFee")}).addClass("planFee");
			var realFee = $("<input />",{name:"realFee",type:"hidden",value:obj.get("realFee")}).addClass("realFee");
			var memo = $("<input />",{name:"memo",type:"hidden",value:obj.get("memo")}).addClass("memo");
			
			var th = $("<th></th>",{align:"center"}).append("网络费").append(facilityId);
			var money = $("<td></td>",{align:"center"}).append(obj.get("planFee")+"元").append(planFee).append(realFee);
			var payDate = $("<td></td>").addClass("centertd").append(obj.get("planPayDate")).append(planPayDate);
			var time = $("<td></td>").addClass("centertd").append(obj.get("startDate")+"&nbsp;&nbsp至&nbsp;&nbsp"+obj.get("endDate")).append(startDate).append(endDate);
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deleteRoom($(this).parent().parent());}}).append($("<span></span>").css("vertical-align","middle").append("删除"));
			var op = $("<td></td>",{align:"center"}).append(a);
			tr.append(th);
			tr.append(money);
			tr.append(payDate);
			tr.append(time).append(memo);
			tr.append(op);
			$("#planListTBody").append(tr);
		}
		function deletePlan(tr){
			tr.remove();
			calculateTotal("money","totalMoney");
		}
		function getPayDateTd(){
			var tr = $("<tr></tr>");
			var id = getPlanId();
	    	var start = getCalendarInputTd("playPayDate"+id,"playPayDate");
	    	var startIcon = getCalendarIconTd("playPayDate"+id);
	    	var split = $("<td></td>",{width:40}).append("之前");
	    	tr.append(start);
			tr.append(startIcon);
			tr.append(split);
			return $("<td></td>").append($("<table></table>",{"border":0,"cellspacing":0,"cellpadding":10}).append(tr));
		}
		function getFeeDateTd(){
			var tr = $("<tr></tr>");
			var id = getPlanId();
	    	var start = getCalendarInputTd("planStartDate"+id,"planStartDate");
	    	var startIcon = getCalendarIconTd("planStartDate"+id);
	    	var split = $("<td></td>",{width:20}).append("至");
	    	var end = getCalendarInputTd("planEndDate"+id,"planEndDate");
	    	var endIcon = getCalendarIconTd("planEndDate"+id);
	    	tr.append(start);
			tr.append(startIcon);
			tr.append(split);
			tr.append(end);
			tr.append(endIcon);
			return $("<td></td>").append($("<table></table>",{"border":0,"cellspacing":0,"cellpadding":10}).append(tr));
		}
		function fireChange(el,className){
			$("."+className).each(function(){
				if(!$(this).val() || $(this).val()==""){
					$(this).val($(el).val());
				}
			});
		}
		function calculateTotal(className,total){
			var sum = 0;
			$("."+className).each(function(){
				if($(this).val()){
					sum += parseFloat($(this).val());
				}
			});
			$("#"+total).text(sum);
		}
		function initForm(){
			$("#form1").validate({
				rules: {
					"contract.customerName":"required",
					"contract.contractNo":"required",
					"managerName":"required",
					"contract.receiveDate":"required",
					"contract.signDate":"required",
					"contract.startDate":"required",
					"contract.endDate":"required",
					"deposit":"number"
				},
				messages: {
					"contract.customerName":"请选择已方",
					"contract.contractNo":"请输入合同编号",
					"managerName":"请选择负责人",
					"contract.receiveDate":"请选择交付日期",
					"contract.signDate":"请选择签订日期",
					"contract.startDate":"请选择有效日期开始时间",
					"contract.endDate":"请选择有效日期结束时间",
					"deposit":"请输入正确的押金"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("有效日期开始时间不能小于有效日期结束时间",3000); 
						return;
					}
					var checkPass = true;
					$(".netStartDate").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("租期不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					});
					$(".netStartDate").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("租期不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					});
					$(".money").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("金额不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					});
					$(".playPayDate").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("缴费日期不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					});
					if(checkPass){
						$(form).ajaxSubmit({
					        dataType: 'json',
					        success: function(data){
				        		showTip(data.result.msg,2000);
					        	if(data.result.success){
					        		setTimeout("getOpener().reloadList();parent.fb.end()", 2000);
					        	}
					        } 
					    });
					}
				}
			});
		}
		
		function generateCode(){
			var name = $("#contractModel :selected").val();
			$.post("<%=basePath%>contract!generateCode.action?contractModel="+name,function(data){
				if(data.result.success){
					$("#contractNo").val(data.result.value);
				}
			});
		}
		
		function addBillRent(){
			if(!netRent){
				showTip("请先填写租赁网络");
				return;
			}
			var ids = "";
			$(".netId").each(function(){
				ids += $(this).val()+",";
			});
			ids = ids.substring(0,ids.length-1);
			fbStart('添加资金计划','<%=basePath %>billPlanFacility!addNetworkPlanByIds.action?ids='+ids+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);
		}
		
	</script>
</head>
<body>
<form action="<%=basePath %>contract!saveNetContract1.action" method="post" name="form1" id="form1">
<input type="hidden" name="contract.item" value="${param.item}"/>
<input type="hidden" name="contract.type" value="<%=ContractTypeEnum.NetWorkContract %>"/>
<div class="basediv" style="margin-top:0px; height:450px; overflow:hidden; margin-top:3px;">
<div id="scrollDiv" style=" overflow-x:hidden;  height:450px; overflow-y:scroll; position:relative;">
<!--basediv-->
<div class="basediv">
<!--titlebg-->
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">甲方乙方</div>
<!--//titlebg-->
 <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td class="layertdleft100"><span class="psred">*</span>甲方(出租方)：</td>
      <td class="layerright" >
	      <strong><dd:select name="contract.contractPartyId" key="crm.0031" checked="crm.003101"/></strong>
	  </td>
    </tr>
    <tr>
     
      <td class="layertdleft100"><span class="psred">*</span>乙方(承租方)：</td>
      <td class="layerright"><table width="50%" border="0" cellspacing="0" cellpadding="0">
        <tbody><tr>
          <td><input id="customerId" name="contract.customerId" type="hidden" /><input id="customerName" name="contract.customerName" class="inputauto" onclick="selectCustomer()" readonly="readonly"/></td>
          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCustomer()" style="cursor:pointer"/></td>
          </tr>
      </tbody></table></td>
    </tr>
    
  </table>
  </div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->

<!--basediv-->
<div class="basediv">
<!--titlebg-->
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">基本信息</div>
<!--//titlebg-->
 <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
			<td class="layertdleft100"><span class="psred">*</span>合同编号：</td>
      		<td class="layerright" width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
		            <tr>
		            	<td width="265"><input id="contractNo" name="contract.contractNo" type="text" style="width: 118px;"class="inputauto"/></td>
		            	<td><select id="contractModel" style="height: 21px">
		            	<option>S</option>
		            	<option>C</option>
		            	<option>P</option>
		            	</select></td>
		                <td><img src="core/common/images/auto.gif" width="75" height="22" onclick="generateCode()" style="margin-left:-4px;"/></td>
		            </tr>
	            </tbody>
       		</table></td>
       		<td class="layertdleft100">承租用途：</td>
	      	<td class="layerright"><input name="contract.purpose" type="text" class="inputauto" style="width:98%;" /></td>
    	</tr>
    	<tr>
	      <td class="layertdleft100"><span class="psred">*</span>交付时间：</td>
	      <td class="layerright" width="35%"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><input id="receiveDate" name="contract.receiveDate" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('receiveDate')"/></td>
	          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('receiveDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
	        </tr>
	      </table></td>
	      <td class="layertdleft100"><span class="psred">*</span>负责人：</td>
	      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><input id="managerId" name="contract.managerId" type="hidden"/><input id="managerName" name="managerName" class="inputauto" onclick="selectUser()" readonly="readonly"/></td>
	          <td width="21" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectUser()" style="cursor:pointer"/></td>
	        </tr>
	      </table></td>
	    </tr>
	    <tr>
	      <td class="layertdleft100"><span class="psred">*</span>签订日期：</td>
	      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><input id="signDate" name="contract.signDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('signDate')"/></td>
	          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('signDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
	        </tr>
	      </table></td>
	      <td class="layertdleft100"><span class="psred">*</span>开始日期：</td>
	      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><input id="startDate" name="contract.startDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('startDate');" /></td>
	          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('startDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
	        </tr>
	      </table></td> 
	    </tr>
	    <tr>
	      <td class="layertdleft100">合同总额：</td>
			<td class="layerright">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="120"><input name="contract.totalAmount" type="text" class="inputauto"/></td>
						<td align="left">&nbsp;元</td>
					</tr>
				</table>
			</td>
	      <td class="layertdleft100"><span class="psred">*</span>结束日期：</td>
	      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><input id="endDate" name="contract.endDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('endDate')"/></td>
	          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('endDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
	        </tr>
	      </table></td>
	    </tr>
  </table>
  
  </div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->

<!--basediv-->
<!--租赁房间-->
<div class="basediv" style="margin-top:0px; display:block" id="textname">
	<div class="emailtop">
		<div class="leftemail">
	    	<strong style="line-height:27px; color:#000; padding-left:5px;">租赁网络</strong>
	    </div>
		<div class="rightemail" style="width:auto; padding-right:10px;">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加租赁网络','<%=basePath %>subjectNetwork!add.action?saveFlag=0&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>添加租赁网络</li>
			</ul>
		</div>
	</div>
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="nowrap">
			<tbody id="netListTBody">
				<tr>
		            <td class="tdcenterL" onmousemove="this.className='tdcenterLover'" onmouseout="this.className='tdcenterL'" style="border-left:0;">网络</td>
		            <td width="185" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">单价 </td>
		            <td width="200" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">租期 </td>
		            <td width="90" class="tdrightc" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">操作</td>
	          	</tr>
	          	<tr id="nonData">
	          		<td colspan="4" align="center">无数据</td>
	          	</tr>
          	</tbody>
         </table>
    </div>
    
	<div class="emailtop">
		<div class="leftemail">
	    	<strong style="line-height:27px; color:#000; padding-left:5px;">资金计划</strong>
	    </div>
		<div class="rightemail" style="width:auto; padding-right:10px;">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addBillRent();" class=""><span><img src="core/common/images/emailadd.gif" width="15" height="13"/></span>添加资金计划</li>
			</ul>
		</div>
	</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nowrap">
		<tbody id="planListTBody">
			<tr>
				<td class="tdcenterL" onmousemove="this.className='tdcenterLover'" onmouseout="this.className='tdcenterL'" style="border-left:0;">费用类型</td>
				<td width="145" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">计划付费金额</td>
				<td width="120" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">计划付费日期</td>
				<td width="160" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">计费日期</td>
				<td width="50" class="tdrightc" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">操作</td>
	        </tr>
          	<tr  id="noPlan">
          		<td colspan="5" align="center">无数据</td>
          	</tr>
        </tbody>
	</table>
</div>
<!-- <div class="basediv" style="margin-top:0px; display:block" id="textname" name="textname">
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">租赁网络&nbsp;&nbsp;<a href="javascript:void(0)" onclick="appendNet()" title="" style="font-weight:normal; color:#06c;">+新建租赁网络</a></div>
		
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy3">
            <thead>
              <tr>
                <th width="100">网络</th>
                <th width="90" align="left">单价</th>
                <th width="70" align="left">IP段</th>
                <th width="70" align="left">接入端口数</th>
                <th width="70" align="left">公网IP数</th>
                <th align="left">租期</th>
                <th width="60" align="center">操作</th>
              </tr>
            </thead>
            <tbody id="netListTBody">
            </tbody>
        </table>
  </div>
<div class="basediv" style="margin-top: 0px; display: block;" id="textname" name="textname">
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">资金计划&nbsp;&nbsp;<a href="javascript:void(0);" onclick="appendPlan()" title="" style="font-weight:normal; color:#06c;">+新建资金计划</a></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy3">
            <thead>
              <tr>
                <th width="140">费用类型</th>
                <th width="130" align="left">金额</th>
                <th align="left">缴费日期</th>
                <th align="left">计费区间</th>
                <th width="70" align="center">操作</th>
              </tr>
            </thead>
            <tbody id="planListTBody">
            </tbody>
            <tfoot>
            	<tr>
            		<th>资金总额：</th>
                    <td colspan="4"><strong id="totalMoney">0</strong>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;<span><label><input name="autocheck" value="yes" type="checkbox" style="vertical-align:middle;">是否自动出帐</label></span></td>
                </tr>
            </tfoot>
        </table>
        
  </div> -->
<!--//basediv-->



</div></div>

<div class="buttondiv">
  <label>&nbsp; 
  <input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
