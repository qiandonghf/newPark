<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath =  BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
</head>

<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="layertdleft100">姓名：</td>
		<td width="35%" class="layerright">
			${result.value.name}			
		</td>
		<td class="layertdleft100">编号：</td>
    	<td class="layerright">
    		${result.value.orderId }
    	</td>
	 </tr>
	 <tr>
	 	<td class="layertdleft100">是否导师：</td>
   		<td class="layerright">
   			${result.value.tutor.title}
   		</td>
	 	<td class="layertdleft100">性别：</td>
		<td class="layerright">			
			${result.value.gender.title}
		</td>
	 </tr>
	 <tr>
	 	<td class="layertdleft100">出生年月：</td>
		<td class="layerright">${result.value.birth }</td>
	 	<td class="layertdleft100">学历：</td>
		<td class="layerright">${result.value.education }</td>
	 </tr>
	 <tr>
	 	<td class="layertdleft100">联系电话：</td>
    	<td class="layerright">${result.value.phone}</td>
    	<td class="layertdleft100">职称：</td>
    	<td class="layerright"><label>
    	${result.value.position}
    	</label></td>
	 </tr>
    <tr>
    	<td class="layertdleft100">手机：</td>
    	<td class="layerright">${result.value.mobile}</td>
    	<td class="layertdleft100">email：</td>
    	<td class="layerright"><label>
    	${result.value.email}
    	</label></td>
    </tr>
    <tr>
    	<td class="layertdleft100">就职单位:</td>
        <td class="layerright"><label>
    	${result.value.nuit}
    	</label></td>
    	<td class="layertdleft100">职务：</td>
    	<td class="layerright"><label>
    	${result.value.job}
    	</label></td>
    </tr>
    <tr>
    	<td class="layertdleft100">单位地址：</td>
    	<td class="layerright" colspan="3">   		
    		${result.value.address}
    	</td>
   	</tr>
   	 <tr>
    	<td class="layertdleft100">专长领域：</td>
   		<td class="layerright" colspan="3">
   			<div style="height: 40px;overflow-x: hidden;overflow-y: auto">${result.value.speciality}</div>
   		</td>
    </tr>
	</table>
	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">照片：</td>
      <td colspan="3" class="layerright" style="padding-bottom:2px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50">
					<c:if test="${result.value.photo ne ''}">
						<img id="imgpre" src="core/resources/${result.value.photo}" style="border:1px solid #ddd;"  width="50"  height="50" />
					</c:if>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
    </tr>   
    <tr>
    	<td class="layertdleft100">简介：</td>
    	<td colspan="3" class="layerright">
			<div style="height: 100px;overflow-x: hidden;overflow-y: auto">${result.value.memo}</div>
		</td>
    </tr>
  </table>
</div>
<!--//divlay-->
<div class="hackbox"></div>
</div>
<div style="padding-bottom: 2px;"></div>
</body>
</html>
