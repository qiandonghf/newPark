<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/calendar.css"/>
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/js/calendar.js"></script>
<script type="text/javascript" src="core/common/js/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/js/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/layertable.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	
<script type="text/javascript">
$(document).ready(function() {
	initTip();
	initForm();
});

function initForm(){
	$("#form1").validate({
		rules:{
			"card.name":"required"
		},
		messages: {
			"card.name":"请输入名字"
		},
		errorPlacement: function(error, element){
			showTip(error.html());
		},
		submitHandler: function(form){
			$('#form1').ajaxSubmit({ 
		        dataType: 'json',		        
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.refresh();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		}
	});
}


</script>
</head>

<body>
		<!--basediv-->
		<div class="basediv">
			<div class="divlays">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
						
	<tr>
      <td class="layertdleft100">姓名：</td>
      <td class="layerright" width="35%">
      		${result.value.name}
      </td>
      <td class="layertdleft100">昵称：</td>
      <td class="layerright">
      		${result.value.nickName}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">出生年月：</td>
      <td class="layerright">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
          <td width="153">
			<fmt:formatDate value="${result.value.birthday}" pattern="yyyy-MM-dd"/>
		</td>
      </tr>
      </table></td>
      <td class="layertdleft100">称谓：</td>
      <td width="35%" class="layerright"><label>
     	 ${result.value.appellation.title}
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">名片夹：</td>
	  <td colspan="3" class="layerright">
	 	 <div style=" vertical-align:middle; padding:5px; overflow-x:hidden; overflow-y:auto;">
	  		<c:forEach items="${cardCategoryList}" var="cardCategory">
	  			${cardCategory.name}
	  		</c:forEach>
	  		</div>
	  </td>
    </tr>
    
  </table>
				<div class="hackbox"></div>
			</div>
		</div>
		<!--//basediv-->
		<div style="height: 176px;">
			<!--table切换开始-->
			<div class="apptab" id="tableid">
				<ul>
					<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">联系方式</li>
					<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">公司</li>
					<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">家庭</li>
					<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',3)">备注</li>
				</ul>
			</div>
			<!--//table切换开始-->
			<!--basediv-->
			<div class="basediv tabswitch" style="margin-top: 0px;" name="textname"
				id="textname">
				<!--divlays-->
				<div class="divlays" style="margin: 0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft100">手机号码：</td>
							<td><label> 
								&nbsp;${result.value.mobile}
							</label></td>
						</tr>
						<tr>
							<td class="layertdleft100">固定电话：</td>
							<td>
								&nbsp;${result.value.homeTel}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">Email：</td>
							<td>
								&nbsp;${result.value.email}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">QQ：</td>
							<td>
								&nbsp;${result.value.qq}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">MSN：</td>
							<td>
								&nbsp;${result.value.msn}
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--//basediv-->
			<!--basediv-->
			<div class="basediv tabswitch" style="margin-top: 0px; display: none;"
				name="textname" id="textname">
				<!--divlays-->
				<div class="divlays" style="margin: 0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft100">职务：</td>
							<td><label> 
									&nbsp;${result.value.position}
							</label></td>
						</tr>
						<tr>
							<td class="layertdleft100">单位名称：</td>
							<td><label>&nbsp;${result.value.company}
									
							</label></td>
						</tr>
						<tr>
							<td class="layertdleft100">单位地址：</td>
							<td>&nbsp;${result.value.companyAddr}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">单位电话：</td>
							<td>
								&nbsp;${result.value.officeTel}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">单位传真：</td>
							<td>
								&nbsp;${result.value.fax}
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--//basediv-->
			<!--basediv-->
			<div class="basediv tabswitch" style="margin-top: 0px; display: none;"
				name="textname" id="textname">
				<!--divlays-->
				<div class="divlays" style="margin: 0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft100">家庭住址：</td>
							<td><label> 
								&nbsp;${result.value.homeAddr}
							</label></td>
						</tr>
						<tr>
							<td class="layertdleft100">家庭邮编：</td>
							<td><label>
								&nbsp;${result.value.zipcode}
							</label></td>
						</tr>
						<tr>
							<td class="layertdleft100">配偶：</td>
							<td>
								&nbsp;${result.value.spouse}
							</td>
						</tr>
						<tr>
							<td class="layertdleft100">子女：</td>
							<td>
								&nbsp;${result.value.child}
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--//basediv-->
			<!--basediv-->
			<div class="basediv tabswitch" style="margin-top: 0px; display: none;"
				name="textname" id="textname">
				<!--divlays-->
				<div class="divlays" style="margin: 0px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="layertdleft100">备注：</td>
							<td class="layerright">
								<div style="height: 112px;overflow-x: hidden;overflow-y: auto">${result.value.memo}</div>
						    </td>
						</tr>
					</table>
				</div>
			</div>
			<!--//basediv-->
		</div>
		<div style="height: 5px;">
		</div>
</body>
</html>
