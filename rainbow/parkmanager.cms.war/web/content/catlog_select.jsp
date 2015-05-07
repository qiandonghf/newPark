<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.wiiy.commons.action.BaseAction"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
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
	var selectedCatlog;
	$(document).ready(function() {
		initTip();
		initCatlogTree();
	    //$("#resizable").resizable();
	    $("#resizable").css("width",window.parent.document.documentElement.clientHeight-200);
	});
	function initCatlogTree(){
		var memo = "${param.memo}";
		var url = "<%=basePath%>articleType!treeList.action?paramId=${param.paramId}&articleKind=${param.kind}&memo=${param.memo}";
		<%-- if(memo == 'article'){
			url = "<%=basePath%>articleType!singleTreeList.action?paramId=${param.paramId}&articleKind=${param.kind}";
		} --%>
		showTip("正在读取数据……",999999);
		$.ajax({
		  "url" : url,
		  type:"POST",
		  success: function(data){
			showTip("读取数据成功",2000);
			$("#tt").tree({
				"data" : data.articleTypeList,
				onDblClick : function(node) {
					selectedCatlog = {"id" : node.id, "name" : node.text};
	     			var path = ">>" + node.text;
	     			for (var parent=$("#tt").tree("getParent", node.target); parent != null; parent=$("#tt").tree("getParent", parent.target)) {
		     			path = ">>" + parent.text + path;
	     			}
     				$("#selectedCatlog").text(path);
				}
			});
		  }
		});
	}

	function submitSelectedCatlog(){
		getOpener().setSelectedCatlog(selectedCatlog);
		fb.end();
	}

</script>
</head>

<body>
<div class="basediv">

<!--container-->
<div id="container" style="height:300px;overflow-y:scroll;">

   <div id="catlogTreeContainer">
       <ul id="tt">
       </ul>
   </div>
</div>
<div class="hackbox"></div>
<div>
选中的文章栏目：<span id="selectedCatlog"></span>
</div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="rightbtn" value="" onclick="submitSelectedCatlog()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/></label>
</div>
</body>
</html>
