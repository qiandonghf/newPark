<%@page import="com.wiiy.crm.preferences.enums.PriorityEnum"%>
<%@page import="com.wiiy.crm.preferences.enums.InvestmentStatusEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript">
	var suffix = "";
	$(function(){
		initTip();
		initForm();
		initNums();
	});
	
	function initNums(){
		var nums = "${result.value.staffInfo}";
		var numArray = nums.split(",");
		$(".inlinetdRight").each(function(i){
			$(this).find("input").val(numArray[i]);
		});
		checkNums();
	}
	
	function getNums(){
		var nums = "";
		$(".inlinetdRight").find("input").each(function(i){
			var value = $(this).val();
			nums += value+",";
		});
		nums = nums.substring(0, nums.length-1);
		$("input[name='investment.staffInfo']").val(nums);
	}
	
	function checkNums(){
		var num = 0;
		/*
			第一个循环是各职称的总人数
		*/
		var zz = 0;
		var jz = 0;
		for(var i = 0;i<7;i++){
			var zc1 = Number($(".inlinetdRight").find("input").eq(i).val());//某个职称专职
			var zc2 = Number($(".inlinetdRight").find("input").eq(i+7).val());//某个职称兼职
			zz += zc1;
			jz += zc2;
			num =zc1+zc2;
			$(".rightReadOnly").find("input").eq(i+1).val(num);
			$(".rightReadOnly").find("input").eq(8).val(zz);
			$(".rightReadOnly").find("input").eq(9).val(jz);
			zz = Number($(".rightReadOnly").find("input").eq(8).val());//专职
			jz =  Number($(".rightReadOnly").find("input").eq(9).val());//兼职
		}
		for(var i = 1,num = 0; i <= 7; i++){
			num += Number($(".rightReadOnly").find("input").eq(i).val());
		}
		$(".rightReadOnly").find("input").eq(0).val(num);//员工总数
	}
	
	function keyUp(obj){
		var value = $(obj).val().replace(/[^\d]/g,'');
		$(obj).val(value);
		checkNums();
	}
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"investment.name":"required"
			},
			messages: {
				"investment.name":"请输入企业名称"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				getNums();
				$(form).ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().location.reload();parent.fb.end();",2000);
			        	}
			        } 
			    });
			}
		});
	}
</script>

<style>
	table{
		table-layout:fixed;
	}
	td{
	}
	#inline_table td{
		height:24px;
	}
	#inline_table .inlinetdleft{
		background-color:#f2f2f2;
		border-right:1px solid #fff;
		border-bottom:1px solid #fff;
		color:#666;
	}
	#inline_table .inlinetdRight{
		border-bottom:1px solid #f2f2f2;
		border-right:1px solid #f2f2f2;
		padding-right:4px;
		padding-left:2px;
	}
	.inlinetdRight input{
		text-align:center;
		width:100%;
		border: 0px;
		border-bottom: 1px solid #666;
	}
	#inline_table .rightReadOnly{
		border-bottom:1px solid #f2f2f2;
		border-right:1px solid #f2f2f2;
		padding-right:4px;
		padding-left:2px;
	}
	.rightReadOnly input{
		text-align:center;
		width:100%;
		border: 0px;
		border-bottom: 1px solid #666;
	}
	.rightReadOnly input{
		border: 0px;
	}
</style>
</head>

<body style="padding-bottom:2px;">
<form action="<%=basePath %>investment!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="investment.staffInfo" />
<input type="hidden" name="investment.id" value="${result.value.id }" />
<!--basediv--><!--//basediv-->
<div class="basediv" style="padding-bottom:2px;border:0px;background-color: #eeeeee;">
	<div class="pm_msglist apptable" style="padding:2px;background-color: #fff;">
		<div>	
			<div class="apptable" style="border-top:none; border-left:none;">
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        		<tr>
				        <td class="layertdleft120"><span class="psred">*</span>企业名称：</td>
				        <td class="layerright">
				          <input name="investment.name" value="${result.value.name }" type="text" class="inputauto" />
				        </td>
				        <td class="layertdleft120">企业类型：</td>
				        <td class="layerright"><input value="${result.value.type }" name="investment.type" type="text" class="inputauto" /></td>
				    </tr>
					<tr>
						<td class="layertdleft120">详细地址：</td>
						<td class="layerright"> <input value="${result.value.address }" name="investment.address" type="text" class="inputauto" /></td>
						<td class="layertdleft120">办公场地面积：</td>
						<td class="layerright"><input value="${result.value.officeArea }" name="investment.officeArea" type="text" class="inputauto" /></td>
					</tr>
					<tr>
				        <td class="layertdleft120">法定代表人：</td>
				        <td class="layerright"><input value="${result.value.legalPerson }" name="investment.legalPerson" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">联系人：</td>
				        <td class="layerright"><input value="${result.value.contactPerson }" name="investment.contactPerson" type="text" class="inputauto" /></td>
      			   </tr>
      			   <tr>
				        <td class="layertdleft120">法定代表人联系电话：</td>
				        <td class="layerright"><input value="${result.value.legalPersonPhone }" name="investment.legalPersonPhone" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">联系人联系电话：</td>
				        <td class="layerright"><input value="${result.value.contactPhone }" name="investment.contactPhone" type="text" class="inputauto" /></td>
       			   </tr>
       			   <tr>
						<td class="layertdleft120">法定代表人E-mail：</td>
						<td class="layerright"><input value="${result.value.legalPersonEmail }" name="investment.legalPersonEmail" type="text" class="inputauto" /></td>
						<td class="layertdleft120">联系人E-mail：</td>
						<td class="layerright"><input value="${result.value.contactEmail }" name="investment.contactEmail" type="text" class="inputauto" /></td>
				   </tr>
				   <tr>
				        <td class="layertdleft120">项目名称：</td>
				        <td colspan="3" class="layerright"><input value="${result.value.projectName }" name="investment.projectName" type="text" class="inputauto" /></td>
			       </tr>
			       <tr>
						<td colspan="4">
							<table id="inline_table" width="100%" border="0" cellspacing="0" cellpadding="0">
					          <tr>
					            <td class="inlinetdleft" rowspan="5" colspan="2" align="center" valign="middle">企业<br/>职工<br/>人员<br/>状况</td>
					            <td class="inlinetdleft" colspan="2" rowspan="2" align="center" valign="middle">人员构成</td>
					            <td class="inlinetdleft" colspan="2" rowspan="2" align="center" valign="middle">职工总数</td>
					            <td class="inlinetdleft" colspan="4" align="center" valign="middle">科技人员</td>
					            <td class="inlinetdleft" colspan="2" align="center" valign="middle">财务人员</td>
					            <td class="inlinetdleft" rowspan="2" align="center" valign="middle">其<br/>他</td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" align="center" valign="middle">博士</td>
					            <td class="inlinetdleft" align="center" valign="middle">硕士</td>
					            <td class="inlinetdleft" align="center" valign="middle">本科</td>
					            <td class="inlinetdleft" align="center" valign="middle">大专</td>
					            <td class="inlinetdleft" align="center" valign="middle">会计</td>
					            <td class="inlinetdleft" align="center" valign="middle">出纳</td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" colspan="2" align="center" valign="middle">总&nbsp;&nbsp;数</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" rowspan="2" align="center" valign="middle">其<br/>中</td>
					            <td class="inlinetdleft" align="center" valign="middle">专职</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" align="center" valign="middle">兼职</td>
					            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
					          </tr>
							</table>
						</td>
			       </tr>
			       <tr>
				        <td class="layertdleft120">项目的技术特点、<br/>市场状况</td>
        				<td colspan="3" class="layerright">
          					<textarea class="inputauto" name="investment.marketSituation" id="textarea" style="height:40px;resize:none;">${result.value.marketSituation}</textarea>
          				</td>
			       </tr>
			       <tr>
				        <td class="layertdleft120" >项目的来源说明和知识产权情况</td>
				        <td colspan="3" class="layerright"><label for="textarea"></label>
          					<textarea class="inputauto" name="investment.propertyRight" id="textarea" style="height:40px;resize:none;">${result.value.propertyRight}</textarea>
				        </td>
				   </tr>
				   <tr>
				        <td class="layertdleft120">经营范围</td>
				        <td colspan="3" class="layerright"><label for="textarea"></label>
          					<textarea class="inputauto" name="investment.businessScope" id="textarea" style="height:40px;resize:none;">${result.value.businessScope}</textarea>
				        </td>
				   </tr>
	        	</table>
			</div>
		</div>
	  </div>
</div>


<div class="buttondiv" style="margin-top:10px;">
	<label><input name="Submit" type="submit" class="savebtn" value=" " /></label>
	<label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
</div>

</form>
</body>
</html>

