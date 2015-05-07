<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript">
	 $(function(){
		initTip();
		initForm();
		initUploadify("imageUpload");
	}); 
	 function initForm(){
		$("#form1").validate({
			rules: {
				"archives.serialNo":"required",
				"archives.name":"required",
				"archives.idNo":"required",
				"archives.religiousId":"required",
				"archives.politicalId":"required",
				"archives.gender":"required",
				"archives.nationalityId":"required",
				"archives.ethnicId":"required",
				"archives.orgId":"required",
				"archives.status":"required"
			},
			messages: {
				"archives.serialNo":"请填写档案编号",
				"archives.name":"请填写员工姓名",
				"archives.idNo":"请填写身份证号",
				"archives.religiousId":"请选择宗教信仰",
				"archives.politicalId":"请选择政治面貌",
				"archives.gender":"请选择性别",
				"archives.nationalityId":"请选择国籍",
				"archives.ethnicId":"请选择民族",
				"orgName":"请选择所属部门或公司",
				"archives.status":"请选择状态"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$("#photo").val($("#archives_imagery_img").attr("src"));
				$(form).ajaxSubmit({
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){			        		
			        		setTimeout("parent.fb.end();getOpener().reloadList();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	 function initUploadify(id){
 		$("#"+id).uploadify( {
 			'auto'				: true, //是否自动开始 默认true
 			//'multi'				: false, //是否支持多文件上传 默认true
 			'formData'			: {'module':'oa','directory':uploadify.directory.images},//提交到后台的数据 module 模块名 directory：文件夹名  images attachments
 			'uploader'			: "<%=BaseAction.rootLocation%>/core/upload.action",
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
		$("#photo").val($.parseJSON(data).path);
		$("#archives_imagery_img").attr("src", "core/resources/"+$.parseJSON(data).path);
	}
			
	function removeImagery() {
		var Imagery = $("#archives_imagery_img").attr("src");
		$("#archives_imagery_img").attr("src", Imagery + "-d");
		$("#photo").val("core/common/images/topxiao.gif");
		$("#archives_imagery_img").attr("src", "core/common/images/topxiao.gif");
	}
	function setSelectedOrg(selectedOrg){
		$("#orgId").val(selectedOrg.id);
		$("#orgName").val(selectedOrg.name);
	}
	
	function setSelectedUser(user){
		$("#username").val(user.realName);
		$("#userId").val(user.id);
	}
	
<%-- 	function setSalaryDefineId(id){
		$("#salaryDefineId").val(id);//给archives.salaryDefineId赋值
		$.post("<%=basePath%>archives!show.action?id="+id,function(data){
			//级联下拉框，选中了相应标准ID，则对应的标准编号、标准金额就会显示出来
			var dlsalaryName = document.getElementById("salaryName");
		    var dlsalaryNo=document.getElementById("salaryNo");
		    var dlsalary=document.getElementById("salary");
		    dlsalaryNo.length=0;//先将下拉列表框清空
		    dlsalary.length=0;
		    if(dlsalaryName.value==""){
		    	dlsalaryNo.options.add(new Option("-----选择编号-----","-1")); 
			    dlsalary.options.add(new Option("--选择金额--","-1"));	
		    }else{
		    	var salaryDefineSerialNo = data.result.value.serialNo;
				var count = data.count;
		    	dlsalaryNo.options.add(new Option(salaryDefineSerialNo,salaryDefineSerialNo)); 
			    dlsalary.options.add(new Option(count,count));
		    }
		    return; 
		});
	} 
	function initOption(){
		initPoitionOption();
		initSalaryNameOption();
	}
	function initPoitionOption(){
		var opts = document.getElementById("position");
        var value = "${result.value.positionId}";//这个值就是你获取的值;
		if(value!=""){
		for(var i=0;i<opts.options.length;i++){
	        if(value==opts.options[i].value){
	            opts.options[i].selected = 'selected';
	            break;
	          }
	       }
		}
	}
	
	function initSalaryNameOption(){
		var opts = document.getElementById("salaryName");
        var value = "${result.value.salaryName}";//这个值就是你获取的值;
		if(value!=""){
		for(var i=0;i<opts.options.length;i++){
	        if(value==opts.options[i].value){
	            opts.options[i].selected = 'selected';
	            setSalaryDefineId(opts.options[i].name);
	            break;
	          }
	       }
		}
	}
	--%>
</script>
</head>
<body>

<form id="form1" name="form1" method="post" action="<%=basePath%>archives!update.action">
<div class="basediv">
	<div class="layertitle">基本信息</div>
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>档案编号：
        </td>
        <td width="30%" class="layerright">
       		<input name="archives.serialNo" type="text" class="inputauto" value="${result.value.serialNo}"/>
        </td>
        <td class="layertdleft100"><span class="psred">*</span>员工姓名：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200"><input id="username" name="archives.name" value="${result.value.name}" class="inputauto" /></td>
			</tr>
		</table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>身份证号：</td>
        <td class="layerright"><label><input name="archives.idNo" value="${result.value.idNo}" type="text" class="inputauto" /></label></td>
        <td class="layertdleft100"><span class="psred">*</span>宗教信仰：</td>
        <td class="layerright">  		
    		<dd:select id="religiousId" name="archives.religiousId" checked="result.value.religiousId" key="oa.0004"/>
    	</td>
      </tr>
      <tr>
        <td class="layertdleft100">出生日期：</td>
        <td class="layerright">
			<table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="200"><input id="birthDay" name="archives.birthDay" type="text" class="inputauto" readonly="readonly" 
					onclick="return showCalendar('birthDay','y-mm-dd');" value="<fmt:formatDate value="${result.value.birthDay}" pattern="yyyy-MM-dd"/>"/></td>
				<td><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative; left:-1px" onclick="return showCalendar('birthDay','y-mm-dd');"/></td>
			</tr>
			</table>
		</td>
        <td class="layertdleft100"><span class="psred">*</span>政治面貌：</td>
        <td class="layerright">  		
    		<dd:select id="politicalId" name="archives.politicalId" checked="result.value.politicalId" key="oa.0005"/>
    	</td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>性别：</td>      
        <td class="layerright"><enum:select name="archives.gender" checked="result.value.gender" type="com.wiiy.commons.preferences.enums.GenderEnum"/></td>
        <td class="layertdleft100"><span class="psred">*</span>国籍：</td>
       	<td class="layerright">  		
    		<dd:select id="nationalityId" name="archives.nationalityId" checked="result.value.nationalityId" key="oa.0006"/>
    	</td>
      </tr>
      <tr>
        <td class="layertdleft100">婚姻状况：</td>
        <td class="layerright"><enum:select name="archives.marriage" checked="result.value.marriage" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
        <td class="layertdleft100"><span class="psred">*</span>民族：</td>
        <td class="layerright">  		
    		<dd:select id="ethnicId" name="archives.ethnicId" checked="result.value.ethnicId" key="oa.0007"/>
    	</td>
      </tr>
      <tr>
        <td class="layertdleft100">籍贯：</td>
        <td class="layerright"><input name="archives.homeTown" value="${result.value.homeTown}" type="text" class="inputauto" /></td>
        <td class="layertdleft100"><span class="psred">*</span>状态:</td>
        <td class="layerright">
	        <enum:select name="archives.status" checked="result.value.status" type="com.wiiy.oa.preferences.enums.PositionConditionEnum"/>
	    </td>
      </tr>
    </table></td>
    <td width="175" valign="top"><table style=" padding-top:3px;" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="110">
		            <c:if test="${result.value.photo!=''}">
		           		<img id="archives_imagery_img" class="oa_img" src="${result.value.photo}" width="110" height="123" />
		           </c:if>
		           <c:if test="${result.value.photo==''}">
		           		<img id="archives_imagery_img" class="oa_img" src="core/common/images/topxiao.gif" width="110" height="123" />
		           </c:if>
            </td>
            <td width="15" valign="bottom"><img id="archives_imagery" src="core/common/images/locking.jpg" width="15" height="15"  onclick="removeImagery()"/></td>
            <td valign="top">
            	<img id="imageUpload" src="core/common/images/uploadbtn.png" width="47" height="22" />
            	<input id="photo" type="hidden" name="archives.photo" value="${result.value.photo}"/>	
            	<input id="id" type="hidden" name="archives.id" value="${result.value.id}"/>
           	</td>
          </tr>
    </table></td>
  </tr>
</table>
</div>
</div>
<!--//basediv-->
<!--table切换开始-->
<div class="apptab" id="tableid">
	<ul>
		<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">职务薪酬信息</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">联系方式</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">教育情况</li>
		<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">其它</li>
	</ul>
</div>
<!--//table切换开始-->
<!--basediv-->
<div class="basediv tabswitch" style="margin-top:0px;" name="textname" id="textname">
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100" style="white-space:nowrap;"><span class="psred">*</span>所属部门或公司：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
				<td width="200"><input id="orgId" name="archives.orgId" value="${result.value.orgId}"  type="hidden" /><input id="orgName" name="orgName" value="${result.value.org.name}" class="inputauto" readonly="readonly" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
				<td><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择部门','<%=BaseAction.rootLocation %>/core/org!select.action',520,400);"/></td>
			</tr>
     	</table></td>
      <%--   <td class="layertdleft100"><span class="psred">*</span>职位：</td>
        <td class="layerright"><select id="position" name="archives.positionId" class="selectauto">
        	<option value="">--选择职位--</option>
         	<c:forEach items="${positionList}" var="position">
         		<option value="${position.id}">${position.name}</option>      	
        	</c:forEach>              
        </select></td> --%>
      </tr>
      <tr>
        <td class="layertdleft100">职务：</td>
        <td class="layerright"><label><input name="archives.position" value="${result.value.position}" type="text" class="inputauto" /></label></td>
       <%--  <td class="layertdleft100"><span class="psred">*</span>薪酬标准名称：</td>
        <td class="layerright">
        <input id="salaryDefineId" name="archives.salaryDefineId" type="hidden" value=""/>
        <select id="salaryName" name="archives.salaryName" class="selectauto" onchange="setSalaryDefineId(this.options[this.selectedIndex].name);">     
         	<option name="-1" value="">--选择名称--</option>
         	<c:forEach items="${salaryDefines}" var="salaryDefine">
         		<option name="${salaryDefine.id}" value="${salaryDefine.name}">${salaryDefine.name}</option>          	
        	</c:forEach>       	      	
        </select></td> --%>
      </tr>
      
      <tr>
        <td class="layertdleft100">入职时间：</td>
        <td class="layerright">
			<table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="200"><input id="entryTime" value="<fmt:formatDate value="${result.value.entryTime}" pattern="yyyy-MM-dd"/>" name="archives.entryTime" type="text" class="inputauto" readonly="readonly" onclick="return showCalendar('entryTime','y-mm-dd');" /></td>
				<td ><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer; position: relative; left:-1px;" onclick="return showCalendar('entryTime','y-mm-dd');"/></td>
			</tr>
			</table>
		</td>
      </tr>
      
      <td class="layertdleft100">合同期限：</td>
        <td class="layerright">
	        <table border="0" cellspacing="0" cellpadding="10">
	          <tr>
	            <td width="90">
	            	<input id="startTime" name="archives.startTime" class="data inputauto" value="<fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('startTime')"/>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('startTime');" />
	            </td>
	            <td>--</td>
	            <td width="90">
	            		<input id="endTime" name="archives.endTime" class="data inputauto" value="<fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('endTime')"/>
	            </td>
	            <td width="20">
	            	<img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('endTime');" />
	            </td>
	          </tr>
	        </table>
	    </td>
      <tr>
        <td class="layertdleft100">开户银行：</td>
        <td class="layerright"><input name="archives.bank" value="${result.value.bank}" type="text" class="inputauto" /></td>
      <!--   <td class="layertdleft100">薪酬标准编号：</td>
        <td class="layerright">
       	 	<select id="salaryNo" name="archives.salaryNo" class="selectauto">
       	 		<option value="-1">--选择编号--</option>
        	</select>
        </td> -->
      </tr>
      <tr>
        <td class="layertdleft100">银行账号：</td>
       	<td class="layerright"><input name="archives.bankAccount" value="${result.value.bankAccount}"  type="text" class="inputauto" /></td>
       <!--  <td class="layertdleft100">薪酬标准金额：</td>
        <td class="layerright">
        	<select id="salary" name="archives.salary" class="selectauto">
        		<option value="-1">--选择金额--</option>
        	</select>
        </td> -->
      </tr>
      <tr>
        <td class="layertdleft100">培训情况：</td>
        <td colspan="3" class="layerright"><textarea name="archives.train" rows="4" class="textareaauto">${result.value.train}</textarea></td>
        </tr>
    </table></td>  
  </tr>
</table>
</div>
</div>
<!--//basediv-->
<!--basediv-->
<div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">家庭地址：</td>
        <td width="30%" class="layerright">
          <input name="archives.homeAddr" value="${result.value.homeAddr}"  type="text" class="inputauto" />
        </td>
        <td class="layertdleft100">电话号码：</td>
        <td width="30%" class="layerright"><input name="archives.phone" value="${result.value.phone}"  type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100">家庭邮编：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><input name="archives.zipCode" value="${result.value.zipCode}"  type="text" class="inputauto" /></td>
          </tr>
        </table></td>
        <td class="layertdleft100">QQ号码：</td>
        <td width="30%" class="layerright"><input name="archives.qq" value="${result.value.qq}"  type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100">手机号码：</td>
        <td width="30%" class="layerright"><input name="archives.mobile" value="${result.value.mobile}"  type="text" class="inputauto" /></td>
        <td class="layertdleft100">电子邮箱：</td>
        <td width="30%" class="layerright"><input name="archives.email" value="${result.value.email}"  type="text" class="inputauto" /></td>
      </tr>
    </table></td>
   
  </tr>
</table>
</div>
</div>
<!--//basediv-->

<!--basediv-->
<div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">学历：</td>
       	<td class="layerright"><input name="archives.degree" value="${result.value.degree}"  type="text" class="inputauto" /></td>
        <td class="layertdleft100">毕业学校：</td>
        <td class="layerright"><input name="archives.school" value="${result.value.school}"  type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td class="layertdleft100">专业：</td>
        <td class="layerright"><input name="archives.profession" type="text" value="${result.value.profession}"  class="inputauto"/></td>      
        <td class="layertdleft100">参加工作时间：</td>
         <td class="layerright"><input name="archives.workTime" value="${result.value.workTime}"  type="text" class="inputauto" /></td>
      </tr>
      <tr>
        <td valign="top" class="layertdleft100">教育背景：</td>
        <td colspan="3" valign="top"><label><span class="layerright">
          <textarea name="archives.education" rows="8" class="textareaauto">${result.value.education}</textarea>
        </span></label></td>
        </tr>
    </table></td>
   
  </tr>
</table>
</div>
</div>
<!--//basediv-->
<div class="basediv tabswitch" style="margin-top:0px;display:none;" name="textname" id="textname">
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top" class="layertdleft100">奖惩情况：</td>
        <td colspan="3" valign="top"><label><span class="layerright">
          <textarea name="archives.rewards" rows="6" class="textareaauto">${result.value.rewards}</textarea>
        </span></label></td>
        <td valign="top" class="layertdleft100">工作经验：</td>
        <td colspan="3" valign="top"><label><span class="layerright">
          <textarea name="archives.experience" rows="6" class="textareaauto">${result.value.experience}</textarea>
        </span></label></td>
      </tr> 
      <tr>
        <td valign="top" class="layertdleft100">个人爱好：</td>
        <td colspan="3" valign="top"><label><span class="layerright">
          <textarea name="archives.hobby" rows="6" class="textareaauto">${result.value.hobby}</textarea>
        </span></label></td>
        <td valign="top" class="layertdleft100">备注：</td>
        <td colspan="3" valign="top"><label><span class="layerright">
          <textarea name="archives.memo" rows="6" class="textareaauto">${result.value.memo}</textarea>
        </span></label></td>
      </tr>    
    </table></td>
   
  </tr>
</table>
</div>
</div>
<!--//basediv-->

<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
