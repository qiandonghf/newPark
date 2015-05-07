<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	var typeMenu = [[{
	    text: "添加固定资产",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('新建固定资产','<%=basePath%>fixedAssets!addFixedAssets.action?typeId='+$(this).find('input').first().val(),530,386);
	    }
	}]];
	var fixedAssetsMenu = [[{
	    text: "编辑",
		classname: "smarty_menu_ico0",
	    func: function() {
			fbStart('编辑固定资产','<%=basePath%>fixedAssets!edit.action?id='+$(this).find('input').val(),530,386);		
	    }
	},{
	    text: "删除",
		classname: "smarty_menu_ico0",
	    func: function() {
			if(confirm("您确定要删除")){
			$.post("<%=basePath%>fixedAssets!delete.action?id="+$(this).find('input').val(),function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadList();
	        		}
				});
			}
	    }
	}]];
	$(document).ready(function() {
		initTip();
		initList();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight());
		$("#msglist").css("height",getTabContentHeight()-28);
		$("#treeviewdiv").css("height",getTabContentHeight()-90);				
		$("#browser").tree({
			animate: true,
			lines: true,
			onClick: function(node){
				if($(this).tree("isLeaf",node.target)){
					var id = $(node.target).find("input").val();
					$("#list").setGridParam({url:'<%=basePath%>fixedAssets!loadTreeById.action?id='+id,postData:{filters:''}}).trigger('reloadGrid');
				}
			},
			onLoadSuccess: function(node, data){
				var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];					
					$(node.target).find(".tree-title").click(function(node){
						var assetsTypeid = $(this.parentNode).attr("node-id");						
						$("#list").setGridParam({url:'<%=basePath%>fixedAssets!loadTreeByTypeId.action?typeId='+assetsTypeid,postData:{filters:''}}).trigger('reloadGrid');
						$("#typeId").val(assetsTypeid);
					});									
					if(!$(this).tree("isLeaf",node.target)){
						$(node.target).find(".tree-title").smartMenu(typeMenu,{name:'typeMenu'});
						var children = $(this).tree("getChildren",node.target);
						for( var j = 0; j < children.length; j++){
							var child = children[j];							
							$(child.target).find(".tree-title").smartMenu(fixedAssetsMenu,{name:'fixedAssetsMenu'});
						}
					}
				}
			}
		});
		$(".folder").smartMenu(typeMenu,{name:'typeMenu'});	
	});
	function initList(){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-185;
		$("#list").jqGrid({
	    	url:'<%=basePath%>fixedAssets!list.action',
	    	colModel: [
	   				{label:'资产编号',width:70, name:'id',align:"center"}, 
	   				{label:'资产名称',name:'name',align:"center"}, 
	   				{label:'资产类别',width:70,name:'type.dataValue',align:"center"}, 
	   				{label:'置办日期',width:110, name:'dealDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
	   				{label:'折旧类型',width:110, name:'depreciation.title',align:"center",hidden:true}, 
	   				{label:'开始折旧日期',width:110,name:'startDate',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center",hidden:true}, 
	   				{label:'原资产值',width:135, name:'originalValue',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center",hidden:true}, 
	   				{label:'现资 产值',width:135,name:'newValue',formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: " ", decimalPlaces: 2, defaulValue: 0}, align:"center" ,hidden:true},			
	   				{label:'所属部门',name:'org.name',align:"center",hidden:true}, 
	   				{label:'规格型号',name:'spec',align:"center",hidden:true}, 
	   				{label:'厂商',name:'factory',align:"center",hidden:true}, 
	   				{label:'采购日期',name:'buyDate',align:"center",hidden:true,formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'},align:"center"}, 
	   				{label:'备注',name:'memo',align:"center",hidden:true},
	   			    {label:'管理',width:70, name:'manager', align:"center", sortable:false, resizable:false}
	   			    
	   			],
	   			height: height,
	   			width: width,
	   			shrinkToFit: false,
	   			multiselect: true,
	   			gridComplete: function(){
	   				var ids = $(this).jqGrid('getDataIDs');
	   				for(var i = 0 ; i < ids.length; i++){
	   					var id = ids[i];
	   					var content = "";
	   					/* content += "<img src=\"core/common/images/converted.png\" width=\"14\" height=\"14\" title=\"固定资产折算\" onclick=\"convertById('"+id+"');\"  /> ";
	   					 */content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> ";
	   					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
	   					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
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
		$("#exportForm").submit();
	}
	function convertById(id){
		if(confirm("您确定要进行资产折算？")){			
			$.post("<%=basePath%>fixedAssets!convert.action?id="+id,function(data){				
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		reloadList();
	        	}
			});
		}		
	}
	function viewById(id){
		fbStart('查看固定资产信息','<%=basePath%>fixedAssets!view.action?id='+id,590,370);
	}
	function editById(id){
		fbStart('编辑固定资产信息','<%=basePath%>fixedAssets!edit.action?id='+id,590,386);
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>fixedAssets!delete.action?id="+id,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		reloadList();
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
			$.post("<%=basePath%>fixedAssets!delete.action?ids="+ids,function(data){
				if(data.result!=null){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		reloadList();
		        	}
				}else{
					showTip("没有权限");
				}
			});
		}
	}

	function reloadList(){
		$("#list").trigger("reloadGrid");
		//setTimeout("location.reload()", 1000);
	}
		
	function expandAllNode() {	
		$("#browser").tree("expandAll");
	}
	
	function collapseAllNode() {			
		$("#browser").tree("collapseAll");
	}
</script>
<style type="text/css">
	.refresh{
		overflow:hidden;
	}
	.refresh a{
		display:inline-block;
	}
	.refresh span{
		display:block;
		float:left;
	}
	.re1{
		margin-top:4px;
	}
</style>
</head>

<body>
<form action="<%=basePath%>fixedAssets!export.action?type=1" id="exportForm" method="post">
	<input type="hidden" id="columns" name="columns"/>
	<input type="hidden" id="filters" name="filters"/>
	<input type="hidden" id="typeId" name="typeId"/>
</form>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="182" valign="top">
                <div class="agency" id="resizable">
                    <!--titlebg-->
                    <div class="titlebg">资产类别</div>
                    <!--//titlebg-->
                    <!--agencybtn-->
                    <div class="agencybtn">
                        <ul>
                            <li class="refresh"><a href="<%=basePath%>fixedAssets!fixedAssetsTree.action"><span class="re1"><img src="core/common/images/refresh3.png" /></span><span>刷新</span></a></li>
                            <li><a href="javascript:expandAllNode()"><span class="ico2"></span>展开</a></li>
                            <li><a href="javascript:collapseAllNode()"><span class="ico3"></span>收起</a></li>
                        </ul>
                    </div>
                    <!--//agencybtn-->
                    <!--agencylist-->
                    <div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						 <ul id="browser" >
							<c:forEach items="${typeList}" var="type">
								<li state="closed" id="${type.id}">
									<span class="folder">${type.dataValue}<input type="hidden" value="${type.id}" /></span>
									<ul id="typeUl${type.id}">
										<c:forEach items="${fixedAssetsList}" var="fixedAssets">
											<c:if test="${fixedAssets.typeId eq type.id}">
												<li class="public">${fixedAssets.name}<input type="hidden" value="${fixedAssets.id}" /></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:forEach>
						 </ul>
			        </div>
                    <!--//agencylist-->
                </div>
            </td>
			<td width="100%" valign="top">
				<div class="pm_msglist" id="msglist">
					<div class="titlebg">固定资产列表</div>
						<div class="emailtop">
							<div class="leftemail">
								<ul>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建固定资产','<%=basePath%>fixedAssets!addFixedAssets.action',590,386);"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="deleteByIds()"><span><img src="core/common/images/emaildel.png"/></span>删除</li>
									<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="exportDate()"><span><img src="core/common/images/database_(start)_16x16.gif" width="16" height="16" /></span>导出</li>
								</ul>
							</div>
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

</body>
</html>