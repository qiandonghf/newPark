<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		initList();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		var h = getTabContentHeight();
		var w = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$('#overflowAuto').height(h-55).width(w-185);
	});
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)+25;
		$("#list").jqGrid({
	    	url:'<%=basePath%>room!rentRoom.action',
			colModel: [
				{label:'楼号',width:40, name:'building.name', align:"center"}, 
				{label:'分类', name:'type.dataValue', width:30 , align:"center"}, 
				{label:'房号',width:40, name:'name', align:"center"}, 
				{label:'建筑面积', width:50, name:'buildingArea', width:80,formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"},  
			    {label:'企业', name:'customerName', align:"center",width:70},
			    {label:'合同到期日期', name:'endDate', align:"center", width:80,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'备注', name:'memo', align:"center",width:70},
			],
			height: height,
			width: width,
			multiselect: false
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	


	function doSearch() {
		search(getSearchFilters());
	}

	function search(filters) {
		$("#list").setGridParam({postData : {filters : filters}}).trigger('reloadGrid');
	}
	
	function exportData(){
		location.href='<%=basePath%>bill!exportBillByYear.action';
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
							<jsp:param value="2" name="index" />
						</jsp:include>
					</div>
				</td>
				<td width="100%" valign="top">
				   <!--titlebg--><div class="titlebg">年结算报表:</div><!--//titlebg-->
                 <div class="emailtop">
			<!--打印-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/print_btn.gif"></span>打印</li>
				</ul>
			</div>
			<!--//打印-->
			</div>
	<div class="overflowAuto" id="overflowAuto">
<!--[if lte ie 8]> <div style="+zoom:1"><![endif]-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space:nowrap; table-layout:fixed;">
        <!-- colgroup表示合计列前面的几列，等同一个占位,下面两个col表示合计的2个列，这里加入淡黄背景，以后将不再做注释 -->
	    <colgroup span="${mapSize*2+1}">
        </colgroup>
        <col style="background:#feffc6;" />
        <col style="background:#feffc6;" /> 
        	<thead>
		    <tr>
		      <th width="80" rowspan="2">时间</th>
		      <c:forEach items="${mapValues}" var="typeName">
				 <th width="200" colspan="2">${typeName}</th>
			  </c:forEach>
			     <th width="140" colspan="2">总计</th>
		    </tr>
		    <tr>
		       <c:forEach items="${mapValues}" var="typeName">
			   <th width="70">收</th>
		   	   <th width="70">付</th>
			   </c:forEach>
		       <th width="70">收</th>
		       <th width="70">付</th>
		    </tr>
    		</thead>
   			<c:forEach items="${result.value}" var="topGroup">
			<tr>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;${topGroup.amount}年</th>
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
				<td ><fmt:formatNumber value="${inTotal}" pattern="#0.00"/></td>
				<td ><fmt:formatNumber value="${outTotal}" pattern="#0.00"/></td>
			</tr>
			</c:forEach>
		 <tfoot>
   		 <tr>
            <th>合计：</th>
            <c:set var="inTotal2" value="0"/>
			<c:set var="outTotal2" value="0"/>
            <c:forEach items="${mapValues}" var="typeName">
        	    <td style="width:200px;">
          		  <c:forEach items="${yearCountList}" var="list">
          		  <c:if test="${list.name eq typeName }">
					<c:if test="${list.memo eq 'IN' }"><c:set var="inTotal2" value="${inTotal2 + list.dValue }"/><fmt:formatNumber value="${list.dValue}" pattern="#0.00"/></c:if>
				  </c:if>
				  </c:forEach>
			   </td>
        	    <td>
          		  <c:forEach items="${yearCountList}" var="list">
          		  <c:if test="${list.name eq typeName }">
					<c:if test="${list.memo eq 'OUT' }"><c:set var="outTotal2" value="${outTotal2 + list.dValue }"/><fmt:formatNumber value="${list.dValue}" pattern="#0.00"/></c:if>
				  </c:if>
				  </c:forEach>
			   </td>
			</c:forEach>
            <td><fmt:formatNumber value="${inTotal2}" pattern="#0.00"/></td>
			<td><fmt:formatNumber value="${outTotal2}" pattern="#0.00"/></td>
      	</tr>
      	</tfoot>
    
    
   </table>
<!--[if lte ie 8]> </div><![endif]-->
  </div>

  
  <!-- <div class="page">
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
          </div> -->
      </td>
    </tr>
  </table>
  
</div>


</body>
</html>