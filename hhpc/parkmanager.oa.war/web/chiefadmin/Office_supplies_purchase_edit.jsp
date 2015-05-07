<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/js/calendar.js"></script>
<script type="text/javascript" src="core/common/js/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/js/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initForm();
});
function initForm(){
	$("#form1").validate({
		rules:{
			"supplyPurchase.supply.name":"required",
			"supplyPurchase.supply.spec":"required",
			"supplyPurchase.amount":"required",
			"supplyPurchase.supply.unit":"required",
			"supplyPurchase.price":"required",
			"supplyPurchase.totalPrice":"required",
			"supplyPurchase.applyTime":"required",			
			"supplyPurchase.purchaser":"required",
			"supplyPurchase.comment":"required"
		},
		messages: {
			"supplyPurchase.supply.name":"请选择商品",
			"supplyPurchase.supply.spec":"请选择型号",
			"supplyPurchase.amount":"请正确填写申请数量",
			"supplyPurchase.supply.unit":"请填写单位",
			"supplyPurchase.price":"请填写商品价钱",	
			"supplyPurchase.totalPrice":"请填写商品总额",
			"supplyPurchase.applyTime":"请选择申请时间",			
			"supplyPurchase.purchaser":"请填写采购人",									
			"supplyPurchase.comment":"请填写备注"	
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
	$("#supplySpec").val(supply.spec);	
	$("#supplyUnit").val(supply.unit);
}

function setSelectedUser(user){
	$("#applyer").val(user.realName);
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
	if($("#amount").val()!=null && $("#price").val()!=null){
		var totalPrice=$("#amount").val()*$("#price").val();
		$("#totalPrice").val(totalPrice);
	}
}
function checkPrice(obj){
	//先把非数字的都替换掉，除了数字和.   
    obj.value = obj.value.replace(/[^\d.]/g,"");   
    //必须保证第一个为数字而不是.   
    obj.value = obj.value.replace(/^\./g,"");   
    //保证只有出现一个.而没有多个.   
    obj.value = obj.value.replace(/\.{2,}/g,".");   
    //保证.只出现一次，而不能出现两次以上   
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$","."); 
	if($("#amount").val()!=null && $("#price").val()!=null){
		var totalPrice=$("#amount").val()*$("#price").val();
		$("#totalPrice").val(totalPrice);
	}
}
/* function setSelectedUsers(users){
	var ids = "";
	var names = "";
	for(var i = 0; i < users.length; i++){
		ids += users[i].id+",";
		names += users[i].name+",";
	}
	ids = deleteLastCharWhenMatching(ids,",");
	$("#ids").val(ids);
	names = deleteLastCharWhenMatching(names,",");
	$("#applyer").val(names);
} */

</script>
</head>

<body>
<form id="form1" action="<%=basePath%>supplyPurchaseApply!update.action"  name="form1" method="post" >
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
      <td class="layertdleft100"><span class="psred">*</span>名称：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="390">
          	  <input id="id" name="supplyPurchase.id" type="hidden" value="${result.value.id}"/>
	          <input id="supplyId" name="supplyPurchase.supplyId" type="hidden"/>
	          <input id="supplyName" name="supplyPurchase.supply.name" value="${result.value.supply.name}" readonly="readonly" class="inputauto" onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/>
          </td>
          <td width="20">
          	  <img src="core/common/images/outdiv.gif" width="20" height="22" style="position: relative;left:-4px;" onclick="fbStart('选择商品','<%=basePath %>supply!select.action',520,400);"/>
          </td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>型号：</td>
      <td class="layerright">     
      	<input id="supplySpec" value="${result.value.supply.spec}" name="supplyPurchase.supply.spec" type="text" class="inputauto" readonly="readonly" />
      </td>
    </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>数量：</td>
      <td class="layerright">
	  <label>
	  <input id="amount" name="supplyPurchase.amount" value="<fmt:formatNumber value="${result.value.amount}" pattern='#0.00'/>" type="text" class="inputauto" style="padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;width: 100px;"  onkeyup="checkAmount(this)"/>
	  </label>	  </td>
     </tr>
     <tr>
      <td class="layertdleft100"><span class="psred">*</span>单位：</td>
      <td class="layerright">     	
      	<input id="supplyUnit" value="${result.value.supply.unit}" name="supplyPurchase.supply.unit" type="text" class="inputauto" readonly="readonly"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>单价：</td>
      <td class="layerright">
      	<input id="price" name="supplyPurchase.price" value="<fmt:formatNumber value="${result.value.price}" pattern='#0.00'/>" type="text" class="inputauto" onkeyup="checkPrice(this)"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>总额：</td>
      <td class="layerright">
      	<input id="totalPrice" name="supplyPurchase.totalPrice" value="<fmt:formatNumber value="${result.value.totalPrice}" pattern='#0.00'/>" type="text" class="inputauto" readonly="readonly"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>日期：</td>
      <td class="layerright"><table width="110px" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="80">
          	<input id="applyTime" name="supplyPurchase.applyTime" value="<fmt:formatDate value="${result.value.applyTime}" pattern='yyyy-MM-dd'/>" type="text" readonly="readonly" class="inputauto" onclick="return showCalendar('applyTime');"/></td>
          <td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22"  style="position: relative;left: -4px;" onclick="return showCalendar('applyTime');"/></td>
        </tr>
      </table></td>
      </tr>
      <tr>
      <td class="layertdleft100"><span class="psred">*</span>采购人：</td>
      <td class="layerright">
      	<input id="purchaser" name="supplyPurchase.purchaser" value="${result.value.purchaser}" type="text" class="inputauto" />
      </td>
    </tr>
   
     <!-- <tr>
      	  <td class="layertdleft100"><span class="psred">*</span>审批状态：</td>
      	  <td class="layerright">
      		未审批
      </td>
      </tr> -->
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>备注：</td>
      <td class="layerright"><textarea id="comment" name="supplyPurchase.comment"  rows="8" class="textareaauto">${result.value.comment}</textarea></td>
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
