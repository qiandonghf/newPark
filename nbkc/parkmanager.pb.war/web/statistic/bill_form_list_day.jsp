<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>

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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight()-50);
		initList();
		jqGridResizeRegister("list");
		var h = getTabContentHeight();
		var w = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$('#pm_scrolldiv').height(h-55).width(w-540);
	});
	
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-540;
		$("#list").jqGrid({
	    	url:'<%=basePath%>bill!billCostByDay.action?startTime='+$("#startTime").val()+'&endTime='+$("#endTime").val(),
			colModel: [
					{label:'企业名称', width:'120' ,name:'customer.name', align:"center"}, 
					{label:'费用类型', width:'70' ,name:'billType.typeName', align:"center"}, 
					{label:'结算金额',width:'70' , name:'factPayment', align:"center"}, 
					{label:'收支',width:'60' , name:'inOut.title', align:"center"}, 
				    {label:'出账日期', width:'80',name:'checkoutTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				    {label:'结算日期', width:'80' ,name:'payTime', align:"center", formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				    {label:'状态', width:'40' ,name:'status.title', align:"center"}
			],
			height: height,
			width: width,
			shrinkToFit: false
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
		    caption : "列选择",
		    title : "选择要显示的列",
		    onClickButton : function(){
		        $(this).jqGrid('columnChooser');
		    }
		});
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	 function toSubmit(){
		 	if($("#startTime").val()!=null && $("#endTime").val()!=null){
				if($("#startTime").val()>$("#endTime").val()){
					showTip("开始时间不能大于结束时间");
					return false;
				}
	 		}
		 	
		 	
			location.href="<%=basePath%>statistic!billCostByDay.action?startTime="+$("#startTime").val()+"&endTime="+$("#endTime").val();
		}
	 
	 function exportData(){
			var columns = "{";
			$.each($("#list").getGridParam("colModel"),function(){
				if(this.label && this.name!="manager" && !this.hidden){
					columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
				}
			});
			columns = deleteLastCharWhenMatching(columns,",");
			columns += "}";
			var startTime = $("#startTime").val();
			var endTime = $("#endTime").val();
			$("#STARTTIME").val(startTime);
			$("#ENDTIME").val(endTime);
			$("#columns").val(columns);
			$("#exportForm").submit();
		}
  </script>

</head>
<body>
<form action="<%=basePath%>bill!exportBillByDay.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
	<input type="hidden" id="STARTTIME" name="STARTTIME"/>
	<input type="hidden" id="ENDTIME" name="ENDTIME"/>
</form>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top"><div class="agency" id="resizable" >
        <div class="titlebg">统计类型</div>
			<jsp:include page="bill_form_list_left.jsp">
				<jsp:param value="0" name="index" />
			</jsp:include>
       </div>
      </td>
      <td width="100%" valign="top">
            <div class="clear">
            	<div class="cal_left">
                	<div class="searchdivkf">
                          <form id="form2" name="form2" method="post" action="">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
                            <tr>
                            <td>日期：</td>
	                        <td width="190">
	                          <table width="100%" border="0" cellspacing="0" cellpadding="10" style="table-layout:fixed;">
						          <tr>
						            <td width="70">
						            	<input id="startTime" name="startTime" type="text" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${startTime}"/>' class="inputauto" onclick="return showCalendar('startTime');"/>
						            </td>
						            <td width="20" align="center">
						            	<img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('startTime');"/>
						            </td>
						            <td width="10" align="center">-</td>
						            <td width="70" align="center">
						            	<input id="endTime" name="endTime" type="text" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${endTime}"/>' class="inputauto" onclick="return showCalendar('endTime');"/>
						            </td>
						            <td width="20" align="center">
						            	<img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('endTime');"/>
						            </td>
						            <td align="center">&nbsp;</td>
						          </tr>
					         </table>
					        </td>
	                        <td  style="padding-left:10px;"><label><input name="Submit" type="submit" class="searchbtn" onclick="toSubmit();" value=""/></label></td>
                      	    </tr>
                     	    </table>
                          </form>
                        </div>
                     <div class="table_layout">
                     	<p class="" style="text-align:right; padding:0px 0 5px;">单位（元）</p>
                     	<table width="100%"  border="0" cellspacing="0" cellpadding="0" class="table_sy1">
                            <thead>
                              <tr>
                                <th width="25%">费用类型</th>
                                <th width="25%">收款金额</th>
                                <th width="25%">付款金额</th>
                                <th width="25%">合计</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${result.value}" var="group">
                                <tr>
                                    <td align="center">${group.name}</td>
                                    <td align="center">
		                            <c:set var="inValue" value="0"/>
                                    <c:forEach items="${group.list}" var="list">
                                    	<c:if test="${list.name == '收入'}">
		                                    ${list.dValue}
	                                    	<c:set var="inValue" value="${list.dValue}"/>
	                                    	<c:set var="inTotalValue" value="${list.dValue}"/>
                                    	</c:if>
                                    </c:forEach>
                                    </td>
                                    <td align="center">
		                             <c:set var="outValue" value="0"/>
                                     <c:forEach items="${group.list}" var="list">
                                    	<c:if test="${list.name == '支出'}">
		                                    ${list.dValue}
	                                    <c:set var="outValue" value="${list.dValue}"/>
	                                    <c:set var="outTotalValue" value="${list.dValue}"/>
                                    	</c:if>
                                    </c:forEach>
                                    </td>
        	                        <td align="center">
        	                        	${inValue+outValue}
        	                        </td>
                                </tr>
                                
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            	<!-- <tr>
                                    <th align="center">单据总数</th>
                                    <td align="center">&nbsp;</td>
                                    <td align="center">&nbsp;</td>
                                    <td align="center">&nbsp;</td>
                                </tr> -->
                                <%
                                Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
                                List<StatisticGroupDto> dtoList = result.getValue();
                                Double inTotal = 0D;
                                Double outTotal = 0D;
                                for(StatisticGroupDto gDto : dtoList){
                                	for(StatisticDto dto : gDto.getList()){
                                		if(dto.getName().equals("收入")){
                                			inTotal += dto.getdValue();
                                		}else if(dto.getName().equals("支出")){
                                			outTotal += dto.getdValue();
                                		}
                                	}
                                }
                                %>
                                <tr>
                                    <th align="center">合计金额</th>
                                    <td align="center"><%=inTotal%></td>
                                    <td align="center"><%=outTotal%></td>
                                    <td align="center"><%=inTotal+outTotal%></td>
                                </tr>
                            </tfoot>
                          </table>
                     </div>
                     
              </div>
                
                <div class="cal_right">
                 <!--titlebg--><div class="titlebg">日结算报表:</div><!--//titlebg-->
			<div class="emailtop">
			<!--打印-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/print_btn.gif"/></span>打印</li>
				</ul>
			</div>
			<!--//打印-->
			</div>
		
	<div class="msglist" id="msglist">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
</div>
</div>
            </div>
      </td>
    </tr>
  </table>
  
</div>
<!--//container-->

</body>
</html>
