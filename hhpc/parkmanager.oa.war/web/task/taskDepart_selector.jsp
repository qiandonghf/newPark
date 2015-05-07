<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript">
		$(function(){
			$("#tree").tree({
				animate: true,
				checkbox: true,
				onLoadSuccess: function(node,data){
					var root = $(this).tree("getRoot");
					var nodes = $(this).tree("getChildren",root.target);
					var ids = "${ids}";
					for(var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						if(ids.indexOf(","+node.id+",")>-1){
							$(this).tree("check",node.target);
						}
					}
				}
			});
		});
		function submitSelect(){
			try{
				if(typeof(getOpener().eval("setSelectedDeparts")) == "function"){
					var nodes = $("#tree").tree("getChecked");
					var departs = new Array();
					var a = -1;
					for(var i = 0; i < nodes.length; i++){
						var node = nodes[i];
						if(node.id!=0){
							departs[a+1] = {"id":node.id,"name":node.text};
							a = a+1;
						}
					}
					getOpener().setSelectedDeparts(departs);
				}
			} catch(e){}
			 fb.end(); 
		}
	</script>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
<div class="basediv" style="padding:0;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="50%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50%" valign="top">
				<div style="overflow-x: hidden; width:400px; height:200px;overflow-Y:auto">
					<ul id="tree" class="tree">
						<li id="0"><span>所有部门</span>
						<ul>
							<c:forEach items="${result.value}" var="depart">
							<li id="${depart.id}"><span>${depart.name}</span></li>
							</c:forEach>
						</ul>
						</li>
					</ul>
				</div></td>				
			</tr>
		</table></td>
	</tr>
</table>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="submitSelect()" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>

