<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base
	href="<%=BaseAction.rootLocation%>/" />
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
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		initList();
	});
	function initList(){
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>meeting!list.action',
			colModel: [
				{label:'会议主题', name:'title',width:"300", align:"center"}, 
				{label:'会议类型', name:'meetingType.dataValue',width:"85", align:"center"}, 
			    {label:'会议时间', name:'meetingTime',width:"85", align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}},
				{label:'上传人', name:'creator',align:"center"}, 
				/* {label:'附件', name:'title',width:"90", align:"center",formatter:subGridRowExpand},  */
				{label:'备注', name:'content',width:"90", align:"center"}, 
			    {label:'操作', name:'manager', align:"center", width:"50",resizable:false}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			multiselect: true,
			pager:'#pager',
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
	            	url:'<%=basePath%>meetingAtt!list.action',
	    			colModel: [
	    				{label:'附件名称', name:'name',width:"300", align:"center",formatter:attUrl}, 
	    				{label:'大小', name:'size',width:"90", align:"center",formatter:fmtSize}, 
	    			    {label:'操作', name:'manager2', align:"center", width:"50",resizable:false,formatter:downAtt}
	    			],
	    			postData:{filters:generateSearchFilters('meetingId','eq',row_id,'long')},
	    			multiselect: false,
	    			pager:'',
	    			height: "100%",
	            });
			},
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_summary_add");
					boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_summary_edit");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_summary_del");
					boolean view = OaActivator.getHttpSessionService().isInResourceMap("oa_summary_view");
					%>
					<%if(view){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";  
					<%} %>
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
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
	
	/* function subGridRowExpand(cellvalue, options, rowObject){
		
		return "点此展开附件";
	} */
	
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
		var src = "<img src=\"core/common/images/down.png\" width=\"14\" height=\"14\" title=\"下载\" onclick=\"downLoad('"+path+"','"+name+"')\"  /> ";			
		return src;
	}
	function viewById(id){
		fbStart('查看会议纪要','<%=basePath%>meeting!view.action?id='+id,510,216);
	}
	function editById(id){
		fbStart('编辑会议纪要','<%=basePath %>meeting!edit.action?id='+id,510,274);
	}
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>meeting!delete.action?id="+id,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				}else{
					showTip("没有权限");
				}
			});
		}
	}
	
	function deleteByIds(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>meeting!delete.action?ids="+ids,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("#list").trigger("reloadGrid");
		        	}
				}else{
					showTip("没有权限");
				}
			});
		}
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}

</script>

</head>

<body>
	<div class="emailtop">
		<div class="leftemail">
			<ul>
				<%if(add){%>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''"
					onclick="fbStart('新建会议纪要','<%=basePath %>web/chiefadmin/meeting_add.jsp',510,274);"><span><img
						src="core/common/images/emailadd.gif" /></span>新建</li>
				<%} %>
				<%if(delete){%>
				<li onmouseover="this.className='libg'"
					onmouseout="this.className=''" onclick="deleteByIds()"><span><img
						src="core/common/images/emaildel.png" /></span>删除</li>
				<%} %>
			</ul>
		</div>
	</div>
	<div class="msglist" id="msglist">
		<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
		</div>
	</div>
</body>
</html>
