<%@page import="com.wiiy.crm.preferences.enums.PriorityEnum"%>
<%@page import="com.wiiy.crm.preferences.enums.InvestmentStatusEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/merchants.css"/>

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

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

<script type="text/javascript">
	var suffix = "";
	$(function(){
		initTip();
		initForm();
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
		checkAtts();
		getCalendarScrollTop();
	});
	
	function checkAtts(id){
		if(id){
			if($("#"+id).text().replace(/(^\s*)|(\s*$)/g, "") == ''){
				$("#"+id).parent().parent().hide();
			}
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
	
	function initUploadify(id,name,width){
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
			'fileTypeDesc'		: "*.*",//选择文件对话框文件类型描述信息
			'fileTypeExts'		: "*.*",//可上传上的文件类型
			'onUploadSuccess'	: function(file, data, response){
				onUploadSuccess(file, data, response,id);
			}
		});
	}
	
	function onUploadSuccess(file, data, response,type) {
		var info = $.parseJSON(data);
		var path = info.path;
		var oldName = info.originalName;
		var subName = oldName;
		if(oldName.length >=16){
			subName = oldName.substring(0,15)+"...";
		}
		var size = info.size;
		$("#"+type+"Atts").html($("#"+type+"Atts").html()+setText(path,oldName,size,type,subName));
		$("."+type).show();
	}
	
	function setText(path,oldName,size,type,subName){
		var htmlText = "";
		htmlText += "<div class=\'downlistleft\'>";
		htmlText +="<img src=\'core/common/images/word.png\'/>";
		htmlText +="<input type=\'hidden\' value=\'"+path+"\'/>";
		htmlText +="<input type=\'hidden\' value=\'"+oldName+"\'/>";
		htmlText +="<ul>";
		htmlText +="<li><em class=\'lititle' title=\'"+oldName+"\'>"+subName+"</em>";
		htmlText +="</li><li>";
		//htmlText +="<a href=\'javascript:void(0);\' onclick=\'downAttr("+id+");\'>下载</a>";
		//htmlText +="<a href=\'javascript:void(0);\' onclick=\'rename(this);\'>重命名</a>";
		htmlText +="<a href=\'javascript:void(0);\' onclick=\'deleteAttr(\""+type+"\",this);\'>删除</a>";
		htmlText +="</li>";
		htmlText +="</ul>";
		htmlText +="</div>";
		return htmlText;
	}
	
	function checkForm(){
		var name = $("input[name='investment.name']").val();
		if(name.replace(/(^\s*)|(\s*$)/g, "") != ''){
			return true;
		}
		showTip("请输入企业名称",2000);
		$(".tabswitch").each(function(i){
			$(this).hide();
		});
		$(".tabswitch").eq(0).show();
		$(".apptabliover").removeClass("apptabliover").addClass("apptabli");
		$(".apptabli").eq(0).removeClass("apptabli").addClass("apptabliover");
		$("input[name='investment.name']").focus();
		return false;
	}
	
	function initForm(){
		$("#form1").validate({
			rules: {
				"investment.name":"required"
			},
			messages: {
				"investment.name":"请输入企业名称"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("input[name='path']").val(getAttsList());
				if(checkForm()){
					getNums();
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout(function(){
				        			parent.fb.end();
				        			var info = "${param.info}";
				        			if(info != 'WINDOW'){
				        				getOpener().location.reload();
				        			}
				        		},2000);
				        	}
				        } 
				    });
				}
			}
		});
	}
	function downAttr(obj){
		var parent = $(obj).parent().parent().parent();
		var path = $(parent).children().eq(1).val();
		var name = $(parent).children().eq(2).val();
		location.href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() %>/core/resources/"+path+"?name="+name;
	}

	function rename(obj){
		var attr = $(obj).parent().parent();
		var current = $(attr).children().eq(0);
		var oldName = $(current).children().eq(0).val();
		var attrName = oldName.substr(0,oldName.lastIndexOf("."));
		suffix = oldName.substr(oldName.lastIndexOf(".")+1);
		$(current).children().eq(0).val(attrName);
		$(current).children().eq(0).show();
		$(current).children().eq(1).hide();
		$(current).children().eq(0).focus();
	}
	
	function changeAttr(obj){
		var attr = $(obj).val();
		var current = $(obj).parent();
		attr += "."+suffix;
		$(current).children().eq(0).val(attr);
		$(current).children().eq(1).text(attr);
		$(current).children().eq(0).hide();
		$(current).children().eq(1).show();
	}
	
	function deleteAttr(type,obj){
		var path = $(obj).parent().parent().parent().children().eq(1).val();
		if(confirm("确定删除")){
			showTip("正在与服务器传输数据……",9999999);
			$.post("<%=basePath%>investment!deleteByFilePath.action?path="+path,function(data){
				showTip(data.result.msg,2000);
	        	if(data.result.success){
	        		$(obj).parent().parent().parent().remove();
	    			checkAtts(type+"Atts");
	    			showTip("删除成功",2000);
	        	}
			});
		}
	}
	
	/*
	获取所有附件	
	*/
	function getAttsList(){
		var attrPaths = "[";
		var obj = $(".investmentAtts");
		$(obj).each(function (i){
			if($(this).text().replace(/(^\s*)|(\s*$)/g, "") != ''){
				var cid = $(this).attr("id");
				var len = cid.length;
				var type = $(this).attr("id").substr(0,len-4).toUpperCase();
				$(this).children().each(function(){
					var child = $(this).children();
					var oldName = $(child).eq(2).val();
					oldName = encodeURIComponent(oldName);
					oldName = encodeURIComponent(oldName);
					var str = "{\"filePath\" : \""+$(child).eq(1).val()+"\",";
					str += "\"type\" : \""+type+"\",";
					str += "\"fileName\" : \""+oldName+"\"}";
					attrPaths += str+",";
				}); 
			}
		});
		if(attrPaths.lastIndexOf(",") == attrPaths.length-1)
			attrPaths = attrPaths.substr(0,attrPaths.length-1);
		return attrPaths+"]";
	}
</script>

<style>
	.emaildown .downlistleft {
		width:200px;
		
	}
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
	.lititle{
		height:18px;
		line-heght:18px;
		display:inline-block;
		max-width:120px;
		overflow:hidden;
	}
	
	.uploadify-progress{
		z-index:99999;
	}

	table{
		table-layout:fixed;
	}
	td{
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
		border-bottom: 1px solid #666;
	}
	.rightReadOnly input{
		border: 0px;
	}
</style>
</head>

<body style="padding-bottom:2px;">
<form action="<%=basePath %>investment!save.action" method="post" name="form1" id="form1">
<input type="hidden" name="investment.staffInfo" />
<input type="hidden" name="investment.investmentStatus" value="<%=InvestmentStatusEnum.NEW %>" />
<input type="hidden" name="investment.priority" value="<%=PriorityEnum.LOW %>" />
<input type="hidden" name="path" />
<!--basediv--><!--//basediv-->
<div class="basediv" style="padding-bottom:2px;border:0px;background-color: #eeeeee;">
	<div class="divlays" style="margin:0px;padding-bottom:0px;">
		<div class="apptab" id="tableid">
			<ul>
				<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">基本信息</li>
				<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">法人信息</li>
				<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">附件</li>
			</ul>
		</div>
	</div>
	<div class="pm_msglist apptable tabswitch" style="padding:2px;background-color: #fff;">
		<div>	
			<div class="apptable" style="border-top:none; border-left:none;">
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	        		<tr>
				        <td class="layertdleft120"><span class="psred">*</span>企业名称：</td>
				        <td class="layerright">
				          <input name="investment.name" type="text" class="inputauto" />
				        </td>
				        <td class="layertdleft120">企业类型：</td>
				        <td class="layerright"><input name="investment.type" type="text" class="inputauto" /></td>
				    </tr>
					<tr>
						<td class="layertdleft120">详细地址：</td>
						<td class="layerright"> <input name="investment.address" type="text" class="inputauto" /></td>
						<td class="layertdleft120">办公场地面积：</td>
						<td class="layerright"><input name="investment.officeArea" type="text" class="inputauto" /></td>
					</tr>
					<tr>
				        <td class="layertdleft120">法定代表人：</td>
				        <td class="layerright"><input name="investment.legalPerson" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">联系人：</td>
				        <td class="layerright"><input name="investment.contactPerson" type="text" class="inputauto" /></td>
      			   </tr>
      			   <tr>
				        <td class="layertdleft120">法定代表人联系电话：</td>
				        <td class="layerright"><input name="investment.legalPersonPhone" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">联系人联系电话：</td>
				        <td class="layerright"><input name="investment.contactPhone" type="text" class="inputauto" /></td>
       			   </tr>
       			   <tr>
						<td class="layertdleft120">法定代表人E-mail：</td>
						<td class="layerright"><input name="investment.legalPersonEmail" type="text" class="inputauto" /></td>
						<td class="layertdleft120">联系人E-mail：</td>
						<td class="layerright"><input name="investment.contactEmail" type="text" class="inputauto" /></td>
				   </tr>
				   <tr>
				        <td class="layertdleft120">项目名称：</td>
				        <td colspan="3" class="layerright"><input name="investment.projectName" type="text" class="inputauto" /></td>
			       </tr>
			       <tr>
						<td colspan="4">
							<table id="inline_table" width="100%" border="0" cellspacing="0" cellpadding="0">
					          <tr>
					            <td class="inlinetdleft" rowspan="5" colspan="2" align="center" valign="middle">企业<br/>职工<br/>人员<br/>状况</td>
					            <td class="inlinetdleft" colspan="2" rowspan="2" align="center" valign="middle">人员构成</td>
					            <td class="inlinetdleft" colspan="2" rowspan="2" align="center" valign="middle">职工总数</td>
					            <td class="inlinetdleft" colspan="4" align="center" valign="middle">科技人员</td>
					            <td class="inlinetdleft" colspan="2" align="center" valign="middle">财务人员</td>
					            <td class="inlinetdleft" rowspan="2" align="center" valign="middle">其<br/>他</td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" align="center" valign="middle">博士</td>
					            <td class="inlinetdleft" align="center" valign="middle">硕士</td>
					            <td class="inlinetdleft" align="center" valign="middle">本科</td>
					            <td class="inlinetdleft" align="center" valign="middle">大专</td>
					            <td class="inlinetdleft" align="center" valign="middle">会计</td>
					            <td class="inlinetdleft" align="center" valign="middle">出纳</td>
					          </tr>
					          <tr>
					            <td class="inlinetdleft" colspan="2" align="center" valign="middle">总&nbsp;&nbsp;数</td>
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
					            <td class="inlinetdleft" rowspan="2" align="center" valign="middle">其<br/>中</td>
					            <td class="inlinetdleft" align="center" valign="middle">专职</td>
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
					            <td class="inlinetdleft" align="center" valign="middle">兼职</td>
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
				        <td class="layertdleft120">项目的技术特点、<br/>市场状况</td>
        				<td colspan="3" class="layerright">
          					<textarea class="inputauto" name="investment.marketSituation" id="textarea" style="height:40px;resize:none;"></textarea>
          				</td>
			       </tr>
			       <tr>
				        <td class="layertdleft120" >项目的来源说明和知识产权情况</td>
				        <td colspan="3" class="layerright"><label for="textarea"></label>
          					<textarea class="inputauto" name="investment.propertyRight" id="textarea" style="height:40px;resize:none;"></textarea>
				        </td>
				   </tr>
				   <tr>
				        <td class="layertdleft120">经营范围</td>
				        <td colspan="3" class="layerright"><label for="textarea"></label>
          					<textarea class="inputauto" name="investment.businessScope" id="textarea" style="height:40px;resize:none;"></textarea>
				        </td>
				   </tr>
	        	</table>
			</div>
		</div>
	  </div>
	
	
	<!-- 法人信息   -->
	<div class="pm_msglist apptable tabswitch" style="display:none;padding:2px;background-color: #fff;">
		<div>	
			<div class="apptable" style="border-top:none; border-left:none;">
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  				<tr>
				        <td class="layertdleft120">姓名：</td>
				        <td class="layerright">
				          <input name="investmentDirector.name" type="text" class="inputauto" />
				        </td>
				        <td class="layertdleft120">出生年月：</td>
				        <td class="layerright">
				        	<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="birthday" name="investmentDirector.birthDay" onclick="showCalendar('birthday');" readonly="readonly" class="inputauto" /></td>
									<td width="30"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('birthday');"/></td>
								</tr>
							</table>  
						</td>
				     </tr>
				     <tr>
				        <td class="layertdleft120">性别：</td>
				        <td class="layerright">
				        	<enum:radio name="investmentDirector.gender" type="com.wiiy.commons.preferences.enums.GenderEnum"/>
						</td>
				        <td class="layertdleft120">文化程度：</td>
				        <td class="layerright">
				        	<dd:select key="crm.0015" name="investmentDirector.degreeId"/>
				        </td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">政治面目：</td>
				        <td class="layerright">
				        	<dd:select name="investmentDirector.politicalId" key="crm.0029" />
				        </td>
				        <td class="layertdleft120">技术职称：</td>
				        <td class="layerright"><input name="investmentDirector.profession" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">企业名称：</td>
				        <td class="layerright"><input name="investmentDirector.customer" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">担任职务：</td>
				        <td class="layerright"><input name="investmentDirector.position" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">原工作单位：</td>
				        <td class="layerright"><input name="investmentDirector.original" type="text" class="inputauto" /></td>
				        <td class="layertdleft120">离职方式：</td>
				        <td class="layerright"><input name="investmentDirector.leaveBy" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">家庭住址：</td>
				        <td colspan="3" class="layerright"><input name="investmentDirector.address" type="text" class="inputauto" /></td>
				      </tr>
				      <tr>
				        <td class="layertdleft120">主要学历<br/>（获得何种学位）</td>
				        <td colspan="3" class="layerright" style="padding-bottom:1px;"><label for="textarea"></label>
				          <textarea class="inputauto" name="investmentDirector.specialty" style="height:50px;resize:none;"></textarea></td>
				        </tr>
				        <tr>
				        <td class="layertdleft120">工作简历<br/>（有何发明、论著，获得何种奖励）</td>
				        <td colspan="3" class="layerright" style="padding-bottom:1px;"><label for="textarea"></label>
				          <textarea class="inputauto" name="investmentDirector.resume" style="height:70px;resize:none;"></textarea></td>
				        </tr>
	  			</table>
	  		</div>
	  	</div>
	</div>
	
	<div class="pm_msglist apptable tabswitch" style="display:none;background-color: #fff;">
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
</div>

<div class="buttondiv">
	<label><input name="Submit" type="submit" class="savebtn" value=" " /></label>
	<label><input name="Submit2" type="button" class="cancelbtn" value=" " onclick="parent.fb.end();"/></label>
</div>
<div class="hide testWidth"></div>
</form>
</body>
</html>

