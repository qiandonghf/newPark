<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
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
		initTip();
		initList();
	});
	
	function initList(){
		var height = getTabContentHeight()-75;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#list").jqGrid({
	    	url:'<%=basePath%>archives!list.action?listIndex='+"${listIndex}",
			colModel: [
				{label:'档案编号', name:'serialNo',align:"center"}, 
				{label:'员工姓名',width:90,name:'name',align:"center"}, 
				{label:'性别', width:160,name:'gender.title', align:"center"},
				{label:'籍贯', width:160,name:'homeTown', align:"center"},
				{label:'出生日期', width:160,name:'birthDay',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'身份证号', width:160,name:'idNo', align:"center"},
				{label:'合同开始时间', width:160,name:'startTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'合同结束时间', width:160,name:'endTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'职务', width:110,name:'position', align:"center"},
				{label:'入职时间', width:110,name:'entryTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'电话号码', width:160,name:'phone', align:"center"},
				{label:'备注', width:160,name:'memo', align:"center"},
				
				{label:'建档人', width:90,name:'creator', align:"center",hidden:true},
				{label:'建档时间', width:100,name:'createTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center",hidden:true},
				{label:'部门或公司', width:160,name:'org.name', align:"center",hidden:true},			
 				{label:'状态', width:160,name:'status.title', align:"center",hidden:true},
				{label:'宗教信仰', width:160,name:'religious.dataValue', align:"center",hidden:true},
				{label:'政治面貌', width:160,name:'political.dataValue', align:"center",hidden:true},
				{label:'国籍', width:160,name:'nationality.dataValue', align:"center",hidden:true},
				{label:'民族', width:160,name:'ethnic.dataValue', align:"center",hidden:true},
				{label:'婚姻状况', width:160,name:'marriage.title', align:"center",hidden:true},
				{label:'开户银行', width:160,name:'bank', align:"center",hidden:true},
				{label:'银行账号', width:160,name:'bankAccount', align:"center",hidden:true},
				{label:'培训情况', width:160,name:'train', align:"center",hidden:true},
				{label:'家庭地址', width:160,name:'homeAddr', align:"center",hidden:true},
				{label:'家庭邮编', width:160,name:'zipCode', align:"center",hidden:true},
				{label:'手机号码', width:160,name:'mobile', align:"center",hidden:true},
				{label:'QQ号码', width:160,name:'qq', align:"center",hidden:true},
				{label:'电子邮箱', width:160,name:'email', align:"center",hidden:true},
				{label:'学历', width:160,name:'degree', align:"center",hidden:true},
				{label:'毕业学校', width:160,name:'school', align:"center",hidden:true},
				{label:'专业', width:160,name:'profession', align:"center",hidden:true},
				{label:'参加工作时间', width:160,name:'workTime', align:"center",hidden:true},
				{label:'教育背景', width:160,name:'education', align:"center",hidden:true},
				{label:'奖惩情况', width:160,name:'rewards', align:"center",hidden:true},
				{label:'工作经验', width:160,name:'experience', align:"center",hidden:true},
				{label:'个人爱好', width:160,name:'hobby', align:"center",hidden:true},
			    {label:'操作',width:60, name:'manager', align:"center", sortable:false, resizable:false}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			multiselect: true, 
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean addIn = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesIn_add");
					boolean editIn = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesIn_edit");
					boolean deleteIn = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesIn_del");
					boolean viewIn = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesIn_view");
					boolean exportDataIn = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesIn_view");
					boolean addOut = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesOut_add");
					boolean editOut = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesOut_edit");
					boolean deleteOut = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesOut_del");
					boolean viewOut = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesOut_view");
					boolean exportDataOut = OaActivator.getHttpSessionService().isInResourceMap("oa_archivesOut_view");
					%>
					<%if(viewIn||viewOut){%>
					content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
					<%} %>
					<%if(editIn||editOut){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
					<%if(deleteIn||deleteOut){%>
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
	function viewById(id){
		var state = "${listIndex}";
		if(state=="IN"){
			fbStart('查看档案','<%=basePath%>archives!view.action?id='+id,710,483);
		}else{
			fbStart('查看档案','<%=basePath%>archives!viewOut.action?id='+id,710,483);
		}
	}
	function editById(id){
		var state = "${listIndex}";
		if(state=="IN"){
			fbStart('编辑档案','<%=basePath%>archives!edit.action?id='+id,710,483);
		}else{
			fbStart('编辑档案','<%=basePath%>archives!editOut.action?id='+id,710,483);
		}
		
	}
	
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	
	function deleteById(id){
		var state = "${listIndex}";
		if(confirm("您确定要删除")){
			if(state=="IN"){
				$.post("<%=basePath%>archives!delete.action?id="+id,function(data){
					if(data.result!=null){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("#list").trigger("reloadGrid");
			        	}
					}else{
						showTip("没有权限");
					}
				});
			}else{
				$.post("<%=basePath%>archives!deleteOut.action?id="+id,function(data){
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
	}
	
	function deleteSelected(){
		var state = "${listIndex}";
		if(confirm("确定要删吗")){
			if(state=="IN"){
				var ids = $("#list").jqGrid("getGridParam","selarrrow");
				$.post("<%=basePath%>archives!delete.action?ids="+ids,function(data){
					if(data.result!=null){
						showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("#list").trigger("reloadGrid");
			        	}
					}else{
						showTip("没有权限");
					}
				});
			}else{
				var ids = $("#list").jqGrid("getGridParam","selarrrow");
				$.post("<%=basePath%>archives!deleteOut.action?ids="+ids,function(data){
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
	}
	
	function exportDate(){
		var columns = "{";
		$.each($("#list").getGridParam("colModel"),function(){
			if(this.label && this.name!="manager" && this.hidden !=true){
				columns += "\"" + this.name + "\"" + ":" + "\"" + this.label + "\",";
			}
		});
		columns = deleteLastCharWhenMatching(columns,",");
		columns += "}";
		$("#columns").val(columns);
		$("#exportForm").submit();
	}
	function newArchives(){
		var state = "${listIndex}";
		if(state=="IN"){
			fbStart('新建档案','<%=basePath%>archives!add.action',710,485);
		}else{
			fbStart('新建档案','<%=basePath%>archives!addOut.action',710,485);
		}
	}
</script>

</head>

<body >
<form action="<%=basePath%>archives!export.action?listIndex=${listIndex}" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
</form>
<!--emailtop-->
			<div class="emailtop">
				<div class="leftemail">
					<ul>
						<%if(addIn||addOut){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="newArchives();"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
						<%} %>
						<%if(deleteIn||deleteOut){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteSelected()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
						<%} %>
						<%if(exportDataIn||exportDataOut){%>
						<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
						<%} %>
					</ul>
				</div>
			</div>
<!--//emailtop-->
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
