<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initList("list");
	});
	
	function initList(list){
		var height = window.parent.parent.document.documentElement.clientHeight-(window.screenTop-window.parent.parent.screenTop)-160;
		var width = window.parent.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.parent.screenLeft);
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>document!loadDocByParentId.action',
			colModel: [
				{label:'文档名称',name:'name',align:"left",formatter:ducumentNameUrl}, 
				{label:'id',name:'id',hidden:true},
				{label:'创建时间',width:40, name:'createTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'是否发布',align:"center" ,name:'pubed.title',width:40,hidden:true},
				{label:'是否目录',align:"center" ,name:'isFolder.title',width:40,hidden:true},
				{label:'大小',width:40, name:'size',align:"center" ,formatter:documentSize}, 
			    {label:'管理',width:40, name:'manager', align:"center", sortable:false, resizable:false}
			],
			height: height,
			width: width,
			multiselect: false,
			//shrinkToFit: false,
			gridComplete: function(){
				var ids = $(this).jqGrid('getDataIDs');
				for(var i = 0 ; i < ids.length; i++){
					var id = ids[i];
					var pubed = $(this).getCell(id,'pubed.title');
					var isFolder = $(this).getCell(id,'isFolder.title');
					var content = "";
					<%
					Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
					boolean add = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_add");
					boolean edit = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_edit");
					boolean delete = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_del");
					boolean shareIn = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_shareIn");
					boolean shareOut = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_shareOut");
					boolean pubed = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_shareWeb");
					boolean back = OaActivator.getHttpSessionService().isInResourceMap("oa_personal_back");
					%>
					if(pubed == '否' || pubed == '' ){
						<%if(pubed){%>
						content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"发布\" onclick=\"publishById('"+id+"');\"  /> ";
						<%} %>
						if(isFolder == '是'){
							<%if(back){%>
							content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"撤回\" onclick=\"backById('"+id+"');\"  /> ";
							<%} %>
						}
					}else{
						if(isFolder == '是'){
							<%if(pubed){%>
							content += "<img src=\"core/common/images/uploadicon.png\" width=\"14\" height=\"14\" title=\"发布\" onclick=\"publishById('"+id+"');\"  /> ";
							<%} %>
						}
						<%if(back){%>
						content += "<img src=\"core/common/images/back.png\" width=\"14\" height=\"14\" title=\"撤回\" onclick=\"backById('"+id+"');\"  /> ";
						<%} %>
					}
					<%if(edit){%>
					content += "<img src=\"core/common/images/edit.gif\" width=\"14\" height=\"14\" title=\"编辑\" onclick=\"editById('"+id+"');\"  /> ";
					<%} %>
					<%if(shareIn){%>
					content += "<img src=\"core/common/images/internal.png\" width=\"14\" height=\"14\" title=\"内部共享\" onclick=\"shareInById('"+id+"');\"  /> ";
					<%} %>
					<%if(shareOut){%>
					content += "<img src=\"core/common/images/external.png\" width=\"14\" height=\"14\" title=\"企业共享\" onclick=\"shareOutById('"+id+"');\"  /> ";
					<%} %>
					<%if(delete){%>
					content += "<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"删除\" onclick=\"deleteById('"+id+"');\"  /> ";
					<%} %>
					$(this).jqGrid('setRowData',id,{manager:content});
				}
			}
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
	}
	
	function publishById(id){
		if(confirm("确定要发布吗")){
			$.post("<%=basePath%>document!publish.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function backById(id){
		if(confirm("确定要撤回吗")){
			$.post("<%=basePath%>document!back.action?id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$("#list").trigger("reloadGrid");
	        	}
			});
		}
	}
	
	function deleteById(id){
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>document!delete.action?id="+id,function(data){
				showTip(data.result.msg,1000);
				if(data.result.success){
					setTimeout("parent.refreshTree();");
					reloadList();
				}
			});
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
	}
	
	function refreshTree(){
		parent.refreshTree();
	}
	
	function editById(id){
		fbStart('编辑文档','<%=basePath%>document!edit.action?id='+id,300,71);
	}
	
	function shareInById(id){
		fbStart('内部共享','<%=basePath%>web/document/shareIn.jsp?id='+id,430,294);
	}
	
	function shareOutById(id){
		fbStart('企业共享','<%=basePath%>web/document/shareOut.jsp?id='+id,430,294);
	}
	
	function documentSize(cellvalue, options, rowObject){
		var size = "";
		if(cellvalue!=null){
			size = Math.round(cellvalue/1024*100)/100+"KB";
		}
		return size+"&nbsp";
	}
	
	function ducumentNameUrl(cellvalue, options, rowObject){
		var id = rowObject["id"];
		var src = rowObject["fileName"];
		var data = "";
		if(/\.(doc)$/.test(cellvalue)) {
			data = dataUrl("word",src,cellvalue);
		}else if(/\.(png)$/.test(cellvalue)){
			data = dataUrl("png",src,cellvalue);
		}else if(/\.(gif)$/.test(cellvalue)){
			data = dataUrl("gif",src,cellvalue);
		}else if(/\.(jpg)$/.test(cellvalue)){
			data = dataUrl("jpg",src,cellvalue);
		}else if(/\.(rar)$/.test(cellvalue)){
			data = dataUrl("rar",src,cellvalue);
		}else if(/\.(xls)$/.test(cellvalue)){
			data = dataUrl("xls",src,cellvalue);
		}else if(src==null){
			data = folderUrl("follder",id,cellvalue);
		}else{
			data = dataUrl("other",src,cellvalue);
		}
		var memo = rowObject["memo"];
		if(memo!=null){
			data = data + " ("+memo+")";
		}
		return data;
	}
	function dataUrl(type,src,cellvalue){
		cellvalue = replaceSrc(cellvalue);
		var data = "<span class=\""+type+"\"></span><a href=\"core/resources/"+src+"?name="+cellvalue+"\" style=\"text-decoration: none;\">"+cellvalue+"</a>";
		return data;
	}
	function folderUrl(type,id,cellvalue){
		cellvalue = replaceSrc(cellvalue);
		var data = "<span class=\""+type+"\"></span><a href=\"javascript:void(0)\" onclick=\"loadByParentId("+id+",'"+cellvalue+"')\" style=\"text-decoration: none;\">"+cellvalue+"</a>";
		return data;
	}

	String.prototype.replaceAll = function(s1,s2) { 
	    return this.replace(new RegExp(s1,"gm"),s2); 
	}
	
	function replaceSrc(s){
		  s = s.replaceAll("&","&amp;");
		  s = s.replaceAll("<","&lt;");
		  s = s.replaceAll(">","&gt;");
		  s = s.replaceAll("\t","    ");
		  s = s.replaceAll("\r\n","\n"); 
		  s = s.replaceAll("\n","");  
		  s = s.replaceAll("  "," &nbsp;"); 
		  s = s.replaceAll("'","&#39;");
		  s = s.replaceAll("\"","&quot;");
		  return s; 
	}
	
	function loadByParentId(id,name){
		$("#list").setGridParam({url:'<%=basePath%>document!loadDocByParentId.action?id='+id}).trigger('reloadGrid');
		if(id==null){
			$("#addDocument").empty();
			$("#addDocument").append($("<li></li>",{id:"addFolder",onmouseover:"this.className='libg'",onmouseout:"this.className=''",click:function(){
				fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp',500,220);
			}}).append($("<span></span>").append("<img src=\"core/common/images/emailadd.gif\"/>")).append("添加文档"));
			$("#folderNames").empty();
		}else{
			$("#addDocument").empty();
			$("#addDocument").append($("<li></li>",{id:"addFolder",onmouseover:"this.className='libg'",onmouseout:"this.className=''",click:function(){
				fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp?id='+id,500,220);
			}}).append($("<span></span>").append("<img src=\"core/common/images/emailadd.gif\"/>")).append("添加文档"));
			
			$("#folderNames").append($("<span  id=\"folder\"></span>").append("<input type=\"hidden\" value=\""+id+"\"/>").append("&gt;&gt;&nbsp;").append($("<a></a>",{style:"text-decoration: none;color:#999;",href:"javascript:void(0)",click:function(){loadChildren(this,id);}}).append(name)));
		}
	}
	
	function loadPrevFolder(){
		$("#folderNames :last").parent().remove();
		$("#list").setGridParam({url:'<%=basePath%>document!loadDocByParentId.action?id='+$("#folderNames input:last").val()}).trigger('reloadGrid');
	}
	
	function loadChildren(el,id){
		$(el).parent().nextAll().remove();
		$("#list").setGridParam({url:'<%=basePath%>document!loadDocByParentId.action?id='+$("#folderNames input:last").val()}).trigger('reloadGrid');
	}
	
	function loadFolder(ids,names){
		var name = names.split(",");
		var id = ids.split(",");
		$("#addDocument").empty();
		$("#addDocument").append($("<li></li>",{id:"addFolder",onmouseover:"this.className='libg'",onmouseout:"this.className=''",click:function(){
			fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp?id='+id[id.length-1],500,220);
		}}).append($("<span></span>").append("<img src=\"core/common/images/emailadd.gif\"/>")).append("添加文档"));
		$("#folderNames").empty();
		for(var i=0;i<name.length;i++){
			$("#folderNames").append($("<span  id=\"folder\"></span>").append("<input type=\"hidden\" value=\""+id[i]+"\"/>").append("&gt;&gt;&nbsp;").append($("<a></a>",{style:"text-decoration: none;color:#999;",href:"javascript:void(0)",click:function(){
				loadChildren(this,id[i]);
			}}).append(name[i])));
		}
		$("#list").setGridParam({url:'<%=basePath%>document!loadDocByParentId.action?id='+$("#folderNames input:last").val()}).trigger('reloadGrid');
	}
	
</script>
</head>
<body>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="pm_msglist" style="display:block;" id="textname">
					<div class="titlebg">文件列表 </div>
					<div class="emailtop">
						<div class="leftemail">
							<ul id="addDocument">
								<%if(add){%>
									<li id="addFolder" onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp',500,220);"><span><img src="core/common/images/emailadd.gif"/></span>添加文档</li>
								<%} %>
							</ul>
						</div>
					</div>
					<div class="emailtop">
						<div class="leftemail">
							<ul id="rootmenu">
								<span class="back"></span>
								<a id="prev" href="javascript:void(0)" onclick="loadPrevFolder();" style="text-decoration: none;color:#333;">返回上级</a>&nbsp;&nbsp;
								<span style=" font-family:'宋体';" >
								[<a href="javascript:void(0)" onclick="loadByParentId();" style="text-decoration: none;color:#999;">根目录</a><span id="folderNames"></span>]</span>
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
