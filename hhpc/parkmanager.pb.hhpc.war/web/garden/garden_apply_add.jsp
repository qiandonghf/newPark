<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.pb.preferences.enums.GardenApplySourceEnum"%>
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
var index = 0;
var type = "add";
$(function(){
	initTip();
	initForm();
	sourceChange();
	typeChange();
	contact();
	initUploadify("businessPlan","上传","100",true,"*.*");
	initUploadify("otherAtt","上传","60",false,"*.*");
	initUploadify("teamPic","上传图片","80",false,uploadify.images.fileTypeExts);
});



function initUploadify(id,name,width,isBusiness,fileType){
	var root = '<%=BaseAction.rootLocation %>/';
	$("#"+id).uploadify( {
		'auto'				: true, //是否自动开始 默认true
		'multi'				: false, //是否支持多文件上传 默认true
		'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
		'uploader'			: root+"core/upload.action",
		'swf'				: uploadify.swf,//上传组件swf
		'width'				: width,//按钮图片的长度
		'height'			: "20",//按钮图片的高度
		'buttonText'		: name,
		'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
		'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
		'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
		'fileTypeDesc'		: fileType,//选择文件对话框文件类型描述信息
		'fileTypeExts'		: fileType,//可上传上的文件类型
		'onUploadSuccess'	: function(file, data, response){
			onUploadSuccess(file, data, response,isBusiness,id);
		}
	});
}

function onUploadSuccess(file, data, response,isBusiness,cid) {
	showTip("文件读取成功!",2000);
	var info = $.parseJSON(data);
	var path = info.path;
	var oldName = info.originalName;
	var size = info.size;
	var type = "";
	var id= $("input[name='gardenApply.applyId']").val();
	if(isBusiness)
		type = "BUSINESSPLAN";
	else
		type = "OTHER";
	if(cid != 'teamPic'){
		var postData = {"gardenApplyAtt.applyId":id,"gardenApplyAtt.name":oldName,"gardenApplyAtt.newName":path,"gardenApplyAtt.size":size,"gardenApplyAtt.type":type};
		$.ajax({
			type:"post",
			data:postData,
			url :"<%=basePath%>garden!attSave.action",
			success:function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					if(isBusiness){
						$(".business").show();
						$("#business").html($("#business").html()+setText(path,oldName,size,data.result.value.id));
					}else{
						$(".otherSrc").show();
						$("#otherSrc").html($("#otherSrc").html()+setText(path,oldName,size,data.result.value.id));
					}
				}
			}
		});
	}else{
		$("#teamPicSrc").html(setPicText(path,oldName,size));
	}
}

function setPicText(path,oldName,size){
	var htmlText = "";
	htmlText += "<div class=\'downlistleft\'>";
	htmlText +="<img src=\'core/common/images/rar.png\'/>";
	htmlText +="<input name=\'gardenApply.photo\' type=\'hidden\' value=\'"+path+"\'/>";
	htmlText +="<input name=\'gardenApply.oldName\' type=\'hidden\' value=\'"+oldName+"\'/>";
	htmlText +="<ul>";
	htmlText +="<li><em class=\'lititle\' title=\'"+oldName+"\'>"+oldName+"</em><span>("+Math.round(size/1024)+"KB)</span";
	htmlText +="</li><li>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'downAttr(this);\'>下载</a>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'deletePic(this);\'>删除</a>";
	htmlText +="</li>";
	htmlText +="</ul>";
	htmlText +="</div>";
	return htmlText;
}

function setText(path,oldName,size,id){
	var htmlText = "";
	htmlText += "<div class=\'downlistleft\'>";
	htmlText +="<img src=\'core/common/images/word.png\'/>";
	htmlText +="<input type=\'hidden\' value=\'"+path+"\'/>";
	htmlText +="<input class=\'att"+id+"\' type=\'hidden\' value=\'"+oldName+"\'/>";
	htmlText +="<ul>";
	htmlText +="<li><em class=\'lititle att"+id+"\' title=\'"+oldName+"\'>"+oldName+"</em><span>("+Math.round(size/1024)+"KB)</span";
	htmlText +="</li><li>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'downAttr(this);\'>下载</a>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'rename("+id+");\'>重命名</a>";
	htmlText +="<a href=\'javascript:void(0);\' onclick=\'deleteAttr("+id+",this);\'>删除</a>";
	htmlText +="</li>";
	htmlText +="</ul>";
	htmlText +="</div>";
	return htmlText;
}

function refreshAtt(cls,name){
	$("."+cls).val(name);
	$("."+cls).text(name);
	$("."+cls).attr("title",name);
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
			if(index < 1){
				$(form).ajaxSubmit({
			        dataType: 'json',
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		$("input[name='gardenApply.applyId']").val(data.result.value.id);
			        		setTimeout("deal();", 2000);
			        	}
			        } 
			    });
			}else if(index >= 1){
				deal();
			}
		}
	});
}

function deal(){
	$(".step li").eq(index).removeClass("active");
	switch(index){
	case 0:
		$(".app_table_wrapper").addClass("hide");
		$(".attachment").removeClass("hide");
		$(".nextbtns:eq(1)").addClass("hide");
		index ++;
		break;
	case 1:
		$(".attachment").addClass("hide");
		$(".app-finish").removeClass("hide");
		index ++;
		$(".nextbtns:eq(0)").addClass("hide");
		$(".nextbtns:eq(1)").addClass("hide");
		$(".nextbtns:eq(2)").removeClass("hide");
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


function closeFrame(){
	var source = "${param.source }";
	if(source == "<%=GardenApplySourceEnum.CENTER %>"){
		window.opener.location.href=window.opener.location.href;
		window.close();
	}else
		window.close();
}

function deletePic(obj){
	var name = $(obj).parent().parent().parent().children().eq(2).val();
	var path = $(obj).parent().parent().parent().children().eq(1).val();
	if(confirm("确定要删除\""+name+"\"")){
		$.post("<%=basePath%>garden!deleteByPath.action?fileName="+path,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		setTimeout(function(){
        			$(obj).parent().parent().parent().remove();
        		}, 2000);
        	}
		});
	}
}

function deleteAttr(id,obj){
	if(confirm("确定要删除吗")){
		$.post("<%=basePath%>garden!attDelete.action?id="+id,function(data){
			showTip(data.result.msg,2000);
        	if(data.result.success){
        		setTimeout(function(){
        			$(obj).parent().parent().parent().remove();
        			var k = $("#business").text();
        			k = k.replace(/(^\s*)|(\s*$)/g, "");
        			if(k == ''){
        				$(".business").hide();
        			};
        			k= $("#otherSrc").text();
        			k = k.replace(/(^\s*)|(\s*$)/g, "");
        			if(k == ''){
        				$(".otherSrc").hide();
        			};
        		}, 2000);
        	}
		});
	}
}

function downAttr(obj){
	var name = $(obj).parent().parent().parent().children().eq(2).val();
	var path = $(obj).parent().parent().parent().children().eq(1).val();
	location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
}

function rename(id){
	fbSearch('重命名','<%=basePath %>garden!attEdit.action?id='+id,333,67);
}

</script>

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
		
.nextbtn{
	background: url("core/common/images/next.png") no-repeat;
	width: 75px;
	height: 22px;
	border: none;
	cursor: pointer;
}
.cancelbtn{
	background: url("core/common/images/cancel.png") no-repeat;
	width: 75px;
	height: 22px;
	border: none;
	cursor: pointer;
}
.closebtn{
	background: url("core/common/images/close2.png") no-repeat;
	width: 75px;
	height: 22px;
	border: none;
	cursor: pointer;
}
</style>
<title>入圃申请</title>
</head>

<body style="background:#fff;">
<iframe id="download" src="about:blank" style="display:none" width="0px" height="0px"></iframe>
<form id="form1" name="form1" action="<%=basePath %>garden!applySave.action" method="post">
<input name="gardenApply.applySource" value="${param.source }" type="hidden"/>
<input name="gardenApply.applyId" type="hidden"/>
<div class="step clearfix">
  <ul>
    <li class="active">第一步：基本信息</li>
    <li>第二步：附件上传</li>
    <li>完成</li>
  </ul>
</div>
<div class="app_table_wrapper" >
  <div class="app_tables">
  <div class="app_header clearfix">
  	<ul>
        <li class="fl"><span class="psred">*</span><span>申请人：</span><input name="gardenApply.applyer" class="app_input" style="width:200px;"/></li>
        <li class="fr" style="line-height:23px;margin-right:15px;">
        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><span  style="line-height:23px;width:65px;">申请时间：</span></td>
					<td width="145"><input style="border:0px;padding-top:3px;padding-bottom:3px;margin-right:2px;" value='<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/> ' id="applyTime" name="gardenApply.applyTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('applyTime');"/></td>
					<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('applyTime');"/></td>
				</tr>
			</table>
        </li>
    </ul>
  </div>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="app_table">
      <tr>
        <td class="app_td" width="80" align="center" valign="middle"><span class="psred">*</span>项目名称</td>
        <td class="app_td"><input name="gardenApply.projectName" class="app_input"/></td>
      </tr>
      <tr>
        <td  class="app_td" align="center" valign="middle">项目来源</td>
        <td><table  width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td"><label>A.导师课题
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.TEACHER %>" checked="checked" type="radio"/>
                </label></td>
            </tr>
            <tr>
              <td class="app_td"><label>B.学生自行拟定
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.STUDENT %>" type="radio"/>
                </label></td>
            </tr>
            <tr>
              <td class="app_td"><label>C.其它
                  <input name="gardenApply.projectSource" class="app_td_checkbox" value="<%=GardenProjectSourceEnum.OTHER %>" type="radio"/>
                </label>
                <input name="gardenApply.sourceDetail" class="app_input_border"/></td>
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
                  <input name="gardenApply.projectType" class="app_td_checkbox" value="<%=GardenProjectTypeEnum.PRODUCT %>" checked="checked" type="radio"/>
                </label>
              </td>
            </tr>
            <tr>
              <td class="app_td">
              	<label>B.服务
                  <input name="gardenApply.projectType" class="app_td_checkbox" value="<%=GardenProjectTypeEnum.SERVICE %>" type="radio"/>
                </label>
              </td>
            </tr>
            <tr>
              <td class="app_td">
              	<label>C.其它
                  <input name="gardenApply.projectType" class="app_td_checkbox" value="<%=GardenProjectTypeEnum.OTHER %>" type="radio"/>
                </label>
                <input name="gardenApply.projectTypeDetail" class="app_input_border"/>
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
            	<input name="gardenApply.financing" class="app_td_checkbox" value="<%=BooleanEnum.YES %>" checked="checked" type="radio"/>
            </label>
            <label>否
            	<input name="gardenApply.financing" class="app_td_checkbox" value="<%=BooleanEnum.NO %>" type="radio"/>
            </label>
            <span style="color:#f00;margin-left:15px;">注:如选择是,则该项目的信息将对外发布</span>
      	</td>
      </tr>
      <tr>
      	<td class="app_td" align="center" valign="middle">是否发布</td>
      	<td class="app_td">
      		<label>是
            	<input name="gardenApply.pub" class="app_td_checkbox" value="<%=BooleanEnum.YES %>" checked="checked" type="radio"/>
            </label>
            <label>否
            	<input name="gardenApply.pub" class="app_td_checkbox" value="<%=BooleanEnum.NO %>" type="radio"/>
            </label>
            <span style="color:#f00;margin-left:15px;">注:如选择是,则该项目会发布到网站</span>
      	</td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目负责人<br/>联系方式</td>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="app_td" width="100">姓名</td>
              <td class="app_td" width="150"><input name="gardenApply.leaderName" class="app_input"/></td>
              <td width="100" class="app_td">手机 </td>
              <td class="app_td"><input name="gardenApply.leaderMobile" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td">E-mail </td>
              <td class="app_td"><input name="gardenApply.leaderEmail" class="app_input"/></td>
              <td class="app_td">QQ</td>
              <td class="app_td"><input name="gardenApply.leaderQQ" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td">学校</td>
              <td class="app_td"><input name="gardenApply.leaderSchool" class="app_input"/></td>
              <td class="app_td">院系年级</td>
              <td class="app_td"><input name="gardenApply.leaderCollege" class="app_input"/></td>
            </tr>
            <tr>
              <td class="app_td" colspan="2">紧急联络方式(不要重复手机)</td>
              <td class="app_td" colspan="2"><input name="gardenApply.leaderPhone" class="app_input" /></td>
            </tr>
          </table>
         </td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目简介</td>
        <td class="app_td" style="padding:2px 5px;">
          <textarea name="gardenApply.introduction" id="textarea" cols="80" rows="6" style="resize:none;"></textarea>
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
							&nbsp;
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
              <td class="app_td"><input name="gardenApply.competition" class="app_input"/></td>
            </tr>
            <tr>
              <td width="220" align="center" class="app_td">曾获奖励/专利</td>
              <td class="app_td"><input name="gardenApply.reward" class="app_input"/></td>
            </tr>
            <tr>
              <td width="220" align="center" class="app_td">指导老师</td>
              <td class="app_td"><input name="gardenApply.teacher" class="app_input"/></td>
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
	            <c:forEach begin="1" end="5" var="index">
	            <tr>
	           	  <td class="app_td" align="center"><input name="gardenApply.memberName${index }" class="app_input"/></td>
	              <td class="app_td" align="center"><input name="gardenApply.memberMajor${index }" class="app_input"/></td>
	              <td  class="app_td"align="center"><input name="gardenApply.memberPhone${index }" class="app_input"/></td>
	              <td class="app_td" align="center"><input name="gardenApply.memberRole${index }" class="app_input"/></td>
	            </tr>
	            </c:forEach>
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
                        <input name="gardenApply.tableCnt" class="app_td_checkbox" value="1" checked="checked" type="radio"/>
                      </label></td>
                  </tr>
                  <tr>
                    <td class="app_td"><label>B.2个工位
                        <input name="gardenApply.tableCnt" class="app_td_checkbox" value="2"  type="radio"/>
                      </label></td>
                  </tr>
                  <tr>
                    <td class="app_td"><label>C.3个工位
                        <input name="gardenApply.tableCnt" class="app_td_checkbox" value="3"  type="radio"/>
                      </label></td>
                  </tr>
                </table></td>
            </tr>
          </table></td>
      </tr>
    </table>
  </div>
</div>
<!--第二步-->
<div class="attachment hide">
  <div class="merchantsTtitle">
    <ul>
      <li><strong class="fl">附件</strong></li>
    </ul>
  </div>
  <div class="divlays" style="padding:2px 5px 10px 5px;"> 
 	<div style=" margin:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="10"></td>
			</tr>
			<tr>
				<td>
					<div class="merchantsTtitle">
						<ul>
							<li><em>创业计划书</em><span><input id="businessPlan" type="file"/></span></li>
						</ul>
					</div>
				</td>
			</tr>
			<tr class="agreementTR">
				<td >
					<div class="divlays business" style="padding:2px 5px 0px 5px;display:none;">
						<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
							<div id="business" style="display:block;">
							</div>
							<div class="hackbox"></div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<div style=" margin:5px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="10"></td>
			</tr>
			<tr>
				<td>
					<div class="merchantsTtitle">
						<ul>
							<li><em>附件材料</em><span><input id="otherAtt" type="file"/></span></li>
						</ul>
					</div>
				</td>
			</tr>
			<tr class="agreementTR">
				<td >
					<div class="divlays otherSrc" style="padding:2px 5px 0px 5px;display:none;">
						<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
							<div id="otherSrc" style="display:block;">
								
							</div>
							<div class="hackbox"></div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
  </div>
</div>
<!--第二步-->
<div class="app-finish hide">入圃申请提交成功，等待审核</div>
<div class="buttondiv PT10">
  <label><input name="Submit1" type="submit" class="nextbtns nextbtn" value="" /></label>
  <label><input name="Submit2" type="submit" class="nextbtns cancelbtn" value="" onclick="window.close();"/></label>
	<label><input name="Submit3" type="submit" class="nextbtns closebtn hide" value="" onclick="closeFrame();"/></label>
</div>
</form>
</body>
</html>

