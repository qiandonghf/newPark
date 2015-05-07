<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";;
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
	});
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)+25;
		$("#list").jqGrid({
	    	url:'<%=basePath%>room!roomList.action',
			colModel: [
				{label:'分类',width:60, name:'type.dataValue', width:30 , align:"center"}, 
				{label:'楼号',width:70, name:'building.name', align:"center"}, 
				{label:'房号',width:60, name:'name', align:"center"}, 
				{label:'建筑面积', width:100, name:'buildingArea', width:80,formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"},  
				{label:'租用企业', name:'customerName', align:"center",width:150}, 
			    {label:'优惠起始期', name:'discountBeginTime', width:90, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'租期开始时间', name:'', width:80, hidden: true,align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'租期结束时间', name:'endDate', width:90, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
				{label:'租金/物业费',width:60, name:'rentPrice', width:80,formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center"}, 
			    {label:'备注', name:'summary', align:"center",width:70},
			],
			shrinkToFit: false,
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
	
	function selectBuilding(){
		var id = $("#park").val();
		if(id!=null){
			$.post("<%=basePath%>room!loadByParkId.action?id=" + id, function(data) {
				if (data.result.success) {
					var list = data.result.value;
					var contectId = $("#building");
					contectId.empty();
					contectId.append($("<option></option>", {value : ""}).append("----请选择楼宇----"));
					for ( var i = 0; i < list.length; i++) {
						var contect = list[i];
						contectId.append($("<option></option>", {value : contect.id}).append(contect.name));
					}
				} else {
					showTip(data.result.msg,2000);
				}
			});
		}
	}

	function doSearch() {
		search(getSearchFilters());
	}

	function search(filters) {
		$("#list").setGridParam({
			postData : {
				filters : filters
			}
		}).trigger('reloadGrid');
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
						<jsp:include page="building_statistic_left.jsp">
							<jsp:param value="3" name="index" />
						</jsp:include>
					</div>
				</td>
				<td width="100%" valign="top">
				<div class="titlebg">孵化用房管理表</div>
					<div class="searchdiv">
						<table width="100%" height="25" border="0" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="40">园区：</td>
								<td width="120"><select id="park"
									onchange="selectBuilding();">
										<option>----请选择园区----</option>
										<c:forEach items="${result.value}" var="park">
											<option value="${park.id }">${park.name }</option>
										</c:forEach>
								</select></td>

								<td width="40">楼宇：</td>
								<td width="120"><select id="building" class="data">
										<option>----请选择楼宇----</option>
								</select> <input class="field" type="hidden" value="buildingId" /><input
									class="op" type="hidden" value="eq" /><input class="dataType"
									type="hidden" value="long" /></td>
								<td width="75" align="center"><input name="Submit"
									type="button" class="searchbtn" value="" onclick="doSearch();" />
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</div>
					<div id="container">
						<div class="msglist" style="display: block;" id="textname"
							name="textname">
							<table id="list" class="jqGridList">
								<tr>
									<td></td>
								</tr>
							</table>
							<div id="pager"></div>
						</div>
					</div> <map name="Map" id="Map">
						<area shape="rect" coords="0,0,53,22" href="javascript:void(0)"
							onclick="doSearch()" />
					</map>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>