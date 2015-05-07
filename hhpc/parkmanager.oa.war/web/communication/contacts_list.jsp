<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.wiiy.commons.preferences.enums.TitleEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
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
<link rel="stylesheet" type="text/css" href="parkmanager.oa/web/style/cord_icon.css"/>

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
	
	var cardCategoryMenu=[[
		<%
		Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
		boolean flag = false;
		if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_reName")){
			flag = true;
		%>
 		{text:"重命名",
			classname:"smarty_menu_ico1",
			func:function(){
				fbStart('重命名','<%=basePath%>cardCategory!edit.action?id='+$(this.parentNode).attr("node-id"),300,80);
			}
		}
 		<%}%>
 		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_delCategory")){
			if(flag){
		%>
		   ,
		<%}
			flag = true;
		%> 
 		{text:"删除",
		classname:"smarty_menu_ico2",
			func:function(){
				if(confirm("您确定要删除")){
					$.post("<%=basePath%>cardCategory!delete.action?id="+$(this.parentNode).attr("node-id"),function(data){
						showTip(data.result.msg,2000);
						if(data.result.success){
							refreshTree();
							setTimeout("reloadList();");
					}});
				}
			}
		}
 		<%}%>
 	],[
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_addCardCategoryByParentId")){%>
	 	   {text:"添加名片夹",
			classname:"smarty_menu_ico0",
			func:function(){
				fbStart('添加名片夹','<%=basePath%>cardCategory!addCardCategoryByParentId.action?id='+$(this.parentNode).attr("node-id"),300,80);
			}
		}
		<%}%>
 	  ]];
	var cardMenu=[[
		<%
			flag = false;
			if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_reName")){
				flag = true;
		%>
		{text:"重命名",
		classname:"smarty_menu_ico1",
			func:function(){
				fbStart('重命名','<%=basePath%>cardCategory!edit.action?id='+$(this.parentNode).attr("node-id"),300,80);
			}
		}
		<%}%>
 		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_delCategory")){
			if(flag){
		%>
		   ,
		<%}
			flag = true;
		%> 
		{text:"删除",
		classname:"smarty_menu_ico2",
			func:function(){
				if(confirm("您确定要删除")){
					$.post("<%=basePath%>cardCategory!delete.action?id="+$(this.parentNode).attr("node-id"),function(data){
						showTip(data.result.msg,1000);
						refreshTree();
						setTimeout("reloadList();");
					});
				}
			}
		}
		<%}%>
	]];
	
	

	var myCardCategoryMenu=[[
					<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_addCardCategoryByParentId")){%>
	                         {text:"添加名片夹",
	                    		classname:"smarty_menu_ico0",
	                    		func:function(){
	                    			fbStart('添加名片夹','<%=basePath%>cardCategory!addCardCategoryByParentId.action?id='+$(this.parentNode).attr("node-id"),300,80);
	                    		}
	                    	}
	                  <%}%>
	                       ]];

	$(document).ready(function() {
		initTip();
		//$("#resizable").resizable();
		$("#resizable").css("height",getTabContentHeight()-28);
		$("#msglist").css("height",getTabContentHeight()-28);
		$("#treeviewdiv").css("height",getTabContentHeight()-82);
		refreshTree();
		initList();
		jqGridResizeRegister("list");
	});
	
	function refreshTree(){
		$.ajax({
		  "url" : "<%=basePath%>card!cmCard.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				animate: true,
				lines:true,
				"data" : data.cardCategoryList
			}); 
				var nodes = $("#tt").tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					if(node.text=='我的名片夹'){
						$(node.target).find(".tree-title").smartMenu(myCardCategoryMenu,{name:'myCardCategoryMenu'});
					}else{
						<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){%>
							$(node.target).find(".tree-title").smartMenu(cardCategoryMenu,{name:'cardCategoryMenu'});
						<%}%>
					}
					var children = $(this).tree("getChildren",node.target);
					for( var j = 0; j < children.length; j++){
						var child = children[j];
						if(node.text=='我的名片夹'){
							$(child.target).find(".tree-title").smartMenu(cardMenu,{name:'cardMenu'});
						}else{
							<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){%>
								$(child.target).find(".tree-title").smartMenu(cardMenu,{name:'cardMenu'});
							<%}%>
						}
						$(child.target).find(".tree-title").click(function(node){
							var ids = $(this.parentNode).attr("node-id");
							loadCardByCategoryId(ids);
						});
					}
				}
		  }
		});
	}
	
	function loadCardByCategoryId(categoryId){
		if(categoryId ==null){
			$("#list").setGridParam({url:'<%=basePath%>card!loadCard.action',postData:{filters:''}}).trigger('reloadGrid'); 
		}
		else
			$("#list").setGridParam({url:'<%=basePath%>card!loadCardByCategoryId.action?id='+categoryId,postData:{filters:''}}).trigger('reloadGrid');
	}
	
	function initList(){
		var height = getTabContentHeight()-160;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft)-190;
		$("#list").jqGrid({
	    	url:'<%=basePath%>card!loadMyCard.action',
			colModel: [
					{label:'姓名',width:'80' , name:'name', align:"center"}, 
					{label:'手机', width:'90' ,name:'mobile', align:"center"}, 
					{label:'公司电话',width:'105' , name:'officeTel', align:"center"}, 
				    {label:'传真', width:'100',name:'fax', align:"center"}, 
				    {label:'QQ', width:'100' ,name:'qq', align:"center"},
				    {label:'分组', name:'category.parent.name', align:"center"},
				    {label:'名片夹', width:'110' ,name:'category.name', align:"center"},
				    {label:'公司名称', name:'company', align:"center", hidden:true},
				    {label:'性别', name:'gender', align:"center", hidden:true},
				    {label:'家庭电话', name:'homeTel', align:"center", hidden:true},
				    {label:'职位', name:'position', align:"center", hidden:true},
				    {label:'MSN', name:'msn', align:"center", hidden:true},
				    {label:'网址', name:'homepage', align:"center", hidden:true},
				    {label:'邮编', name:'zipcode', align:"center", hidden:true},
				    {label:'分类外键', name:'categoryId', align:"center", hidden:true},
				    {label:'名片性质', name:'typeEnum', align:"center", hidden:true},
				    {label:'标签拥有者ID', name:'ownerId', align:"center", hidden:true},
				    {label:'拥有类型', name:'ownerEnum.title', align:"center", hidden:true},
				    {label:'分类名称', name:'category.name', align:"center", hidden:true},
				    {label:'管理', width:'70' ,name:'manager', align:"center",sortable:false, resizable:false}
			],
			height: height,
			width: width,
			shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var content = "";
					<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_viewCard")){%>
						content += "<img src=\"core/common/images/viewbtn.gif\" width=\"14\" height=\"14\" title=\"查看\" onclick=\"viewById('"+id+"');\"  /> "; 
					<%}%>
					<%if(OaActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
						<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_editCard")){%>
							content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> "; 
						<%}%>
						<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_delCard")){%>
							content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
						<%}%>
					<%}%>
					<%if(!OaActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
					if($(this).getCell(id,19)=='私有'){
						<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_editCard")){%>
						content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
						<%}%>
						<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_delCard")){%>
						content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
						<%}%>
					}
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
		fbStart($("#list").getRowData(id).name,'<%=basePath %>card!view.action?id='+id,500,340);
	}
	function editById(id){
		fbStart('编辑名片','<%=basePath %>card!edit.action?id='+id,500,340);
	}
	
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function deleteById(id){
		if(confirm("确定要删吗")){
			$.post("<%=basePath%>card!delete.action?id="+id,function(data){
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
	function doSearch(){
		var filters = getSearchFilters();
		$("#filters").val(filters);
		search(filters);
	}
	function search(filters){
		$("#filters").val(filters);
		$("#list").jqGrid('setGridParam',{page:1,postData:{filters:filters}}).trigger('reloadGrid');
	}
	function deleteSelected(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids!='' && confirm("确定要删吗")){
			$.post("<%=basePath%>card!delete.action?ids="+ids,function(data){
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
	function copy(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==''){
			showTip('请选择名片',2000);
		}
		if(ids!=''){
			fbStart('复制到','<%=basePath %>web/communication/contact_copy.jsp?ids='+ids,400,320);
		}
		
	}
	function move(){
		var ids = $("#list").jqGrid("getGridParam","selarrrow");
		if(ids==''){
			showTip('请选择名片',2000);
		}
		if(ids!=''){
			fbStart('移动到','<%=basePath %>web/communication/contact_move.jsp?ids='+ids,400,320);
		}
	
	}
	
</script>

</head>
<body>
<div class="emailtop">
	<div class="leftemail">
		<ul>
			<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_addNewCard")){%>
				<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建名片','<%=basePath %>web/communication/contact_addNewCard.jsp',500,340);"><span><img src="core/common/images/emailadd.gif" /></span>新建名片</li>
			<%} %>				
		</ul>
	</div>
</div>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="182" valign="top" id="leftTd">
				<div class="agency" id="resizable" >
					<div class="titlebg">名片夹分组</div>
					<%if(BooleanEnum.YES.equals(OaActivator.getSessionUser(request).getAdmin())){ %>
					<div class="agencybtn">
						<ul>
							<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_addGroup")){%>
								<li><a href="javascript:void(0)" onclick="fbStart('添加名片夹','<%=basePath %>web/communication/contacts_category_add.jsp',300,80);"><span class="icoadd"></span>添加公共组</a></li>
							<%} %>	
						</ul>
					</div>
					<%} %>
					<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						<ul id="tt"></ul>
					</div>
				</div>
			</td>
			<td width="100%" valign="top">
				<div class="pm_msglist" id="msglist">
					<div class="titlebg">名片列表</div>
					<div class="emailtop">
						<div class="leftemail">
							<ul>
								<%if(OaActivator.getSessionUser(request).getAdmin().equals(BooleanEnum.YES)){%>
								<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_delCard")){%>	
								<li onmouseover="this.className='libg'"
									onmouseout="this.className=''" 
									onclick="deleteSelected()"><span><img
										src="core/common/images/emaildel.png"/></span>删除</li>
								<%}%>
								<%}%>
								<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_copyCard")){%>	
								<li onmouseover="this.className='libg'"
									onmouseout="this.className=''" 
									onclick="copy()"><span><img
										src="core/common/images/copy.gif"/></span>复制</li>
								<%}%>
								<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_cardCategory_moveCard")){%>		
								<li onmouseover="this.className='libg'"
									onmouseout="this.className=''" 
									onclick="move()"><span><img
										src="core/common/images/move.png"/></span>移动</li>	
								<%}%>
							</ul>
						</div>
					</div>
						<!--//titlebg-->
					<div class="searchdiv">
					  <form id="form2" name="form2" method="post" action="">
						<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td width="40">姓名： </td>
							<td width="105"><table width="100%" border="0" cellspacing="2" cellpadding="0">
							  <tr>
								<td width="180">
									<search:input id="name" dataType="string" field="name" op="cn" inputClass="input170"/>	
								</td>
							  </tr>
							</table>
							<label></label></td>
							<td width="40" align="right">职位：</td>
							<td width="180">
								<search:input id="position" dataType="string" field="position" op="cn" inputClass="input170"/>	
							</td>
							<td width="75" align="center"><label><img src="core/common/images/search.jpg" width="75" height="22" border="0" usemap="#Map" /></label></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						  </tr>
						</table>
					  </form>
					</div>
						<div id="demo">
							<div style="overflow: auto;">
								<table id="list" class="jqGridList">
									<tr>
										<td />
									</tr>
								</table>
								<div id="pager"></div>
							</div>
						</div>
					</div> <!--//msglist-->
				</td>
			</tr>
		</table>
	</div>
	<!--//container-->

	<map name="Map" id="Map">
		<area shape="rect" coords="2,1,51,20" href="javascript:void(0)"  onclick="doSearch()"/>
		<area shape="rect" coords="55,1,74,20" href="javascript:void(0)"
			onclick="fbSearch('高级搜索','<%=basePath %>web/communication/search_list.jsp',500,400);" />
	</map>
</body>
</html>
