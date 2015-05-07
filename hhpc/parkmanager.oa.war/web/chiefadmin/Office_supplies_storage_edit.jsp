<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		initTip();
		initForm();
	});
	
	function initForm(){
		$("#form1").validate({
			rules:{
				"supplyStockIn.supply.name":"required",
				"supplyStockIn.supplier":"required",
				"supplyStockIn.price":"number",
				"supplyStockIn.amount":"number",
				"supplyStockIn.inTime":"required",
				"supplyStockIn.purchaser":"required"
			},
			messages: {
				"supplyStockIn.supply.name":"请选择商品",
				"supplyStockIn.supplier":"请填写供应商",
				"supplyStockIn.price":"请正确填写价格",
				"supplyStockIn.amount":"请正确填写总数",
				"supplyStockIn.inTime":"请选择进货时间",
				"supplyStockIn.purchaser":"请填写购买人"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedSupply(supply){
		$("#supplyId").val(supply.id);
		$("#supplyName").val(supply.name);
	}
	
	function checkAmount(obj){
		//先把非数字的都替换掉，除了数字和.   
	    obj.value = obj.value.replace(/[^\d.]/g,"");   
	    //必须保证第一个为数字而不是.   
	    obj.value = obj.value.replace(/^\./g,"");   
	    //保证只有出现一个.而没有多个.   
	    obj.value = obj.value.replace(/\.{2,}/g,".");   
	    //保证.只出现一次，而不能出现两次以上   
	    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
	}
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath %>supplyStockIn!update.action">
<!--basediv-->
<input value="${result.value.id}" name="supplyStockIn.id" type="hidden" id="id"/>
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>商品名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="370"><input id="supplyId"  name="supplyStockIn.supplyId"  value="${result.value.supply.id}" type="hidden"/>
          <input id="supplyName"  value="${result.value.supply.name}"  readonly="readonly" class="inputauto"  onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/></td>
          <td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22"  style="position: relative;left:-3px;"  onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>供应商：</td>
      <td class="layerright"><label>
        <input id="supplier" name="supplyStockIn.supplier"   value="${result.value.supplier}" type="text" class="inputauto" />
      </label></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>价格：</td>
      <td class="layerright">
	  <label>
	  <input id="price" name="supplyStockIn.price" value="<fmt:formatNumber value="${result.value.price}" pattern="#0.00"/>" type="text" class="inputauto" onkeyup="checkAmount(this)"/>
	  </label>	  </td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>总数：</td>
      <td class="layerright"><input id="amount"  name="supplyStockIn.amount" value="<fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/>" type="text" class="inputauto" onkeyup="checkAmount(this)" /></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>进货时间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
       	  <tr>
        	  <td width="370"><input id="inTime" name="supplyStockIn.inTime"  readonly="readonly"  value="<fmt:formatDate value="${result.value.inTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto"  onclick="return showCalendar('inTime');"/></td>
        	  <td width="20"><img src="core/common/images/timeico.gif"  width="20" height="22"  style="position: relative;left:-3px;"  onclick="return showCalendar('inTime');"/></td>
         </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>购买人：</td>
      <td class="layerright"><input id="purchaser" name="supplyStockIn.purchaser" value="${result.value.purchaser}"  type="text" class="inputauto" /></td>
      </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
