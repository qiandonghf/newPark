<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<script type="text/javascript" charset="utf-8"> 
	//alert(tablew);
	$(document).ready(function() {
		initTip();
		initList();
	} );
	
	function initList(){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>notice!list.action',
			colModel: [
				{label:'ID', name:'id', align:"center",hidden:true}, 
				{label:'公告标题', name:'name', align:"center",width:250}, 
				{label:'发布者', name:'issuer', align:"center",width:165}, 
				{label:'发布时间', name:'issueTime',index:'issueTime', align:"center",width:256,formatter:'date',formatoptions:{srcformat: 'Y-m-d', newformat: 'Y-m-d'}}, 
			    {label:'状态', name:'state.title',index:'state', align:"center",width:132},
			    {label:'管理', name:'operation', align:"center", resizable:false,sortable:false,width:78}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			subGrid: true, // (1)开启子表格支持
			subGridRowExpanded: function(subgrid_id, row_id) {// (2)子表格容器的id和需要展开子表格的行id，将传入此事件函数  
				var subgrid_table_id;  
	            subgrid_table_id = subgrid_id + "_t";   // (3)根据subgrid_id定义对应的子表格的table的id  
	              
	            var subgrid_pager_id;  
	            subgrid_pager_id = subgrid_id + "_pgr";  // (4)根据subgrid_id定义对应的子表格的pager的id  
	            // (5)动态添加子报表的table和pager  
	            $("#" + subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+subgrid_pager_id+"' class='scroll'></div>");  
	              
	            // (6)创建jqGrid对象  
	            $("#" + subgrid_table_id).jqGrid({  
	            	url:'<%=basePath%>noticeAtt!list.action',
	    			colModel: [
	    				{label:'附件名称', name:'name',width:"300", align:"center",formatter:attUrl}, 
	    				{label:'大小', name:'size',width:"90", align:"center",formatter:fmtSize}, 
	    			    {label:'操作', name:'manager2', align:"center", width:"50",resizable:false,formatter:downAtt}
	    			],
	    			postData:{filters:generateSearchFilters('noticeId','eq',row_id,'long')},
	    			multiselect: false,
	    			pager:'',
	    			height: "100%",
	            });
			},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var src = '<%=basePath%>notice!view.action?id='+id;
					var content = "";
					<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_notice_view")){%>
					content += "<a target=\"_blank\" href=\""+src+"\"><img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\"/></a>"; 
					<%}%>
					<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_notice_edit")){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					<%}%>
					<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_notice_delete")){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%}%>
					$(this).jqGrid('setRowData',id,{operation:content});
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
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>notice!delete.action?ids="+ids,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	function attUrl(cellvalue, options, rowObject){
		var path = rowObject["newName"];
		var data = "<a href=\"core/resources/"+path+"?name="+cellvalue+"\" style=\"text-decoration: none;\">"+cellvalue+"</a>";
		return data;
	}
	
	function fmtSize(cellvalue, options, rowObject){
		var size = "";
		if(cellvalue!=null){
			size = Math.round(cellvalue/1024*100)/100+"KB";
		}
		return size+"&nbsp";
	}
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
	function downAtt(cellvalue, options, rowObject){
		var path = rowObject["newName"];
		var name = rowObject["name"];
		var src = "<img src=\"core/common/images/down.png\" width=\"14\" height=\"14\" title=\"下载\" onclick=\"location.href='<%=BaseAction.rootLocation%>/core/resources/"+path+"?name="+name+"'\"  /> ";		
		return src;
	}
	function viewById(id){
		window.open('<%=basePath%>notice!view.action?id='+id,window);
	}
	function editById(id){
		fbStart('编辑公告','<%=basePath %>notice!edit.action?id='+id,510,274);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>notice!delete.action?id="+id,function(data){
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
	function doSearch(){
		search(getSearchFilters());
	}
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
</script>
</head>
 
<body >
<div class="emailtop">
	<div class="leftemail">
		<ul>
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_notice_add")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="fbStart('新建公告信息','<%=basePath%>web/information/notice_add.jsp',600,585);"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
		<%}%>
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_notice_delete")){%>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''"  onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
		<%}%>
		</ul>
	</div>
</div>
 <div class="searchdiv">
  
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="50">发布者： </td>
		<td width="150"><search:input dataType="string" field="issuer" op="cn" inputClass="inputauto"/></td>
        <td width="50" align="right">标题：</td>
        <td width="110"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
        <td width="70" style="padding-left: 10px;" align="center"><label><img src="core/common/images/search.gif" width="75" height="22" border="0" onclick="doSearch()" /></label></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
</div>
<!--//search-->
<!--container-->
<div class="msglist" id="msglist">
    <table id="list" class="jqGridList" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr><td></td></tr>
    </table>
    <div id="pager"></div>
</div>
<!--//container-->
</body>
</html>