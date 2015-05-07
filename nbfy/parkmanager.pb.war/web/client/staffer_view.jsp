<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td class="layerright">${result.value.customer.name }</td>
    </tr>
    <tr>
      <td class="layertdleft100">姓名：</td>
      <td class="layerright">${result.value.name }</td>
    </tr>
    <tr>
      <td class="layertdleft100">性别：</td>
      <td class="layerright">${result.value.gender.title }</td>
    </tr>
    <tr>
      <td class="layertdleft100">出生年月：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.birth}" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">职位：</td>
      <td class="layerright">
      	${result.value.position.dataValue }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">职称：</td>
      <td class="layerright">
      	${result.value.professional }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">政治面貌：</td>
      <td class="layerright">
      	${result.value.political.dataValue }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">联系电话：</td>
      <td class="layerright">${result.value.phone }</td>
    </tr>
    
    <tr>
      <td class="layertdleft100">Email：</td>
      <td class="layerright">${result.value.email }</td>
    </tr>
    <tr>
      <td class="layertdleft100">学位：</td>
      <td class="layerright">
      	${result.value.degree.dataValue }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">学历：</td>
      <td class="layerright">
      	${result.value.education }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">毕业学校：</td>
      <td class="layerright">${result.value.studySchool }</td>
    </tr>
    <tr>
      <td class="layertdleft100">留学国家：</td>
      <td class="layerright">${result.value.abroadCountry }</td>
    </tr>
    <tr>
      <td class="layertdleft100">是否总经理：</td>
      <td class="layerright">${result.value.manager.title }</td>
    </tr>
    <tr>
      <td class="layertdleft100">是否法人：</td>
      <td class="layerright">
      	 ${result.value.legal.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否留学员：</td>
      <td class="layerright">
      	${result.value.studyAbroad.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否股东：</td>
      <td class="layerright">
      	${result.value.stockHolder.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否发布网站</td>
      <td class="layerright">
      	 ${result.value.pub.title }
      </td>
    </tr>
    <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">${result.value.creator }</td>
    </tr>
    <tr>
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">${result.value.modifier }</td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/></td>
    </tr> --%>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
