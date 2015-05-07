<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
 <%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		initTip();
		initUploadify("fileUpload");
		initForm();
	});
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "<%=uploadPath %>core/upload.action",//文件服务器路径
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: uploadify.width,//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#size").val($.parseJSON(data).size);
		$("#imageList").append($("<td width='60'><input type='hidden' value='"+$.parseJSON(data).originalName+"' class='roomAttName' /><input type='hidden' value='"+$.parseJSON(data).path+"' class='roomimg' /></td>").append("<img src='core/resources/"+$.parseJSON(data).path+"' width='50' height='50'/>"));
		$("#imageList").append($("<td width='25' valign='bottom'></td>").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$(this).attr("src","core/resources/"+$.parseJSON(data).path+"-d");
			$(this).parent().prev().remove();
			$(this).parent().remove();
			}})));
	}
	function startUpload(id){
		$("#"+id).uploadify("upload");
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"room.floorId":"required",
				"room.name":"required",
				"room.kindId":"required",
				"room.status":"required",
				"room.realArea":"required",
				"room.buildingArea":"required"
			},
			messages: {
				"room.floorId":"请选择所在楼层",
				"room.name":"请输入房间名称",
				"room.kindId":"请选择房间性质",
				"room.status":"请选择房间状态",
				"room.realArea":"请输入实用面积",
				"room.buildingArea":"请输入建筑面积"
				
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				var path;
				var pathString = "";
				$(".roomimg").each(function(){
					path = $(this).attr("value")+",";
					pathString += path;
				});
				$("#photos").val(pathString);
				var attName = "";
				var attString = "";
				$(".roomAttName").each(function(){
					attName = $(this).attr("value")+ ",";
					attString += attName;
				});
				$("#attname").val(attString);
				if(!checkRange("rentEnd", "rentBegin", "租金")){
					showTip("租金区间有误");
					return;
				}
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadRoomList();fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function checkRange(id1,id2,text){
		if ($("#rentBegin").val()!="") {
			if(checkDouble("rentBegin","租金起")==false){
				return;
			}
		}
		if ($("#rentEnd").val()!="") {
			if(checkDouble("rentEnd","租金止")==false){
				return;
			}
		}
		if(Number($("#"+id1).attr("value"))<Number($("#"+id2).attr("value"))){
			return false;
		}else{
			return true;
		}
	}
function checkNameUnique(){
	var name = $("#roomname").val();
	var id = ${building.id};
	$.post(
		  "<%=basePath %>room!checkNameUnique.action",
		  {name:name,id:id},
		  function(data) {
		    if(data.unique){
		   	 	return true;
		    }else{
		    	showTip("房间名称重复",2000);
		    	return false;
		    }
		  }
	);
}
</script>
</head>

<body>
<form action="<%=basePath %>room!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
<div class="divlays">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">所在园区：</td>
      <td class="layerright" width="240"> <input type="hidden" name="room.building.parkId" value="${building.parkId}" />
      ${building.park.name}</td>
      <td class="layertdleft100"><span class="psred">*</span>性质：</td>
      <td class="layerright">
         <dd:select name="room.kindId" key="pb.0007"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">所在楼宇：</td>
      <td class="layerright" name="building"> <input type="hidden" name="room.buildingId" value="${building.id}" />
      ${building.name}</td>
      <td class="layertdleft100">用途：</td>
      <td class="layerright">
      	<dd:select name="room.typeId" key="pb.0006"/>
     </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>所在楼层：</td>
      <td class="layerright"><select id="floor" name="room.floorId">
      	 <option value="">请选择所在楼层</option>
          <c:forEach items="${floorList}" var="floor">
	          <option value="${floor.id }">${floor.name }</option>
          </c:forEach>
      </select></td>
      <td class="layertdleft100"><span class="psred">*</span>状态：</td>
      <td class="layerright">
          <enum:select id="status" name="room.status" type="com.wiiy.pb.preferences.enums.RoomStatusEnum"/>
     </td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>房间名称：</td>
      <td class="layerright"><label>
        <input id="roomname" name="room.name" type="text" class="input100" onblur="checkNameUnique()"/>
      </label></td>
      <td class="layertdleft100">预定公司：</td>
      <td class="layerright"><label>
        <input  name="room.reserveCompanyName" type="text" class="input100"/>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">租金区间：</td>
    	 <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
          <td><input id="rentBegin" name="room.rentStart" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
          <td width="20" align="center">&nbsp;—</td>
          <td><input id="rentEnd" name="room.rentEnd" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
          <td width="75" align="center">&nbsp;(元/月/平米)</td>
        </tr>
      </table>      <label></label></td>
      <td class="layertdleft100">显示权值：</td>
      <td class="layerright"><input id="displayOrder" name="room.displayOrder" type="text" class="inputauto" style="width:90px;" /></td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>建筑面积：</td>
      <td class="layerright">
      <table width="100%"  border="0" cellspacing="0">
      <tr>
      	<td>
      		<input id="buildingArea" name="room.buildingArea" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d\.]/g,'')"/>&nbsp;(㎡)
      	</td>
      </tr></table></td>
      <td class="layertdleft100"><span class="psred">*</span>实用面积：</td>
      <td class="layerright">
      <table width="100%"  border="0" cellspacing="0">
      <tr>
      	<td>
     		<input id="realArea" name="room.realArea" type="text" class="inputauto" style="width:90px;" onkeyup="value=value.replace(/[^\d\.]/g,'')"/>&nbsp;(㎡)
    	</td>
      </tr></table></td>
    </tr>
    <tr>
      <td class="layertdleft100">位置：</td>
      <td class="layerright"><input name="room.location" type="text" class="inputauto" /></td>
    </tr>
    <tr>
      <td class="layertdleft100">优惠说明：</td>
      <td colspan="3"><span class="layerright">
        <textarea name="room.discountRate" rows="3" class="textareaauto"></textarea>
      </span></td>
    </tr>
     <tr>
      <td class="layertdleft100">照片：</td>
      <td class="layerright">
      <table border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td  width="100"> 
      	<input id="size" name="roomAtt.size" type="hidden" />
       	<input id="attname" name="roomAtt.name" type="hidden" />
       	<input id="attType" name="roomAtt.type" type="hidden" value="PHOTO" />
      	<input type="file" id="fileUpload" /> <div id="fileQueue"></div> </td>
      	<input  type="hidden" id="photos" name="room.photos"/>
      </tr>
       <tr id="attName"></tr>
      </table>
      </td>
    </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    <tr>
    <td class="layertdleft100">图片浏览：</td>
    <td class="layerright">
    	 <div style="width:560px; overflow-x:scroll; overflow-y:hidden; height:80px; margin-bottom:2px;">
	      <table border="0" cellspacing="0" cellpadding="0">
	      <tr id="imageList"></tr>
	      </table>
	     </div>
     </td>
    </tr>
   </table>
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">房间介绍：</td>
      <td colspan="3"><span class="layerright">
        <textarea name="room.summary" rows="5" class="textareaauto"></textarea>
      </span></td>
    </tr>
   </table>
  </table>
  </div>
</div>

<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value=""/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
