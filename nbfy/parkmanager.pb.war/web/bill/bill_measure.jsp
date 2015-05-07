<%@page import="com.wiiy.crm.dto.StatisticGroupDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";

Result<List<StatisticGroupDto>> result = (Result<List<StatisticGroupDto>>)request.getAttribute("result");
List<StatisticGroupDto> groupList = result.getValue();
String[] colors = new String[]{"C4E647","FFA600","F56908","F8F605","FBCE03","0490E5","0FCD11","D80DE5","005E9B","A5BD4F","FE0000","659303","F0A5B1","1A4EEC"};
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

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>

<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/Code/DOM/js/FusionChartsDOM.js"></script>

<script>
	$(document).ready(function() {
		initTip();
		$("#resizable").css("height",getTabContentHeight()-6);
		initList();
		loadTopType();
	});
	function loadTopType(){
		var billTypeId = $("#topTypeId");
		$.post("<%=basePath%>billType!loadTopType.action",function(data){
			if(data.result.success){
				var billTypes = data.result.value;
				for(var i = 0; i < billTypes.length; i++){
					billTypeId.append($("<option></option>",{value:billTypes[i].id}).append(billTypes[i].typeName));
				}
			}
		});
	}
	function loadTypeChildren(parentId){
		var billTypeId = $("#billTypeId");
		billTypeId.empty();
		billTypeId.append($("<option></option>",{value:''}).append("----请选择----"));
		$.post("<%=basePath%>billType!loadChildrenType.action?id="+parentId,function(data){
			if(data.result.success){
				var billTypes = data.result.value;
				for(var i = 0; i < billTypes.length; i++){
					billTypeId.append($("<option></option>",{value:billTypes[i].id}).append(billTypes[i].typeName));
				}
			}
		});
	}
	function initList(){
		var height = getTabContentHeight()-103;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-355;
		$("#list").jqGrid({
	    	url:'<%=basePath%>bill!loadBill.action',
			colModel: [
				{label:'企业名称', name:'customer.name', align:"center"}, 
				{label:'流水号', name:'number', align:"center",width:90}, 
			    {label:'费用类型', name:'billType.typeName', align:"center",width:80}, 
			    {label:'金额', name:'totalAmount', align:"center",width:60},
			    {label:'计费期限', name:'feeTime', align:"center",sortable:false, formatter:feeTimeFormatter,width:150},
			    {label:'计费开始日期', name:'feeStartTime', align:"center", hidden:true, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'计费结束日期', name:'feeEndTime', align:"center", hidden:true, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'计划付费日期', name:'planPayTime', align:"center",width:80, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'出账日期', name:'checkoutTime', align:"center",width:80 , formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}
			],
			postData:{filters:getSearchFilters()},
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
	function feeTimeFormatter(cellvalue, options, rowObject){
		var startTime = rowObject['feeStartTime'];
		var endTime = rowObject['feeEndTime'];
		if(startTime!=null){
			var start = startTime.substring(0,startTime.indexOf('T'));
 			var end	= endTime.substring(0,endTime.indexOf('T'));
			return start+"&nbsp;至&nbsp;"+end;
		} else return "";
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function changeInOut(state){
		var span = $(".taskactive_arrow");
		$(".taskactive").remove("span").removeClass().addClass('tasklink');
		$('#'+state).removeClass().addClass('taskactive').append(span);
		$("#listTitle").text($('#'+state).find("a").text().substring(0,2)+$("#listTitle").text().substring(2));
		$("#inOut").val(state.toUpperCase());
		doSearch();
	}
</script>
</head>

<body>
	<search:choose dataType="com.wiiy.crm.preferences.enums.BillInOutEnum" field="inOut" op="eq">
	<input id="inOut" type="hidden" class="data" value="IN"/>
	</search:choose>
	<search:choose dataType="com.wiiy.crm.preferences.enums.BillStatusEnum" field="status" op="eq">
	<input type="hidden" class="data" value="UNPAID"/>
	</search:choose>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="350" valign="top">
					<div class="agency" id="resizable" style="width:350px;">
						<div class="titlebg">测算类型</div>
						<div class="task_qiucknav" style="border-top:1px solid #DDD;">
							<ul>
								<li id="in" class="taskactive"><span class="taskactive_arrow" style="left:50%; margin-left:-4px;"></span><a href="javascript:void(0)" onclick="changeInOut('in')">收费测算表</a></li>
							</ul>
						</div>
						<div class="datalist">
							<ul>
								<li class="img">
									<a href="javascript:void(0)" onclick="changeInOut('in')">
										<div class="statistic" style="height:140px" >
											<div id="chart1div" style=""></div>
											<script language="JavaScript">					
												var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_Pie2D.swf", "chart1Id", "180", "140", "0", "1");		   			
												var xml = "<graph decimalPrecision='0' showNames='1' baseFontSize='12' showValues='0'><%
												for(int i = 0; i < groupList.get(0).getList().size(); i++){
													StatisticDto dto = groupList.get(0).getList().get(i);
													out.print("<set name='"+dto.getName()+"' value='"+dto.getdValue()+"' color='"+colors[i%colors.length]+"' />");
												}
												%></graph>";
												chart1.setDataXML(xml);
												chart1.render("chart1div");
											</script>
										</div>
									</a>
								</li>
							</ul>
						</div>
						<div class="task_qiucknav" style="border-top:1px solid #DDD;">
							<ul>
								<li id="out" class="tasklink"><a href="javascript:void(0)" onclick="changeInOut('out')">付费测算表</a></li>
							</ul>
						</div>
						<div class="datalist">
							<ul>
								<li class="img">
									<a href="javascript:void(0)" onclick="changeInOut('out')">
										<div class="statistic" style="height:120px;">
											<div id="chart2div"></div>
											<script language="JavaScript">					
												var chart2 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_Pie2D.swf", "chart2Id", "180", "140", "0", "1");		   			
												var xml2 = "<graph decimalPrecision='0' showNames='1' baseFontSize='12' showValues='0'><%
												for(int i = 0; i < groupList.get(1).getList().size(); i++){
													StatisticDto dto = groupList.get(1).getList().get(i);
													out.print("<set name='"+dto.getName()+"' value='"+dto.getdValue()+"' color='"+colors[i%colors.length]+"' />");
												}
												%></graph>";
												chart2.setDataXML(xml2);
												chart2.render("chart2div");
											</script>
										</div>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</td>
				<td width="100%" valign="top">
					<div id="listTitle" class="titlebg">收费测算列表</div>
					<div class="searchdiv">
						<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="60" align="right">费用类型：</td>
								<td width="200">
								<search:choose dataType="long" field="billType.parentId" op="eq">
								<select id="topTypeId" class="data" onchange="loadTypeChildren(this.value)">
									<option value="">----请选择----</option>
								</select>
								</search:choose>
								<search:choose dataType="long" field="billTypeId" op="eq">
			        			<select id="billTypeId" class="data">
									<option value="">----请选择----</option>
								</select>
								</search:choose>
								</td>
								<td width="75" align="center"><input name="Submit" type="button" class="search_cx" value="" onclick="doSearch();"></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</div>
                	<div class="overflowAuto" id="overflowAuto">
						<table id="list" class="jqGridList"><tr><td/></tr></table>
						<div id="pager"></div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
