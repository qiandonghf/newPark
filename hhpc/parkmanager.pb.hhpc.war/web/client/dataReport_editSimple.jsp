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
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"dataReport.finishTime":"required"
			},
			messages: {
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
		        		showTip(data.result.msg,2000);
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
				<td class="layerright" >${result.value.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">数据模板：</td>
				<td class="layerright">${result.value.template.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">报表类型：</td>
				<td class="layerright">${result.value.reportType.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">日期：</td>
				<td class="layerright">
					<fmt:formatDate value="${result.value.dataTime}" pattern="yyyy" var="year"/>
					<fmt:formatDate value="${result.value.dataTime}" pattern="M" var="month"/>
					<%
						Result<DataReport> r = (Result<DataReport>)request.getAttribute("result");
						int t = -1;
						switch(r.getValue().getReportType()){
							case YEAR: t++;
							case MONTH: t++;
							case SEASON: t++;
							case HALFYEAR: t++;
							case TEMP: t++;
						}
					%>
					<span id="dataTimeYear" class="dataTime" <%if(t==4){%>style="display: none;"<%} %>>${year}&nbsp;年</span>
					<span id="dataTimeMonth" class="dataTime" <%if(t!=1){%>style="display: none;"<%} %>>${month}&nbsp;月</span>
					<span id="dataTimeSeason" class="dataTime" <%if(t!=2){%>style="display: none;"<%} %>>
						<c:if test="${3==month}">一季度</c:if>
						<c:if test="${6==month}">二季度</c:if>
						<c:if test="${9==month}">三季度</c:if>
						<c:if test="${12==month}">四季度</c:if>
					</span>
					<span id="dataTimeHalfyear" class="dataTime" <%if(t!=3){%>style="display: none;"<%} %>>
						<c:if test="${6==month}">上半年</c:if>
						<c:if test="${12==month}">下半年</c:if>
					</span>
					<table id="dataTimeOther" class="dataTime" border="0" cellspacing="0" cellpadding="10" <%if(t!=4){%>style="display: none;"<%} %>>
						<tr>
							<td width="200"><input id="dataTimeOther" type="text" class="inputauto" readonly="readonly" onblur="$('#dataTime').val(this.value)" onclick="return showCalendar('dataTimeOther');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" onblur="$('#dataTime').val($('#dataTimeOther').val())" style="position: relative;left:-1px;" onclick="return showCalendar('dataTimeOther');"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">填报截至日期：</td>
				<td class="layerright">
					<table border="0" cellspacing="0" cellpadding="10">
						<tr>
							<td width="200"><input id="finishTime" value="<fmt:formatDate value="${result.value.finishTime}" pattern="yyyy-MM-dd"/>" name="dataReport.finishTime" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('finishTime');"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('finishTime');"/></td>
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