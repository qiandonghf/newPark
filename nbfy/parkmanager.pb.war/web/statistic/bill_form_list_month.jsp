<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
<%@page import="com.wiiy.hibernate.Result"%>

<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css"
	href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/jquery-ui.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css"
	href="core/common/style/ui.multiselect.css" />

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
		var rw = $("#resizable").width();
		$('#overflowAuto').height(h-82);
		$('#overflowAuto').width(w-rw-210);
		
		var h = getTabContentHeight();
		var w = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$('#overflowAuto').height(h-83).width(w-185);
	});
	


	function doSearch() {
		search(getSearchFilters());
	}

	function search(filters) {
		$("#list").setGridParam({postData : {filters : filters}}).trigger('reloadGrid');
	}
	
	function search(){
		var startTime = new Date($("#startYear").val(),parseInt($("#startMonth").val())-1,1);
		var endTime = new Date($("#endYear").val(),parseInt($("#endMonth").val())-1,1);
		if(startTime>endTime){
			showTip("开始日期不能大于结束日期");
			return;
		}
		startTime = $("#startYear").val()+"-"+$("#startMonth").val()+"-1";
		endTime = $("#endYear").val()+"-"+$("#endMonth").val()+"-1";
		location ="<%=basePath%>statistic!billCostByMonth.action?startTime="+startTime+"&endTime="+endTime;
	}
	
	function exportData(){
		var curYear = $("#startYear").val();
		location.href='<%=basePath%>bill!exportBillByMonth.action?time='+curYear;
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
							<jsp:param value="1" name="index" />
						</jsp:include>
					</div>
				</td>
				<td width="100%" valign="top">
				   <!--titlebg--><div class="titlebg">月结算报表:</div><!--//titlebg-->
                 <div class="emailtop">
			<!--打印-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/print_btn.gif"></span>打印</li>
				</ul>
			</div>
			<!--//打印-->
			</div>
	<div class="searchdivkf">
			  <form id="form2" name="form2" method="post" action="">
				<table border="0" cellspacing="0" cellpadding="0" height="25">
                            <tbody>
                            <tr>
                         <td>
                         	<select id="startYear">
								<c:forEach items="${years}" var="year">
									<option <c:if test='${year==startYear}'>selected="selected"</c:if> value="${year}" >${year}年</option>
								</c:forEach>
							</select>
						</td>
						<td>&nbsp;</td>
                         <td>
                         	<select id="startMonth">
								<c:forEach begin="1" end="12" var="month">
									<option value="${month}" <c:if test='${month==startMonth}'>selected="selected"</c:if>>${month}月</option>
								</c:forEach>
							</select>
						</td>
						<td>&nbsp;至&nbsp;</td>
                         <td>
                         	<select id="endYear">
								<c:forEach items="${years}" var="year">
									<option <c:if test='${year==endYear}'>selected="selected"</c:if> value="${year}" >${year}年</option>
								</c:forEach>
							</select>
						</td>
						<td>&nbsp;</td>
                         <td>
                         	<select id="endMonth">
								<c:forEach begin="1" end="12" var="month">
									<option value="${month}" <c:if test='${month==endMonth}'>selected="selected"</c:if>>${month}月</option>
								</c:forEach>
							</select>
						</td>
                          <td style="padding-left:10px;">
                          <label><input name="Submit" type="button" class="searchbtn" value="" onclick="search();"/>
                          </label></td>
                        </tr>
                      </tbody></table>
			  </form>
		</div>
	<div class="overflowAuto" id="overflowAuto">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space:nowrap; table-layout:fixed;">
	     <colgroup span="${mapSize*2+1}">
	     </colgroup>
	     <col style="background:#feffc6;" />
	     <col style="background:#feffc6;" />   
	       <thead>
	       <tr>
		      <th width="80" rowspan="2" align="center">时间</th>
		      <c:forEach items="${mapValues}" var="typeName">
				 <th width="140" colspan="2">${typeName}</th>
			  </c:forEach>
			     <th width="140" colspan="2">总计</th>
		    </tr>
		    <tr>
		       <c:forEach items="${mapValues}" var="typeName">
			   <th width="70" align="center">收</th>
		   	   <th width="70" align="center">付</th>
			   </c:forEach>
		       <th width="70" align="center">收</th>
		       <th width="70" align="center">付</th>
		    </tr>
    		</thead>
   			<c:forEach items="${result.value}" var="topGroup">
			<tr>
				<th align="center">${topGroup.name}月</th>
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
			</tr>
			</c:forEach>
		<%
           Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
           List<StatisticGroupDto> dtoList = result.getValue();
                                
        %>
		 <tfoot>
   		 <tr>
            <th>合计：</th>
            <c:set var="inTotal2" value="0"/>
			<c:set var="outTotal2" value="0"/>
            <c:forEach items="${mapValues}" var="typeName">
            <c:forEach items="${topTotalGroupList}" var="topTotalGroup">
          	  <c:set var="find" value="false"/>
           	  <c:if test="${topTotalGroup.amount eq curYear}">
                  <c:forEach items="${topTotalGroup.groups}" var="type">
			      <c:if test="${type.name eq typeName }" var="eqTypeName">
				  <c:set var="find" value="true"/>
						<td>
							<c:forEach items="${type.list}" var="dto">
								<c:if test="${dto.name eq 'IN' }"><c:set var="inTotal2" value="${inTotal2 + dto.dValue }"/><fmt:formatNumber value="${dto.dValue}" pattern="#0.00"/></c:if>
							</c:forEach>
						</td>
						<td>
							<c:forEach items="${type.list}" var="dto">
								<c:if test="${dto.name eq 'OUT' }"><c:set var="outTotal2" value="${outTotal2 + dto.dValue }"/><fmt:formatNumber value="${dto.dValue}" pattern="#0.00"/></c:if>
							</c:forEach>
						</td>
			    </c:if>
          	    </c:forEach>
          	  <c:if test="${!find}">
					<td></td><td></td>
			  </c:if>
              </c:if>
			</c:forEach>
			</c:forEach>
            <td><fmt:formatNumber value="${inTotal2}" pattern="#0.00"/></td>
			<td><fmt:formatNumber value="${outTotal2}" pattern="#0.00"/></td>
      	</tr>
      	</tfoot>
 	 </table>
  	</div>
 	</td>
  </tr>
</table>
</div>

</body>
</html>
