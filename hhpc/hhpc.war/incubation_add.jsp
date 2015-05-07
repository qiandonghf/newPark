<%@page import="com.wiiy.crm.preferences.enums.PriorityEnum"%>
<%@page import="com.wiiy.crm.preferences.enums.InvestmentStatusEnum"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.pb.preferences.enums.GardenApplySourceEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.wiiy.pb.preferences.enums.GardenProjectSourceEnum" %>
<%@ page language="java" import="com.wiiy.pb.preferences.enums.GardenProjectTypeEnum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<jsp:useBean id="now" class="java.util.Date" />
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><%=InitListener.webParam.getName() %></title>
	<!---样式---->
		<jsp:include page="style.jsp"></jsp:include>
		<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
		<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<!---样式结束----> 
	<script>
	var clickIndex = 0;
	var type = "add";
	$(function(){
		initTip();
		initUploadify("report","上传","100");
		initUploadify("about","上传","100");
		initUploadify("legal","上传","100");
		initUploadify("list","上传","100");
		initUploadify("constitution","上传","100");
		initUploadify("identity","上传","100");
		initUploadify("license","上传","100");
		initUploadify("shareholder","上传","100");
		initUploadify("project","上传","100");
		initUploadify("other","上传","100");
	});
	
	function checkAtts(id){
		if($("#"+id).text().replace(/(^\s*)|(\s*$)/g, "") == ''){
			$("#"+id).parent().parent().hide();
		}
	}
	
	function getNums(){
		var nums = "";
		$(".inlinetdRight").find("input").each(function(i){
			var value = $(this).val();
			nums += value+",";
		});
		nums = nums.substring(0, nums.length-1);
		$("input[name='investment.staffInfo']").val(nums);
		alert(nums);
	}
	
	function checkNums(){
		var num = 0;
		/*
			第一个循环是各职称的总人数
		*/
		var zz = 0;
		var jz = 0;
		for(var i = 0;i<7;i++){
			var zc1 = Number($(".inlinetdRight").find("input").eq(i).val());//某个职称专职
			var zc2 = Number($(".inlinetdRight").find("input").eq(i+7).val());//某个职称兼职
			zz += zc1;
			jz += zc2;
			num =zc1+zc2;
			$(".rightReadOnly").find("input").eq(i+1).val(num);
			$(".rightReadOnly").find("input").eq(8).val(zz);
			$(".rightReadOnly").find("input").eq(9).val(jz);
			zz = Number($(".rightReadOnly").find("input").eq(8).val());//专职
			jz =  Number($(".rightReadOnly").find("input").eq(9).val());//兼职
		}
		for(var i = 1,num = 0; i <= 7; i++){
			num += Number($(".rightReadOnly").find("input").eq(i).val());
		}
		$(".rightReadOnly").find("input").eq(0).val(num);//员工总数
	}
	
	function keyUp(obj){
		var value = $(obj).val().replace(/[^\d]/g,'');
		$(obj).val(value);
		checkNums();
	}
	
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	
	function getCalendarScrollTop(){
		$(".calendar").css("width","220px");
		return $("#scrollDiv").scrollTop();
	}
	
	function initUploadify(id,name,width){
		var root = '<%=BaseAction.rootLocation %>/';
		$("#"+id).uploadify( {
			'auto'				: true, //是否自动开始 默认true
			'multi'				: false, //是否支持多文件上传 默认true
			'formData'			: {'module':'pb','directory':uploadify.directory.attachments},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
			'uploader'			: root+"upload.action",
			'swf'				: uploadify.swf,//上传组件swf
			'width'				: width,//按钮图片的长度
			'height'			: "20",//按钮图片的高度
			'buttonText'		: name,
			'fileObjName'		: uploadify.fileObjName, //和以下input的name属性一致 提交到服务器的属性
			'fileSizeLimit'		: uploadify.fileSizeLimit,//控制上传文件的大小，单位byte
			'removeCompleted'	: uploadify.removeCompleted, //上传完成移除出队列 默认true
			'fileTypeDesc'		: "*.*",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response){
				onUploadSuccess(file, data, response,id);
			}
		});
	}
	
	function onUploadSuccess(file, data, response,cid) {
		var info = $.parseJSON(data);
		var path = info.path;
		var oldName = info.originalName;
		var subName = oldName;
		if(oldName.length >=16){
			subName = oldName.substring(0,15)+"...";
		}
		var size = info.size;
		var id= $("input[name='investment.id']").val();
		var type = cid.toUpperCase();
		var postData = {"investmentArchiveAtt.investmentId":id,"investmentArchiveAtt.name":oldName,"investmentArchiveAtt.newName":path,"investmentArchiveAtt.size":size,"investmentArchiveAtt.attType":type};
		$.ajax({
			type:"post",
			data:postData,
			url :"<%=basePath%>save.action?type=archiveAtt",
			success:function(data){
				if(data.result.success){
					$("#"+cid+"Atts").html($("#"+cid+"Atts").html()+setText(path,oldName,size,id,subName));
					$("."+cid).show();
				}
			}
		});
	}
	
	function setText(path,oldName,size,id,subName){
		var htmlText = "";
		htmlText += "<div class=\'downlistleft\'>";
		htmlText +="<img src=\'core/common/images/word.png\'/>";
		htmlText +="<input type=\'hidden\' value=\'"+path+"\'/>";
		htmlText +="<input class=\'att"+id+"\' type=\'hidden\' value=\'"+oldName+"\'/>";
		htmlText +="<ul>";
		htmlText +="<li><em class=\'lititle att"+id+"\' title=\'"+oldName+"\'>"+subName+"</em><span>("+Math.round(size/1024)+"KB)</span>";
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
	
	function downAttr(obj){
		var parent =$(obj).parent().parent().parent();
		var path= $(parent).children().eq(1).val();
		var name= $(parent).children().eq(2).val();
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}
	
	function deleteAttr(id,obj){
		var path = $(obj).parent().parent().parent().children().eq(1).val();
		var type = $(obj).parent().parent().parent().parent().attr("id");
		if(confirm("确定删除")){
			showTip("正在与服务器传输数据……",10000);
			$.post("<%=basePath%>delFile.action?type=archiveAtt&directory="+path+"&id="+id,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$(obj).parent().parent().parent().remove();
	    			checkAtts(type);
	    			showTip("删除成功",2000);
	        	}
			});
		}
	}
	
	function rename(id){
		fbSearch('重命名','<%=basePath %>garden.action?type=rename&id='+id,333,67);
	}
	
	function deal(){
		$(".step li").eq(clickIndex).removeClass("active");
		switch(clickIndex){
		case 0:
			$(".app_table_wrapper").eq(0).addClass("hide");
			$(".app_table_wrapper").eq(1).removeClass("hide");
			$("#step3").removeClass("hide");
			clickIndex ++;
			break;
		case 1:
			$(".app_table_wrapper").eq(1).addClass("hide");
			$(".attachment").removeClass("hide");
			clickIndex ++;
			$("#step1").addClass("hide");
			$("#step2").val("完成并关闭");
			$("#step3").addClass("hide");
			break;
		}
		$(".step li").eq(clickIndex).addClass("active");
	}
	
	function preTabs(){
		clickIndex = 0;
		$(".app_table_wrapper").eq(1).addClass("hide");
		$(".app_table_wrapper").eq(0).removeClass("hide");
		$(".step li").eq(1).removeClass("active");
		$(".step li").eq(0).addClass("active");
		$("#step3").addClass("hide");
	}
	
	function saveApply(){
		var applyer = $("input[name='investment.name']");
		if($(applyer).val().replace(/(^\s*)|(\s*$)/g, "")==''){
			showTip("请输入企业名称",2000);
			$(applyer).focus();
			return;
		}
		if(clickIndex == 1){
			$("#applyForm").ajaxSubmit({
				type:"post",
		        dataType: 'json',
		        success: function(data){
		        	showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		$("input[name='investment.id']").val(data.result.value.id);
		        		setTimeout("deal();", 400);
		        	}
		        } 
		    });
		}else
			deal(); 
	}
	</script>
	
	<style>
	.uploadify-button {
		background-color: #fff;
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
	.emailtop .leftemail ul li span {
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
	#inline_table td{
		height:24px;
	}
	#inline_table .inlinetdleft{
		background-color:#f2f2f2;
		border-right:1px solid #fff;
		border-bottom:1px solid #fff;
		color:#666;
	}
	#inline_table .inlinetdRight,#inline_table .rightReadOnly{
		border-bottom:1px solid #f2f2f2;
		border-right:1px solid #f2f2f2;
		padding-right:4px;
		padding-left:2px;
	}
	.inlinetdRight input,.rightReadOnly input{
		text-align:center;
		width:100%;
		border: 0px;
		border-bottom: #999 1px solid
	}
	.rightReadOnly input{
		border: 0px;
	}
	table{
		table-layout:fixed;
	}
	.tdLeft{
		border-right:#ddd 1px solid;
		border-bottom:#ddd 1px solid;
		padding:2px 4px 2px 2px;
	}
	.app_td{
		width:120px;
	}
	</style>
</head>
<body>


<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 

<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
<!---导航结束----> 

<!---焦点图开始---->
	<jsp:include page="view_photo.jsp"></jsp:include>
<!---焦点图结束----> 

<!---主体内容开始---->
<form id="applyForm" action="<%=basePath %>save.action?type=investment" method="post">
<input type="hidden" name="investment.staffInfo" />
<input type="hidden" name="investment.investmentStatus" value="<%=InvestmentStatusEnum.NEW %>" />
<input type="hidden" name="investment.priority" value="<%=PriorityEnum.LOW %>" />
<input name="investment.id" type="hidden"/>
<div id="main">
  <!---左侧标题开始---->
  <h1 class="Title5">
    <p>当前位置：<a href="index.action">首页</a>》入孵申请</p>
  </h1>
  <!---左侧标题结束----> 
  
<div class="step clearfix">
  <ul>
    <li class="active">第一步：基本信息</li>
    <li>第二步：法定代表人信息</li>
    <li>上传附件</li>
  </ul>
</div>
 
<div class="app_table_wrapper">
 <div class="app_tables">
  <table width="100%"  border="0" cellpadding="0" cellspacing="0" class="app_table">
      <tr>
        <td class="app_td" width="80" align="center" valign="middle">企业信息</td>
        <td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
	              <td class="app_td" width="100"><span class="psred">*</span>企业名称</td>
	              <td class="tdLeft"><input name="investment.name" class="app_input"/></td>
	              <td width="100" class="app_td">企业类型 </td>
	              <td class="tdLeft"><input name="investment.type" class="app_input"/></td>
	            </tr>
	            <tr>
	              <td class="app_td">详细地址</td>
	              <td class="tdLeft"><input name="gardenApply.leaderEmail" class="app_input"/></td>
	              <td class="app_td">办公场地面积</td>
	              <td class="tdLeft"><input name="gardenApply.leaderQQ" class="app_input"/></td>
	            </tr>
			</table>
		</td>
      </tr>
      <tr>
        <td class="app_td" width="80" align="center" valign="middle">法定代表人信息<br/>联系人信息</td>
        <td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="app_td">法定代表人姓名</td>
					<td class="tdLeft"><input name="investment.legalPerson" class="app_input"/></td>
					<td class="app_td">联系人姓名</td>
					<td class="tdLeft"><input name="investment.contactPerson" class="app_input"/></td>
	            </tr>
	            <tr>
					<td class="app_td">法定代表人联系电话 </td>
					<td class="tdLeft"><input name="investment.legalPersonPhone" class="app_input"/></td>
					<td class="app_td">联系人电话</td>
					<td class="tdLeft"><input name="investment.contactPhone" class="app_input"/></td>
	            </tr>
	            <tr>
	              <td class="app_td">法定代表人E-mail</td>
	              <td class="tdLeft"><input name="investment.legalPersonEmail" class="app_input"/></td>
	              <td class="app_td">联系人E-mail</td>
	              <td class="tdLeft"><input name="investment.contactEmail" class="app_input"/></td>
	            </tr>
			</table>
		</td>
      </tr>
      <tr>
        <td class="app_td" align="center" valign="middle">项目信息</td>
        <td>
        	<table id="inline_table" width="100%" border="0" cellspacing="0" cellpadding="0">
	             <tr>
					<td class="app_td" colspan="2" align="center" valign="middle">项目名称</td>
		            <td style="padding:0px 4px 0px 2px;border-right:#ddd 1px solid;" colspan="11"><input name="investment.projectName" class="app_input"/></td>
	             </tr>
	             <tr>
					<td class="app_td" rowspan="5" colspan="2" align="center" valign="middle">企业<br/>职工<br/>人员<br/>状况</td>
		            <td class="app_td" colspan="2" rowspan="2" align="center" valign="middle">人员构成</td>
		            <td class="app_td" colspan="2" rowspan="2" align="center" valign="middle">职工总数</td>
		            <td class="app_td" colspan="4" align="center" valign="middle">科技人员</td>
		            <td class="app_td" colspan="2" align="center" valign="middle">财务人员</td>
		            <td class="app_td" rowspan="2" align="center" valign="middle">其<br/>他</td>
	            </tr>
	            <tr>
		            <td class="app_td" align="center" valign="middle">博士</td>
		            <td class="app_td" align="center" valign="middle">硕士</td>
		            <td class="app_td" align="center" valign="middle">本科</td>
		            <td class="app_td" align="center" valign="middle">大专</td>
		            <td class="app_td" align="center" valign="middle">会计</td>
		            <td class="app_td" align="center" valign="middle">出纳</td>
		          </tr>
				<tr>
		            <td class="app_td" colspan="2" align="center" valign="middle">总&nbsp;&nbsp;数</td>
		            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="rightReadOnly" align="center" valign="middle"><input readonly="readonly"/></td>
				</tr>
				<tr>
		            <td class="app_td" rowspan="2" align="center" valign="middle">其<br/>中</td>
		            <td class="app_td" align="center" valign="middle">专职</td>
		            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
				</tr>
				<tr>
		            <td class="app_td" align="center" valign="middle">兼职</td>
		            <td class="rightReadOnly" colspan="2" align="center" valign="middle"><input readonly="readonly"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
		            <td class="inlinetdRight" align="center" valign="middle"><input onkeyup="keyUp(this);"/></td>
				</tr>
          	</table>
          </td>
      </tr>
      <tr>
        <td class="app_td" width="80" align="center" valign="middle">项目的技术特点、<br/>市场状况</td>
        <td width="100%" class="tdLeft">
			<textarea name="investment.marketSituation" style="height:80px;resize:none;width:100%;"></textarea>
		</td>
      </tr>
      <tr>
        <td class="app_td" width="80" align="center" valign="middle">项目的来源说明和知识产权情况</td>
        <td width="100%" class="tdLeft">
			<textarea name="investment.propertyRight" style="height:80px;resize:none;width:100%;"></textarea>
		</td>
      </tr>
      <tr>
        <td class="app_td" width="80" align="center" valign="middle">经营范围</td>
        <td width="100%" class="tdLeft">
			<textarea name="investment.businessScope" style="height:80px;resize:none;width:100%;"></textarea>
		</td>
      </tr>
    </table>
 </div>
</div> 
 <!-----第一步结束---------> 
 
 <!-----第二步开始---------> 
 <div class="app_table_wrapper hide">
	 <div class="app_tables">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="app_table">
	 		<tr>
		        <td class="app_td" width="80" align="center" valign="middle">个人信息</td>
		        <td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="app_td">姓名</td>
							<td class="tdLeft"><input name="investmentDirector.name" class="app_input"/></td>
							<td class="app_td">出生年月</td>
							<td class="tdLeft">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><input id="birthday" name="investmentDirector.birthDay" onclick="showCalendar('birthday');" readonly="readonly" class="app_input" /></td>
										<td width="30"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('birthday');"/></td>
									</tr>
								</table>  
							</td>
			            </tr>
			            <tr>
							<td class="app_td">性别 </td>
							<td class="tdLeft"><enum:radio name="investmentDirector.gender" type="com.wiiy.commons.preferences.enums.GenderEnum" /></td>
							<td class="app_td">文化程度</td>
							<td class="tdLeft"><dd:select key="crm.0015" name="investmentDirector.degreeId" /></td>
			            </tr>
			            <tr>
			              <td class="app_td">政治面目</td>
			              <td class="tdLeft"><dd:select name="investmentDirector.politicalId" key="crm.0029" /></td>
			              <td class="app_td">技术职称</td>
			              <td class="tdLeft"><input name="investmentDirector.profession" class="app_input"/></td>
			            </tr>
			            <tr>
			              <td class="app_td">企业名称</td>
			              <td class="tdLeft"><input name="investmentDirector.customer" class="app_input"/></td>
			              <td class="app_td">担任职务</td>
			              <td class="tdLeft"><input name="investmentDirector.position" class="app_input"/></td>
			            </tr>
			            <tr>
			              <td class="app_td">原工作单位</td>
			              <td class="tdLeft"><input name="investmentDirector.original" class="app_input"/></td>
			              <td class="app_td">离职方式</td>
			              <td class="tdLeft"><input name="investmentDirector.leaveBy" class="app_input"/></td>
			            </tr>
			            <tr>
			            	<td class="app_td">家庭住址</td>
					        <td class="tdLeft" colspan="3">
								<input name="investmentDirector.address" class="app_input" />
					        </td>
			            </tr>
					</table>
				</td>
		      </tr>
		      <tr>
				<td class="app_td" width="80" align="center" valign="middle">主要学历<br/>（获得何种学位）</td>
		      	<td class="tdLeft">
		      		<textarea name="investmentDirector.specialty" style="width:100%;height:80px;resize:none;"></textarea>
		      	</td>
		      </tr>
		      <tr>
				<td class="app_td" width="80" align="center" valign="middle">工作简历<br/>（有何发明、论著，获得何种奖励）</td>
		      	<td class="tdLeft">
		      		<textarea name="investmentDirector.resume" style="width:100%;height:80px;resize:none;"></textarea>
		      	</td>
		      </tr>
	 	</table>
	 </div>
 </div>
 
 <!--第三步-->
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
								<li><em>申请报告</em><span><input id="report" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays report" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="reportAtts" style="display:block;">
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
								<li><em>杭州高新区科技创业服务中心孵化企业概况表</em><span><input id="about" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays about" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="aboutAtts" style="display:block;">
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
								<li><em>法定代表人简介</em><span><input id="legal" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays legal" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="legalAtts" style="display:block;">
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
								<li><em>杭州高新区科技创业服务中心孵化企业人员名单</em><span><input id="list" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays list" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="listAtts" style="display:block;">
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
								<li><em>企业章程（工商局注册文件）复印件</em><span><input id="constitution" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays constitution" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="constitutionAtts" style="display:block;">
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
								<li><em>法定代表人身份证、学历证复印件</em><span><input id="identity" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays identity" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="identityAtts" style="display:block;">
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
								<li><em>营业执照复印件和税务登记证复印件</em><span><input id="license" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays license" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="licenseAtts" style="display:block;">
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
								<li><em>法人股东的营业执照复印件</em><span><input id="shareholder" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays shareholder" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="shareholderAtts" style="display:block;">
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
								<li><em>研发项目简介打印稿</em><span><input id="project" type="file"/></span></li>
							</ul>
						</div>
					</td>
				</tr>
				<tr class="agreementTR">
					<td >
						<div class="divlays project" style="padding:2px 5px 0px 5px;display:none;">
							<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
								<div class="investmentAtts" id="projectAtts" style="display:block;">
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
							<li><em>其他材料</em><span><input id="other" type="file"/></span></li>
						</ul>
					</div>
				</td>
			</tr>
			<tr class="agreementTR">
				<td >
					<div class="divlays other" style="padding:2px 5px 0px 5px;display:none;">
						<div class="emaildown" style="margin-top:5px;border-bottom:1px solid #e4e4e4;border-left:1px solid #e4e4e4;border-right:1px solid #e4e4e4;">
							<div id="otherAtts" style="display:block;">
								
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

<div class="buttondiv PT10">
  <label>
    <input name="Submit2" id="step3" type="button" onclick="preTabs();" class="nextbtn hide" value="上一步"/>
  </label>
  <label>
    <input name="Submit2" id="step1" type="button" class="nextbtn" onclick="saveApply();" value="下一步" />
  </label>
  <label>
    <input name="Submit2" id="step2" type="button" onclick="window.close();" class="nextbtn" value="关闭"/>
  </label>
</div>
  
</div>
</form>
<div class="hackbox"></div>

<!---主体内结束----> 
<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束----> 
</body>
</html>
