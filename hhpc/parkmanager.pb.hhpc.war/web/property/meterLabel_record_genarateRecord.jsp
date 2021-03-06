<%@page import="com.wiiy.pb.entity.MeterLabelRecord"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>电费结算</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>web/style/ps.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/easyslider1.7/css/slider.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/easyslider1.7/js/easySlider1.7.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		$('#overflowAuto').css('height',getTabContentHeight()-60);
	});
	function checkPrice(obj,id){
		//先把非数字的都替换掉，除了数字和.   
		obj.value = obj.value.replace(/[^\d.]/g,"");   
		//必须保证第一个为数字而不是.   
		obj.value = obj.value.replace(/^\./g,"");   
		//保证只有出现一个.而没有多个.   
		obj.value = obj.value.replace(/\.{2,}/g,".");   
		//保证.只出现一次，而不能出现两次以上   
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		
		var bill = 0*1;
		if($("#"+id+"_price").val()!=''){
			bill = $("#"+id+"_price").val()*$("#"+id+"_totalAmount").val();
		}
		var capacity = 0*1;
		if($("#"+id+"_capacity").val()!=''){
			capacity = $("#"+id+"_capacity").val()*1;
		}
		var capacityBill = 0*1;
		if($("#"+id+"_capacityBill").val()!=''){
			capacityBill = $("#"+id+"_capacityBill").val()*1;
		}
		$("#"+id+"_bill").val(CurrencyFormatted(Math.round(bill*100)/100));
		totalBill = bill+capacity+capacityBill;
		totalBill=Math.round(totalBill*100)/100;
		$("#"+id+"_totalBill").val(CurrencyFormatted(totalBill));
	}
	
	function CurrencyFormatted(amount) {
	    var i = parseFloat(amount);
	    if(isNaN(i)) { i = 0.00; }
	    var minus = '';
	    if(i < 0) { minus = '-'; }
	    i = Math.abs(i);
	    i = parseInt((i + .005) * 100);
	    i = i / 100;
	    s = new String(i);
	    if(s.indexOf('.') < 0) { s += '.00'; }
	    if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	    s = minus + s;
	    return s;
	}
	
	function checkData(id){
		var bill = 0*1;
		var price=0;
		var capacity=0*1;
		var capacityBill=0*1;
		
		var priceVal = $("#"+id+"_price").val();
		$("#"+id+"_price").blur(function(){
			price = this.value;
			if(priceVal==price){
				return;
			}
			if($("#"+id+"_price").val()!=''){
				bill = $("#"+id+"_price").val()*$("#"+id+"_totalAmount").val();
				price=$("#"+id+"_price").val();
			}
			if($("#"+id+"_capacity").val()!=''){
				capacity = $("#"+id+"_capacity").val()*1;
			}
			if($("#"+id+"_capacityBill").val()!=''){
				capacityBill = $("#"+id+"_capacityBill").val()*1;
			}
			var totalBill = $("#"+id+"_totalBill").val();
			var str = price+":"+bill+":"+capacity+":"+capacityBill+":"+totalBill;
			$.post('<%=basePath%>meterLabelRecord!updateGenaratorReport.action?str='+str+'&id='+id,function(data){
				if(data.result.success){
					priceVal=price;
	        		showTip("收费报表更新成功",2000);
	        		setTimeout(function(){
					},2000);
	        	}else{
	        		showTip("收费报表更新失败",2000);
					return;
	        	}
			}); 
		});
		
		var capacityVal = $("#"+id+"_capacity").val()*1;
		$("#"+id+"_capacity").blur(function(){
			capacity = this.value;
			if(capacityVal==capacity){
				return;
			}
			if($("#"+id+"_price").val()!=''){
				bill = $("#"+id+"_price").val()*$("#"+id+"_totalAmount").val();
				price=$("#"+id+"_price").val();
			}
			if($("#"+id+"_capacity").val()!=''){
				capacity = $("#"+id+"_capacity").val()*1;
			}
			if($("#"+id+"_capacityBill").val()!=''){
				capacityBill = $("#"+id+"_capacityBill").val()*1;
			}
			
			var totalBill = $("#"+id+"_totalBill").val();
			var str = price+":"+bill+":"+capacity+":"+capacityBill+":"+totalBill;
			$.post('<%=basePath%>meterLabelRecord!updateGenaratorReport.action?str='+str+'&id='+id,function(data){
				if(data.result.success){
					capacityVal=capacity;
	        		showTip("收费报表更新成功",2000);
	        		setTimeout(function(){
					},2000);
	        	}else{
	        		showTip("收费报表更新失败",2000);
					return;
	        	}
			}); 
		});
		
		var capacityBillVal = $("#"+id+"_capacityBill").val()*1;
		$("#"+id+"_capacityBill").blur(function(){
			capacityBill = this.value;
			if(capacityBillVal==capacityBill){
				return;
			}
			if($("#"+id+"_price").val()!=''){
				bill = $("#"+id+"_price").val()*$("#"+id+"_totalAmount").val();
				price=$("#"+id+"_price").val();
			}
			if($("#"+id+"_capacity").val()!=''){
				capacity = $("#"+id+"_capacity").val()*1;
			}
			if($("#"+id+"_capacityBill").val()!=''){
				capacityBill = $("#"+id+"_capacityBill").val()*1;
			}
			var totalBill = $("#"+id+"_totalBill").val();
			var str = price+":"+bill+":"+capacity+":"+capacityBill+":"+totalBill;
			$.post('<%=basePath%>meterLabelRecord!updateGenaratorReport.action?str='+str+'&id='+id,function(data){
				if(data.result.success){
					capacityBillVal=capacityBill;
	        		showTip("收费报表更新成功",2000);
	        		setTimeout(function(){
					},2000);
	        	}else{
	        		showTip("收费报表更新失败",2000);
					return;
	        	}
			}); 
		});
		
		
	}
	function checkWaterEleFee(){
		var checkedMeter = new Array();
		var names = new Array();
		var ids = new Array();
		var kinds = new Array();
		var i = 0;
		var j= 0;
		var k = 0;
		var l = 0;
		var flag = true;
		$(".fee").each(function(){
			if($(this).is(':checked')){
				checkedMeter[i++] = $(this).val();
				names[j++] = $(this).parent().next().next().text();
				ids[k++] = $(this).parent().next().next().find("input").val();
				kinds[l++] = $(this).parent().next().find("input").val();
			}
		});
		
		var noCheckedIds = "";
		for ( var i = 0; i < checkedMeter.length; i++) {
			if(checkedMeter[i]=='1' ){
				if(names[i]==null ||names[i]=="" || kinds[i]==null || kinds[i]=='SELF' ){
					noCheckedIds += ids[i]+",";	
					flag = false;
				}
			}else{
				noCheckedIds += ids[i]+",";	
			}
			
		}
		
		if(!flag){
			if(confirm("自用表和企业名称为空的将无法出账，是否继续")){
				var check = $("#checkOut").val();
				if(check != 'CKECKOUT'){
					$.post("<%=basePath%>meterLabelRecord!checkWaterEleFee.action?ids="+noCheckedIds+"&labelId=${result.value.labelId}",function(data){
						if(data.result.success){
			        		showTip(data.result.msg,2000);
							setTimeout(function(){
								location.reload();
							},2000);
			        	}else{
			        		showTip(data.result.msg,2000);
							return;
			        	}
					}); 
				}else{
					showTip("此报表已出帐",2000);
					return;
				}
			}
		}else{
			if(confirm("自用表和企业名称为空的将无法出账，是否继续")){
				var check = $("#checkOut").val();
				if(check != 'CKECKOUT'){
					$.post("<%=basePath%>meterLabelRecord!checkWaterEleFee.action?ids="+noCheckedIds+"&labelId=${result.value.labelId}",function(data){
						if(data.result.success){
			        		showTip(data.result.msg,2000);
							setTimeout(function(){
								location.reload();
							},2000);
			        	}else{
			        		showTip(data.result.msg,2000);
							return;
			        	}
					}); 
				}else{
					showTip("此报表已出帐",2000);
					return;
				}
			}
		}
		
	}
	
	function generateReport(){
		$.post("<%=basePath%>meterLabelRecord!validatGenerateReport.action?labelId=${result.value.labelId}&lableType=${result.value.labelType}",function(data){
			if(!data.option){
				showTip("操作成功",2000);
				setTimeout(function(){
					location.reload();
				},2000);
			}else{
				showTip(data.result.msg,2000);
			}
		});
	}
</script>
</head>

<body>
<div id="container">
	<jsp:include page="commonEle.jsp">
		<jsp:param value="2" name="index"/>
		<jsp:param value="${result.value.labelId}" name="labelId"/>
		<jsp:param value="${result.value.labelType}" name="labelType"/>
		<jsp:param value="${result.value.checkOut}" name="checkOut"/>
	</jsp:include>
	<input type="hidden" id="checkOut" value="${result.value.checkOut}"/>
	<div class="pm_msglist tabswitch">
		<div class="emailtop">
			<div class="leftemail">
					<ul>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_meterLabelRecord_out")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="checkWaterEleFee();"><span><img src="core/common/images/emailadd.gif"/></span>审核出账</li>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_meterLabelRecord_reGenerateReport")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="generateReport();"><span><img src="core/common/images/edit.gif"/></span>重新生成</li>
					<%} %>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_meterLabelRecord_printFee")){ %>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="window.open('<%=basePath%>meterLabelRecord!printFee.action?labelId=${result.value.labelId}&lableType=${result.value.labelType}')"><span><img src="core/common/images/print_btn.gif"/></span>打印</li>
					<%} %>
					</ul>
			</div>
		</div>
	
	<div class="overflowAuto" id="overflowAuto" style="font-size: 12px">
	<div style="width:90%; padding:10px 0 5px; margin:0 auto;">
	<h1 style="text-align:center; font-size:2em;">浙江大学科技园宁波发展有限公司电费结算单</h1>
	<span style="float:right;font-size:12px;">制表人：<%=PbActivator.getSessionUser(request).getRealName() %></span>
	<span style=" font-size:12px;">结算期：<u><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/></u>&nbsp;至&nbsp;<u><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/></u></span>
	</div>
  	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="margin:0;">
      <thead>
      	<tr>
        	<th width="40" rowspan="2" >序号</th>
        	<th width="80" rowspan="2">是否出账</th>
        	<th width="70" rowspan="2" >表名</th>
        	<th width="100" rowspan="2">企业名称</th>
		    <th width="75" rowspan="2">上月<br />抄表数</th>
		    <th width="75" rowspan="2">本月<br />抄表数</th>
		    <th width="80" rowspan="2">倍率</th>
		    <th width="80" rowspan="2">实用度数</th>
		    <th width="80" rowspan="2">耗电</th>
		    <th width="80" rowspan="2">合计度数</th>
		    <th width="80" rowspan="2">单价</th>
		    <th width="80" rowspan="2">金额</th>
		    <th width="120" colspan="2">基本电费</th>
		    <th width="80" rowspan="2">合计金额</th>
		    <th width="60" rowspan="2">用户单位签字</th>
		    </tr>
		    
		    <tr>
      			<th width="">装机容量</th>
      			<th width="">合计</th>
      		</tr>

		    
		    </thead>
			
			<tbody>
			
      			<c:forEach items="${result.value.labelRecords}" var="list" varStatus="status">
	      			<tr>
	      				
	       				<td height="25">${status.index+1}</td>
	        			<c:forEach items="${result.value.meters }" var="meter">
	        			<c:if test="${meter.orderNo==list.meterOrderNo and meter.kind =='HOUSEHOLD' }"><td><input name="shi+${list.id }" class="fee" checked="checked" type="radio" value="1"/>是<input class="fee" type="radio" value="2" name="shi+${list.id }"/>否</td></c:if>
	        			<c:if test="${meter.orderNo==list.meterOrderNo and meter.kind =='SELF' }"><td><input name="shi+${list.id }" class="fee" type="radio" value="1"/>是<input class="fee" type="radio" value="2" checked="checked"  name="shi+${list.id }"/>否</td></c:if>
	        			<c:if test="${meter.orderNo==list.meterOrderNo }"><td>${meter.name}<input type="hidden" value="${meter.kind }"/></td></c:if>
	        			</c:forEach>
	        			<td>${list.customerName}<input id="meterId${list.id}" type="hidden" value="${list.id}"/></td>
	        			<td><fmt:formatNumber value="${list.preReading}" pattern="#0.00" /></td>
	        			<td><fmt:formatNumber value="${list.curReading}" pattern="#0.00" /></td>
	       				<td>${list.meterFactor}</td>
				        <td><fmt:formatNumber value="${list.syAmount}" pattern="#0.00" /></td>
				        <td><fmt:formatNumber value="${list.hdAmount}" pattern="#0.00" /></td>
				       	<td><input type="text" id="${list.id }_totalAmount" name="" class="input" value="<fmt:formatNumber value="${list.totalAmount}" pattern="#0.00" />" style="width:100%;border:0;" readonly="readonly"/></td>
				       	<td><span class="pointSpan"><input type="text" id="${list.id }_price" name="" class="input" value="<fmt:formatNumber value="${list.price}" pattern="#0.00" />" style="width:100%;" onfocus="checkData(${list.id});" onkeyup="checkPrice(this,${list.id});"/></span></td>
				       	<td><input type="text" id="${list.id }_bill" name="" class="input" value="<fmt:formatNumber value="${list.bill}" pattern="#0.00" />" style="width:100%;border:0;" readonly="readonly"/></td>
				       	<c:forEach items="${result.value.meters }" var="meter">
	        			<c:if test="${meter.orderNo==list.meterOrderNo }">
	        			<td><span class="pointSpan"><input type="text" id="${list.id }_capacity" name="" class="input" value="<fmt:formatNumber value="${meter.capacity}" pattern="#0.00" />" style="width:100%;" onfocus="checkData(${list.id});" onkeyup="checkPrice(this,${list.id});"/></span></td>
				        <td><span class="pointSpan"><input type="text" id="${list.id }_capacityBill" name="" class="input" value="<fmt:formatNumber value="${meter.capacityBill}" pattern="#0.00" />" style="width:100%;" onfocus="checkData(${list.id});" onkeyup="checkPrice(this,${list.id});"/></span></td>
				        </c:if>
	        			</c:forEach>
				        <td><input type="text" id="${list.id }_totalBill" name="" class="input" value="<fmt:formatNumber value="${list.totalBill}" pattern="#0.00" />" style="width:100%;border:0;" readonly="readonly"/></td>
				        <td>&nbsp;</td>
				        
	      			</tr>
      			</c:forEach>
      		</tbody>
    	</table>
	</div>
	</div>
</div>
</body>
</html>

