<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ page import="com.wiiy.oa.preferences.enums.SignTypeEnum"%>
<%@ page import="com.wiiy.oa.preferences.enums.SignStatusEnum"%>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
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
	    	url:'<%=basePath%>userSign!list.action',
			colModel: [
				{label:'登记时间',width:120,name:'signTime',formatter:'date',formatoptions:{srcformat:'Y-m-d H:i',newformat:'Y-m-d H:i'},align:"center"}, 
				{label:'登记人',width:110,name:'user.realName',align:"center"}, 
				{label:'班次',width:80,name:'workClass.name', align:"center",hidden:true},
			    {label:'周几',width:70,name:'weekDay', align:"center",formatter:getWeekDay},
				{label:'考勤标识',width:80,name:'signType.title', align:"center"},
				{label:'考勤状态',width:80,name:'signStatus.title', align:"center"},
				{label:'迟到或早退分钟',width:100,name:'minute', align:"center"},
				{label:'迟到或早退原因',name:'reason', align:"center"},
			    {label:'操作',width:50, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_info_add");
					boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_info_edit");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_info_del");
					boolean view = OaActivator.getHttpSessionService().isInResourceMap("oa_info_view");
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
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	function viewById(id){
		fbStart('查看','<%=basePath%>userSign!view.action?id='+id,380,180);
	}
	function editById(id){
		fbStart('编辑签到、签退','<%=basePath%>userSign!edit.action?id='+id,400,180);
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>userSign!delete.action?id="+id,function(data){
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
	function deleteSelected(){
		if(confirm("确定要删吗")){
			var ids = $("#list").jqGrid("getGridParam","selarrrow");
			$.post("<%=basePath%>userSign!delete.action?ids="+ids,function(data){
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
	
	function getWeekDay(cellvalue,options,rowObject){
	   var time = rowObject["signTime"];
	   var year = time.substring(0,4);
	   var month = time.substring(5,7);
	   var day = time.substring(8,10);
	   var d = new Date();
	   d.setFullYear(year);
	   d.setMonth(month);
	   d.setDate(day);
	   var num = d.getDay();
	   if(num==6){
		   cellvalue = "周四";
	   }
	   if(num==0){
		   cellvalue = "周五";
	   }
	   if(num==1){
		   cellvalue = "周六";
	   }
	   if(num==2){
		   cellvalue = "周日";
	   }
	   if(num==3){
		   cellvalue = "周一";
	   }
	   if(num==4){
		   cellvalue = "周二";
	   }
	   if(num==5){
		   cellvalue = "周三";
	   }
	   return cellvalue;
	}
	
	function doSearch(){
		search(getSearchFilters());
	}
	
	function search(filters){
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
		$("#signTime1").val('');
		$("#signTime2").val(''); 
		$("#ste").val(''); 
		$("#sse").val(''); 
	}
</script>
</head>

<body >
<!--emailtop-->
			<div class="emailtop">
				<div class="leftemail">
					<ul>
						<%if(add){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('补鉴到、鉴退','<%=basePath%>userSign!add.action',400,180);"><span><img src="core/common/images/emailadd.gif"/></span>补签</li>
						<%} %>
						<%if(delete){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
						<%} %>
					</ul>
				</div>
			</div>
<!--//emailtop-->
<div class="searchdiv">
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="80" align="right">考勤标识： </td>
        <td width="50"><search:choose dataType="com.wiiy.oa.preferences.enums.SignTypeEnum" field="signType" op="eq"><enum:select id="ste" styleClass="data"  type="com.wiiy.oa.preferences.enums.SignTypeEnum"/></search:choose></td>
        <td width="65" align="right">考勤状态：</td>
        <td width="50"><search:choose dataType="com.wiiy.oa.preferences.enums.SignStatusEnum" field="signStatus" op="eq"><enum:select id="sse" styleClass="data" type="com.wiiy.oa.preferences.enums.SignStatusEnum"/></search:choose></td>
        <td width="40" align="right">员工：</td>
        <td width="80"><search:input  dataType="string" field="user.realName" op="cn" inputClass="inputauto" /></td>
        <td width="75" align="right">考勤日期：</td>
        <td width="230">
	        <table width="100%" border="0" cellspacing="0" cellpadding="10">
	          <tr>
	            <td width="90">
	            	<search:choose dataType="java.util.Date" field="signTime" op="ge">
	            		<input id="signTime1" class="data inputauto" onclick="return showCalendar('signTime1')"/>
	            	</search:choose>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('signTime1');" />
	            </td>
	            <td>--</td>
	            <td width="90">
	            	<search:choose dataType="java.util.Date" field="signTime" op="le">
	            		<input id="signTime2" class="data inputauto" onclick="return showCalendar('signTime2')"/>
	            	</search:choose>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('signTime2');" />
	            </td>
	          </tr>
	        </table>
	    </td>
        <td><input type="submit" name="button" id="button" class="searchbtn" value="" onclick="doSearch()"/></td>
      </tr>
    </table>
</div>

<!--container-->
<div class="msglist" id="msglist">
	<div id="container">
		<table id="list" class="jqGridList"><tr><td/></tr></table>
		<div id="pager"></div>
	</div>
</div>
<!--//container-->
</body>
</html>
