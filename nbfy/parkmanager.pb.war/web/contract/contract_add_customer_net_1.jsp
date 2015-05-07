<%@page import="com.wiiy.core.service.export.DataDictInitService"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@page import="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum"%>
<%@ page import="com.wiiy.crm.preferences.enums.ContractTypeEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		});
		
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
		function appendNet(){
			var tr = $("<tr></tr>");
			var select = $("<select></select>",{name:"netId"});
			for(var i = 0; i < facilityList.length; i++){
				var facility = facilityList[i];
				var option = $("<option></option>",{value:facility.id}).append(facility.name);
				select.append(option);
			}
			var th = $("<th></th>").append(select);
			var price = $("<input />",{name:"price"}).addClass("inputauto").addClass("price").css("width",40).keyup(function(){checkDouble(this);}).blur(function(){fireChange(this, "price");});
			var priceTd = $("<td></td>",{align:"left"}).append(price).append("&nbsp;&nbsp;元/月");
			var ip = $("<input />",{name:"ip"}).addClass("inputauto").addClass("ip").css("width",40).keyup(function(){checkDouble(this);}).blur(function(){fireChange(this, "ip");});
			var ipTd = $("<td></td>",{align:"left"}).append(ip).append("&nbsp;&nbsp;个");
			var port = $("<input />",{name:"port"}).addClass("inputauto").addClass("port").css("width",40).keyup(function(){checkDouble(this);}).blur(function(){fireChange(this, "port");});
			var portTd = $("<td></td>",{align:"left"}).append(port).append("&nbsp;&nbsp;个");
			var ipPub = $("<input />",{name:"ipPub"}).addClass("inputauto").addClass("ipPub").css("width",40).keyup(function(){checkDouble(this);}).blur(function(){fireChange(this, "ipPub");});
			var ipPubTd = $("<td></td>",{align:"left"}).append(ipPub).append("&nbsp;&nbsp;个");
			var date = getNetDateTd();
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deleteRoom($(this).parent().parent());}}).append($("<span></span>").css("vertical-align","middle").append("删除"));
			var op = $("<td></td>",{align:"center"}).append(a);
			tr.append(th);
			tr.append(priceTd);
			tr.append(ipTd);
			tr.append(portTd);
			tr.append(ipPubTd);
			tr.append(date);
			tr.append(op);
			$("#netListTBody").append(tr);
		}
		function getNetId(){
			if($(".netId").size()==0) return 0;
			else return parseInt($(".netId").last().val())+1;
		}
	    function getNetDateTd(){
	    	var tr = $("<tr></tr>");
	    	var id = getNetId();
	    	var start = getCalendarInputTd("netStartDate"+id,"netStartDate",$("#netStartDate").val());
	    	var startIcon = getCalendarIconTd("netStartDate"+id);
	    	var split = $("<td></td>").append("&nbsp;至&nbsp;");
	    	var end = getCalendarInputTd("netEndDate"+id,"netEndDate",$("#netEndDate").val());
	    	var endIcon = getCalendarIconTd("netEndDate"+id);
	    	tr.append(start);
			tr.append(startIcon);
			tr.append(split);
			tr.append(end);
			tr.append(endIcon);
			return $("<td></td>").append($("<table></table>",{"border":0,"cellspacing":0,"cellpadding":10}).append(tr));
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
		function appendPlan(){
			var tr = $("<tr></tr>");
			var id = $("<input />",{name:"planId",type:"hidden",value:getPlanId()}).addClass("planId");
			var th = $("<th></th>").append("网络费").append(id);
			var money = $("<input />",{name:"money"}).addClass("inputauto").addClass("money").css("width",40).keyup(function(){checkDouble(this);}).blur(function(){calculateTotal("money", "totalMoney");});
			var moneyTd = $("<td></td>",{align:"left"}).append(money).append("&nbsp;&nbsp;元");
			var payDate = getPayDateTd();
			var feeDate = getFeeDateTd();
			var a = $("<a></a>",{href:"javascript:void(0)",click:function(){deleteRoom($(this).parent().parent());}}).append($("<span></span>").css("vertical-align","middle").append("删除"));
			var op = $("<td></td>",{align:"center"}).append(a);
			tr.append(th);
			tr.append(moneyTd);
			tr.append(payDate);
			tr.append(feeDate);
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
					"contract.purpose":"required",
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
					"contract.purpose":"请输入租凭用途",
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
					/* $(".planStartDate").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("计费区间不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					});
					$(".planEndDate").each(function(){
						if(checkPass && !$(this).val()) {
							showTip("计费区间不能为空!");
							checkPass = false;
							$(this).focus();
							return;
						}
					}); */
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
	</script>
</head>
<body>
<form action="<%=basePath %>contract!saveNetContract1.action" method="post" name="form1" id="form1">
<input type="hidden" name="contract.item" value="${param.item}"/>
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
      <td class="layertdleft100">甲方(出租方)：</td>
      <td class="layerright"><strong>杭州万轮科技创业中心有限公司</strong></td>
     
    </tr>
    <tr>
     
      <td class="layertdleft100">乙方(承租方)：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tbody><tr>
          <td width="215"><input id="customerId" name="contract.customerId" type="hidden" ><input id="customerName" name="contract.customerName" class="inputauto" onclick="selectCustomer()" readonly="readonly"></td>
          <td width="26" align="center" style="padding-right: 5px;"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectCustomer()" style="cursor:pointer"></td>
          <td width="102" align="right" class="layertdleft100">合同编号：</td>
          <td style="padding-left: 5px;"><input name="contract.contractNo" type="text" class="inputauto" /></td>
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
      <td class="layertdleft100">承租用途：</td>
      <td class="layerright"><input name="contract.purpose" type="text" class="inputauto" style="width:98%;" /></td>
      <td class="layertdleft100">负责人：</td>
      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="managerId" name="contract.managerId" type="hidden"><input id="managerName" name="managerName" class="inputauto" onclick="selectUser()" readonly="readonly"></td>
          <td width="21" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="selectUser()" style="cursor:pointer"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">交付时间：</td>
      <td class="layerright" width="35%"><table width="143" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="receiveDate" name="contract.receiveDate" readonly="readonly" type="text" class="inputauto" onclick="showCalendar('receiveDate')"/></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('receiveDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
        </tr>
      </table></td>
      <td class="layertdleft100">签订日期：</td>
      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="signDate" name="contract.signDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('signDate')"/></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('signDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">开始日期：</td>
      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="startDate" name="contract.startDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('startDate');" /></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('startDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
        </tr>
      </table></td>
      <td class="layertdleft100">结束日期：</td>
      <td class="layerright"><table width="143" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="endDate" name="contract.endDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('endDate')"/></td>
          <td width="20" align="center"><img style="position:relative; left:-1px;" onclick="showCalendar('endDate')" src="core/common/images/timeico.gif" width="20" height="22" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">合同押金：</td>
      <td class="layerright"><input name="deposit" type="text" class="inputauto" style="width:98%;" /></td>
    </tr>
  </table>
  
  </div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->

<!--basediv-->
<!--租赁房间-->
<div class="basediv" style="margin-top:0px; display:block" id="textname" name="textname">
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
              <!-- <tr>
                <th>西湖科技园-创业大厦-A045</th>
                <td align="left"><input name="textfield2" type="text" class="inputauto roomArea" style=" width:40px;" onblur="fireChange(this,'roomArea');calculateTotal('roomArea', 'totalArea')">&nbsp;&nbsp;平方米</td>
                <td align="left"><input name="textfield2" type="text" class="inputauto roomPrice" style=" width:40px;" onblur="fireChange(this,'roomPrice')">&nbsp;&nbsp;元</td>
                <td>
                	<table border="0" cellspacing="0" cellpadding="10">
                    	<tr>
                      		<td width="80"><input name="textfield17" type="text" class="inputauto"></td>
                      		<td width="20" align="center"><img style="position:relative; left:-3px;" src="core/common/images/timeico.gif"></td>
                      		<td>&nbsp;至&nbsp;</td>
                      		<td width="80"><input name="textfield17" type="text" class="inputauto"></td>
                      		<td width="20" align="center"><img style="position:relative; left:-3px;" src="core/common/images/timeico.gif"></td>
                    	</tr>
                  	</table>
                </td>
                <td align="center"><a href="javascript:void(0)" onclick="deleteRoom($(this).parent().parent());" title=""><span style="vertical-align:middle;">删除</span></a></td>
              </tr> -->
            </tbody>
        </table>
  </div>
  <!--//租赁房间-->
<!--//basediv-->


<!--basediv-->
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
              	<!-- <tr>
                	<th>
                		<select><option disabled="disabled">租金</option><option>押金</option></select>
                	</th>
                	<td align="left"><input name="textfield2" type="text" class="inputauto" style=" width:40px;">&nbsp;&nbsp;元</td>
                	<td>
                		<table border="0" cellspacing="0" cellpadding="10">
                  			<tbody>
                    			<tr>
                      				<td width="80"><input name="textfield9" type="text" class="inputauto" /></td>
                      				<td width="20" align="center"><img style="position:relative; left:-3px;" src="core/common/images/timeico.gif" width="20" height="22" /></td>
                      				<td width="40" >之前</td>
                    			</tr>
                  			</tbody>
                		</table>
                	</td>
                	<td>
                		<table border="0" cellspacing="0" cellpadding="10">
                  			<tbody>
                    			<tr>
                      				<td width="80"><input name="textfield9" type="text" class="inputauto" /></td>
                      				<td width="20" align="center"><img style="position:relative; left:-3px;" src="core/common/images/timeico.gif" width="20" height="22" /></td>
                      				<td width="20" >至</td>
                      				<td width="80"><input name="textfield9" type="text" class="inputauto" /></td>
                      				<td width="20" align="center"><img style="position:relative; left:-3px;" src="core/common/images/timeico.gif" width="20" height="22" /></td>
                    			</tr>
                  			</tbody>
                		</table>
                	</td>
                	<td align="center"><a href="javascript" onclick="deletePlan($(this).parent().parent());" title=""><span style="vertical-align:middle;">删除</span></a></td>
              	</tr> -->
            </tbody>
            <tfoot>
            	<tr>
            		<th>资金总额：</th>
                    <td colspan="4"><strong id="totalMoney">0</strong>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;<span><!-- <label><input name="autocheck" value="yes" type="checkbox" style="vertical-align:middle;">是否自动出帐</label> --></span></td>
                </tr>
            </tfoot>
        </table>
        
  </div>
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
