<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<script>
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight());
		$("#treeviewdiv").css("height",getTabContentHeight()-30);
		$("#browser").tree({
			animate: true,
			lines: true,
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					$("#list").setGridParam({url:'<%=basePath%>bill!listByTypeId.action?id='+$(node.target).find("input").val()}).trigger('reloadGrid');
				}
			}
		});
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-77;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-240;
		$("#list").jqGrid({
	    	url:'<%=basePath%>bill!loadBill.action',
			colModel: [
				{label:'企业名称', name:'customer.name', align:"center",width:180,sortable:false}, 
				{label:'流水号', name:'number', align:"center",width:170}, 
				{label:'收支', name:'inOut.title', align:"center",width:80}, 
			    {label:'费用类型', name:'billType.typeName', align:"center",width:110,sortable:false}, 
			    {label:'应付金额', name:'factPayment', align:"center",width:110},
			    {label:'滞纳金', name:'penalty', align:"center",width:110},
			    {label:'计划付费日期', name:'planPayTime',width:100, align:"center", formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'结算日期', name:'payTime', align:"center",width:100, formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'状态', name:'status.title', align:"center",width:80,sortable:false},
			    {label:'管理', name:'manager', align:"center",sortable:false, resizable:false,width:40}
			],
			height: height,
			width: width,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					/* if($(this).getCell(id,10)=='未支付'){
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/hexiao.gif\" width=\"14\" height=\"14\" title=\"核销\" onclick=\"chargeoffById('"+id+"');\"  /> "; 
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					} */
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
	function viewById(id){
		fbStart($("#list").getRowData(id)["customer.name"],'<%=basePath %>bill!view.action?id='+id,550,310);
	}
	function editById(id){
		fbStart('编辑账单','<%=basePath %>bill!edit.action?id='+id,500,370);
	}
	function chargeoffById(id){
		if(confirm("确定要核销吗")){
			$.post("<%=basePath%>bill!chargeoff.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function deleteById(id){
		if(confirm("确定要删除吗")){
			$.post("<%=basePath%>bill!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>bill!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>

<body>
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('收款单','<%=basePath%>bill!printCustomerBill.action',700,480);"><span><img src="core/common/images/print_16x16.gif"/></span>打印缴费单</li>
			</ul>
		</div>
	</div>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	        	<td width="182" valign="top">
					<div class="pstextleft" id="resizable" >
            <div class="pstitles">提示</div>
			<!--agencylist-->
            <%-- <p class="pstextcolor">　　您有<span class="psred">${customerToPayCount }</span>笔款项未支付请您在收到缴费通知后请及时到指定银行缴纳款项，再凭银行回单到中心企业部开具发票。</p>
			<p class="ptop">中心全称：<span class="psnamecolor">三略科技</span></p>
			<p>开户行：<span class="psnamecolor">农行开发区支行</span></p>
			<p>租金请缴入以下账户：</p>
			<p class="psnamecolor">　312-220101040003766-0100</p>
			<p >其他费用请缴入以下账户：</p>
			<p class="psnamecolor">　312-220101040003766-0402-0213</p> --%>
			<%
				Integer customerToPayCount = (Integer)request.getAttribute("customerToPayCount");
				String billInfo = "";
				if(PbActivator.getAppConfig().getConfig("billInfo")!=null){
					billInfo = PbActivator.getAppConfig().getConfig("billInfo").getParameter("name");
				}else{
					billInfo = "应用参数未配置，请联系管理员";
				}
				billInfo = billInfo.replace("${customerToPayCount }", "<span style='color:#f00; font-weight:bold;font-style:normal; padding-right:2px; font-family:Arial, Helvetica, sans-serif;'>"+customerToPayCount+"</span>");
				out.print(billInfo); 
			
			%>
			<!--//agencylist-->
			</div>
				</td>
				<td width="100%" valign="top">
					<%
					boolean isCenterUser=true;
					String userType = PbActivator.getSessionUser().getUserType().getTitle();
					if(userType.equals("企业帐号")){
						isCenterUser=false;
					}
					%>
					<%if(isCenterUser){ %>
					<div class="searchdivkf">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
							<tr>
								<td width="65">企业名称：</td>
								<td width="200">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td>
												<search:choose dataType="long" field="customerId" op="eq">
												<input type="hidden" id="customerId" class="data"/>
												</search:choose>
												<search:choose dataType="string" field="customer.name" op="cn">
												<input onkeyup="$('#customerId').val('')" id="customerName" name="endTime" type="text" class="data inputauto"/>
												</search:choose>
											</td>
											<td width="20"><img style="cursor:pointer;" src="core/common/images/outdiv.gif" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
										</tr>
									</table>
								</td>
								<td><label><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map"></label></td>
							</tr>
						</table>
					<%} %>
					<div style="overflow: auto;">
						<table id="list" class="jqGridList"><tr><td/></tr></table>
						<div id="pager"></div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<map name="Map" id="Map">
		<area shape="rect" coords="1,2,50,21" href="javascript:void(0)" onclick="doSearch()"/>
		<area shape="rect" coords="54,0,73,19" href="javascript:void(0)" onclick="fbSearch('高级搜索','<%=basePath %>web/bill/bill_search.jsp',550,410);" />
	</map>
</body>
</html>
