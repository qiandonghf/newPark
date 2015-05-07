<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>

<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String customerIds = request.getParameter("customerIds");
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<style>a{TEXT-DECORATION:none}</style>
<script type="text/javascript">
	<%if(PbActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
	var customterMenu=[[
	<%boolean flag=false;
	if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerCategory_rename")){
		flag=true;%>
	
 	{
		text:"重命名",
		classname:"smarty_menu_ico1",
		func:function(){
			fbStart('重命名','<%=basePath%>customerCategory!edit.action?id='+$(this).find('input').val(),300,80);
		}
	}
	<%}%>
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerCategory_delete")){
		if(flag){
			%>,<%}%>
 	{
		text:"删除",
		classname:"smarty_menu_ico2",
		func:function(){
			if(confirm("您确定要删除")){
				$.post("<%=basePath%>customerCategory!delete.action?id="+$(this).find('input').val(),function(data){
					showTip(data.result.msg,1000);
					setTimeout("location.reload()", 1000);
				});
			}
		}
	}
 	<%}%>
 	],[
 	   <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_tag_add")){%>
 	   {
		text:"添加标签",
		classname:"smarty_menu_ico0",
		func:function(){
			fbStart('添加标签','<%=basePath%>customerLabel!addByCategoryId.action?id='+$(this).find('input').val(),300,80);
		}
	}
 	   <%}%>]];
	<%}%>
	var customterLabel=[[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerLabel_edit")){%>
 	{
		text:"重命名",
		classname:"smarty_menu_ico1",
		func:function(){
			fbStart('重命名','<%=basePath%>customerLabel!edit.action?id='+$(this).find('input').val(),300,80);
		}
	}
 	<%}%>
 	],[
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerLabel_delete")){%>
	 	   {
			text:"删除",
			classname:"smarty_menu_ico2",
			func:function(){
				if(confirm("您确定要删除")){
					$.post("<%=basePath%>customerLabel!delete.action?id="+$(this).find('input').val(),function(data){
						showTip(data.result.msg,1000);
						setTimeout("location.reload()", 1000);
					});
				}
			}
		}
	 <%}%>	   
 	   ]];
	<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_tag_add")){%>
	var MyCustomterMenu=[[{
		text:"添加标签",
		classname:"smarty_menu_ico0",
		func:function(){
			
			fbStart('添加标签','<%=basePath%>customerLabel!addByCategoryId.action?id='+$(this).find('input').val(),300,80);
			
		}
	}]];
	<%}%>
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-28);
		$("#msglist").css("height",getTabContentHeight()-28);
		$("#treeviewdiv").css("height",getTabContentHeight()-82);
		initTree();
		initList();
	});
	function loadCustomerLabelByCategoryId(categoryId){
		if($("#customerCategoryLi"+categoryId).hasClass("expandable")){
			$.post("<%=basePath%>customerLabel!loadCustomerLabelByCategoryId.action?id="+categoryId,function(data){
				if(data.result.success){
					$("#customerLabelUl"+categoryId).empty();
					for(var i = 0; i < data.result.value.length; i++){
						var customerLabel = data.result.value[i];
						var span = $("<span class=\"file\"></span>").append(customerLabel.name).append($("<input />",{type:"hidden",value:customerLabel.id}));
						span.smartMenu(customterLabel,{name:'customterLabel'});
						span.bind("click",function(){
							loadCustomerByLabelId($(this).find('input').val());
						});
						$("#customerLabelUl"+categoryId).append($("<li></li>").append($("<a href=\"javascript:void(0)\"></a>").append(span)));
					}
				}
			});
		}
	}
	function loadMyLabel(categoryId){
		if($("#customerCategoryLi"+categoryId).hasClass("expandable")){
			$.post("<%=basePath%>customerLabel!loadMyLabel.action",function(data){
				if(data.result.success){
					$("#customerLabelUl"+categoryId).empty();
					for(var i = 0; i < data.result.value.length; i++){
						var customerLabel = data.result.value[i];
						var span = $("<span class=\"file\"></span>").append(customerLabel.name).append($("<input />",{type:"hidden",value:customerLabel.id}));
						span.smartMenu(customterLabel,{name:'customterLabel'});
						span.bind("click",function(){
							loadCustomerByLabelId($(this).find('input').val());
						});
						$("#customerLabelUl"+categoryId).append($("<li></li>").append($("<a href=\"javascript:void(0)\"></a>").append(span)));
					}
				}
			});
		}
	}
	function loadCustomerByLabelId(labelId){
		$("#labelId").val(labelId);
		$("#list").setGridParam({url:'<%=basePath%>customer!list.action?labelId='+labelId,page:1}).trigger('reloadGrid');
	}
	function loadCustomerByIncubatorRote(routeId){
		$("#routeId").val(routeId);
		$("#list").setGridParam({url:'<%=basePath%>customer!list.action?routeId='+routeId,page:1}).trigger('reloadGrid');
	}
	function loadAllCustomer(){
		$("#list").setGridParam({url:'<%=basePath%>customer!list.action',page:1}).trigger('reloadGrid');
	}
	
	function customerName(cellvalue, options, rowObject){
		var id = rowObject["id"];
		var data = "";
 		data = "<a href=\"javascript:void(0)\" onclick=\"showView('"+cellvalue+"','"+id+"');\">"+cellvalue+"</a>";
		return data;
	}
	
	function showView(name,id){
		fbStart(name,'<%=basePath %>customer!view.action?id='+id,870,450);
	}
	
	function initList(){
		var height = getTabContentHeight()-135;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-186;
		$("#list").jqGrid({
	    	url:'<%=basePath%>customer!list.action',
			colModel: [
				{label:'企业名称', name:'name', align:"center",width:220,formatter:customerName}, 
				{label:'企业简称', name:'shortName', align:"center",width:180}, 
				{label:'企业编号', name:'code', align:"center",width:60}, 
			    {label:'企业性质', name:'type.title', align:"center",width:60,hidden:true}, 
			    {label:'入驻状态', name:'parkStatus.title', align:"center",width:60},
			    {label:'招商项目ID', name:'investmentId', align:"center",hidden:true},
			    {label:'账号', name:'userId', align:"center", hidden:true},
			    {label:'跟踪引进', name:'hostName', align:"center", hidden:true},
			    {label:'技术领域', name:'technic.dataValue', align:"center", hidden:true},
			    {label:'企业来源', name:'source.dataValue', align:"center", hidden:true},
			    {label:'孵化企业', name:'incubated.title', align:"center",width:60},
				{label:'联系地址', name:'customerInfo.address', align:"center", hidden:true}, 
			    {label:'邮编', name:'customerInfo.zipCode', align:"center", hidden:true},
			    {label:'网址', name:'customerInfo.webSite', align:"center", hidden:true},
			    {label:'办公电话', name:'customerInfo.officePhone', align:"center", hidden:true},
			    {label:'传真', name:'customerInfo.fax', align:"center", hidden:true},
			    {label:'Email地址', name:'customerInfo.email', align:"center", hidden:true},
			    {label:'注册时间', name:'customerInfo.regTime', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'注册类型', name:'customerInfo.regType.dataValue', align:"center", hidden:true},
			    {label:'注册资本', name:'customerInfo.regCapital', align:"center", hidden:true},
			    {label:'币种', name:'customerInfo.currencyType.dataValue', align:"center", hidden:true},
			    {label:'组织机构', name:'customerInfo.organizationNumber', align:"center", hidden:true},
			    {label:'工商注册号', name:'customerInfo.businessNumber', align:"center", hidden:true},
			    /* {label:'税务登记证', name:'customerInfo.taxNumber', align:"center", hidden:true}, */
			    {label:'法定代表人', name:'customerInfo.legalPerson', align:"center", hidden:true},
			    {label:'证件类型', name:'customerInfo.documentType.dataValue', align:"center", hidden:true},
			    {label:'证件号', name:'customerInfo.documentNumber', align:"center", hidden:true},
			    {label:'注册EMAIL', name:'customerInfo.regMail', align:"center", hidden:true},
			    {label:'移动电话', name:'customerInfo.cellphone', align:"center", hidden:true},
			    {label:'注册地址', name:'customerInfo.regAddress', align:"center", hidden:true},
			    {label:'经营范围', name:'customerInfo.businessScope', align:"center", hidden:true},
			    {label:'营业截至日期', name:'customerInfo.businessExpireDate', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'孵化日期起', name:'incubationInfo.incubationStartDate', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'孵化日期止', name:'incubationInfo.incubationEndDate', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'毕业日期', name:'incubationInfo.graduationDate', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'是否高新技术企业', name:'incubationInfo.highTechEnterprise.title', align:"center", hidden:true},
			    {label:'是否建立创业导师', name:'incubationInfo.tutorSupport.title', align:"center", hidden:true},
			    {label:'是否大学生创业', name:'incubationInfo.undergraduateEnterprise.title', align:"center", hidden:true},
			    {label:'是否留学生创业', name:'incubationInfo.overseaEnterprise.title', align:"center", hidden:true},
			    {label:'孵化状态', name:'incubationInfo.statusName', align:"center",width:120},
			    {label:'管理', name:'manager', align:"center",width:80,sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					var row = $(this).jqGrid('getRowData',id);
					if(row.userId==''){
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_configAccount")){%>
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"设置账号\" onclick=\"createUser('"+id+"');\"  /> ";
						<%}%>
					}else{
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_updatePassword")){%>
						content += "<img src=\"core/common/images/users.png\" width=\"14\" height=\"14\" title=\"修改密码\" onclick=\"updateAccountPassword('"+row.userId+"');\"  /> ";
						<%}%>
					}
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					<%}%>
					if(row.investmentId!=''){
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_investmentView")){%>
						content += "<img src=\"core/common/images/view2.png\" width=\"14\" height=\"14\" title=\"项目信息\" onclick=\"viewInvestmentById('"+row.investmentId+"');\"  /> "; 
					<%}%>
					}
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%}%>
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
	function createUser(id){
		fbStart('设置账号','<%=basePath %>customer!configAccount.action?id='+id,300,95);
	}
	function updateAccountPassword(userId){
		fbStart('修改密码','<%=basePath %>customer!updatePassword.action?id='+userId,300,95);
	}
	function viewById(id){
		fbStart($($("#list").getRowData(id).name).text(),'<%=basePath %>customer!view.action?id='+id,870,453);
	}
	function viewInvestmentById(investmentById){
		fbStart('项目信息','<%=basePath %>investment!view.action?id='+investmentById,700,364);
	}
	function editById(id){
		fbStart('编辑企业档案','<%=basePath %>customer!edit.action?id='+id,700,450);
	}
	function reloadList(){
   		$("#list").trigger("reloadGrid");
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>customer!delete.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function doSearch(){
		var filters = getSearchFilters();
		$("#filters").val(filters);
		search(filters);
	}
	function search(filters){
		$("#filters").val(filters);
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>customer!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function exportDate(){
		var columns = "{";
		$.each($("#list").getGridParam("colModel"),function(){
			if(this.label && this.name!="manager" && !this.hidden){
				columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
			}
		});
		columns = deleteLastCharWhenMatching(columns,",");
		columns += "}";
		$("#columns").val(columns);
		showTip("正在导出，请耐心等候...",5000);
		$("#exportForm").submit();
	}
	
	function initTree(){
		$("#browser").tree({
			animate: true,
			url:"<%=basePath%>customer!loadCategory.action",
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					if($(node.target).find("input").val()==null){
						loadAllCustomer();
					}
					if($(node.target).find("input").val()>-1){
						loadCustomerByLabelId($(node.target).find("input").val());
					}else{
						loadCustomerByIncubatorRote($(node.target).find("input").val());
					}
				}
			},
			onBeforeExpand: function(node){
				if(node.id>-1){
					$("#browser").tree("options").url="<%=basePath%>customer!loadLabelByCategoryId.action";
				} else if(node.id==-2) {
					$("#browser").tree("options").url="<%=basePath%>customer!loadIncubatorRote.action";
				} else {
					$("#browser").tree("options").url="<%=basePath%>customer!loadCategory.action";
				}
			},
			onLoadSuccess: function(node, data){
				var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					if(!$(this).tree("isLeaf",node.target)){
						if(node.id==-2){
							continue;
						}
						if(node.id==0){
							$(node.target).find(".tree-title").smartMenu(MyCustomterMenu,{name:'myCustomterMenu'});
						<%if(PbActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
						} else {
							$(node.target).find(".tree-title").smartMenu(customterMenu,{name:'customterMenu'});
						<%}%>
						}
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];
							$(child.target).find(".tree-title").smartMenu(customterLabel,{name:'customterLabel'});
						}
					}
				}
			}
		});
	}
	
	function refreshGroup(){
		initTree();
	}
	
	function toImportCard() {
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(confirm("确定要导入名片夹（客户-企业档案）吗")){
			showTip("正在导入名片，请稍候...",100000);
			$.post('<%=basePath %>customer!importCard.action?ids='+ids,
				function(data){
					showTip(data.result.msg,2000);
				}
			);
		 }
	 }
	
	function sortGenerator(){
		if(confirm("是否按孵化状态进行企业分类")){
			showTip("正在生成分类，请稍候...",10000);
			$.post('<%=basePath %>customer!createCategoryByIncubation.action',
				function(data){
					showTip(data.result.msg,2000);
					initTree();
				}
			);
		}
	}
</script>

</head>
<body>
<form action="<%=basePath%>customer!export.action" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
	<input type="hidden" id="labelId" name="labelId"/>
	<input type="hidden" id="routeId" name="routeId"/>
</form>
<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_add")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建企业档案','<%=basePath %>customer!add.action',700,519);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_delete")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_export")){ %>	
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_importCard")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toImportCard()"><span><img src="core/common/images/card.png"/></span>导入名片</li>
		<%} %>
		<%-- <%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_createCategory")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="sortGenerator()"><span><img src="core/common/images/break_the_egg.png"/></span>生成孵化企业分类</li>
		<%} %> --%>
		</ul>
	</div>
</div>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="182" valign="top">
				<div class="agency" id="resizable" >
					<div class="titlebg">企业分组</div>
					<%if(PbActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){ %>
					<div class="agencybtn">
						<ul>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_enterprise_classify")){ %>
							<li><a href="javascript:void(0)" onclick="fbStart('企业分类','<%=basePath %>web/client/group_add.jsp',300,80);"><span class="icoadd"></span>企业分类</a></li>
						<%} %>
						</ul>
					</div>
					<%} %>
					<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						<ul id="browser" class="filetree">
						</ul>
						<%--<ul id="browser" class="filetree">
							<li>
								<span class="file" onclick="loadAllCustomer()">所有企业</span>
							</li>
							<c:forEach items="${customerCategoryList}" var="customerCategory">
							<li state="closed" id="customerCategoryLi${customerCategory.id}">
								<span class="folder public" >${customerCategory.name}<input type="hidden" value="${customerCategory.id}" /></span>
								<ul id="customerLabelUl${customerCategory.id}">
									<c:forEach items="${customerLabelList}" var="customerLabel">
										<c:if test="${customerLabel.categoryId eq customerCategory.id}">
											<li class="public">${customerLabel.name}<input type="hidden" value="${customerLabel.id}" /></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
							</c:forEach>
							<li state="closed" id="myCustomerCategoryLi">
								<span class="folder public" >我的分组</span>
								<ul id="customerLabelUl0">
									<c:forEach items="${myLabelList}" var="customerLabel">
										<c:if test="${customerLabel.categoryId eq customerCategory.id}">
											<li>${customerLabel.name}<input type="hidden" value="${customerLabel.id}" /></li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
						</ul>
					--%></div>
				</div>
			</td>
			<td width="100%" valign="top">
				<div class="pm_msglist" id="msglist">
					<div class="titlebg">企业列表</div>
					<div class="searchdivkf">
						<form id="form1" name="form1" method="post" action="">
						<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="65">企业名称： </td>
								<td width="105">
									<table width="100%" border="0" cellspacing="2" cellpadding="0">
										<tr>
											<td width="180">
												<search:input id="name" dataType="string" field="name" op="cn"/>
											</td>
						  				</tr>
									</table>
								</td>
								<td width="70" align="right">企业类型：</td>
								<td width="105">
									<search:choose id="name" dataType="com.wiiy.crm.preferences.enums.CustomerTypeEnum" field="type" op="eq" >
									<enum:select styleClass="data" name="type" checked="sessionScope.Park_type" type="com.wiiy.crm.preferences.enums.CustomerTypeEnum"/>
									</search:choose>
								</td>
								<td width="70" align="right">孵化状态：</td>
								<td width="105">
									<search:choose id="routeId"  dataType="string" field="incubationInfoStatusRoute.id" op="eq" >
										<dd:select key="crm.0025" styleClass="data"/>
									</search:choose>
								</td>
								<td width="75" align="center"><label><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map"/></label></td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						</table>
						</form>
					</div>
					<div style="overflow: auto;">
						<table id="list" class="jqGridList"><tr><td/></tr></table>
						<div id="pager"></div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
<map name="Map" id="Map">
	<area shape="rect" coords="2,1,51,20" href="javascript:void(0)" onclick="doSearch()"/>
	<area shape="rect" coords="55,1,74,20" href="javascript:void(0)" onclick="fbSearch('高级搜索','<%=basePath %>web/client/customer_search.jsp',550,400);" />
</map>
</body>
</html>