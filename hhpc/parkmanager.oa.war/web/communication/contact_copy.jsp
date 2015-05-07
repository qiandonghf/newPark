<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page import="com.wiiy.oa.activator.OaActivator"%>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />

<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.oa/web/style/cord_icon.css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>

<script type="text/javascript">
	$(function() {
		initTip();
		refreshTree();
	});
	function refreshTree() {
		$.ajax({
		  "url" : "<%=basePath%>card!copyMove.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				animate: true,
				checkbox:true,
				lines:true,
				"data" : data.cardCategoryList
			});
		  }
		});
	}
	
	function copySelected() {
		var nodes = $('#tt').tree("getChecked");
		var copyIds = "";
		for(var i=0;i<nodes.length;i++){
			var node = nodes[i];
			var id = node.id;
			copyIds += id+",";
		}
		if(copyIds==""){
			showTip('请选择文件夹',2000);
		}else{
			$.ajax({
				  url:"<%=basePath%>card!copyCard.action?ids=${param.ids}&copyIds="+copyIds,
				  type:"POST",
				  contentType:"application/json; charset=utf-8",
				  dataType:"json",
				  success: function(data){
					  if(data.result.msg!=null){
			          	  showTip(data.result.msg,2000);
					  }
					  if(data.result.success){
						 setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
				      }
				  }
			});
		}
	}
	
	function contained(checkedNodes, id) {
		for (var i = 0; i < checkedNodes.length; i ++) {
			if (checkedNodes[i].id == id) {
				return true;
			}
		}
		return false;
	}
	
</script>
</head>

<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td>
		<div id="documentTreeContainer" style="height: 251px;overflow-x: hidden;overflow-y: auto">
			<ul id="tt">
			</ul>
		</div>
	</td></tr>
	</table>
</div>
</div>	
<div class="buttondiv">
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="copySelected()"><span><img src="core/common/images/accept.png">确认</span></a>
	<a href="javascript:void(0)" title="" class="btn_bg" onclick="parent.fb.end();"><span><img src="core/common/images/close.png">取消</span></a>
 </div>
</body>
</html>
