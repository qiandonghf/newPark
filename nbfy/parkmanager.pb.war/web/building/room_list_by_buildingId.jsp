<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initList("list");
});

function initList(list){
	var height = getTabContentHeight()-136;
	var width = window.parent.parent.document.documentElement.clientWidth-(window.parent.screenLeft-window.parent.parent.screenLeft)-190;
	$("#"+list).jqGrid({
    	url:'<%=basePath%>room!list.action?id=${result.value.id}',
		colModel: [
			{label:'状态',width:40, name:'status.title',index:'status',align:"center"}, 
			{label:'房间',width:80, name:'name',align:"center"}, 
			{label:'性质',width:40, name:'kind.dataValue',index:'kind',align:"center"}, 
			{label:'楼层', name:'floor.name',align:"center"}, 
			{label:'建筑面积',width:80,name:'buildingArea',align:"center"}, 
			{label:'预定公司',width:80,name:'reserveCompanyName',align:"center"}, 
			{label:'企业名称', name:'customerName',align:"center"}, 
			{label:'优惠起始时间',width:80, name:'discountBeginTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center", hidden:true},
			{label:'租金起', name:'rentStart', align:"center", hidden:true},
			{label:'租金止', name:'rentEnd', align:"center", hidden:true},
			{label:'优惠率', name:'discountRate', align:"center", hidden:true},
			{label:'水电押金', name:'electricityDeposit', align:"center", hidden:true},
			{label:'租凭押金', name:'rentDeposit', align:"center", hidden:true},
			{label:'实用面积', name:'realArea', align:"center", hidden:true},
			{label:'显示顺序', name:'displayOrder', align:"center", hidden:true},
			{label:'房间价格', name:'rentPrice', align:"center", hidden:true},
			{label:'计费方式', name:'chargingType.title', align:"center", hidden:true},
			{label:'位置', name:'location', align:"center", hidden:true},
		    {label:'管理', name:'manager', align:"center", sortable:false, resizable:false,width:70}
		    
		],
		height: height,
		width: width,
		shrinkToFit: false,
		gridComplete: function(){
			var ids = $(this).jqGrid('getDataIDs');
			for(var i = 0 ; i < ids.length; i++){
				var id = ids[i];
				var content = "";
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_view")){ %>	
				content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_edit")){ %>
				content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
				<%}%>
				<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_delete")){ %>
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
function reloadRoomList(){
	$("#list").trigger("reloadGrid");
}
function viewById(id){
	$.post("<%=basePath%>room!roomViewTitleById.action?id="+id,function(data){
		var title = data.name;
		fbStart(title,'<%=basePath%>room!info.action?id='+id,800,521);
	});
}
function editById(id){
	fbStart('编辑房间信息','<%=basePath%>room!edit.action?id='+id,700,463);
}
function deleteById(id){
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>room!delete.action?id="+id,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
function deleteByIds(){
	var selectedRowIds =   
	$("#list").jqGrid("getGridParam","selarrrow"); 
	if(confirm("您确定要删除")){
		$.post("<%=basePath%>room!delete.action?ids="+selectedRowIds,function(data){
			showTip(data.result.msg,1000);
			$("#list").trigger("reloadGrid");
		});
	}
}
</script>
</head>
<body>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="titlebg">房间信息</div>
				<div class="apptab" id="tableid">
					<ul>
					<li class="apptabli"><a href="<%=basePath%>building!view.action?id=${result.value.id}">基本信息</a></li>
					<li class="apptabli" ><a href="<%=basePath%>floor!floorView.action?id=${result.value.id}">楼层视图</a></li>
					<li class="apptabliover" ><a href="<%=basePath%>room!listByBuildingId.action?id=${result.value.id}">房间信息</a></li>
					</ul>
				</div>
				<div class="pm_msglist" style="display:block;" id="textname">
					<div class="emailtop">
						<div class="leftemail">
							<ul>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_add")){ %>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建房间','<%=basePath%>room!add.action?id=${result.value.id }',700,463);"><span><img src="core/common/images/emailadd.gif" width="15" height="13" /></span>新建</li>
							<%} %>
							<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_room_delete")){ %>
								<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
							<%} %>
							</ul>
						</div>
					</div>
					<table id="list" class="jqGridList"><tr><td/></tr></table>
					<div id="pager"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
