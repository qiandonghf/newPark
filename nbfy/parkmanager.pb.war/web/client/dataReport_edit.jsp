<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.DataReport"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
		$("#reportType").change(function(){
			if($(this).val()=="MONTH"){
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeYear").removeAttr("disabled");
				$("#dataTimeYear").css("display","");
				$("#dataTimeMonth").removeAttr("disabled");
				$("#dataTimeMonth").css("display","");
				$("#year").val($("#dataTimeYear").find("select").val());
				$("#month").val($("#dataTimeMonth").find("select").val());
			} else if($(this).val()=="SEASON"){
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeYear").removeAttr("disabled");
				$("#dataTimeYear").css("display","");
				$("#dataTimeSeason").removeAttr("disabled");
				$("#dataTimeSeason").css("display","");
				$("#year").val($("#dataTimeYear").find("select").val());
				$("#month").val($("#dataTimeSeason").find("select").val());
			} else if($(this).val()=="HALFYEAR"){
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeYear").removeAttr("disabled");
				$("#dataTimeYear").css("display","");
				$("#dataTimeHalfyear").removeAttr("disabled");
				$("#dataTimeHalfyear").css("display","");
				$("#year").val($("#dataTimeYear").find("select").val());
				$("#month").val($("#dataTimeHalfyear").find("select").val());
			} else if($(this).val()=="YEAR"){
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeYear").removeAttr("disabled");
				$("#dataTimeYear").css("display","block");
				$("#year").val($("#dataTimeYear").find("select").val());
				$("#month").val(1);
			} else if($(this).val()=="TEMP"){
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeOther").removeAttr("disabled");
				$("#dataTimeOther").css("display","block");
			} else {
				$(".dataTime").css("display","none");
				$(".dataTime").attr("disabled","disabled");
				$("#dataTimeEmpty").removeAttr("disabled");
				$("#dataTimeEmpty").css("display","block");
			}
			changeDataTime();
		});
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"dataReport.name":"required",
				"dataReport.templateId":"required",
				"dataReport.reportType":"required",
				"dataReport.dataTime":"required",
				"dataReport.finishTime":"required"
			},
			messages: {
				"dataReport.name":"请输入报表名称",
				"dataReport.templateId":"请选择数据模板",
				"dataReport.reportType":"请选择报表类型",
				"dataReport.dataTime":"请选择日期",
				"dataReport.finishTime":"请选择填报截至日期"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				updateCustomerIds();
				$(form).ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
			        	var msg = data.msg;
		        		showTip(msg,2000);
			        	if(data.result.success){
			        		setTimeout(function(){
			        			getOpener().reloadIframe(data.result.value.id,data.result.value.groupId);parent.fb.end();
			        		}, 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedCustomers(customers){
		for(var i = 0 ; i < customers.length; i++){
			var customer = customers[i];
			if($("#customer"+customer.id).length==0){
				$("#customerUl").append(
					$("<li></li>",{id:"customer"+customer.id,
						mouseover:function(){$(this).find('span').show()},
						mouseout:function(){$(this).find('span').hide()}
					}).append(customer.name).append($("<input type=\"hidden\" class=\"customerId\" value=\""+customer.id+"\"/>")
					).append($("<span></span>",{click:function(){$(this).parent().remove();}}).hide())
				);
			}
		}
	}
	function updateCustomerIds(){
		var customerIds = "";
		$(".customerId").each(function(){
			customerIds += $(this).val()+",";
		});
		customerIds = deleteLastCharWhenMatching(customerIds,",");
		$("#customerIds").val(customerIds);
	}
	function changeDataTime(){
		$("#dataTime").val($("#year").val()+"-"+$("#month").val()+"-1");
	}
</script>
</head>

<body>
<form action="<%=basePath %>dataReport!update.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${result.value.id}" name="dataReport.id"/>
	<input type="hidden" name="ids" id="customerIds"/>
	<div class="basediv">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">报表名称：</td>
				<td class="layerright" ><input name="dataReport.name" type="text" class="inputauto" value="${result.value.name}"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">数据模板：</td>
				<td class="layerright">
					<select name="dataReport.templateId">
						<option value="">----请选择----</option>
						<c:forEach items="${dataTemplateList}" var="template">
							<option value="${template.id}" <c:if test="${template.id==result.value.templateId}">selected="selected"</c:if>>${template.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">报表类型：</td>
				<td class="layerright"><enum:select id="reportType" name="dataReport.reportType" checked="result.value.reportType" type="com.wiiy.crm.preferences.enums.ReportTypeEnum"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">日期：</td>
				<td class="layerright">
					<input id="dataTime" name="dataReport.dataTime" type="hidden" value="<fmt:formatDate value="${result.value.dataTime}" pattern="yyyy-MM-dd"/>"/>
					<fmt:formatDate value="${result.value.dataTime}" pattern="yyyy" var="year"/>
					<fmt:formatDate value="${result.value.dataTime}" pattern="M" var="month"/>
					<input id="year" type="hidden" value="${year}"/>
					<input id="month" type="hidden" value="${month}"/>
					<%
						Result<DataReport> r = (Result<DataReport>)request.getAttribute("result");
						int t = -1;
						switch(r.getValue().getReportType()){
							case TEMP: t++;
							case MONTH: t++;
							case SEASON: t++;
							case HALFYEAR: t++;
							case YEAR: t++;
						}
					%>
					<span id="dataTimeEmpty" class="dataTime" <%if(t!=-1){%>style="display: none;"<%} %>>请选择数据模板</span>
					<span id="dataTimeYear" class="dataTime" <%if(t==4){%>style="display: none;"<%} %>>
						<select onchange="$('#year').val(this.value);changeDataTime();">
							<c:forEach begin="2010" end="2020" var="s">
							<option value="${s}" <c:if test="${s==year}">selected="selected"</c:if>>${s}</option>
							</c:forEach>
						</select>&nbsp;年
					</span>
					<span id="dataTimeHalfyear" class="dataTime" <%if(t!=1){%>style="display: none;"<%} %>>
						<select onchange="$('#month').val(this.value);changeDataTime();">
							<option value="6" <c:if test="${6==month}">selected="selected"</c:if>>上半年</option>
							<option value="12" <c:if test="${12==month}">selected="selected"</c:if>>下半年</option>
						</select>
					</span>
					<span id="dataTimeSeason" class="dataTime" <%if(t!=2){%>style="display: none;"<%} %>>
						<select onchange="$('#month').val(this.value);changeDataTime();">
							<option value="3" <c:if test="${3==month}">selected="selected"</c:if>>一季度</option>
							<option value="6" <c:if test="${6==month}">selected="selected"</c:if>>二季度</option>
							<option value="9" <c:if test="${9==month}">selected="selected"</c:if>>三季度</option>
							<option value="12" <c:if test="${12==month}">selected="selected"</c:if>>四季度</option>
						</select>
					</span>
					<span id="dataTimeMonth" class="dataTime" <%if(t!=3){%>style="display: none;"<%} %>>
						<select onchange="$('#month').val(this.value);changeDataTime();">
							<c:forEach begin="1" end="12" var="s">
							<option value="${s}" <c:if test="${s==month}">selected="selected"</c:if>>${s}</option>
							</c:forEach>
						</select>&nbsp;月
					</span>
					<table id="dataTimeOther" class="dataTime" border="0" cellspacing="0" cellpadding="10" <%if(t!=4){%>style="display: none;"<%} %>>
						<tr>
							<td width="200"><input id="dataTimeOther1" type="text" class="inputauto" readonly="readonly" onblur="$('#dataTime').val(this.value)" onclick="showCalendar('dataTimeOther1');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" onblur="$('#dataTime').val($('#dataTimeOther').val())" style="position: relative;left:-1px;" onclick="showCalendar('dataTimeOther1');"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">填报截至日期：</td>
				<td class="layerright">
					<table border="0" cellspacing="0" cellpadding="10">
						<tr>
							<td width="200"><input id="finishTime" value="<fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/>" name="dataReport.finishTime" type="text" class="inputauto" readonly="readonly" onclick="showCalendar('finishTime');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('finishTime');"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">报表状态：</td>
				<td class="layerright">${result.value.status.title}</td>
			</tr>
			<tr style="display: none;">
				<td class="layertdleft100">填报企业：</td>
				<td class="layerright" style="margin-top:4px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="28" valign="top"><img src="core/common/images/outdiv.gif" width="20" height="22" style="cursor:pointer;" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);" /></td>
							<td class="customerdiv">
								<div style=" width:auto; height:120px; overflow-x:hidden; overflow-y:scroll">
									<ul id="customerUl">
										<c:forEach items="${customerList}" var="customer">
											<li onmouseout="$(this).find('span').hide()" onmouseover="$(this).find('span').show()">${customer.name}<input type="hidden" class="customerId" value="${customer.id}"/><span style="display:none;" onclick="$(this).parent().remove()"></span></li>
										</c:forEach>
									</ul>		
								</div>	
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>