<%@ page import="com.wiiy.commons.action.BaseAction" contentType="text/html;charset=UTF-8" language="java" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		$.ajax({
		  "url" : "<%=basePath%>userTopButton!userMenus.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				lines:true,
				checkbox: true,
				onClick:function(node){
					$(this).tree('toggle', node.target);
				},
				"data" : data.easyUITreeNode
			});
		  }
		});
	});
	
	function addparentId(node,ids){
		var id = $(node.target).find("input").val();
		if(ids.indexOf(","+id+",")==-1){
			ids += id+",";
		}
		if($("#tt").tree("getParent",node.target)){
			var pNode = $("#tt").tree("getParent",node.target);
			ids = addparentId(pNode,ids);
		}
		return ids;
	}
	
	function selectedTopButton(){
		var ids = ",";
		var nodes = $('#tt').tree('getChecked'); 
		for(var i = 0 ; i < nodes.length; i++){   
			if($("#tt").tree("getParent",nodes[i].target)){
				ids = addparentId(nodes[i],ids);
			}
		}
		if(ids.length>1){
			$.ajax({
				  url:"<%=basePath%>userTopButton!selectedTopButton.action?ids="+ids,
				  type:"POST",
				  contentType:"application/json; charset=utf-8",
				  dataType:"json",
				  success: function(data){
	          		  showTip(data.result.msg,2000);
					  if(data.result.success){
						setTimeout(function(){
					 		var src = "core/userTopButton!list.action";
			        		getOpener().reloadButton(src);
					 		fb.end();
						},2000);
				      }
				  }
			});
		}else{
			showTip("请选择快速按钮");
		}
	}
</script>
</head>

<body>
<!--basediv-->
<div class="basediv">
<div class="divlays" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top">
				<div style="overflow-x: hidden; width:425px; height:200px;overflow-Y:auto">
					<ul id="tt">
					</ul>
				</div></td>
			</tr>
		</table></td>
	</tr>
</table>
</div>
</div>
<!--//basediv-->
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="selectedTopButton();"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
