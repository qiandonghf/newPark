<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.dto.StatisticDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
		$("#resizable").css("height",getTabContentHeight());
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-355;
		$("#list").jqGrid({
	    	url:'<%=basePath%>bill!loadBill.action?status=UNPAID',
			colModel: [
				{label:'企业名称', name:'customer.name', align:"center"}, 
				{label:'流水号', name:'number', align:"center",width:90}, 
			    {label:'费用类型', name:'billType.typeName', align:"center",width:80}, 
			    {label:'欠费金额', name:'totalAmount', align:"center",width:60},
			    {label:'计费期限', name:'feeTime', align:"center",sortable:false, formatter:feeTimeFormatter,width:150},
			    {label:'计费开始日期', name:'feeStartTime', align:"center", hidden:true, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'计费结束日期', name:'feeEndTime', align:"center", hidden:true, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'计划付费日期', name:'planPayTime', align:"center",width:80, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'逾期天数', name:'planPayTime', align:"center",width:80 , formatter:overdueFormatter}
			],
			postData:{filters:generateSearchFilters("planPayTime","le",getNowDate(),"java.util.Date")},
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
	function getNowDate(){
		var now = new Date();
		return now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
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
	function overdueFormatter(cellvalue, options, rowObject){
		var planPayTime = rowObject['planPayTime'];
		var planPay = planPayTime.substring(0,planPayTime.indexOf('T'));
		//var playTime = new Date(planPay.split("-")[0],parseInt(planPay.split("-")[1])-1,planPay.split("-")[2]);
		var date = (new Date()).format("yyyy-MM-dd");
		var days = DateDiff(date,planPay);
		//var days = parseInt((new Date()-playTime)/1000/60/60/24);
		if(days==null){
			days="";
		}
		Math.ceil(days);
		return "<span style='color:#F00; font-weight:bold;'>"+days+"天</span>";
	}
	
	function DateDiff(d1,d2)

	{

	    var day = 24 * 60 * 60 *1000;

	    try{    

	        var dateArr = d1.split("-");

	        var checkDate = new Date();

	        checkDate.setFullYear(dateArr[0], dateArr[1]-1, dateArr[2]);

	        var checkTime = checkDate.getTime();

	        var dateArr2 = d2.split("-");

	        var checkDate2 = new Date();

	        checkDate2.setFullYear(dateArr2[0], dateArr2[1]-1, dateArr2[2]);

	        var checkTime2 = checkDate2.getTime();

	        var cha = (checkTime - checkTime2)/day;
	        return cha;

	    }

	    catch(e)

	    {

	        return false;

	    }

	    //调用方法 （注意日期格式）

//	    DateDiff("2010/12/28",5) ;

	}


</script>
</head>

<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="350" valign="top">
					<div class="agency" id="resizable" style="width:350px;">
						<div class="titlebg">欠费报警图表</div>
						<div class="datalist">
							<ul>
								<li class="img">
									<div class="statistic">
										<div id="chart1div"></div>
										<script language="JavaScript">					
											var chart1 = new FusionCharts("<%=BaseAction.rootLocation %>/core/common/FusionChartsFree/Charts/FCF_Pie2D.swf", "chart1Id", "280", "300", "0", "1");		   			
											var xml = "<graph decimalPrecision='0' showNames='1' baseFontSize='12' showValues='0'><%
											Result<List<StatisticDto>> result = (Result<List<StatisticDto>>)request.getAttribute("result");
											List<StatisticDto> list = result.getValue();
											String[] colors = new String[]{"C4E647","005E9B","A5BD4F","FE0000","FFA600","F56908","F8F605","FBCE03","0490E5","0FCD11","D80DE5","659303","F0A5B1","1A4EEC"};
											for(int i = 0; i < list.size(); i++){
												out.print("<set name='"+list.get(i).getName()+"' value='"+list.get(i).getdValue()+"' color='"+colors[i%colors.length]+"' />");
											}
											%></graph>";
											chart1.setDataXML(xml);
											chart1.render("chart1div");
										</script>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</td>
				<td width="100%" valign="top">
					<div class="titlebg">欠费列表</div>
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
