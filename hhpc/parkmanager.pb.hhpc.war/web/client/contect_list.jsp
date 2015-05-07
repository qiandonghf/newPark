<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
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
	$(document).ready(function() {
		initTip();
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-105;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>contect!list.action',
			colModel: [
				{label:'企业', name:'customer.name', align:"center",width:218}, 
				{label:'姓名', name:'name', align:"center",width:80}, 
			    {label:'职位', name:'position', align:"center"},
			    {label:'手机', name:'mobile', align:"center",width:100}, 
			    {label:'固定电话', name:'phone', align:"center",width:120},
			    {label:'是否主要联系人', name:'main.title', align:"center",width:100},
			    {label:'Email', name:'email', align:"center", hidden:true},
			    {label:'电话', name:'phone', align:"center", hidden:true},
			    {label:'MSN', name:'msn', align:"center", hidden:true},
			    {label:'QQ', name:'qq', align:"center", hidden:true},
			    {label:'传真', name:'fax', align:"center", hidden:true},
			    {label:'邮编', name:'zipcode', align:"center", hidden:true},
			    {label:'家庭地址', name:'homeAddr', align:"center", hidden:true},
			    {label:'家庭电话', name:'homePhone', align:"center", hidden:true},
			    {label:'生日', name:'birthDay', align:"center", hidden:true,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}},
			    {label:'爱好', name:'favorite', align:"center", hidden:true},
			    {label:'管理', name:'manager', align:"center", width:70 ,resizable:false,sortable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_view")){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					<%}%>
					<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_delete")){%>
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
	function viewById(id){
		fbStart('查看联系人','<%=basePath %>contect!view.action?id='+id,550,370);
	}
	function editById(id){
		fbStart('编辑联系人','<%=basePath %>contect!edit.action?id='+id,550,370);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>contect!delete.action?id="+id,function(data){
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
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>contect!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function tab(title,url){
		if (parent.$('#tt').tabs('exists',title)){
			parent.$('#tt').tabs('select', title);
		} else {
			parent.$('#tt').tabs('add',{
				title:title,
				content: '<iframe src="'+url+'" frameborder="0" height="'+document.documentElement.clientHeight+'" width="100%"></iframe>',
				closable:true
			});
		}
	}
	
	function toImportCard() {
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(confirm("确定要导入名片夹（客户-联系人）吗")){
			showTip("正在导入名片，请稍候...",100000);
			$.post('<%=basePath %>contect!importCard.action?ids='+ids,
				function(data){
					showTip(data.result.msg,2000);
				}
			);
		 }
	 }
</script>

</head>
<body>
<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_add")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建联系人','<%=basePath %>web/client/contect_add.jsp',550,370);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_delete")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contect_importCard")){ %>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="toImportCard()"><span><img src="core/common/images/card.png"/></span>导入名片</li>
		<%} %>
			<%--
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="tab('发送短信','parkmanager.oa/sms!smsPage.action')"><span><img src="core/common/images/phone.gif"/></span>短信</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="tab('发送邮件','parkmanager.oa/sms!smsPage.action')"><span><img src="core/common/images/emailhf.gif"/></span>邮件</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"><span><img src="core/common/images/print_16x16.gif" width="16" height="16" /></span>打印</li>
			--%>
		</ul>
	</div>
</div>
<div class="searchdiv">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="70">企业名称： </td>
			<td width="180"><search:input dataType="string" field="customer.name" op="cn" inputClass="inputauto"/></td>
			<td width="50" align="right">姓名：</td>
			<td width="105"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
			<td width="85" align="right">主要联系人：</td>
			<td width="105"><search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="main" op="eq"><enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></search:choose></td>
			<td width="75" align="center"><label><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map" /></label></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
    </table>
</div>
<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
</div>
<map name="Map" id="Map">
	<area shape="rect" coords="2,0,52,20" href="javascript:void(0)" onclick="doSearch()"/>
	<area shape="rect" coords="55,0,74,20" href="javascript:void(0)" onclick="fbSearch('高级搜索','<%=basePath %>web/client/contect_search.jsp',550,400);"/>
</map>
</body>
</html>