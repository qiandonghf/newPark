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
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>

<script type="text/javascript">
	$(function(){
		var investmentId = '<%=request.getParameter("investmentId")%>';
		$("#investmentId").val(investmentId);
		initList();
	});
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function initList(){
		$("#list").jqGrid({
	    	url:'<%=basePath%>investmentDirector!selectList.action?investmentId='+$("#investmentId").val(),
			datatype: 'json',
			mtype: 'POST',
			prmNames: {search: "search"},
			jsonReader: {root:"root",repeatitems: false},
			colModel: [
				{label:'&nbsp;', sortable: false, width:20, name:'MY_ID', index:'MY_ID', align:"center"},
				{label:'ID', name:'id', index:'id', align:"center", hidden:true},
				{label:'姓名', name:'name', index:'name', align:"center"},
				{label:'性别', name:'gender', index:'gender', align:"center",hidden:true},
				{label:'出生年月', name:'birthDay', index:'birthDay', align:"center",hidden:true},
				{label:'邮箱', name:'email', index:'email', align:"center",hidden:true},
				{label:'手机', name:'mobile', index:'mobile', align:"center",hidden:true},
				{label:'座机', name:'phone', index:'phone', align:"center",hidden:true},
			],
			height: 240,
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
			if(typeof(getOpener().eval("setSelectedInvestment")) == "function"){
				var ids = $("#list").jqGrid("getDataIDs");
					$(ids).each(function (index, id) {
						if ($("#list").find('#'+id+' input').prop('checked')) {
							var rowData = $("#list").jqGrid("getRowData", id);
							getOpener().setSelectedUser(rowData);
							return;
						}
					});
				}
		} catch(e){}
		try{
			if(typeof(getOpener().eval("setSelectedInvestments")) == "function"){
				var array = new Array();
				var selectIds = $("#list").getGridParam("selarrrow");
				for(var i = 0 ; i < selectIds.length; i++){
					array[i] = $("#list").getRowData(selectIds[i]);
				}
				getOpener().setSelectedUser(array);
			}
		} catch(e){}
		fb.end();
	}
</script>
</head>

<body>
<input type="hidden" id="investmentId" />
	<div class="basediv">
		<table width="100%" border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td valign="top">
					<div >
						<div class="titlebg">人员列表</div>
						<div class="searchdiv">
							<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width="185"><search:input id="name" dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
									<td>&nbsp</td>
									<td><input name="Submit3" type="submit" class="search_cx" value="" onclick="doSearch()"/></td>
								</tr>
							</table>
						</div>
						<div>
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
