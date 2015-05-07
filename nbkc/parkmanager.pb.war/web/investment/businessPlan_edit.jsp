<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
			});
			function checkForm(){
				$("#form1").ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().frames[0].location.reload();parent.fb.end();",2000);
			        	}
			        } 
			    });
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>businessPlan!update.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.id}" name="businessPlan.id"/>
			<div class="basediv">
				<div class="divlays" style="margin:0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft150">拟办企业概况：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.companySummery" style="height:65px;" class="textareaauto">${result.value.companySummery}</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft150">创业团队概况：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.teamSummery" style="height:65px;" class="textareaauto">${result.value.teamSummery}</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft150">项目技术可行性分析：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.projectFeasibility"  style="height:65px;" class="textareaauto">${result.value.projectFeasibility}</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft150">产品市场可行性分析：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.marketFeasibility" style="height:65px;" class="textareaauto">${result.value.marketFeasibility}</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft150">经济效益及社会效益分析：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.economicBenefits" style="height:65px;" class="textareaauto">${result.value.economicBenefits}</textarea></td>
						</tr>
						<tr>
							<td class="layertdleft150">对创业中心的要求：</td>
							<td class="layerright" style="padding-top:2px;"><textarea name="businessPlan.requirements" style="height:65px;"  class="textareaauto">${result.value.requirements}</textarea></td>
						</tr>
					</table>
				</div>
				<div class="hackbox"></div>
			</div>
			<div class="buttondiv">
				<label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
				<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
			</div>
		</form>
	</body>
</html>

