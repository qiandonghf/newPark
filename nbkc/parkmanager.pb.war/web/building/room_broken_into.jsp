<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
 
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
	});
	
	function checkForm(){
		var name = $("#roomName").val();
		if(confirm("您确定要拆分"+name)){
			var name1 = $("#roomName1").val();
			var name2 = $("#roomName2").val();
			if(trim(name)==""){
				showTip("请选择拆分房间");
				return;
			}
			if(trim(name1)==""){
				showTip("房间编号一不能为空");
				return;
			}
			if(trim(name2)==""){
				showTip("房间编号二不能为空");
				return;
			}
			name1 = name1.replace(",","");
			name2 = name2.replace(",","");
			var names = name1+","+name2;
			var id = $("#roomId").val();
			$.post(
				"<%=basePath%>room!roomBroken.action", 
				{name: names, id: id},
				function(data){ 
					showTip(data.result.msg,3000);
				 	if(data.result.success){
				 		setTimeout(function(){
				 			getBasementOpener().frames[0].reloadRoomList();
				 			fb.end();
				 			var config = 'sameBox:true caption:查看房间信息 width:800 height:510 '+floatboxConfig;
							parent.fb.start('<%=basePath%>room!info.action?id='+data.room.id, config);
				 		},1000);
		        	}
				}
			);
		}
	}
	
	function getBasementOpener(){
		var tab = parent.parent.$('#tt').tabs('getSelected');
		return parent.parent.window.frames[parent.parent.$('#tt').tabs('getTabIndex',tab)];
	}
	
	function setSelectedRoom(room,type){
		if(typeof(room.id)!="undefined"){
			$("#roomId").val(room.id);
			$("#roomName").val(room['building.name']+" "+room.name);
		}
	}
</script>

</head>

<body>
<div class="basediv" >
<div class="divlays"><!--divlay-->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>请选择拆分房间:</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="roomId" type="hidden" /><input id="roomName" readonly="readonly" class="inputauto" onclick="fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
          <td width="25" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>新房间编号一：</td>
      <td class="layerright"><label>
        <input id="roomName1" type="text" class="inputauto" />
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>新房间编号二：</td>
      <td class="layerright"><label>
        <input id="roomName2" type="text" class="inputauto" />
      </label></td>
      </tr>
    <tr>
      <td class="layertdleft100">注：</td>
      <td class="layerright"><p>每次只能拆分一个房间，此操作是不可逆的，请谨慎使用该功能。拆分后需要重新配置房间参数（水电表等）。</p>        </td>
    </tr>
  </table>
	<div class="hackbox"></div>
</div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</body>
</html>
