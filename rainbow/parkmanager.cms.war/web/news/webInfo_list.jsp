<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/cord_icon.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script>
//园区菜单
var parkMenu = [[{
    text: "编辑",
	classname: "smarty_menu_ico1",
    func: function() {
    	fbStart('编辑栏目','<%=basePath%>column!update.action?id='+$(this.parentNode).attr('node-id'),400,75);
    }
},{
    text: "删除",
	classname: "smarty_menu_ico2",
    func: function() {
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>column!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
				showTip(data.result.msg,1000);
				setTimeout("location.reload()", 1000);
			});
		}
    }
},{
	text: "新建频道",
		classname: "smarty_menu_ico0",
        func: function(e) {  
 	    fbStart('新建频道信息','<%=basePath%>webInfo!createChild.action?id='+$(this.parentNode).attr("node-id"),450,415);
        }
}]];

var parkMenu2 = [[{
    text: "编辑",
	classname: "smarty_menu_ico1",
    func: function() {
    	fbStart('编辑栏目','<%=basePath%>column!update.action?id='+$(this.parentNode).attr('node-id'),400,75);
    }
},{
    text: "删除",
	classname: "smarty_menu_ico2",
    func: function() {
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>column!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
				showTip(data.result.msg,1000);
				setTimeout("location.reload()", 1000);
			});
		}
    }
},{
	text: "新建网站信息",
	classname: "smarty_menu_ico0",
    func: function(e) {  
    	//alert($(this.parentNode).attr("node-id"));
	    fbStart('新建网站信息','<%=basePath%>web/news/channel_add.jsp?id='+$(this.parentNode).attr("node-id"),400,75);
    }
}]];

var childrenParkMenu = [[{
    text: "编辑",
	classname: "smarty_menu_ico1",
    func: function() {
    	fbStart('编辑栏目','<%=basePath%>webInfo!edit.action?id='+$(this.parentNode).attr('node-id'),600,450);
    }
},{
    text: "删除",
	classname: "smarty_menu_ico2",
    func: function() {
		if(confirm("您确定要删除")){
			$.post("<%=basePath%>webInfo!delete.action?id="+$(this.parentNode).attr('node-id'),function(data){
				showTip(data.result.msg,1000);
				setTimeout("location.reload()", 1000);
			});
		}
    }
}]];



$(document).ready(function() {
	initTip();
	$("#resizable").css("height",getTabContentHeight());
	$("#msglist").css("height",getTabContentHeight());
	$("#treeviewdiv").css("height",getTabContentHeight()-55);
	refreshTree();
});

<%-- function refreshTree() {
		$('#tt').tree({
		    url: '<%=basePath%>column!smsPage.action',
		    onClick: function(node){
				$(this).tree('toggle', node.target);
				var id = node.id;
				$("#msglist").attr("src","<%=basePath%>webInfo!view.action?id="+id);
		    },
		    onLoadSuccess: function(){
		    	var nodes = $(this).tree("getRoots");
				for( var i = 0; i < nodes.length; i++){
					var node = nodes[i];
					$(node.target).find(".tree-title").smartMenu(parkMenu,{name:'parkMenu'});
				}
		    },
		});
} --%>


function refreshTree() {
	$.ajax({
	 url: '<%=basePath%>column!smsPage.action',
	  type:"POST",
	  success: function(data){			 
		$("#tt").tree({
			lines:true,
			onClick:function(node){
				$(this).tree('toggle', node.target);
			},
			"data" : data.pindaoList
		});
		//$("#tt .tree-title").smartMenu(parkMenu,{name:'parkMenu'});
		
		var nodes = $("#tt").tree("getRoots");
		for( var i = 0; i < nodes.length; i++){
			var node = nodes[i];	
			$(node.target).find(".tree-title").smartMenu(parkMenu2,{name:'parkMenu2'});	
			var children = $(this).tree("getChildren",node.target);
			for( var j = 0; j < children.length; j++){
				var child = children[j];
				if(child.iconCls !="icon-card")
				$(child.target).find(".tree-title").smartMenu(parkMenu,{name:'parkMenu'});
				else{
					$(child.target).find(".tree-title").smartMenu(childrenParkMenu,{name:'childrenParkMenu'});
					$(child.target).find(".tree-title").click(function(node){
						var id = $(this.parentNode).attr("node-id");
						$("#msglist").attr("src","<%=basePath%>webInfo!view.action?id="+id);		
					});
				}
				
				
			}
		}
		
	  }
	});
}
	function reloadList(){
		refreshTree();
	}
</script>
</head>

<body>
	<div id="container">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	        	<td width="182" valign="top">
					<div class="agency" id="resizable">
						<div class="titlebg">新闻栏目列表</div>
						<div class="agencybtn">
							<ul>
								<li><a href="javascript:void(0)" onclick="fbStart('添加目录','<%=basePath %>web/news/channel_add.jsp',400,75);"><span class="icoadd"></span>添加栏目</a></li>
							</ul>
						</div>
						<div class="treeviewdiv" style="overflow-Y:auto;" id="treeviewdiv">
						 	<ul id="tt">
	 						</ul>
			          	</div>
					</div>		
				</td>
				<td width="100%" valign="top">
					<div>
						<iframe src="parkmanager.cms/web/news/webContent_view.jsp" frameborder="0" id="msglist" width="100%"></iframe>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
