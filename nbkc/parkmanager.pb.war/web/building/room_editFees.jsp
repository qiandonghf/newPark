<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/jquery-easyui-1.2.6/themes/default/easyui.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		refreshTree();
	});
	
	function refreshTree() {
		$.ajax({
		  "url" : "<%=basePath%>roomFee!feeTypeList.action",
		  type:"POST",
		  success: function(data){
			$("#tt").tree({
				lines:true,
				"data" : data.list,
				onClick: function(node){
					if(!node.state){
						$(this).tree('toggle', node.target);
						var id = node.id;
						feeEdit(id);
					}
				}
			});
		  }
		});
	}
	function feeEdit(type){
		var id = $("#roomId").val();
		$("#iframe").attr("src","<%=basePath %>roomFee!editRoomFee.action?id="+id+"&type="+type);
	}
</script>
</head>

<body>
<div class="basediv">
<div class="roomtitle">单元编号：${room.name}</div>
<!--userleft-->
<div class="userleftcharges">
<div class="titlebg">费用类型</div>
<div class="treeviewdiv">
	<ul id="browser" class="filetree">
		<li class="closed">
			<div class="treeviewdiv" style="overflow-Y:auto; height:255px;">
				<ul id="tt">
				</ul>
			</div>
		</li>
	</ul>
</div>
</div>
<div class="userrightcharges">
	<div class="userrightdivs">
		<input type="hidden" value="${room.id }" id="roomId"/>
		<iframe id="iframe" scrolling="no" frameborder="0" src="<%=basePath %>roomFee!editRoomFee.action?id=${room.id}" name="room" width="100%" height="160"></iframe>
	</div>
</div>
<%-- <form action="<%=basePath %>roomFee!update.action" method="post" name="form1" id="form1">
<input type="hidden" name="roomFee.roomId" value="${id}"/>
<input type="hidden" name="roomFee.id" value="${result.value.id}"/>
<div class="userrightcharges">
	<div class="userrightdivs">
	<div class="titlebg">费用信息</div>
	<div class="divlays">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="layertdleft">费用类型：</td>
    <td class="layerright">${name.title}<input name="roomFee.feeType" type="hidden" value="${name}"/></td>
  </tr>
  <tr>
    <td class="layertdleft">费用值：</td>
    <td colspan="3" class="layerright"><input id="amount" name="roomFee.amount" type="text" class="inputauto" value="<fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/>" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
  </tr>
  <tr>
    <td class="layertdleft">费用单位：</td>
    <td>
    	&nbsp;<enum:select name="roomFee.unit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum" checked="result.value.unit"/>
    </td>
  </tr>
</table>
	</div>
	<div class="buttondiv" style="border-top:1px solid #ccc; padding-top:5px;">
      <label>
        <input name="Submit" type="submit" class="savebtn" value=""/>
        </label>
      <label>
        <input name="Submit2" type="button" class="cancelbtn" value="" onclick="document.form1.reset();"/>
        </label>
    </div>
	</div>
</div>
</form> --%>
<div class="hackbox"></div>
</div>
</body>
</html>
