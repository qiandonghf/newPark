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
		var name1 = $("#roomName").val();
		var name2 = $("#roomName2").val();
		if(confirm("是否确认合并房间"+name1+"\\"+name2)){
			var newName = $("#newName").val();
			if(trim(name1)==""){
				showTip("请选择房间一");
				return;
			}
			if(trim(name2)==""){
				showTip("请选择房间二");
				return;
			}
			if(trim(newName)==""){
				showTip("请填写合并房间编号");
				return;
			}
			var ids = $("#roomId").val()+";"+$("#roomId2").val();
			$.post(
				"<%=basePath%>room!roomMerge.action", 
				{name: newName, ids: ids},
				function(data){ 
					showTip(data.result.msg,3000);
				 	if(data.result.success){
				 		setTimeout(function(){
					 		getBasementOpener().frames[0].reloadRoomList();
					 		fb.end();
					 		var config = 'sameBox:true caption:查看房间信息 width:800 height:510 '+floatboxConfig;
							parent.fb.start('<%=basePath%>room!info.action?id='+data.result.value.id, config);
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
	function setSelectedRoom(room){
		if(typeof(room.id)!="undefined"){
			var type=$("#select").val();
			if(type==1){
				$("#roomId").val(room.id);
				$("#roomName").val(room['building.name']+" "+room.name);
			}else{
				$("#roomId2").val(room.id);
				$("#roomName2").val(room['building.name']+" "+room.name);
			}
		}
		
	}
</script>
</head>

<body>
<div class="basediv" >
<div class="divlays">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <input id="select" type="hidden" />
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>请选择房间一:</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="roomId" type="hidden" /><input id="roomName" readonly="readonly" class="inputauto" onclick="$('#select').val(1);fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
          <td width="25" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="$('#select').val(1);fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>请选择房间二:</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="roomId2" type="hidden" /><input id="roomName2" readonly="readonly" class="inputauto" onclick="$('#select').val(2);fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
          <td width="25" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="$('#select').val(2);fbStart('房间选择','<%=basePath %>room!select.action',520,394);"/></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>合并房间编号：</td>
      <td class="layerright"><label>
        <input id="newName" type="text" class="inputauto" />
      </label></td>
      </tr>
    <tr>
      <td class="layertdleft100">注：</td>
      <td class="layerright"><p>每次只能合并一个房间，此操作是不可逆的，请谨慎使用该功能。合并后需要重新配置房间参数（水电表等）。</p>        </td>
    </tr>
  </table>
	<div class="hackbox"></div>
</div>
</div>

<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="fb.end();"/></label>
  </div>
</body>
</html>
