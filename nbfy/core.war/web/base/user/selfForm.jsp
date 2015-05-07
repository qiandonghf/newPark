<%--@elvariable id="enums" type="java.util.Map<String, Map<String, String>>"--%>
<%@page import="com.wiiy.commons.action.BaseAction"%><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="${rootLocation}"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/tree/themes/default/easyui.css" rel="stylesheet" type="text/css"/>
<link href="core/common/tree/themes/icon.css" rel="stylesheet" type="text/css"/>
<link href="core/common/tree/demo/demo.css" rel="stylesheet" type="text/css"/>

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
<script>
	function reload(){
		$('#cc').combotree('reload');
	}
	function setValue(){
		$('#cc').combotree('setValue', 2);
	}
	function getValue(){
		var val = $('#cc').combotree('getValue');
	}
	function disable(){
		$('#cc').combotree('disable');
	}
	function enable(){
		$('#cc').combotree('enable');
	}
    $(document).ready(function() {
		initTip();
       $('#selfForm').submit(function(e) {
    	   e.preventDefault();
    	   $("#user_imagery").val($("#user_imagery_img").attr("src"));
    	   if($("#username").val()==null||$("#username").val()==""){
    		   showTip("用户名不能为空！");
    		   return;
    	   }
    	   if($("#realName").val()==null||$("#realName").val()==""){
    		   showTip("真实姓名不能为空！");
    		   return;
    	   }
    	   if($("#email").val()==null||$("#email").val()==""){
    		   showTip("email不能为空！");
    		   return;
    	   }
           $(this).ajaxSubmit({
				success:function(result, statusText) {
					showTip(result.msg);
                }
            });
            return false;
        });
       
   		initUploadify("fileUpload");
    });
    
	function initUploadify(id){
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			//'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'core','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: "${rootLocation}core/upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: "30",//按钮图片的长度
			'height'			: uploadify.height,//按钮图片的高度
			'buttonText'		: "上传",
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: uploadify.images.fileTypeDesc,//选择文件对话框文件类型描述信息
			'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
			'onUploadSuccess'	: onUploadSuccess//上传成功回调函数 有三个参数 file(可取文件名  注：上传前的文件名不是服务器端重写的文件名) data(服务器端写到response里面的信息) response(true,false)
		});
	}
	function onUploadSuccess(file, data, response) {
		$("#user_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
	}
	function startUpload(id){
		$("#"+id).uploadify("upload");
	}
	function removeImagery() {
		var userImagery = $("#user_imagery_img").attr("src");
		$("#user_imagery_img").attr("src", userImagery + "-d");
		$("#user_imagery").val("core/common/images/topxiao.gif");
		$("#user_imagery_img").attr("src", "core/common/images/topxiao.gif");
	}
</script>
</head>

<body>
<form id="selfForm" name="selfForm" method="post" action="core/self!update.action">
<input type="hidden" name="user.id" value="${user.id}" />
<input type="hidden" name="user.admin" value="${user.admin}" />

<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="layertitle" style="height:27px; line-height:27px;">基本信息</div>
	<!--//titlebg-->
	<!--divlay-->
	<div class="divlays">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          	<td width="350"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft"><span class="psred">*</span>用户名：</td>
					<td><label>
						<input id="username" name="user.username" type="text" class="input200" value="${user.username}"/>
					</label></td>
				</tr>
				<tr>
					<td class="layertdleft"><span class="psred">*</span>真实姓名：</td>
					<td class="layerright">
						<input name="user.realName" id="realName" type="text" class="input100" value="${user.realName}"/>
					</td>
				</tr>
				<tr>
					<td class="layertdleft"><span class="layertdleft40">性别：</span></td>
					<td class="layerright"><label>
                   		<enum:radio name="user.gender" type="com.wiiy.commons.preferences.enums.GenderEnum" checked="user.gender" />
                   		</label></td>
				</tr>
				<tr>
					<td class="layertdleft">出生年月：</td>
					<td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
			                    <td width="183"><input name="user.birthday" type="text" class="inputauto" id="user.birthday" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${user.birthday}"/>' /></td>
			                    <td width=20><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left: -1px;" onclick="return showCalendar('user.birthday', 'y-mm-dd');"/></td>
			                    <td>&nbsp;</td>
							</tr>
					</table></td>
				</tr>
				<tr>
				  <td class="layertdleft" style="height:104px;">头像设置：</td>
				  <td><table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="96">
              			<c:if test="${user.imagery != null}">
                      	<img id="user_imagery_img" style="margin-top:1px;" src="${user.imagery}" width="90" height="90" class="touxian" />
              			</c:if>
              			<c:if test="${user.imagery == null}">
                      	<img id="user_imagery_img" style="margin-top:1px;" src="core/common/images/topxiao.gif" width="90" height="90" class="touxian" />
              			</c:if>
                      </td>
                      <td width="15" align="center" valign="bottom" style="padding-bottom:6px;"><img src="core/common/images/xtopico3.png" width="13" height="13" onclick="removeImagery()"/></td>
                      <td valign="top" style="padding-top:12px;">
				      <input type="file" id="fileUpload" />
				      <input type="hidden" id="user_imagery" name="user.imagery" value="${user.imagery}"/>
                      <!-- <img src="core/common/images/uploadbtn.png" width="47" height="22" /> -->
                      </td>
                    </tr>
                  </table></td>
			  </tr>
			</table></td>
       	</tr>
      </table>
	</div>
	 <!--titlebg-->
	<div class="layertitle" style="border-top:1px solid #c9c9c9;height:27px; line-height:27px;">联系方式</div>
	<div class="divlays">
	<!--//titlebg-->
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="300"><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
				<td class="layertdleft">移动电话：</td>
            	<td>
            	<input name="user.mobile" type="text" class="input200" value="${user.mobile}" />
            	</td>
            	</tr>
            <tr>
				<td class="layertdleft">固定电话：</td>
           		<td>
           		<input name="user.telephone" type="text" class="input200" value="${user.telephone}" />
           		</td>
           </tr>
            <tr>
              <td class="layertdleft"><span class="psred">*</span>Email：</td>
              <td><label>
              	<input name="user.email" id="email" type="text" class="input200" value="${user.email}" />
              </label></td>
            </tr>
            <tr>
              <td class="layertdleft">MSN：</td>
              <td><input name="user.msn" type="text" class="input200" value="${user.msn}" /></td>
            </tr>

          </table></td>
          </tr>
      </table>
	  </div>
	<div class="hackbox"></div>
</div>
<!--//basediv-->

<div class="buttondiv" style=" text-align:left; padding-left:105px;">
  <label>
  <input name="Submit" type="submit" class="savebtn" value="" />
  </label>
  <input name="Submit2" type="button" class="cancelbtn" value="" />
</div>
</form>
</body>
</html>
