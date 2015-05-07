<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.wiiy.pb.preferences.enums.GardenProjectSourceEnum" %>
<%@ page language="java" import="com.wiiy.pb.preferences.enums.GardenProjectTypeEnum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script>
$(function(){
	initTip();
	initForm();
	sourceChange();
	typeChange();
	contact();
	initUploadify("teamPic");
});


function initUploadify(id){
	var root = '<%=BaseAction.rootLocation %>/';
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: root+"core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: 80,//按钮图片的长度
		'height'			: "20",//按钮图片的高度
		'buttonText'		: "上传图片",
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: uploadify.images.fileTypeExts,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: uploadify.images.fileTypeExts,//可上传上的文件类型
		'onUploadSuccess'	: function(file, data, response){
			onUploadSuccess(file, data, response);
		}
	});
}

function onUploadSuccess(file, data, response) {
	showTip("文件读取成功!",2000);
	var info = $.parseJSON(data);
	var path = info.path;
	var oldName = info.originalName;
	var size = info.size;
	$("#teamPicSrc").html(setPicText(path,oldName,size));
}

function setPicText(path,oldName,size){
	var htmlText = "";
	htmlText += "<div class=\'downlistleft\'>";
	htmlText +="<img src=\'core/common/images/rar.png\'/>";
	htmlText +="<input name=\'gardenApply.photo\' type=\'hidden\' value=\'"+path+"\'/>";
	htmlText +="<input name=\'gardenApply.oldName\' type=\'hidden\' value=\'"+oldName+"\'/>";
	htmlText +="<ul>";
	htmlText +="<li><em class=\'lititle\' title=\'"+oldName+"\'>"+oldName+"</em>";
	htmlText +="</li><li>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'download(this);\'>下载</a>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'deletePic(this);\'>删除</a>";
	htmlText +="</li>";
	htmlText +="</ul>";
	htmlText +="</div>";
	return htmlText;
}

function initForm(){
	$("#form1").validate({
		rules: {
			"gardenApply.applyer":"required",
			"gardenApply.projectName":"required"
		},
		messages: {
			"gardenApply.applyer":"请输入申请人",
			"gardenApply.projectName":"请输入项目名称"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			if(checkValue()){
				$(form).ajaxSubmit({
			        dataType: 'json',
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("closeWeb();", 2000);
			        	}
			        } 
			    });
			}
		}
	});
}

function checkValue(){
	var value= $("input[name='gardenApply.projectSource']:checked").val();
	if(value == 'OTHER'){
		var sourceDetail = $("input[name='gardenApply.sourceDetail']").val();
		sourceDetail = sourceDetail.replace(/(^\s*)|(\s*$)/g, "");
		$("input[name='gardenApply.sourceDetail']").val(sourceDetail);
		if(!sourceDetail){
			showTip("请输入项目来源");
			$("input[name='gardenApply.sourceDetail']").focus();
			return false;
		}
	}
	value= $("input[name='gardenApply.projectType']:checked").val();
	if(value == 'OTHER'){
		var projectTypeDetail = $("input[name='gardenApply.projectTypeDetail']").val();
		projectTypeDetail = projectTypeDetail.replace(/(^\s*)|(\s*$)/g, "");
		$("input[name='gardenApply.projectTypeDetail']").val(projectTypeDetail);
		if(projectTypeDetail == ''){
			showTip("请输入项目类型");
			$("input[name='gardenApply.projectTypeDetail']").focus();
			return false;
		}
	}
	return true;
		
}

function closeWeb(){
	window.opener.location.href=window.opener.location.href;
	parent.location.reload();
	window.close();
}

function deal(){
	$(".step li").eq(index).removeClass("active");
	switch(index){
	case 0:
		$(".app_table_wrapper").addClass("hide");
		$(".attachment").removeClass("hide");
		index ++;
		break;
	case 1:
		$(".attachment").addClass("hide");
		$(".app-finish").removeClass("hide");
		index ++;
		$(".nextbtn:eq(0)").addClass("hide");
		$(".nextbtn:eq(1)").removeClass("hide");
		break;
	}
	$(".step li").eq(index).addClass("active");
}

function contact(){
	$("input[name='gardenApply.leaderPhone']").blur(function(){
		var mobile = $("input[name='gardenApply.leaderMobile']");
		var phoneNum = $(this).val();
		var mobileNum =$(mobile).val();
		if(mobileNum == phoneNum &&(mobileNum != ''&& phoneNum != '') ){
			alert("紧急联络号码不能与联系人手机号码重复");
			$(this).focus();
		}
	});
}

function sourceChange(){
	$("input[name='gardenApply.projectSource']").change(function(){
		var value= $("input[name='gardenApply.projectSource']:checked").val();
		if(value == 'OTHER')
			$("input[name='gardenApply.sourceDetail']").focus();
	});
}

function typeChange(){
	$("input[name='gardenApply.projectType']").change(function(){
		var value= $("input[name='gardenApply.projectType']:checked").val();
		if(value == 'OTHER')
			$("input[name='gardenApply.projectTypeDetail']").focus();
	});
}

function download(obj){
	var parent =$(obj).parent().parent().parent();
	var path= $(parent).children().eq(1).val();
	var name= $(parent).children().eq(2).val();
	location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
}

function deletePic(obj){
	if(confirm("确定要删除")){
		var parent =$(obj).parent().parent().parent();
		$(parent).children().eq(1).val("");
		$(parent).children().eq(2).val("");
		$(parent).children().eq(0).remove();
		$(obj).parent().parent().remove();
	}
}

</script>
<title>编辑申请</title>
<style>
	
.uploadify-button {
	background: #fff /*url("../core/common/images/emailadd.gif")*/;
	background-position: left center;
	background-repeat: no-repeat;
	border: 1px solid #fff;;
	color: #1F699D;
	font: 12px Arial, Helvetica, sans-serif;
	/*padding-left:10px;*/
	position: relative;
	text-align: center;
	top: 1px;
	width: 100%;
}
.leftemail ul li span {
	display: inline;
	float: left;
	height: 20px;
	line-height: 20px;
	padding-right: 3px;
	position: relative;
	top:-1px;
}
.uploadify:hover .uploadify-button {
	background-color: #fff;
	color: #1F699D;
	background-position: left center;
}
</style>
</head>

<body style="background:#fff;">
<form id="form1" name="form1" action="<%=basePath %>garden!applyUpdate.action" method="post">
<input name="gardenApply.id" value="${result.value.id }" type="hidden"/>
<div class="step clearfix">
  <ul>
    <li class="" style="width:100%;">基本信息</li>
  </ul>
</div>
<div class="app_table_wrapper">
  <div class="app_tables">
  <div class="app_header clearfix">
  	<ul>
        <li class="fl"><span class="psred">*</span><span>申请人：</span><input name="gardenApply.applyer" value="${result.value.applyer }" class="app_input" style="width:200px;"/></li>
        <li class="fr" style="line-height:23px;margin-right:15px;">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><span  style="line-height:23px;width:65px;">申请时间：</span></td>
					<td width="145"><input style="border:0px;padding-top:3px;padding-bottom:3px;margin-right:2px;" value='<fmt:formatDate value="${result.value.applyTime }" pattern="yyyy-MM-dd"/> ' id="applyTime" name="gardenApply.applyTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('applyTime');"/></td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('applyTime');"/></td>
				</tr>
			</table>
        </li>
    </ul>
  </div>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="app_table">
      <tr>
        <td class="app_td" width="80" align="center" valign="middle"><span class="psred">*</span>项目名称</td>
        <td class="app_td"><input name="gardenApply.projectName" value="${result.value.projectName }" class="app_input"/></td>
      </tr>
      <tr>
        <td  class="app_td" align="center" valign="middle">项目来源</td>
        <td><table  width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td"><label>A.导师课题
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.TEACHER %>" <c:if test="${result.value.projectSource eq 'TEACHER' }">checked="checked"</c:if> type="radio"/>
                </label></td>
            </tr>
            <tr>
              <td class="app_td"><label>B.学生自行拟定
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.STUDENT %>" <c:if test="${result.value.projectSource eq 'STUDENT' }">checked="checked"</c:if> type="radio"/>
                </label></td>
            </tr>
            <tr>
              <td class="app_td"><label>C.其它
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.OTHER %>" <c:if test="${result.value.projectSource eq 'OTHER' }">checked="checked"</c:if> type="radio"/>
                </label>
                <input name="gardenApply.sourceDetail" <c:if test="${result.value.projectSource eq 'OTHER' }">value="${result.value.sourceDetail }"</c:if> class="app_input_border"/></td>
            </tr>
            <tr>
              <td class="app_td">注:如选择C,请予以具体说明</td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目类型</td>
        <td><table  width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td">
              	<label>A.产品
                  <input name="gardenApply.projectType"  class="app_td_checkbox" value="<%=GardenProjectTypeEnum.PRODUCT %>" <c:if test="${result.value.projectType eq 'PRODUCT' }">checked="checked"</c:if> type="radio"/>
                </label>
              </td>
            </tr>
            <tr>
              <td class="app_td">
              	<label>B.服务
                  <input name="gardenApply.projectType" class="app_td_checkbox" value="<%=GardenProjectTypeEnum.SERVICE %>" <c:if test="${result.value.projectType eq 'SERVICE' }">checked="checked"</c:if> type="radio"/>
                </label>
              </td>
            </tr>
            <tr>
              <td class="app_td">
              	<label>C.其它
                  <input name="gardenApply.projectType" class="app_td_checkbox" value="<%=GardenProjectTypeEnum.OTHER %>" <c:if test="${result.value.projectType eq 'OTHER' }">checked="checked"</c:if> type="radio"/>
                </label>
                <input name="gardenApply.projectTypeDetail" <c:if test="${result.value.projectType eq 'OTHER' }">value="${result.value.projectTypeDetail}"</c:if> class="app_input_border"/>
              </td>
            </tr>
            <tr>
              <td class="app_td">注:如选择C,请予以具体说明</td>
            </tr>
          </table></td>
      </tr>
      <tr>
      	<td class="app_td" align="center" valign="middle">是否融资</td>
      	<td class="app_td">
      		<label>是
            	<input name="gardenApply.financing" class="app_td_checkbox" value="<%=BooleanEnum.YES %>" <c:if test="${result.value.financing eq 'YES' }">checked="checked"</c:if> type="radio"/>
            </label>
            <label>否
            	<input name="gardenApply.financing" class="app_td_checkbox" value="<%=BooleanEnum.NO %>" <c:if test="${result.value.financing eq 'NO' }">checked="checked"</c:if> type="radio"/>
            </label>
            <span style="color:#f00;margin-left:15px;">注:如选择是,则该项目的信息将对外发布</span>
      	</td>
      </tr>
      <tr>
      	<td class="app_td" align="center" valign="middle">是否发布</td>
      	<td class="app_td">
      		<label>是
            	<input name="gardenApply.pub" class="app_td_checkbox" value="<%=BooleanEnum.YES %>" <c:if test="${result.value.pub eq 'YES' }">checked="checked"</c:if> type="radio"/>
            </label>
            <label>否
            	<input name="gardenApply.pub" class="app_td_checkbox" value="<%=BooleanEnum.NO %>" <c:if test="${result.value.pub eq 'NO' }">checked="checked"</c:if> type="radio"/>
            </label>
            <span style="color:#f00;margin-left:15px;">注:如选择是,则该项目会发布到网站</span>
      	</td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目负责人<br/>联系方式</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td" width="100">姓名</td>
              <td class="app_td" width="150"><input name="gardenApply.leaderName" value="${result.value.leaderName}" class="app_input"/></td>
              <td width="100" class="app_td">手机 </td>
              <td class="app_td"><input name="gardenApply.leaderMobile" value="${result.value.leaderMobile}" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td">E-mail </td>
              <td class="app_td"><input name="gardenApply.leaderEmail" value="${result.value.leaderEmail}" class="app_input"/></td>
              <td class="app_td">QQ</td>
              <td class="app_td"><input name="gardenApply.leaderQQ" value="${result.value.leaderQQ}" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td">学校</td>
              <td class="app_td"><input name="gardenApply.leaderSchool" value="${result.value.leaderSchool}" class="app_input"/></td>
              <td class="app_td">院系年级</td>
              <td class="app_td"><input name="gardenApply.leaderCollege" value="${result.value.leaderCollege}" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td" colspan="2">紧急联络方式(不要重复手机)</td>
              <td class="app_td" colspan="2"><input name="gardenApply.leaderPhone" value="${result.value.leaderPhone}" class="app_input" /></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目简介</td>
        <td class="app_td" style="padding:2px 5px;">
          <textarea name="gardenApply.introduction" id="textarea" style="width:100%;resize:none;margin:2px 0px 1px;border:0px;height:60px;">${result.value.introduction}</textarea>
        </td>
      </tr>
      <tr>
      	<td class="app_td" align="center" valign="middle">项目成员图片</td>
      	<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td style="border-bottom:1px solid #ddd;border-right:1px solid #ddd;">
              	<div class="merchantsTtitle" style="width:10%;float:left;border:0px;padding:12px 2px;">
					<ul>
						<li><input id="teamPic" type="file"/></li>
					</ul>
				</div>
				<div class="divlays teamPicSrc" style="float:left;width:85%;">
					<div class="emaildown" style="padding:0px;margin:0px;height:47px;border:0px;background-color:#fff;">
						<div id="teamPicSrc" style="display:block;">
							<c:if test="${not empty result.value.photo }">
							<div class="downlistleft">
								<img src="core/common/images/rar.png" />
								<input value="${result.value.photo }" type="hidden" name="gardenApply.photo" />
								<input value="${result.value.oldName }" type="hidden" name="gardenApply.oldName" />
								<ul>
									<li><em class="lititle" title="${result.value.oldName }">${result.value.oldName }</em></li>
									<li>
										<a onclick="download(this);" href="javascript:void(0);">下载</a>
										<a onclick="deletePic(this);" href="javascript:void(0);">删除</a>
									</li>
								</ul>
							</div>
							</c:if>
							<c:if test="$ empty result.value.oldName }">&nbsp;</c:if>
						</div>
						<div class="hackbox"></div>
					</div>
				</div>
			  </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目信息</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="220" align="center" class="app_td">曾经参加比赛</td>
              <td class="app_td"><input name="gardenApply.competition" value="${result.value.competition}" class="app_input"/></td>
            </tr>
            <tr>
              <td width="220" align="center" class="app_td">曾获奖励/专利</td>
              <td class="app_td"><input name="gardenApply.reward" value="${result.value.reward}" class="app_input"/></td>
            </tr>
            <tr>
              <td width="220" align="center" class="app_td">指导老师</td>
              <td class="app_td"><input name="gardenApply.teacher" value="${result.value.teacher}" class="app_input"/></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目成员</td>
        <td>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	              <td class="app_td" align="center">姓名</td>
	              <td class="app_td" align="center">专业</td>
	              <td class="app_td" align="center">联系方式</td>
	              <td class="app_td" align="center">在项目中的职能</td>
	            </tr>
	            <tr>
			        <td class="app_td" align="center"><input name="gardenApply.memberName1" value="${result.value.memberName1 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberMajor1" value="${result.value.memberMajor1 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberPhone1" value="${result.value.memberPhone1 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberRole1" value="${result.value.memberRole1 }" class="app_input"/></td>
 				</tr>
 				<tr>
			        <td class="app_td" align="center"><input name="gardenApply.memberName2" value="${result.value.memberName2 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberMajor2" value="${result.value.memberMajor2 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberPhone2" value="${result.value.memberPhone2 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberRole2" value="${result.value.memberRole2 }" class="app_input"/></td>
 				</tr>
 				<tr>
			        <td class="app_td" align="center"><input name="gardenApply.memberName3" value="${result.value.memberName3 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberMajor3" value="${result.value.memberMajor3 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberPhone3" value="${result.value.memberPhone3 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberRole3" value="${result.value.memberRole3 }" class="app_input"/></td>
 				</tr>
 				<tr>
			        <td class="app_td" align="center"><input name="gardenApply.memberName4" value="${result.value.memberName4 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberMajor4" value="${result.value.memberMajor4 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberPhone4" value="${result.value.memberPhone4 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberRole4" value="${result.value.memberRole4 }" class="app_input"/></td>
 				</tr>
 				<tr>
			        <td class="app_td" align="center"><input name="gardenApply.memberName5" value="${result.value.memberName5 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberMajor5" value="${result.value.memberMajor5 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberPhone5" value="${result.value.memberPhone5 }" class="app_input"/></td>
			        <td class="app_td" align="center"><input name="gardenApply.memberRole5" value="${result.value.memberRole5 }" class="app_input"/></td>
 				</tr>
          	</table>
          </td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">入驻要求</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td" align="center" valign="middle">需用工位数</td>
              <td><table  width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td class="app_td"><label>A.1个工位
                        <input name="gardenApply.tableCnt" <c:if test="${result.value.tableCnt eq '1' }">checked="checked"</c:if> class="app_td_checkbox" value="1" checked="checked" type="radio"/>
                      </label></td>
                  </tr>
                  <tr>
                    <td class="app_td"><label>B.2个工位
                        <input name="gardenApply.tableCnt" <c:if test="${result.value.tableCnt eq '2' }">checked="checked"</c:if> class="app_td_checkbox" value="2"  type="radio"/>
                      </label></td>
                  </tr>
                  <tr>
                    <td class="app_td"><label>C.3个工位
                        <input name="gardenApply.tableCnt" <c:if test="${result.value.tableCnt eq '3' }">checked="checked"</c:if> class="app_td_checkbox" value="3"  type="radio"/>
                      </label></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
    </table>
  </div>
</div>
<div class="buttondiv" style="margin-top:5px;">
	<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
	<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="window.close();"/></label>
</div>
</form>
</body>
</html>

