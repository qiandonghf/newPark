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
		jqGridResizeRegister("list");
	});
	
	function initList(list){
		var height = getTabContentHeight()-107;
		var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
		$("#"+list).jqGrid({
	    	url:'<%=basePath%>docPublic!loadDocByParentId.action',
			colModel: [
				{label:'文档名称',name:'name',width:220, align:"left",formatter:ducumentNameUrl}, 
				{label:'id',name:'id',hidden:true},
				{label:'创建时间',width:100, name:'createTime',formatter:'date',formatoptions:{srcformat:'Y-m-d',newformat:'Y-m-d'}, align:"center"},
				{label:'大小',width:80, name:'size',align:"center" ,formatter:documentSize}, 
				{label:'管理',width:60, name:'manager', align:"center", sortable:false, resizable:false,formatter:downImg}
			],
			shrinkToFit: false,
			height: height,
			width: width,
			multiselect: false
		}).navGrid('#pager',{add: false, edit: false, del: false, search: false});
	}
	function downLoad(path,name){
		location="/core/resources/"+path+"?name="+name;
	}
	function downImg(cellvalue, options, rowObject){
		var type = rowObject["fileExt"];
		var path = rowObject["fileName"];
		var name = rowObject["name"];
		var id=rowObject["id"];
		if(type!=null){
			var src = "<img src=\"core/common/images/down.png\" width=\"14\" height=\"14\" title=\"下载\" onclick=\"downLoad('"+path+"','"+name+"');\"  /> ";
			src+="<img src=\"core/common/images/del.gif\" width=\"14\" height=\"14\" title=\"取消共享\" onclick=\"deleteById('"+id+"');\" /> ";
			return src;
		}
		return "&nbsp;";
	}
	function deleteById(id){
		var parentDocId = $('#parentDocId').val();
		if(confirm("您确定要取消共享？")){
			$.post(
			"<%=basePath %>docPublic!publicDel.action?id="+id+"&parentDocId="+parentDocId,
			function(data){
				showTip(data.result.msg,2000);					
				if(data.result.success){
					reloadList();
				}
			}			
			);
		}
	}
	function reloadList(){
		$("#list").trigger("reloadGrid");
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
		var data = "<span class=\""+type+"\"></span><a href=\"core/resources/"+src+"?name="+cellvalue+"\" style=\"text-decoration: none;\">"+cellvalue+"</a>";
		return data;
	}
	function folderUrl(type,id,cellvalue){
		var data = "<span class=\""+type+"\"></span><a href=\"javascript:void(0)\" onclick=\"loadByParentId("+id+",'"+cellvalue+"')\" style=\"text-decoration: none;\"  >"+cellvalue+"</a>";
		return data;
	}
	
	function loadByParentId(id,name){
		$("#list").setGridParam({url:'<%=basePath%>docPublic!loadDocByParentId.action?id='+id}).trigger('reloadGrid');
		if(id==null){
			$("#addFolder").click(function(){
				fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp',500,285);
			});
			$("#folderNames").empty();
		}else{
			$('#parentDocId').val(id);
			$("#addFolder").click(function(){
				fbStart('添加文档','<%=basePath %>web/document/personaldocuments_add.jsp?id='+id,500,285);
			});
			$("#folderNames").append($("<span  id=\"folder\"></span>").append("<input type=\"hidden\" value=\""+id+"\"/>").append("&gt;&gt;&nbsp;").append($("<a></a>",{style:"text-decoration: none;color:#999;",href:"javascript:void(0)",click:function(){
				loadChildren(this,id);
			}}).append(name)));
		}
	}
	
	function loadPrevFolder(){
		$("#folderNames :last").parent().remove();
		$("#list").setGridParam({url:'<%=basePath%>docPublic!loadDocByParentId.action?id='+$("#folderNames input:last").val()}).trigger('reloadGrid');
	}
	
	function loadChildren(el,id){
		$(el).parent().nextAll().remove();
		$("#list").setGridParam({url:'<%=basePath%>docPublic!loadDocByParentId.action?id='+$("#folderNames input:last").val()}).trigger('reloadGrid');
	}
	
</script>
</head>
<body>
<input id="parentDocId" type="hidden" value=""/>
<div id="container">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100%" valign="top">
				<div class="pm_msglist" style="display:block;" id="textname">
					<div class="titlebg">文件列表 </div>
					<div class="emailtop">
						<ul id="rootmenu">
							<span class="back"></span>
							<a id="prev" href="javascript:void(0)" onclick="loadPrevFolder();" style="text-decoration: none;color:#333;">返回上级</a>&nbsp;&nbsp;
			   				<span style=" font-family:'宋体';" >
							[<a href="javascript:void(0)" onclick="loadByParentId();" style="text-decoration: none;color:#999;">根目录</a><span id="folderNames"></span>]</span>
						</ul>
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
