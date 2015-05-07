<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
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

<script type="text/javascript">
	$(document).ready(function() {
		$("#browser").tree({
			animate: true,
			lines: true,
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					loadCustomerByLabelId($(node.target).find("input").val());
				}
			}
		});
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
		$("#list").setGridParam({url:'<%=basePath%>customer!simpleList.action?labelId='+labelId}).trigger('reloadGrid');
	}
	function loadAllCustomer(){
		$("#list").setGridParam({url:'<%=basePath%>customer!simpleList.action'}).trigger('reloadGrid');
	}
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function initList(){
		$("#list").jqGrid({
	    	url:'<%=basePath%>customer!simpleList.action',
			datatype: 'json',
			mtype: 'POST',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'&nbsp;', sortable: false, width:20, name:'MY_ID', index:'MY_ID', align:"center"},
				{label:'ID', name:'id', index:'id', align:"center", hidden:true},
				{label:'企业名称', name:'name', index:'name', align:"center"}
			],
			height: 236,
			rowNum: 10,//设置表格中显示的记录数如果服务器返回记录数大于此值则只显示rowNum条 -1不检查此项
			autowidth: true,//宽度自动
			multiselect: false,//是否可以多选
			viewrecords: true,//是否显示总记录数
			recordtext: "共 {2} 条",
			rownumbers: true,//显示行顺序号，从1开始递增。此列名为'rn'
			loadui: 'block',//当执行ajax请求时 启用Loading提示，但是阻止其他操作
			pager: '#pager',//指定分页栏对象
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
                    var radioId = "<input id='"+id+"' type='radio' name='myname' value='" + id + "'  />";
					$(this).jqGrid('setRowData',id,{MY_ID:radioId});
				}
			},
			onSelectRow: function(id) {
                $($(this)).find("input[value="+id+"]").prop('checked',true);
            },
			gridview: true
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
	}
	function submitSelected() {
		try{
			if(typeof(getOpener().eval("setSelectedCustomer")) == "function"){
				var ids = $("#list").jqGrid("getDataIDs");
				$(ids).each(function (index, id) {
					if ($("#list").find('#'+id+' input').prop('checked')) {
						var rowData = $("#list").jqGrid("getRowData", id);
						getOpener().setSelectedCustomer(rowData);
						return;
					}
				});
				
			}
		} catch(e){}
		try{
			if(typeof(getOpener().eval("setSelectedCustomers")) == "function"){
				var array = new Array();
				var selectIds = $("#list").getGridParam("selarrrow");
				for(var i = 0 ; i < selectIds.length; i++){
					array[i] = $("#list").getRowData(selectIds[i]);
				}
				getOpener().setSelectedCustomers(array);
			}
		} catch(e){}
		fb.end();
	}
</script>
</head>

<body>
	<div class="basediv">
		<table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td valign="top">
					<div class="userleftcontact" id="resizable">
						<div class="titlebg">企业分类</div>
						<div class="treeviewdiv" style="overflow-Y:auto;height: 320px;" id="treeviewdiv">
							<ul id="browser" class="filetree">
								<li>
									<span class="file" onclick="loadAllCustomer()">所有企业</span>
								</li>
								<c:forEach items="${customerCategoryList}" var="customerCategory">
								<li state="closed" id="customerCategoryLi${customerCategory.id}">
									<span class="folder public" >${customerCategory.name}</span>
									<ul id="customerLabelUl${customerCategory.id}">
										<c:forEach items="${customerLabelList}" var="customerLabel">
											<c:if test="${customerLabel.categoryId eq customerCategory.id}">
												<li>${customerLabel.name}<input type="hidden" value="${customerLabel.id}" /></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
								</c:forEach>
								<li state="closed" id="customerCategoryLi0">
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
						</div>
					</div>
				</td>
				<td valign="top">
					<div class="userrightcontact">
						<div class="titlebg">企业列表</div>
						<div class="searchdiv">
							<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="185"><search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
									<td><input name="Submit3" type="submit" class="search_cx" value="" onclick="doSearch()"/></td>
								</tr>
							</table>
						</div>
						<table id="list" class="jqGridList"><tr><td/></tr></table>
						<div id="pager"></div>
					</div>
				</td>
			</tr>
		</table>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="submitSelected()"><span><img src="core/common/images/accept.png">确认</span></a>
		<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
	</div>
</body>
</html>
