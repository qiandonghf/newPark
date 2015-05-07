<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
		<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
		<script type="text/javascript">
			$(function(){
				initList();
				initTip();
				$("#resizable").css("height",getTabContentHeight()-10);
				$("#msglist").css("height",getTabContentHeight()-10);
			});
			function reloadList(){
				$("#list").trigger("reloadGrid");
			}
			function initList(){		
				var height = getTabContentHeight()-80;
				var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-240;
				$("#list").jqGrid({
			    	url:'<%=basePath%>dataReportToCustomer!listByCustomerId.action?id=${param.id}',
					colModel: [
						{label:'报表名称', name:'report.name', align:"center",width:140}, 
						{label:'报表类型', name:'report.reportType.title', width:80,align:"center"}, 
						{label:'类型', name:'report.reportType', width:30,align:"center",hidden:true}, 
						{label:'数据时间', name:'report.date', width:110,align:"center",formatter:formatDate}, 
					    {label:'日期', name:'report.dataTime',width:60, align:"center",formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'},hidden:true},
					    {label:'截止日期', name:'report.finishTime',width:100, align:"center", index:'status',formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
					    {label:'报表状态', name:'report.status.title',width:85, align:"center", index:'status',hidden:true},
					    {label:'填报日期', name:'fillTime', align:"center",width:100, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
					    {label:'填报状态', name:'status.title', align:"center",width:70},
					    {label:'管理', name:'manager', align:"center",width:80, resizable:false}
					],
					shrinkToFit: false,
					height: height,
					width: width,
					gridComplete: function(){
						var ids = $(this).jqGrid('getDataIDs');
						for(var i = 0 ; i < ids.length; i++){
							var id = ids[i];
							var content = "";
							if($(this).getCell(id,10)!='未上报'){
								content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
							}
							if($(this).getCell(id,4)!='已关闭'){
								if($(this).getCell(id,10)!='已上报'){
									content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"上报\" onclick=\"reportById('"+id+"');\"  /> "; 
									content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"数据填报\" onclick=\"editById('"+id+"');\"  /> "; 
								}
							}
							//content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
							$(this).jqGrid('setRowData',id,{manager:content});
						}
					}
				}).navGrid('#pager',{add: false, edit: false, del: false, search: false}).navButtonAdd('#pager',{
				    caption : "列选择",
				    title : "选择要显示的列",
				    onClickButton : function(){
				        $(this).jqGrid('columnChooser');
				    }
				});
			}
			function formatDate(cellvalue,options,rowObject){
				var type = rowObject["report"].reportType.title;
				var dataTime = rowObject["report"].dataTime;
				var year;
				var month;
				if(type=="月报"){
				    year = dataTime.substring(0,4);
					month = dataTime.substring(5,7);
					if(month<10){
						month = dataTime.substring(6,7);
					}
					cellvalue = year+"年"+month+"月";
				}
				if(type=="季报"){
					year = dataTime.substring(0,4);
					month = dataTime.substring(5,7);
					if(month<10){
						month = dataTime.substring(6,7);
					}
					cellvalue = year+"年"+month/3+"季度";
				}
				if(type=="半年报"){
					year = dataTime.substring(0,4);
					month = dataTime.substring(5,7);
					if(month<10){
						month = dataTime.substring(6,7);
					}
					if(month==6){
						cellvalue = year+"年上半年";
					}
					if(month==12){
						cellvalue = year+"年下半年";
					}
				}
				if(type=="年报"){
					year = dataTime.substring(0,4);
					cellvalue = year+"年";
				}
				if(type=="临时"){
					year = dataTime.substring(0,10);
					cellvalue = year;
				} 
				return cellvalue;
			}
			function reportById(id){
				if(confirm("确定要上报")){
					$.post("<%=basePath%>dataReportToCustomer!reportPub.action?id="+id,function(data){
						showTip(data.result.msg,1000);
						$("#list").trigger("reloadGrid");
					});
				}
			}
			function viewById(id){
				window.open("<%=basePath%>dataReportToCustomer!view.action?id="+id);
			}
			function editById(id){
				fbStart('填报数据','<%=basePath %>dataReportToCustomer!edit.action?id='+id,620,440,false);
			}
			function doSearch(){
				search(getSearchFilters());
			}
			function search(filters){
				$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
			}
			function refresh(){
				if($(".tabswitch").size()==2){
					$("#list").trigger("reloadGrid");
				}else{
					location.reload();
				}
			}
		</script>
	</head>
<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="182" valign="top">
					<div class="pstextleft" id="resizable">
						<div class="pstitles">提示</div>
						<%out.print(PbActivator.getAppConfig().getConfig("dataReport").getParameter("name")); %>
						<!--agencylist-->
						<!-- <p class="pstextcolor">为配合中心主管部门做好我市科技企业发展整体情况调查与分析，按照主管部门要求，中心定期发布科技企业情况调查表，望各单位积极配合填报数据。</p>
						<p>
							咨询电话：<span class="psnamecolor">88776655</span>
						</p> -->
						<!--//agencylist-->
					</div>
				</td>
				<td valign="top">
					<div class="msglist" id="msglist">
						<div class="titlebg">企业数据&nbsp;填报列表</div>
						<table id="list" class="jqGridList">
							<tr>
								<td></td>
							</tr>
						</table>
						<div id="pager"></div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
