<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
				"supply.name":"required",
				"supply.categoryId":"required"
			},
			messages: {
				"supply.name":"请填写物品名称",
				"supply.categoryId":"请选择分类"
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
			        		setTimeout("parent.fb.end();getOpener().reloadList();getOpener().refreshTree();", 2000);
			        	}
			        } 
			    });
			}
		});
	}

	function setSelectedCatlog(catlog) {
  	 	$("#typeId").val(catlog.id);
  	 	$("#typeName").val(catlog.name);
  	 }
	
</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="<%=basePath %>supply!update.action">
<input type="hidden" name="supply.id" value="${result.value.id}"/>
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>所属分类：</td>
       <td class="layerright">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="155">
	            <input readonly="readonly" id="typeName" name="supply.category.name" type="text" class="inputauto"  <c:if test="${result.value.category.name!=null}">value="${result.value.category.name}"</c:if>  onclick="fbStart('选择办公用品','<%=basePath %>web/chiefadmin/supplyCategory_select.jsp',450,300);"/>
	            <input id="typeId" type="hidden" name="supply.categoryId" />
	          </td>
	          <td width="20"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择办公用品','<%=basePath %>web/chiefadmin/supplyCategory_select.jsp',450,300);"/></td>
	          <td>&nbsp;</td>
	        </tr>
	      </table>
      </td>
      <td class="layertdleft100">计量单位：</td>
      <td><label><input name="supply.unit" value="${result.value.unit}" class="input170" />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>物品名称：</td>
      <td><label>
        <input name="supply.name" value="${result.value.name}" class="input170" />
      </label></td>
      <td class="layertdleft100">启用库存警示：</td>
      <td class="layerright">
      	  <enum:select type="com.wiiy.commons.preferences.enums.BooleanEnum" 
							     name="supply.alarm" styleClass="incubated" checked="result.value.alarm"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">规格：</td>
      <td>
	  <label>
	  <input name="supply.spec" value="${result.value.spec}" class="input170" />
	  </label>	  </td>
      <td class="layertdleft100">警报库存数：</td>
      <td><input name="supply.alarmStock" value="<fmt:formatNumber value="${result.value.alarmStock}" pattern="#0.00"/>" class="input170" /></td>
    </tr>
    <tr>
		<td class="layertdleft100">库存数：</td>
		<td colspan="3" >
			<input name="supply.stock" type="text" class="input170" value="<fmt:formatNumber value="${result.value.stock}" pattern="#0.00"/>"/>
		</td>
	</tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td colspan="3" class="layerright"><label>
        <textarea name="supply.memo"  rows="8" class="textareaauto">${result.value.memo}</textarea>
      </label></td>
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
