<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
				initForm();
			});
			function initForm(){
				$("#form1").validate({
					rules: {
						"investmentInvestor.name":"required",
						"investmentInvestor.rate":"number",
						"investmentInvestor.graduateYear":"digits"
					},
					messages: {
						"investmentInvestor.name":"请输入投资方名称",
						"investmentInvestor.rate":"请输入正确的出资比例",
						"investmentInvestor.graduateYear":"请输入正确的毕业年份"
					},
					errorPlacement: function(error, element){
						showTip(error.html());
					},
					submitHandler: function(form){
						if($("#rate").val()){
							if($("#rate").val()<0 || $("#rate").val()>100){
								showTip("出资比例应在1-100之间");
								return false;
							}
						}
						$(form).ajaxSubmit({
					        dataType: 'json',		        
					        success: function(data){
				        		showTip(data.result.msg,2000);
					        	if(data.result.success){
					        		setTimeout("getOpener().reloadInvestmentInvestorList();parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>investmentInvestor!mySave.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${param.investmentId}" name="investmentInvestor.investmentId"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">
							<span class="psred">*</span>投资方：
						</td>
						<td class="layerright">
							<label>
								<input name="investmentInvestor.name" type="text" class="inputauto" />
							</label>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							出资比例：
						</td>
						<td>
							<input id="rate" name="investmentInvestor.rate" type="text" class="input170" />%
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							出资方式：
						</td>
						<td class="layerright">
							<dd:select key="crm.0018" name="investmentInvestor.capitalId"/>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							出生年月：
						</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="120">
										<input id="birthDay" readonly="readonly" name="investmentInvestor.birthDay" type="text" class="inputauto" onclick="showCalendar('birthDay')" />
									</td>
									<td width="20" align="center">
										<img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('birthDay')"/>
									</td>
									<td>
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							毕业年份：
						</td>
						<td>
							<label>
								<input name="investmentInvestor.graduateYear" type="text" class="input170" />
							</label>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							学历：
						</td>
						<td class="layerright">
							<dd:select key="crm.0015" name="investmentInvestor.degreeId"/>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							职称：
						</td>
						<td>
							<input name="investmentInvestor.profession" type="text" class="input170" />
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">
							毕业院校：
						</td>
						<td>
							<input name="investmentInvestor.school" type="text" class="input170" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="buttondiv">
			<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
			<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
		</div>
		</form>
	</body>
</html>

