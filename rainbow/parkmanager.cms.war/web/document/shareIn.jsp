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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />

<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css"/>

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>

<script type="text/javascript">
	$(function() {
		initTip();
		$.ajax({
		  "url" : "<%=basePath%>document!shareDoc.action?id=${param.id}",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				"data" : data.documentList
			});
		  }
		});
	});
	
	function shareSelected() {
		var objs = $(".documentChecked");
		var ids = "";
		for(var i = 0;i<objs.length;i++){
			if(objs.get(i).checked){
				ids += objs.get(i).value+",";
			}
		}
		if(ids==""){
			showTip('请选择文件夹',2000);
		}else{
			$.ajax({
				  url:"<%=basePath%>document!shareIn.action?id=${param.id}&ids="+ids,
				  type:"POST",
				  contentType:"application/json; charset=utf-8",
				  dataType:"json",
				  success: function(data){
	          		  showTip(data.result.msg,2000);
					  if(data.result.success){
				      	setTimeout("fb.end();", 2000);
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
		<div id="documentTreeContainer" style="height: 251px;">
			<ul id="tt">
			</ul>
		</div>
	</td></tr>
	</table>
</div>
</div>	
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value=""  onclick="shareSelected();"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
 </div>
</body>
</html>
