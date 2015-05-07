<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
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
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-10);
		$("#msglist").css("height",getTabContentHeight()-10);
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-80;
		var dataUrl = "";
		<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){%>
			dataUrl = '<%=basePath%>propertyFix!list.action';
		<%}%>
		<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Customer)){%>
			dataUrl = '<%=basePath%>propertyFix!listByUserId.action';
		<%}%>
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-240;
		$("#list").jqGrid({
		    url:dataUrl,
			colModel: [
					{label:'报修状态', width:'70' ,name:'status.title', align:"center"}, 
					{label:'企业', width:'210' ,name:'reporter', align:"center"}, 
					{label:'报修日期',width:'85' , name:'reportTime', align:"center",formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}}, 
				    {label:'报修地点', width:'110',name:'reportAddr', align:"center"},
				    {label:'报修原因',name:'reportReason', align:"center",formatter:count},
				    {label:'是否处理', name:'finished', align:"center", hidden:true},
				    {label:'查看', width:'40' ,name:'manager', align:"center",sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
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
	
	function count(cellvalue,options,rowObject){
		   var reportReason = rowObject["reportReason"];
		   var cellvalue = reportReason;
		   if(reportReason.length > 15){
			   cellvalue = reportReason.substring(0,14)+"......";
		   }
		   return cellvalue;
	}
	
	function checkStatus(cellvalue,options,rowObject){
		var status = "";
		var cellvalue = "";
		status = rowObject["finished"];
		var fixStatus = rowObject["status"];
		
		if(status.title!='是'){
			cellvalue = "未处理";
		}else{
			cellvalue = fixStatus.title;
		}
		status = "";
		return cellvalue;
	}
	function viewById(id){
		fbStart('查看物业报修单','<%=basePath %>propertyFix!view.action?id='+id,800,460);
	}
	
	
	
</script>

</head>


<body>
<!--container-->
<div id="container">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="182" valign="top"><div class="pstextleft" id="resizable" >
        <div class="pstitles">提示</div>
        <!--agencylist-->
        <p class="pstextcolor">　　您可以通过报修请求将报修问题反映给中心，如物业报修、网络维护、空调维修等。中心将会第一时间与您取得联系，做到实时跟踪并及时解决您的报修请求。</p>
        <p class="ptop">您可以通过电话方式联系我们：</p>
        <p>物业部：<span class="psnamecolor">88776655</span></p>
        <!--//agencylist-->
      </div></td>
      <td width="100%" valign="top"><!--msglist-->
        <div class="msglist" id="msglist">
	        <div class="titlebg">报修记录</div>
		    <div id="container">
				<table id="list" class="jqGridList"><tr><td/></tr></table>
				<div id="pager"></div>
			</div>
          
         
        </div>
        <!--//msglist--></td>
    </tr>
  </table>
</div>
<!--//container-->
</body>
</html>
