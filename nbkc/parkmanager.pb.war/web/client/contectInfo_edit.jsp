<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.ContectInfo"%>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initTip();
		//loadContectsByCustomerId('${result.value.customerId}');
	});

	function checkForm(){
		 if(notNull("customerName","企业名称")
				&&notNull("contectId","联系人")
				&&checkSelect("type","交往类型")
				&&notNull("startTime","交往日期")
				&&notNull("content","内容")
		 	){
			 	$("#contectInfoStartTime").val($("#startTime").val()+" "+$("#startHour").val()+":"+$("#startMinute").val()+":00");
				$('#form1').ajaxSubmit({ 
		        dataType: 'json',
		        success: function(data){
	        		showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
		        	}
		        } 
		    });
		} 
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
		//loadContectsByCustomerId(customer.id);
	}
	<%-- function loadContectsByCustomerId(id){
		$.post("<%=basePath%>contect!loadContectsByCustomerId.action?id="+id,function(data){
			if(data.result.success){
				var list = data.result.value;
				var contectId = $("#contectId");
				contectId.empty();
				contectId.append($("<option></option>",{value:""}).append("---请选择---"));
				for(var i = 0; i < list.length; i++){
					var contect = list[i];
					contectId.append($("<option></option>",{value:contect.id}).append(contect.name));
				}
				var contectindex = $("option:contains(${result.value.contectId})").index();
				var contectindex = $("option:contains('${result.value.contect.name}')").index();
				$("#contectId").get(0).selectedIndex = contectindex;
			} else {
				showTip(data.result.msg,2000);
			}
		});
	} --%>
	function selectUser(){
		fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!selectSelf.action',520,400);
	}
	
	function setSelectedUser(user){
		$("#contectId").val(user.id);
		$("#contectName").val(user.realName);
	}
	
</script>
</head>

<body>
<form action="<%=basePath %>contectInfo!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           	<td width="370">
				<input id="customerId" name="contectInfo.customerId" type="hidden" /><input id="customerName" type="text" value="${result.value.customer.name }" class="inputauto" readonly="readonly" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/>          
				<input type="hidden" name="contectInfo.id" value="${result.value.id}" />
        	</td>
            <td><img src="core/common/images/outdiv.gif"  style="position:relative;left:-1px;" width="20" height="22" onclick="fbStart('选择企业','<%=basePath%>customer!select.action',520,400);"/></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>走访人员：</td>
        <td class="layerright">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="10"><input id="contectId" name="contectInfo.contectId" value="${result.value.contectId }" type="hidden" class="inputauto" /><input id="contectName" value="${result.value.contect.realName }" readonly="readonly" type="text" class="inputauto" onclick="selectUser()" /></td>
					<td width="25"><img style="position: relative;left:-1px;" onclick="selectUser()" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
				</tr>
			</table>
		</td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>交往类型：</td>
        <td class="layerright">
      	<dd:select id="type" name="contectInfo.typeId" key="crm.0016" checked="result.value.typeId"/>
    	</td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>交往日期：</td>
        <td colspan="3" class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          	<td>
          		<input name="tartTime" readonly="readonly" type="text" class="inputauto" id="startTime"  value="<fmt:formatDate value="${result.value.startTime }" pattern="yyyy-MM-dd"/>" onclick="return showCalendar('startTime');" />
          		<input id="contectInfoStartTime" name="contectInfo.startTime" type="hidden" value="test"/>
          	</td>
          	<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('startTime');" /></td>
        	<td style="padding-left: 4px;">
        		<%
						Result<ContectInfo> result = (Result<ContectInfo>)request.getAttribute("result"); 
						Calendar startTime = Calendar.getInstance();
						startTime.setTime(result.getValue().getStartTime());
						int hour = startTime.get(Calendar.HOUR_OF_DAY);
						int minute = startTime.get(Calendar.MINUTE);
				%>
				<select id="startHour">
					<c:forEach begin="0" end="23" var="s">
						<option value="<c:if test="${s<10}">0</c:if>${s}" <%if(Integer.parseInt(pageContext.getAttribute("s").toString())==hour) out.println("selected=\"selected\"");%>>${s}</option>
					</c:forEach>
				</select>&nbsp;时
				<select id="startMinute">
					<c:forEach begin="0" end="59" var="s" step="5">
						<option value="<c:if test="${s<10}">0</c:if>${s}" <%if(Integer.parseInt(pageContext.getAttribute("s").toString())==minute) out.println("selected=\"selected\"");%>>${s}</option>
					</c:forEach>
				</select>&nbsp;分
			</td>
        </tr>
      </table></td>
      </tr>
      <tr>
        <td class="layertdleft100"><span class="psred">*</span>内容：</td>
        <td class="layerright"><textarea id="content" name="contectInfo.content" style="height:115px;" class="textareaauto">${result.value.content }</textarea></td>
      </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright" style="margin-top:4px;"><textarea name="contectInfo.memo" style="height:30px;" class="textareaauto">${result.value.memo }</textarea></td>
      </tr>
      <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">
      	${result.value.creator }
   	  </td>
   	 </tr>
    <tr>  
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright">
     	<fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">
      	${result.value.modifier }
   	  </td>
   	  </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright">
      	<fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr> --%>
    </table>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
  <label><input name="Submit" type="button" class="savebtn" value="" onclick="checkForm()"/></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
