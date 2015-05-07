<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"fixedAssets.name":"required",
				"fixedAssets.typeId":"required",
				"fixedAssets.status":"required",
				"fixedAssets.dealDate":"required"			
			},
			messages: {
				"fixedAssets.name":"请填写资产名称",
				"fixedAssets.typeId":"请选择资产类别",
				"fixedAssets.status":"请选择状态",
				"fixedAssets.dealDate":"请设置置办日期"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$(form).ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		//setTimeout("parent.refresh();parent.fb.end();", 2000);
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedOrg(selectedOrg){
		$("#orgId").val(selectedOrg.id);
		$("#orgName").val(selectedOrg.name);
	}
</script>
</head>

<body>
<body>
<form id="form1" name="form1" method="post" action="<%=basePath %>fixedAssets!update.action">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">基本信息</div>
	<!--//titlebg-->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>资产名称：</td>
      <td class="layerright">
      <input name="fixedAssets.id" type="hidden" class="inputauto" value="${result.value.id}"/>
      <input name="fixedAssets.name" type="text" class="inputauto" value="${result.value.name}"/>
      </td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>资产类别：</td>
      <td class="layerright">  		
    		<dd:select id="typeId" name="fixedAssets.typeId" key="oa.0003" checked="result.value.typeId"/>
    	</td>
    	<td >&nbsp;</td>
    	<td>&nbsp;</td>
      </tr>
    <tr>
     <td class="layertdleft100"><span class="psred">*</span>置办日期：</td>
     <td class="layerright">
		<table border="0" cellspacing="0" cellpadding="10">
		<tr>
		<td width="200"><input id="dealDate" name="fixedAssets.dealDate" type="text" class="inputauto" readonly="readonly" 
			onclick="return showCalendar('dealDate','y-mm-dd');" value="<fmt:formatDate value="${result.value.dealDate}" pattern="yyyy-MM-dd"/>"/></td>
		<td width="20" ><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('dealDate','y-mm-dd');"/></td>
		</tr>
		</table>
	 </td>
    </tr>
    <tr>
      <td class="layertdleft100">所属部门：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
			<td width="200"><input id="orgId" name="fixedAssets.orgId" value="${result.value.orgId}" type="hidden" /><input id="orgName" value="${result.value.org.name}" class="inputauto" readonly="readonly" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
			<td><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
		</tr>
      </table></td>
    </tr>
     <tr>
        <td class="layertdleft100">规格型号：</td>
        <td class="layerright"><input name="fixedAssets.spec" type="text" style="width:180px;" class="inputauto" value="${result.value.spec}"/></td>
        </tr>
      <tr>
        <td class="layertdleft100">厂商：</td>
        <td class="layerright"><input name="fixedAssets.factory" type="text" style="width:180px;" class="inputauto" value="${result.value.factory}"/></td>
      </tr>
       <tr>
        <td class="layertdleft100">使用人：</td>
        <td class="layerright"><input name="fixedAssets.user" type="text" style="width:180px;" class="inputauto" value="${result.value.user}"/></td>
      </tr>
      <tr>
        <td class="layertdleft100">保管人：</td>
        <td class="layerright"><input name="fixedAssets.custodian" type="text" style="width:180px;" class="inputauto" value="${result.value.custodian}"/></td>
      </tr>
       <tr>
        <td class="layertdleft100">状态：</td>
        <td class="layerright">
        	 <enum:select checked="result.value.status"  type="com.wiiy.oa.preferences.enums.FixedAssetsStatusEnum"  name="fixedAssets.status"/>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">采购日期：</td>
        <td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="200"><input id="buyDate" name="fixedAssets.buyDate" type="text" class="inputauto" readonly="readonly" 
					onclick="return showCalendar('buyDate','y-mm-dd');" value="<fmt:formatDate value="${result.value.buyDate}" pattern="yyyy-MM-dd"/>"/></td>
				<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('buyDate','y-mm-dd');"/></td>
			</tr>
		</table> </td>
      </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright"><textarea name="fixedAssets.memo"  rows="3" class="textareaauto">${result.value.memo}</textarea></td>
      </tr>
  </table>

</div>
<!--//basediv-->
<!--table切换开始-->
<%-- 	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">折旧信息</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">扩展信息</li>
		</ul>
	</div>
<!--//table切换开始-->
<!--basediv-->
<div class="basediv tabswitch" style="margin-top:0px; height:132px;" name="textname" id="textname">
	<!--divlays-->
	<div class="divlays" style="margin:0px;">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">折旧类型：</td>
        <td class="layerright"><enum:select id="depreciation" name="fixedAssets.depreciation" checked="result.value.depreciation" type="com.wiiy.oa.preferences.enums.DepreciationEnum"/></td>
        <td >&nbsp;</td>
      </tr>
      <tr>
        <td class="layertdleft100">折旧周期：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="110"><input name="fixedAssets.cycleAmount" type="text" class="input100" value="<fmt:formatNumber value="${result.value.cycleAmount}" pattern="#0.00"/>"/></td>
            <td class="layerright"><enum:select id="cycle" name="fixedAssets.cycle" checked="result.value.cycle" type="com.wiiy.oa.preferences.enums.DepreciationCycleEnum"/></td>
          </tr>
        </table><label></label></td>
        <td class="layertdleft100">开始折旧日期：</td>
        <td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="200"><input id="startDate" name="fixedAssets.startDate" type="text" class="inputauto" readonly="readonly" 
						onclick="return showCalendar('startDate','y-mm-dd');" value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>"/></td>
				<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('startDate','y-mm-dd');"/></td>
			</tr>
		</table> </td>
      </tr>
      <tr>
        <td class="layertdleft100">预计净残值率：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="110"><input name="fixedAssets.residualValueRate" type="text" class="input100" value="<fmt:formatNumber value="${result.value.residualValueRate}" pattern="#0.00"/>"/></td>
            <td>%</td>
          </tr>
        </table></td>
        <td class="layertdleft100">预计使用寿命：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           <td width="110"><input name="fixedAssets.lifeTime" type="text" class="input100" value="<fmt:formatNumber value="${result.value.lifeTime}" pattern="#0.00"/>"/></td>
            <td>年</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100">原资产值：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="110"><input name="fixedAssets.originalValue" type="text" class="input100" value="<fmt:formatNumber value="${result.value.originalValue}" pattern="#0.00"/>"/></td>
            <td>元</td>
          </tr>
        </table></td>
        <td class="layertdleft100">现资产值：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="110"><input name="fixedAssets.newValue" type="text" class="input100" value="<fmt:formatNumber value="${result.value.newValue}" pattern="#0.00"/>"/></td>
            <td>元</td>
          </tr>
        </table></td>
      </tr>
	  </table>
    </div>
</div>
<!--//basediv-->

<!--basediv-->
<div class="basediv tabswitch" style="margin-top:0px;display:none" name="textname" id="textname">
	<!--divlays-->
	<div class="divlays" style="margin:0px;">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">规格型号：</td>
        <td class="layerright"><input name="fixedAssets.spec" type="text" style="width:180px;" class="inputauto" value="${resutl.value.spec}"/></td>
        </tr>
      <tr>
        <td class="layertdleft100">厂商：</td>
        <td class="layerright"><input name="fixedAssets.factory" type="text" style="width:180px;" class="inputauto" value="${resutl.value.factory}"/></td>
      </tr>
      <tr>
        <td class="layertdleft100">采购日期：</td>
        <td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="200"><input id="buyDate" name="fixedAssets.buyDate" type="text" class="inputauto" readonly="readonly" 
					onclick="return showCalendar('buyDate','y-mm-dd');" value="<fmt:formatDate value="${result.value.buyDate}" pattern="yyyy-MM-dd"/>"/></td>
				<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;relative; left:-1px;" onclick="return showCalendar('buyDate','y-mm-dd');"/></td>
			</tr>
		</table> </td>
      </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright"><textarea name="fixedAssets.memo"  rows="3" class="textareaauto">${resutl.value.memo}</textarea></td>
      </tr>
    </table>
	</div>
</div> --%>
<!--//basediv-->

<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
