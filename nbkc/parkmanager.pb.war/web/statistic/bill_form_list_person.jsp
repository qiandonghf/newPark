<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		var h = getTabContentHeight();
		var w = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$('#overflowAuto').height(h-83).width(w-185);
	});

	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	
	 function toSubmit(){
		 	var startTime = $("#startTime").val();
		 	var endTime = $("#endTime").val();
		 	var customerId = $("#customerId").val();
		 	var customerName = $("#customerName").val();
		 	if(startTime!=null && endTime!=null && endTime!="" && startTime!=""){
				if($("#startTime").val()>$("#endTime").val()){
					showTip("开始时间不能大于结束时间");
					return false;
				}
	 		}
			location = "<%=basePath%>statistic!billCostByCustomer.action?startTime="+startTime+"&endTime="+endTime+"&customerId="+customerId+"&customerName="+customerName;
		}
	 
	 function exportData(){
			var startTime = $("#startTime").val();
		 	var endTime = $("#endTime").val();
		 	var customerId =  $("#customerId").val();
		 		
		 	if(startTime!=null && endTime!=null && endTime!="" && startTime!=""){
				if($("#startTime").val()>$("#endTime").val()){
					showTip("开始时间不能大于结束时间");
					return false;
				}
	 		}
			location.href ="<%=basePath%>bill!exportBillByCustomer.action?startTime="+startTime+"&endTime="+endTime+"&customerId="+customerId;
		}
</script>

</head>
<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">统计类型</div>
						<jsp:include page="bill_form_list_left.jsp">
							<jsp:param value="3" name="index" />
						</jsp:include>
					</div>
				</td>
				<td width="100%" valign="top">
				   <!--titlebg--><div class="titlebg">分户明细表:</div><!--//titlebg-->
                 <div class="emailtop">
			<!--打印-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/print_btn.gif"/></span>打印</li>
				</ul>
			</div>
			<!--//打印-->
			</div>
	<div class="searchdivkf" >
			  <form id="form2" name="form2" method="post" action="">
				<table border="0" cellspacing="0" cellpadding="0" height="25">
                <tr>
                    <td>企业名称：</td>
                    <td width="150">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
              	    	<tr>
		                    <td>
		                    	<input id="customerId" name="customerId" type="hidden" class="inputauto" value="${customerId}"/>
		                    	<input id="customerName" name="customerName" type="text" class="inputauto" value="${customerName}"  onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);"/>
		                    </td>
		                    <td width="25" align="center">
		                     	<img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择企业','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,390);" style="cursor:pointer;"/>
		                    </td>
              		    </tr>
                	</table>
                    </td>
                    <td width="70" align="right">开始时间：</td>
                    <td width="128">
                    	<table width="100%" border="0" cellspacing="2" cellpadding="0">
                            <tr>
                              <td width="105">
								  <input id="startTime" name="startTime" type="text" class="input100" onclick="return showCalendar('startTime');" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd"/>"/>
							  </td>
                              <td width="125">
                              	  <img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('startTime');"/>
                              </td>
                            </tr>
                        </table>
                   </td>
                   <td width="70" align="right">结束时间：</td>
                   <td width="120">
                   		<table width="100%" border="0" cellspacing="2" cellpadding="0">
		       				 <tr>
					            <td width="105">
					            	 <input id="endTime" name="endTime" type="text" class="input100" onclick="return showCalendar('endTime');" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>"/>
					            </td>
					            <td width="125">
					            	 <img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('endTime');"/>
					            </td>
		        			 </tr>
    			   	   </table>
    			  </td>
                  <td style="padding-left:10px;"><label><input name="Submit" type="button" class="searchbtn" value="" onclick="toSubmit();"/></label></td>
                </tr>
                </table>
			  </form>
		</div>

	<div class="overflowAuto" id="overflowAuto">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space:nowrap; table-layout:fixed;">
			<colgroup span="${mapSize*2+1}"></colgroup>
			<col style="background:#feffc6;" />
			<col style="background:#feffc6;" />
			<col style="background:#feffc6;" />
			<col style="background:#feffc6;" />   
			<thead>
			<tr>
				<th width="150" rowspan="2">企业名称</th>
				<c:forEach items="${mapValues}" var="typeName">
				<th width="140" colspan="2" >${typeName }</th>
				</c:forEach>
				<th width="140" colspan="2">总计</th>
				<!-- <th width="140" colspan="2">单据</th> -->
			</tr>
			<tr>
				<c:forEach items="${mapValues}" var="typeName">
				<th width="70">收</th>
				<th width="70">付</th>
				</c:forEach>
				<th width="70">收</th>
				<th width="70">付</th>
				<!-- <th width="70">收</th>
				<th width="70">付</th> -->
			</tr>
			</thead>
			<c:forEach items="${result.value}" var="topGroup">
			<tr>
				<th title="${topGroup.name }"><c:if test="${fn:length(topGroup.name) gt 10 }">${fn:substring(topGroup.name,0,10) }...
				</c:if><c:if test="${fn:length(topGroup.name) lt 10}"> ${topGroup.name }</c:if></th>
				<c:set var="inTotal" value="0"/>
				<c:set var="outTotal" value="0"/>
				<c:forEach items="${mapValues}" var="typeName">
					<c:set var="find" value="false"/>
					<c:forEach items="${topGroup.groups}" var="type">
						<c:if test="${type.name eq typeName }" var="eqTypeName">
							<c:set var="find" value="true"/>
							<td>
								<c:forEach items="${type.list}" var="dto">
									<c:if test="${dto.name eq 'IN' }"><c:set var="inTotal" value="${inTotal + dto.dValue }"/><fmt:formatNumber value="${dto.dValue}" pattern="#0.00"/></c:if>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${type.list}" var="dto">
									<c:if test="${dto.name eq 'OUT' }"><c:set var="outTotal" value="${outTotal + dto.dValue }"/><fmt:formatNumber value="${dto.dValue}" pattern="#0.00"/></c:if>
								</c:forEach>
							</td>
						</c:if>
					</c:forEach>
					<c:if test="${!find}">
						<td></td><td></td>
					</c:if>
				</c:forEach>
				<td><fmt:formatNumber value="${inTotal}" pattern="#0.00"/></td>
				<td><fmt:formatNumber value="${outTotal}" pattern="#0.00"/></td>
				<!-- <td>&nbsp;</td>
				<td>&nbsp;</td> -->
			</tr>
			</c:forEach>
		</table>
  	</div>
  	 <!--  <div class="page">
            <div class="floatrightdiv">选中50</div>
            <ul>
              <li> <span class="first"></span><span class="pre"></span><span>显示1-6 </span><span class="next"></span><span class="last"></span><span>显示
                <select name="select3" class="select">
                      <option>20</option>
                      <option>40</option>
                      <option>60</option>
                  </select>
              </span>共10条</li>
            </ul>
          </div>
  	 -->
 	</td>
  </tr>
</table>
</div>

</body>
</html>
