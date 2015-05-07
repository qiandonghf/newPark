<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@page import="com.wiiy.core.entity.DataDict"%>
<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
<%@page import="com.wiiy.hibernate.Result"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight()-50);
		jqGridResizeRegister("list");
		var h = getTabContentHeight();
		var w = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$('#overflowAuto').height(h-53).width(w-535);
	});
	
  function toSubmit(){
	  if($("#startTime").val()!=null && $("#endTime").val()!=null && $("#startTime").val()!="" && $("#endTime").val()!=""){
			if($("#startTime").val()>$("#endTime").val()){
				showTip("开始时间不能大于结束时间",4000);
				return;
			}else{
				$.post("<%=basePath%>statistic!billCostByProperty.action",{"startTime":$("#startTime").val(),"endTime":$("#endTime").val()},function(data){});
			}
		}
	}
  
  function exportData(){
	  	var startTime = $("#startTime").val();
	 	var endTime = $("#endTime").val();
		location.href ="<%=basePath%>bill!exportBillByProperty.action?startTime="+startTime+"&endTime="+endTime;
  }
  
  </script>

</head>
<body>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top"><div class="agency" id="resizable" >
        <div class="titlebg">统计类型</div>
			<jsp:include page="bill_form_list_left.jsp">
				<jsp:param value="4" name="index" />
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
						            	<input id="startTime" name="startTime" type="text" class="inputauto" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('startTime');"/>
						            </td>
						            <td width="20" align="center">
						            	<img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="return showCalendar('startTime');"/>
						            </td>
						            <td width="10" align="center">-</td>
						            <td width="70" align="center">
						            	<input id="endTime" name="endTime" type="text" class="inputauto"  value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('endTime');"/>
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
                   	    <div class="table_layout" id="chartdiv11" style="padding-top: 140px;">
							<script language="JavaScript">					
								var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_StackedColumn2D.swf", "ChartId", "325", "250");		   			
								var xml = "<graph palette='2' caption='物业实收图' shownames='1' showvalues='0' baseFontSize='12' decimalPrecision='2' limitsDecimalPrecision='0' divLineDecimalPrecision='0' bgColor='' showAlternateHGridColor='1' alternateHGridColor='' divlinecolor=''>";
								xml += "<%
								Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
								List<StatisticGroupDto> groupList = result.getValue();
								out.print("<categories>");
								for(int i = 0; i < groupList.size(); i++){
									out.print("<category name='"+groupList.get(i).getName()+"'/>");
								}
								out.print("</categories>");
								String[] colors = new String[]{"ff3803","f4eb00","0078ff","08a900","535353","#FFEC8B","#FFA500","#F5DEB3","#F08080","#EE82EE","#DEB887"};
								Collection<String> typeNameList = (Collection<String>)request.getAttribute("mapValues");
								
								int i = 0;
								for(String typeName : typeNameList){
									 out.print("<dataset seriesName='"+typeName+"' color='"+colors[i]+"'>");
									 Boolean b = false;
									 for(int m = 0; m < groupList.size(); m++){
										 String time = groupList.get(m).getName();
									 for(int j =0; j<groupList.get(m).getGroups().size();j++){
											 String tyName = groupList.get(m).getGroups().get(j).getName();
											 if(groupList.get(m).getGroups().get(j).getName().equals(typeName)){
												 for(int k = 0;k<groupList.get(m).getGroups().get(j).getList().size();k++){
													 out.print("<set value='"+groupList.get(m).getGroups().get(j).getList().get(k).getdValue2()+"'/>");
													 b = true;
												 }
											 }
										 }
										 if(b==false){
											 out.print("<set value='0'/>");
										 }
										 b = false;
									} 
									 i++;
									 out.print("</dataset>");
								}
								%>";
								xml += "</graph>";
								chart1.setDataXML(xml);
								//alert(xml);
								chart1.render("chartdiv11");
							</script>
                    	</div>
              			</div>
                
                <div class="cal_right">
                 <!--titlebg--><div class="titlebg">物业应收实收统计表:</div><!--//titlebg-->
                <div class="emailtop"> 
                 <!--打印-->
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportData()"><span><img src="core/common/images/print_btn.gif"/></span>打印</li>
				</ul>
			</div>
			<!--//打印-->
            </div>
            
		<div class="overflowAuto" id="overflowAuto">
<!--[if lte ie 8]> <div style="+zoom:1"><![endif]-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="margin-left:-1px;">
     	    <thead>
   		    <tr>
		      <th width="80" rowspan="2">年月</th>
		      <c:forEach items="${mapValues}" var="typeName">
				 <th width="140" colspan="2">${typeName}</th>
			  </c:forEach>
		    </tr>
		    <tr>
		       <c:forEach items="${mapValues}" var="typeName">
			   <th width="70">应收</th>
		   	   <th width="70">实收</th>
			   </c:forEach>
		    </tr>
    		</thead>
    		<tbody>
   			<c:forEach items="${result.value}" var="topGroup">
			<tr>
				<th>${topGroup.name}</th>
				<c:set var="inTotal" value="0"/>
				<c:set var="outTotal" value="0"/>
				<c:forEach items="${mapValues}" var="typeName">
					<c:set var="find" value="false"/>
					<c:forEach items="${topGroup.groups}" var="type">
						<c:if test="${type.name eq typeName }" var="eqTypeName">
							<c:set var="find" value="true"/>
							<td>
								<c:forEach items="${type.list}" var="dto">
									<c:set var="inTotal" value="${inTotal + dto.dValue }"/><fmt:formatNumber value="${dto.dValue}" pattern="#0.00"/>
								</c:forEach>
							</td>
							<td>
								<c:forEach items="${type.list}" var="dto">
									<c:set var="outTotal" value="${outTotal + dto.dValue2 }"/><fmt:formatNumber value="${dto.dValue2}" pattern="#0.00"/>
								</c:forEach>
							</td>
						</c:if>
					</c:forEach>
					<c:if test="${!find}">
						<td></td><td></td>
					</c:if>
				</c:forEach>
			</tr>
			</c:forEach>
			</tbody>
    
  </table>
<!--[if lte ie 8]> </div><![endif]-->
  </div>
</div>
            </div>
      </td>
    </tr>
  </table>
  
</div>


</body>
</html>

