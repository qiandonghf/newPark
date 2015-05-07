<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
	
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
		$(document).ready(function() {
			refreshTree();
			initList();
		});
		function initList(){
			$("#list").jqGrid({
		    	url:'<%=basePath%>bill!loadBill.action',
				colModel: [
					{label:'状态', name:'status.title', align:"center", width:40}, 
					{label:'企业名称', name:'customer.name', align:"center"}, 
					{label:'计费开始时间', name:'feeStartTime', align:"center", width:60,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
					{label:'计费结束时间', name:'feeEndTime', align:"center", width:60,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				    {label:'总金额', name:'totalAmount', align:"center", width:40},
				    {label:'实际支付金额', name:'factPayment', align:"center", width:40},
				    {label:'滞纳金', name:'penalty', align:"center", width:30}
				],
				height: 142,
				width: 594,
				multiselect: false,
				forceFit: true,
				postData:{filters:generateSearchFilters("roomId","eq",'${id}',"long")}
			}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
		}
		
		function iframeSwitch(url,li){
			$(li).removeClass().addClass("apptabliover");
			$(li).siblings().removeClass().addClass("apptabli");
			$("#iframe").attr("src",url);
		}
		
		function refreshTree() {
			$.ajax({
			  "url" : "<%=basePath%>billType!typeTree.action",
			  type:"POST",
			  success: function(data){
				$("#tt").tree({
					lines:true,
					"data" : data.billTypeList,
					onClick: function(node){
						$(this).tree('toggle', node.target);
						var id = node.id;
						if($(this).tree("isLeaf",node.target)){
							var filters = "{\"rules\":[{\"field\":\"roomId\",\"op\":\"eq\",\"data\":\""+${id}+"\",\"dataType\":\"long\"},"
							                           + "{\"field\":\"billTypeId\",\"op\":\"eq\",\"data\":\""+id+"\",\"dataType\":\"long\"}]}";
							$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
						}
					}
				});
			  }
			});
		}
</script>
</head>
<body>
<div class="basediv">
	<div class="divlays">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('费用设计','<%=basePath %>roomFee!editRoomFees.action?id=${id}',520,383);"><span><img src="core/common/images/money.png" width="15" height="13" /></span>收费标准</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('房间合并','<%=basePath %>web/building/room_merge.jsp',500,164);"><span><img src="core/common/images/hb.gif" width="15" height="13" /></span>合并</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('房间折分','<%=basePath %>web/building/room_broken_into.jsp',500,164);"><span><img src="core/common/images/cf.gif" width="15" height="13" /></span>折分</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建物业报修','<%=basePath %>room!propertyRepair.action?id=${id}',800,460);"><span><img src="core/common/images/wybx.gif" width="15" height="13" /></span>物业报修</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('跟进管理','<%=basePath %>web/building/room_followup_add.jsp?id=${id}',500,269);"><span><img src="core/common/images/gjgl.gif"/></span>跟进管理</li>
				</ul>
			</div>
		</div>
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="iframeSwitch('<%=basePath %>room!view.action?id=${id}',this)">基本信息</li>
				<c:if test="${hasCustomer }"><li class="apptabli" onclick="iframeSwitch('<%=basePath %>room!loadCusInfoByRoomId.action?id=${id }',this)">企业信息</li></c:if>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_listmeter.jsp?id=${id }',this)">水电表</li>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_historyList.jsp?id=${id }',this)">历史租户</li>
				<%--<li class="apptabli"><a href="parkmanager.pb/web/building/room_billList.html" target="room">应收明细</a></li>
				--%><li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_ChangeLoglist.jsp?id=${id }',this)"><a href="javascript:void(0)">变更记录</a></li>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_followupList.jsp?id=${id }',this)">跟进管理</a></li>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_AttList.jsp?id=${id }',this)">附件&amp;图片</li>
				<li class="apptabli" onclick="iframeSwitch('<%=basePath %>web/building/room_Memolist.jsp?id=${id }',this)">备注</li>
			</ul>
		</div>
		<iframe id="iframe" scrolling="no" frameborder="0" src="<%=basePath %>room!view.action?id=${id}" name="room" width="100%" height="194"></iframe>
		<div class="pm_msglist" style="margin-top:5px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="180" valign="top" class="roomview">
						<div class="titlebg">费用类型</div>
						<div class="treeviewdiv" style="overflow-Y:auto; height:221px;">
							<ul id="tt">
	 						</ul>
						</div>
					</td>
					<td valign="top">
						<div class="roomlist">
							<div class="titlebg">历史账单</div>
							<table id="list" class="jqGridList"><tr><td></td></tr></table>
							<div id="pager"></div>
							<div class="roomcount">已收合计：${receivedTotal}元  未收合计：<span class="redweight">${notReceivedTotal}元</span></div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
</div>
<div style="height: 2px;"></div>
</body>
</html>
