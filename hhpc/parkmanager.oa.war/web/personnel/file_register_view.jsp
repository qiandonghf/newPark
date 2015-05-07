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
</head>
<body>
<div class="basediv">
	<div class="layertitle">基本信息</div>
<div class="divlays" style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">档案编号：</td>
        <td width="30%" class="layerright">${result.value.serialNo}</td>
        <td class="layertdleft100">员工姓名：</td>
        <td class="layerright">${result.value.name}</td>
      </tr>
      <tr>
        <td class="layertdleft100">身份证号：</td>
        <td class="layerright">${result.value.idNo}</td>
        <td class="layertdleft100">宗教信仰：</td>
        <td class="layerright"> ${result.value.religious.dataValue}</td>
      </tr>
      <tr>
        <td class="layertdleft100">出生日期：</td>
        <td class="layerright"><fmt:formatDate value="${result.value.birthDay}" pattern="yyyy-MM-dd"/></td>
        <td class="layertdleft100">政治面貌：</td>
        <td class="layerright">${result.value.political.dataValue}</td>
      </tr>
      <tr>
        <td class="layertdleft100">性别：</td>      
        <td class="layerright">${result.value.gender.title }</td>
        <td class="layertdleft100">国籍：</td>
       	<td class="layerright"> ${result.value.nationality.dataValue }</td>
      </tr>
      <tr>
        <td class="layertdleft100">婚姻状况：</td>
        <td class="layerright">${result.value.marriage.title}</td>
        <td class="layertdleft100">民族：</td>
        <td class="layerright">${result.value.ethnic.dataValue }</td>
      </tr>
      <tr>
        <td class="layertdleft100">籍贯：</td>
        <td class="layerright">${result.value.homeTown}</td>
        <td class="layertdleft100">状态:</td>
        <td class="layerright">${result.value.status.title }</td>
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
        <td class="layertdleft100" style="white-space:nowrap;">所属部门或公司：</td>
        <td width="80%" class="layerright">${result.value.org.name}</td>
      </tr>
      <tr>
        <td class="layertdleft100">职务：</td>
        <td width="80%" class="layerright">${result.value.position}</td>
      </tr>
      
      <tr>
        <td class="layertdleft100">入职时间：</td>
        <td width="80%" class="layerright"><fmt:formatDate value="${result.value.entryTime}" pattern="yyyy-MM-dd"/></td>
      </tr>
      
      <td class="layertdleft100">合同期限：</td>
        <td width="80%" class="layerright">
	        <table border="0" cellspacing="0" cellpadding="10">
	          <tr>
	            <td width="70"><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd"/></td>
	            <td width="10">--</td>
	            <td width="70"><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd"/></td>
	          </tr>
	        </table>
	    </td>
      <tr>
        <td class="layertdleft100">开户银行：</td>
        <td width="80%" class="layerright">${result.value.bank}</td>
      </tr>
      <tr>
        <td class="layertdleft100">银行账号：</td>
       	<td width="80%" class="layerright">${result.value.bankAccount}</td>
      </tr>
      <tr>
        <td class="layertdleft100">培训情况：</td>
        <td colspan="3" class="layerright"><div style="height: 70px;overflow-y: auto; overflow-x: hidden;">${result.value.train}</div></td>
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
			${result.value.homeAddr}        </td>
        <td class="layertdleft100">电话号码：</td>
        <td width="30%" class="layerright">${result.value.phone}</td>
      </tr>
      <tr>
        <td class="layertdleft100">家庭邮编：</td>
        <td class="layerright">${result.value.zipCode}</td>
        <td class="layertdleft100">QQ号码：</td>
        <td width="30%" class="layerright">${result.value.qq}</td>
      </tr>
      <tr>
        <td class="layertdleft100">手机号码：</td>
        <td width="30%" class="layerright">${result.value.mobile}</td>
        <td class="layertdleft100">电子邮箱：</td>
        <td width="30%" class="layerright">${result.value.email}</td>
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
        <td class="layertdleft100" >学历：</td>
       	<td width="30%" class="layerright">${result.value.degree}</td>
        <td class="layertdleft100">毕业学校：</td>
        <td width="30%" class="layerright">${result.value.school}</td>
      </tr>
      <tr>
        <td class="layertdleft100">专业：</td>
        <td width="30%" class="layerright">${result.value.profession}</td>      
        <td class="layertdleft100">参加工作时间：</td>
        <td width="30%" class="layerright">${result.value.workTime}</td>
      </tr>
      <tr>
		<td class="layertdleft100">教育背景：</td>
		<td colspan="3" class="layerright" ><div style="height: 70px;overflow-y: auto; overflow-x: hidden;">${result.value.education}</div></td>
      </tr>
    </table>
   </td>
   
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
        <td colspan="3" valign="top">
          <div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.rewards}</div>
        </td>
        <td valign="top" class="layertdleft100">工作经验：</td>
        <td colspan="3" valign="top">
          <div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.experience}</div></td>
      </tr> 
      <tr>
        <td valign="top" class="layertdleft100">个人爱好：</td>
        <td colspan="3" valign="top"><div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.hobby}</div></td>
        <td valign="top" class="layertdleft100">备注：</td>
        <td colspan="3" valign="top"><div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.memo}</div></td>
      </tr>    
    </table></td>
   
  </tr>
</table>
</div>
</div>
<div style="height: 5px;"></div>
<!--//basediv-->
</body>
</html>
