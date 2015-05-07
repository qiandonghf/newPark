<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		$.ajax({
		"url" : "${contextLocation}role!treeAuthorities.action?id=${id}",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				lines:true,
				checkbox: true,
				onClick:function(node){
					$(this).tree('toggle', node.target);
				},
				"data" : data.nodeList
			});
		  }
		});
	});
	/* $(function() {
		$("#tt").tree({
			"url" : "${contextLocation}role!treeAuthorities.action?id=${id}",
			//cascadeCheck: false,
			"checkbox" : true
		});
		initTip();
	}); */
		
	function grantSelectedAuthorities() {
		var checkedNodes = $("#tt").tree("getChecked");
		var moduleAuthorities = new Array();
		$(checkedNodes).each(
				function (moduleIndex, moduleNode) {
					var moduleNodeId = moduleNode.id;
					var moduleId = moduleNodeId.substring(0,moduleNodeId.lastIndexOf("_"));
					var type = moduleNodeId.substring(moduleNodeId.lastIndexOf("_")+1);
					moduleAuthorities[moduleIndex] = {"idSpace" : moduleId, "type" : type};
		});
		var roleAuthorityRefs = {"id" : $("#roleId").attr("value"), "moduleAuthorities" : moduleAuthorities};
		//alert(JSON.stringify(roleAuthorityRefs));
		$.ajax({
			  url:"${contextLocation}saveAuthorityConfig.action",
			  type:"POST",
			  data:JSON.stringify(roleAuthorityRefs),
			  contentType:"application/json; charset=utf-8",
			  dataType:"json",
			  success: function(r){
                  if (r.success) {
                	  fb.end();
          			  //showTip(data.result.msg,2000);
                  }
			  }
			}); 
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

<body style="height: 504px;">
<div class="basediv">
	<!--roltetab-->
	<input type="hidden" name="roleId" id="roleId" value="${id}" />
	<div id="moduleTreeContainer" style="height: 484px; overflow-y:scroll;">
		<ul id="tt">
		</ul>
	</div>
</div>
<div class="buttondiv">
	<label> <input name="Submit" type="button" class="savebtn"
		value="" onclick="grantSelectedAuthorities();"/>
	</label> <input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/>
</div>
</body>
</html>
