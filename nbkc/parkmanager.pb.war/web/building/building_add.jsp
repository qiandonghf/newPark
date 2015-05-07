<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		initTip();
		initUploadify("fileUpload");
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
			'queueID'			: uploadify.queueID, //和存放队列的DIV的id一致 
			'buttonText'		: uploadify.buttonText, //按钮上的文字
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess,//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
			'onSelect' : function(file) {
				deletePic();
	        }
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#photos").val($.parseJSON(data).path);
		$("#imageList").append($("<td width='60'><img src='core/resources/"+$.parseJSON(data).path+"' width='50' height='50'/>"));
		$("#imageList").append($("<td width='25' valign='bottom'></td>").append($("<img />",{src:'core/common/images/locking.jpg',click:function(){
			$(this).attr("src","core/resources/"+$.parseJSON(data).path+"-d");
			$(this).parent().prev().remove();
			$(this).parent().remove();
		}})));
	}
	function deletePic(){
		$("#imageList").empty();
		$.post("<%=BaseAction.rootLocation %>/core/resources/"+$("#photos").val()+"-d");
		$("#photos").val("");
	}
	function startUpload(id){
		$("#"+id).uploadify("upload");
	}
	function checkForm(){
		if ($("#realArea").val()!="") {
			if (checkDouble("realArea","总建筑面积")==false) {
				return;
			}
		}
		if ($("#commericalArea").val()!="") {
			if(checkDouble("commericalArea","商务面积")==false){
				return;
			}
		}
		if ($("#upParkingSpaces").val()!="") {
			if(checkInt("upParkingSpaces","地上停车位")==false){
				return;
			}
		}
		if ($("#downParkingSpaces").val()!="") {
			if(checkInt("downParkingSpaces","地下停车位")==false){
				return;
			}
		}
		if ($("#hourParkingFee").val()!="") {
			if(checkDouble("hourParkingFee","小时停车费")==false){
				return;
			}
		}
		if ($("#upParkingFee").val()!="") {
			if(checkDouble("upParkingFee","地上停车位费")==false){
				return;
			}
		}
		if ($("#downParkingFee").val()!="") {
			if(checkDouble("downParkingFee","地下停车位费")==false){
				return;
			}
		}
		if ($("#passengerElevator").val()!="") {
			if(checkInt("passengerElevator","客梯数")==false){
				return;
			}
		}
		if ($("#cargoElevator").val()!="") {
			if(checkInt("cargoElevator","货梯数")==false){
				return;
			}
		}
		if ($("#minArea").val()!="") {
			if(checkDouble("minArea","最小房间面积")==false){
				return;
			}
		}
		if ($("#maxArea").val()!="") {
			if(checkDouble("maxArea","最大房间面积")==false){
				return;
			}
		}
		 if(notNull("name","楼宇名称")
			&& checkRange("propertyEnd", "propertyBegin", "物业费")
			&& checkRange("rentEnd", "rentBegin", "租金")
		 ){
			 $('#form1').ajaxSubmit({ 
		     	dataType: 'json',
		     	success: function(data){
	        	showTip(data.result.msg,2000);
		        if(data.result.success){
		        	setTimeout(function(){
		        		getOpener().selectBuilding(data.result.value.id,data.result.value.parkId);
				 		parent.fb.end();
					},2000);
		        }
		     } 
		  });
		} 
	}
	function checkRange(id1,id2,text){
		if ($("#"+id1).val()=="" && $("#"+id2).val()=="") {
			return true;
		}
		if ($("#propertyBegin").val()!="") {
			if(checkDouble("propertyBegin","物业费起")==false){
				return;
			}
		}
		if ($("#propertyEnd").val()!="") {
			if(checkDouble("propertyEnd","物业费止")==false){
				return;
			}
		}
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
			showTip(text+"区间有误");
			return false;
		}else{
			return true;
		}
	}
</script>
</head>

<body>
<form action="<%=basePath %>building!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">所在园区：</td>
      <td width="190" class="layerright">${result.value.name}
      	<input type="hidden" name="building.parkId" value="${result.value.id}" />
      </td>
      <td class="layertdleft100"><span class="psred">*</span>楼宇名称：</td>
      <td width="185"><input id="name" name="building.name" type="text"  class="input170" /></td>
      
      <td class="layertdleft100">楼宇类型：</td>
      <td width="170" class="layerright">
      	<dd:select name="building.typeId" key="pb.0001" />
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">楼宇性质：</td>
      <td class="layerright"><dd:select name="building.kindId" key="pb.0002" /></td>
      <td class="layertdleft100">总建筑面积：</td>
      <td class="layerright">
      <table width="100%"  border="0" cellspacing="0">
      <tr><td><input id="realArea" name="building.realArea" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'')"/> </td>
      <td width="30" align="center">(㎡)</td>
      </tr></table>
    </td>
      <td class="layertdleft100">商务面积：</td>
      <td class="layerright"><input id="commericalArea" name="building.commericalArea" type="text" class="input100" onkeyup="value=value.replace(/[^\d\.]/g,'')"/>
      (㎡)</td>
    </tr>
    <tr>
      <td class="layertdleft100">招商方向：</td>
      <td class="layerright">
      <dd:select name="building.investDirectionId" key="pb.0003" />
      </td>
      <td class="layertdleft100">竣工日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><input id="completeDate" name="building.completeDate" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('completeDate');"/></td>
          <td width="20" ><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('completeDate');"/></td>
        </tr>
      </table></td>
      <td class="layertdleft100">物业费区间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
          <td>  <input id="propertyBegin" name="building.propertyBegin" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
		  <td width="10" align="center" style="padding-left: 3px;">-</td>
          <td><input id="propertyEnd" name="building.propertyEnd" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
          <td width="70" align="center" style="padding-left: 6px;">(元/月/平米)</td>	
        </tr>
      </table></td>
    </tr>
    <tr>
      <td class="layertdleft100">租金区间：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="10">
        <tr>
          <td><input id="rentBegin" name="building.rentBegin" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
          <td width="10" align="center" style="padding-left: 3px;">-</td>
          <td><input id="rentEnd" name="building.rentEnd" type="text" class="inputauto" size="8" onkeyup="value=value.replace(/[^\d\.]/g,'')"/></td>
          <td width="70" align="center" style="padding-left: 6px;">(元/月/平米)</td>		
        </tr>
      </table>      <label></label></td>
      <td class="layertdleft100">地下停车位：</td>
      <td class="layerright"><input id="downParkingSpaces" name="building.downParkingSpaces" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d]/g,'')"/> 个</td>
      <td class="layertdleft100">地上停车位：</td>
      <td class="layerright"><input id="upParkingSpaces" name="building.upParkingSpaces" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d]/g,'')"/> 个</td>
    </tr>
    <tr>
      <td class="layertdleft100">小时停车费：</td>
      <td class="layerright"><input id="hourParkingFee" name="building.hourParkingFee" type="text" class="inputauto" style="width:100px;"  onkeyup="value=value.replace(/[^\d\.]/g,'')"/> 元/小时</td>
      <td class="layertdleft100">地下车位租金：</td>
      <td class="layerright"><input id="downParkingFee" name="building.downParkingFee" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d\.]/g,'')"/> 元/月</td>
      <td class="layertdleft100">地上车位租金：</td>
      <td class="layerright"><input id="upParkingFee" name="building.upParkingFee" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d\.]/g,'')"/> 元/月</td>
    </tr>
    <tr>
      <td class="layertdleft100">客梯数：</td>
      <td class="layerright"><input id="passengerElevator" name="building.passengerElevator" type="text" class="inputauto" style="width:100px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>个</td>
      <td class="layertdleft100">货梯数：</td>
      <td class="layerright"><input id="cargoElevator" name="building.cargoElevator" type="text" class="input100" style="width:100px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>个</td>
      <td class="layertdleft100">空调设施：</td>
      <td class="layerright">
      	<dd:select name="building.airconSituationId" key="pb.0004" />
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">装修情况：</td>
      <td class="layerright">
      <dd:select name="building.decorationSituationId" key="pb.0005" />
     </td>
      <td class="layertdleft100">联系人：</td>
      <td class="layerright"><input name="building.contact" type="text" class="input100" /></td>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright"><input id="tel" name="building.tel" type="text" class="inputauto"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">招商热线：</td>
      <td class="layerright"><input id="investTel" name="building.investTel" type="text" class="inputauto" /></td>
      <td class="layertdleft100">地址：</td>
      <td colspan="3" class="layerright"><input name="building.address" type="text" class="inputauto" /></td>
      </tr>
    <tr>
      <td class="layertdleft100">最小房间面积：</td>
      <td class="layerright">
      	<table width="100%"  border="0" cellspacing="0">
      <tr><td><input id="minArea" name="building.minArea" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'')"/> </td>
      <td width="30" align="center">(㎡)</td>
      </tr></table>
      </td>
      <td class="layertdleft100">最大房间面积：</td>
      <td colspan="3" class="layerright"><table width="100%"  border="0" cellspacing="0">
      <tr><td><input id="maxArea" name="building.maxArea" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'')"/> </td>
      <td width="30" align="center">(㎡)</td>
      </tr></table></td>
      </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<div class="basediv">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">楼宇介绍：</td>
      <td class="layerright" style=" padding-bottom:2px;  padding-top:2px;"><label>
        <textarea name="building.summary" style="height:40px;" class="textareaauto"></textarea>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">周边配套设施：</td>
      <td class="layerright"  style=" padding-bottom:2px;"><textarea name="building.supportSituation" style="height:40px;" class="textareaauto"></textarea></td>
    </tr>
    <tr>
      <td class="layertdleft100">交通情况：</td>
      <td class="layerright"><textarea name="building.trafficSituation" style="height:40px;" class="textareaauto"></textarea></td>
    </tr>
    <tr>
      <td class="layertdleft100">照片：</td>
      <input type="hidden" id="photos" name="building.photos" />
      <td class="layerright">
      <table border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td height="60" width="100"> <input type="file" id="fileUpload" /> <div id="fileQueue"></div> </td>
      <td>
	      <table  border="0" cellspacing="0" cellpadding="0">
	      	<tr id="imageList"></tr>
	      </table>
      </td>
      </tr>
      </table>
      </td>
    </tr>
  </table>
</div>
<!--basediv-->

<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
