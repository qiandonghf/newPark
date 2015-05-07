<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${rootLocation}"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>

<script type="text/javascript">
	var selectedOrg;
  $(document).ready(function() {
	    //$("#resizable").resizable();
	    $("#resizable").css("width",window.parent.document.documentElement.clientHeight-72);
		initTip();
		initOrgTree();
	});
	function initOrgTree() {
			$.ajax({
			  "url" : "${contextLocation}org!treeOrgs.action",
			  type:"POST",
			  success: function(data){
				$("#tt").tree({
					"data" : data,
					onDblClick : function(node) {
		     			selectedOrg = {"id" : node.id, "name" : node.text};
		     			var path = ">>" + node.text;
		     			for (var parent=$("#tt").tree("getParent", node.target); parent != null; parent=$("#tt").tree("getParent", parent.target)) {
			     			path = ">>" + parent.text + path;
		     			}
	     				$("#selectedOrg").text(path);
					}
				});
			  }
			});
	}

	function submitSelectedOrg() {
		if(selectedOrg!=null){
			getOpener().setSelectedOrg(selectedOrg);
			fb.end();
		}else{
			showTip("请选择机构");
		}
	}

</script>
</head>

<body>
<div class="basediv">

<!--container-->
<div id="container" style="height:400px;overflow-y:scroll;">

   <div id="orgTreeContainer">
       <ul id="tt">
       </ul>
   </div>
</div>
<div class="hackbox"></div>
<div>
选中的组织：<span id="selectedOrg"></span>
</div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="submitSelectedOrg()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/></label>
</div>
</body>
</html>
