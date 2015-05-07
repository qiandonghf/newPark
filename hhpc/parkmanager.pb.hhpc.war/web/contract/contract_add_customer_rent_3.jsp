<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum"%>
<%@ page import="com.wiiy.crm.preferences.enums.ContractTypeEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String fees = "";
for(RentBillPlanFeeEnum fee : RentBillPlanFeeEnum.values()){
	fees += fee.name() + ":" + fee.getTitle() + ",";
}
if(fees.endsWith(",")) fees = fees.substring(0, fees.length()-1);
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
		function checkRoomExist(id){
			var exist = false;
			$(".roomId").each(function(){
				if($(this).val()==id) exist = true;
			});
			return exist;
		}
		
		function appendBillPlanRent(obj){
			var tr = $("<tr></tr>");
			$("#noPlan").remove();
			var roomName = $("<input />",{name:"planRoomName",type:"hidden",value:obj.get("roomName")}).addClass("planRoomName");
			var roomId = $("<input />",{name:"planRoomId",type:"hidden",value:obj.get("roomId")}).addClass("planRoomId");
			var feeType = $("<input />",{name:"feeType",type:"hidden",value:obj.get("feeType")}).addClass("feeType");
			var planFee = $("<input />",{name:"planFee",type:"hidden",value:obj.get("planFee")}).addClass("planFee");
			var realFee = $("<input />",{name:"realFee",type:"hidden",value:obj.get("realFee")}).addClass("realFee");
			var startDate = $("<input />",{name:"planStartDate",type:"hidden",value:obj.get("startDate")}).addClass("planStartDate");
			var endDate = $("<input />",{name:"planEndDate",type:"hidden",value:obj.get("endDate")}).addClass("planEndDate");
			var planPayDate = $("<input />",{name:"planPayDate",type:"hidden",value:obj.get("planPayDate")}).addClass("planPayDate");
			var status = $("<input />",{name:"status",type:"hidden",value:obj.get("status")}).addClass("planStatus");
			var memo = $("<input />",{name:"planMemo",type:"hidden",value:obj.get("memo")}).addClass("planMemo");

			var typeName = "";
			if(obj.get("feeType") == "RENT"){
				typeName = "租金";
			}else if(obj.get("feeType") == "MANAGE"){
				typeName = "物管费";
			}else if(obj.get("feeType") == "ENERGY"){
				typeName = "能源损耗费";
			}
			var feeType2 = $("<td></td>").addClass("lefttd").append(typeName);
			var planFee2 = $("<td></td>").addClass("centertd").append(obj.get("planFee"));
			var planPayDate2 = $("<td></td>").addClass("centertd").append(obj.get("planPayDate"));
			var date = $("<td></td>").addClass("centertd").append(obj.get("startDate")).append("至"+obj.get("endDate"));
			
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deletePlan($(this).parent().parent());}}).append($("<img src='core/common/images/del.gif' title='删除'/>"));
			var op = $("<td></td>").addClass("centertd").append(a);
			
			tr.append(feeType2).append(planFee2).append(planPayDate2).append(date).append(op);
			tr.append(roomName).append(roomId).append(feeType).append(planFee).append(realFee).append(startDate).append(endDate).append(planPayDate).append(status).append(memo);
			$("#planListTBody").append(tr);
		}
		
		function appendDeposit(obj){
			var tr = $("<tr></tr>");
			$("#noDeposit").remove();
			var depositMemo = obj.get("memo");
			var type = $("<input />",{name:"depositType",type:"hidden",value:obj.get("type")}).addClass("depositType");
			var amount = $("<input />",{name:"depositAmount",type:"hidden",value:obj.get("amount")}).addClass("depositAmount");
			var memo = $("<input />",{name:"depositMemo",type:"hidden",value:depositMemo}).addClass("depositMemo");
			var typeName = "";
			if("WATERELECTRICITY" == obj.get("type")){
				typeName = "水电费押金";
			}else if("ROOM" == obj.get("type")){
				typeName = "房租押金";
			}
			var type2 = $("<td></td>").addClass("lefttd").append(typeName);
			var amount2 = $("<td></td>").addClass("centertd").append(obj.get("amount"));
			if(obj.get("memo")!=null && obj.get("memo").length>10){
				depositMemo = obj.get("memo").substring(0,10);
			}
			var memo2 = $("<td></td>").addClass("centertd").append(depositMemo);
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deletePlan($(this).parent().parent());}}).append($("<img src='core/common/images/del.gif' title='删除'/>"));
			var op = $("<td></td>").addClass("centertd").append(a);
			
			tr.append(type2).append(amount2).append(memo2).append(op);
			tr.append(type).append(amount).append(memo);
			$("#depositListTBody").append(tr);
		}
		
		function appendRoom(obj){
			var tr = $("<tr></tr>");
			if(checkRoomExist(obj.get("roomId"))){
				alert("房间已在租凭列表中！");
				return false;
			}
			$("#nonData").remove();
			var rentPrice = $("<input />",{name:"rentPrice",type:"hidden",value:obj.get("rentPrice")}).addClass("rentPrice");
			var rentPriceUnit = $("<input />",{name:"rentPriceUnit",type:"hidden",value:obj.get("rentPriceUnit")}).addClass("rentPriceUnit");
			var rebate = $("<input />",{name:"rebate",type:"hidden",value:obj.get("rebate")}).addClass("rebate");
			var rebateRuleId = $("<input />",{name:"rebateRuleId",type:"hidden",value:obj.get("rebateRuleId")}).addClass("rebateRuleId");
			var memo = $("<input />",{name:"memo",type:"hidden",value:obj.get("memo")}).addClass("memo");
			
			var id = $("<input />",{name:"roomId",type:"hidden",value:obj.get("roomId")}).addClass("roomId");
			var name = $("<input />",{name:"roomName",type:"hidden",value:obj.get("roomName")}).addClass("name");
			var roomName = $("<td></td>").addClass("lefttd").append(obj.get("roomName")).append(id).append(name);
			
			var area = $("<input />",{name:"roomArea",type:"hidden",value:obj.get("roomArea")}).addClass("roomArea");
			var roomArea = $("<td></td>").addClass("centertd").append(obj.get("roomArea")).append("平方米").append(area);
			
			var startDate = $("<input />",{name:"startDate",type:"hidden",value:obj.get("startDate")}).addClass("startDate");
			var endDate = $("<input />",{name:"endDate",type:"hidden",value:obj.get("endDate")}).addClass("endDate");
			var date = $("<td></td>").addClass("centertd").append(obj.get("startDate")).append("至"+obj.get("endDate")).append(startDate).append(endDate);
		
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deleteRoom($(this).parent().parent());}}).append($("<img src='core/common/images/del.gif' title='删除'/>"));
			var op = $("<td></td>").addClass("centertd").append(a);

			tr.append(rentPrice).append(rentPriceUnit).append(rebate).append(rebateRuleId).append(memo).append(roomName).append(roomArea).append(date).append(op);
			$("#roomListTBody").append(tr);
			var roomIds = new Array();
			$(".roomId").each(function (){
				roomIds.push($(this).val());
			});
			$("#roomIds").val(roomIds);
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
		}
		function deletePlan(tr){
			tr.remove();
		}
		function deleteDeposit(tr){
			tr.remove();
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
					"contract.contractPartyId":"required",
					"contract.customerName":"required",
					"contract.contractNo":"required",
					"managerName":"required",
					"contract.signDate":"required",
					"contract.startDate":"required",
					"contract.endDate":"required"
				},
				messages: {
					"contract.contractPartyId":"请选择甲方",
					"contract.customerName":"请选择已方",
					"contract.contractNo":"请输入合同编号",
					"managerName":"请选择负责人",
					"contract.signDate":"请选择签订日期",
					"contract.startDate":"请选择有效日期开始时间",
					"contract.endDate":"请选择有效日期结束时间"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("有效日期开始时间不能小于有效日期结束时间",3000); 
						return;
					}
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
			});
		}
		function getCalendarScrollTop(){
			return $("#scrollDiv").scrollTop();
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
			var roomIds =$("#roomIds").val();
			fbStart('添加资金计划','<%=basePath %>contract!addBillRent.action?roomIds = '+roomIds+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,286);
		}
		function mySelected(cal, date) {
			  cal.sel.value = date; // just update the date in the input field.
			  if (cal.dateClicked && (cal.sel.id == "sel1" || cal.sel.id == "sel3"))
			    // if we add this call we close the calendar on single-click.
			    // just to exemplify both cases, we are using this only for the 1st
			    // and the 3rd field, while 2nd and 4th will still require double-click.
			    cal.callCloseHandler();
			  if(cal.sel.id=="startDate"){
				  $("#receiveDate").val(date);
				  var ss = date.split("-");
				  var startDate = new Date(ss[0],ss[1],ss[2]);
				  startDate.setFullYear(startDate.getFullYear()+1);
				  startDate.setMonth(startDate.getMonth()-1);
				  startDate.setDate(startDate.getDate()-1);
				  startDate = startDate.format("yyyy-MM-dd");
				  $("#endDate").val(startDate);
			  }
			}
		function myShowCalendar(id){
			var el = document.getElementById(id);
			  if(el==null) el = id;
			    // first-time call, create the calendar.
			    var cal = new Calendar(false, null, mySelected, closeHandler);
			    // uncomment the following line to hide the week numbers
			    // cal.weekNumbers = false;
			    calendar = cal;                  // remember it in the global var
			    cal.setRange(1900, 2200);        // min/max year allowed.//更改起始年月
			    cal.create();
			 
			  //calendar.setDateFormat(format);    // set the specified date format
			  calendar.parseDate(el.value);      // try to parse the text in field
			  calendar.sel = el;                 // inform it what input field we use
			  // the reference element that we pass to showAtElement is the button that
			  // triggers the calendar.  In this example we align the calendar bottom-right
			  // to the button.
			  calendar.showAtElement(el, "B");        // show the calendar
			  return false;
		}

	</script>
</head>
<body>
<input type="hidden" id="roomIds" name="roomIds"/>
<input type="hidden" id="roomId"/>
<input type="hidden" id="roomArea"/>
<input type="hidden" id="roomName"/>
<input type="hidden" id="roomNames"/>
<form action="<%=basePath %>contract!saveRentContract1.action" method="post" name="form1" id="form1">
<input type="hidden" name="contract.item" value="${param.item}"/>
<div class="basediv" style="margin-top:0px; height:450px; overflow:hidden; margin-top:3px;">
  <div id="scrollDiv" style=" overflow-x:hidden;  height:450px; overflow-y:scroll; position:relative;">
<div class="basediv">
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">甲方乙方</div>
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
          <td><input id="customerId" name="contract.customerId" type="hidden" ><input id="customerName" name="contract.customerName" class="inputauto" onclick="selectCustomer()" readonly="readonly"></td>
          <td width="21" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCustomer()" style="cursor:pointer"></td>
          </tr>
      </tbody></table></td>
    </tr>
    
  </table>
  </div>
	<div class="hackbox"></div>
</div>
<div class="basediv">
<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">基本信息</div>
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="layertdleft100"><span class="psred">*</span>合同编号：</td>
      		<td class="layerright" width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
		            <tr>
		            	<td width="265"><input id="contractNo" name="contract.contractNo" type="text" style="width: 118px;" class="inputauto"/></td>
		            	<td><select id="contractModel" style="height: 21px">
		            	<option>Z</option>
		            	<option>S</option>
		            	</select></td>
		                <td><img src="core/common/images/auto.gif" width="75" height="22" onclick="generateCode()" style="margin-left:-4px;"/></td>
		            </tr>
	            </tbody>
       		</table></td>
       		<td class="layertdleft100"><span class="psred">*</span>合同期限：</td>
	      	<td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
	        	<tbody>
	          	<tr>
		            <td width="80"><input id="startDate" name="contract.startDate" type="text" readonly="readonly" class="inputauto" onclick="myShowCalendar('startDate');" /></td>
		            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="myShowCalendar('startDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
		            <td>&nbsp;至&nbsp;</td>
		            <td width="80"><input id="endDate" name="contract.endDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('endDate');" /></td>
		            <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('endDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
	          	</tr>
	        	</tbody>
      		</table></td>
    	</tr>
    	<tr>
			<td class="layertdleft100">座落位置：</td>
			<td class="layerright"><input name="contract.address" type="text" class="inputauto" style="width:99%;" value="宁波市江南路1558号" /></td>
			<td class="layertdleft100"><span class="psred">*</span>负责人：</td>
			<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td><input id="managerId" name="contract.managerId" type="hidden"><input id="managerName" name="managerName" class="inputauto" onclick="selectUser()" readonly="readonly"></td>
		          <td width="21" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectUser()" style="cursor:pointer"/></td>
		        </tr>
		    </table></td>
    	</tr>
    	<tr>
       		<td class="layertdleft100">总建筑面积</td>
      		<td class="layerright" ><input name="contract.overallFloorage" type="text" class="inputauto" style="width:55%;" /> 平方米</td>
      		<td class="layertdleft100"><span class="psred">*</span>签订日期：</td>
     		<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td><input id="signDate" name="contract.signDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('signDate')"/></td>
		          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('signDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
		        </tr>
		    </table></td>
      	</tr>
    	<tr>
	     	<td class="layertdleft100">合同总金额</td>
	      	<td class="layerright" ><input name="contract.totalAmount" type="text" class="inputauto" style="width:83%;" /> 元</td>
	      	<td class="layertdleft100">房屋交付时间：</td>
	      	<td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
	        	<tbody>
		          <tr>
		            <td><input id="receiveDate" name="contract.receiveDate" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('receiveDate')"/></td>
          			<td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('receiveDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
		          </tr>
	        	</tbody>
	      </table></td>
       	</tr>
    	<tr>
	    	<td class="layertdleft100">租金额度：</td>
	    	<td colspan="3" class="layerright"><textarea name="contract.rentAmount" rows="3" class="textareaauto"></textarea></td>
	    </tr>
  </table>
  </div>
<div class="hackbox"></div>
</div>
<div class="basediv" style="margin-top:0px; display:block" id="textname" name="textname">
	<div class="emailtop">
		<div class="leftemail">
	    	<strong style="line-height:27px; color:#000; padding-left:5px;">租赁房间</strong>
	    </div>
		<div class="rightemail" style="width:auto; padding-right:10px;">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加租赁房间','<%=basePath %>web/contract/subjectRent_add.jsp?saveFlag=0&contractId='+$('#contractId').val()+'&startDate='+$('#startDate').val()+'&endDate='+$('#endDate').val(),500,284);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>添加租赁房间</li>
			</ul>
		</div>
	</div>
	<div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="nowrap">
			<tbody id="roomListTBody">
				<tr>
		            <td class="tdcenterL" onmousemove="this.className='tdcenterLover'" onmouseout="this.className='tdcenterL'" style="border-left:0;">房间名称</td>
		            <td width="185" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">租用面积 </td>
		            <td width="200" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">租用日期 </td>
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
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="addBillRent();" class=""><span><img src="core/common/images/emailadd.gif" width="15" height="13"></span>添加资金计划</li>
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
          	<tr id="noPlan">
          		<td colspan="5" align="center">无数据</td>
          	</tr>
        </tbody>
	</table>
</div>
<div class="basediv">
	<div class="emailtop">
		<div class="leftemail">
	    	<strong style="line-height:27px; color:#000; padding-left:5px;">押金信息</strong>
	    </div>
		<div class="rightemail" style="width:auto; padding-right:10px;">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建押金','<%=basePath %>web/contract/contract_deposit_add.jsp',500,165);" class=""><span><img src="core/common/images/emailadd.gif" width="15" height="13"></span>添加押金</li>
			</ul>
		</div>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tbody id="depositListTBody">
			<tr>
				<td class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'" style="border-left:0;">押金类型</td>
				<td width="100" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">实际金额</td>
				<td width="100" class="tdcenter" onmousemove="this.className='tdcenterover'" onmouseout="this.className='tdcenter'">备注</td>
				<td width="100" class="tdrightc" onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">操作</td>
			</tr>
			<tr id="noDeposit" onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'" style="background-color: rgb(255, 255, 255); background-position: initial initial; background-repeat: initial initial;">
	            <td colspan="4" align="center">无数据</td>
			</tr>
    	</tbody>
    </table>
</div>
<div class="basediv">
	<div class="titlebg" style="background:#f0f0f0; border-bottom-color:#D9D9D9;">优惠政策</div>
	<div class="divlays" style="margin:0px;">
  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
  			<tbody>
    			<tr>
      				<td class="layertdleft100">优惠政策：</td>
      				<td colspan="4" class="layerright">
                    	<textarea name="contract.policy" rows="3" class="textareaauto"><c:if test="${param.item eq 'ZCQLXSQY'}">（根据甬高新[2010] 35号文件有关精神，其中乙方有 XX 名留学生，享受  XX   平方米房租免予征收，免租租期从   XX   年 XX 月  XX 日至   XX   年  XX 月  XX   日止）；</c:if><c:if test="${param.item eq 'ZCQZFQY'}">其中  XX 平方米，享受“一免一减半”的政策执行，即第一年免交房租，第二年减半缴纳。</c:if></textarea>
                    </td>
    			</tr>
  			</tbody>
  		</table>
  	</div>
	<div class="hackbox"></div>
</div>
</div></div>

<div class="buttondiv">
  <label>&nbsp; 
  <input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
