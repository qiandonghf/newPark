<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function toSubmit(){
		if($("#email").attr("checked")!='checked' && $("#sms").attr("checked")!='checked'){
			showTip("请选择通知方式");
			return;
		}
		if(confirm('确认通知退款？')){
			var postData = {email:'',sms:''};
			if($("#email").attr("checked")=='checked') postData.email = "yes";
			if($("#sms").attr("checked")=='checked') postData.sms = "yes";
			$.post("<%=basePath %>bill!outInform.action",postData,function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					setTimeout("parent.fb.end()", 2000);
				}
			});
		}
	}
</script>
</head>

<body style=" background:#fff">
<div class="basediv">

<div class="tip tip5_tip">
系统检测到现有${customerTotal}个企业共计${billTotal}条帐单需退款处理，选择通知方式实现通知操作。如需打印退款通知单，则进入&nbsp;<a href="javascript:void(0)" title=""  onclick="fbStart('收款','<%=basePath%>bill!out.action',700,370);">退款结算</a>&nbsp;页面。</div>

<div class="overflowYauto" style="height:390px;  margin:0 4px; border:1px solid #ccc;"">
<ul class="table_list">
<c:forEach items="${result.value}" var="dto">
<li>
<div><span class="flLt">${dto.customerName}</span><span class="flRt">单位：元 </span></div>
    <table border="1" bordercolor="#ccc" cellpadding="0" cellspacing="0" width="100%" style="border-collapse:collapse">
    	<tr>
        	<th width="100">费用类型</th>
            <th width="150">计费时间</th>
            <!-- <th width="80">数量</th>
            <th>单价</th> -->
            <th width="90">出帐日期</th>
            <th width="100">金额</th>
        </tr>
        <c:forEach items="${dto.billList}" var="bill">
        <tr>
           <td align="center">${bill.billType.typeName}</td>
           <td align="center"><fmt:formatDate value="${bill.feeStartTime}" pattern="yyyy-MM-dd"/> – <fmt:formatDate value="${bill.feeEndTime}" pattern="yyyy-MM-dd"/></td>
           <%-- <td align="center"><fmt:formatNumber value="${bill.amount}" pattern="#.##"/></td>
           <td align="center">${bill.price}</td> --%>
           <td align="center"><fmt:formatDate value="${bill.checkoutTime}" pattern="yyyy-MM-dd"/></td>
           <td align="right"><fmt:formatNumber value="${bill.totalAmount}" pattern="#0.00"/></td>
        </tr>
        </c:forEach>
        <tr>
        	<td colspan="3" align="right">合计：</td>
           <td align="right"><fmt:formatNumber value="${dto.total}" pattern="#0.00"/></td>
        </tr>
    </table>
</li>
</c:forEach>
</ul>
</div>

<div style="text-align:left; padding:10px 4px;">
	<label><input id="sms" type="checkbox" class="vetM" /><span class="vetM">短信通知</span></label>&nbsp;&nbsp;&nbsp;&nbsp;<label><input id="email" type="checkbox" class="vetM" /><span class="vetM">邮件通知</span></label>
</div>




</div>
<!--//basediv-->


<div class="buttondiv">

  <a href="javascript:void(0)" title="" class="btn_bg" onclick="fbStart('退款通知单打印','<%=basePath%>bill!printPayMentOut.action?ids=${ids }',730,400);"><span><img src="core/common/images/print_btn.gif" />打印</span></a>
  <a href="javascript:void(0)" title="" class="btn_bg" onclick="toSubmit()"><span><img src="core/common/images/bill_07.gif" />退款通知</span></a>
  
  <a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/closebtnicon.gif" />取消</span></a>
  
</div>

</body>
</html>