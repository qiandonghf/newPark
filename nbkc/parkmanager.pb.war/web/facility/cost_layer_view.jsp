<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.pb.entity.FacilityOrder"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/><title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>


<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	
</script>
</head>

<body>
<form action="" method="post" name="form1" id="form1">
  <!--basediv-->
  <div class="basediv">
    <!--titlebg-->
    <!--//titlebg-->
    <!--divlay-->
    <div class="divlays" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="layertdleft100">设施名称：</td>
          <td class="layerright">
             	${result.value.facility.name}
          </td>
        </tr>
        <tr>
          <td class="layertdleft100">费用类型：</td>
          <td class="layerright"><label>
             ${result.value.facility.type.title}费
             </label></td>
        </tr>
        <tr>
          <td class="layertdleft100">计划金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><fmt:formatNumber value="${result.value.planFee}" pattern="#0.00"/>&nbsp;元 本期设置优惠之前的金额</td>
              <td> </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">实际金额：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><fmt:formatNumber value="${result.value.realFee}" pattern="#0.00"/>&nbsp;元 本期实际需要支付的金额</td>
              <td></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;--&nbsp;&nbsp;<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/></td>
              <td></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="layertdleft100">计划付费日期：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="100"><fmt:formatDate value="${result.value.planPayDate}" pattern="yyyy-MM-dd"/></td>
              <td width="28" align="center"></td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <%-- <tr>
          <td class="layertdleft100">自动出帐：</td>
          <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="20"><label>
                <c:if test="${result.value.autoCheck eq 'YES'}">是</c:if>
                <c:if test="${result.value.autoCheck eq 'NO'}">否</c:if>
              </label></td>
            </tr>
          </table></td>
        </tr>
         <tr>
	      <td class="layertdleft100">出帐状态：</td>
	      <td class="layerright">
	      	 ${result.value.status.title}
	      </td>
	    </tr> --%>
		
		<tr>
	      <td class="layertdleft100"><p>出账时间：</p></td>
	      <td class="layerright">
	     	 <table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
		          <td width="100"><fmt:formatDate value="${result.value.intoAccountDate}" pattern="yyyy-MM-dd"/></td>
		          <td width="28" align="center"></td>
		          <td>&nbsp;</td>
		        </tr>
	     	 </table>
	      </td>
       </tr>
        
	 <tr>
      <td class="layertdleft100">滞纳金：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100">
          	  <c:if test="${result.value.overdueFee!=null}"><fmt:formatNumber value="${result.value.overdueFee}" pattern="#0.00"/>&nbsp;元</c:if>
          	  <c:if test="${result.value.overdueFee==null}">0&nbsp; 元</c:if>
          </td>
          <td></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100">最后付费日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100"><fmt:formatDate value="${result.value.lastPayDate}" pattern="yyyy-MM-dd"/></td>
          <td width="28" align="center"></td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
	 <tr>
      <td class="layertdleft100">已付金额：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100">
          	 <c:if test="${result.value.paidFee!=null}"><fmt:formatNumber value="${result.value.paidFee}" pattern="#0.00"/>&nbsp; 元</c:if>
          	 <c:if test="${result.value.paidFee==null}">0&nbsp; 元</c:if>
         </td>
          <td></td>
        </tr>
      </table></td>
    </tr>
        
        
      </table>
    </div>
    <!--//divlay-->
    <div class="hackbox"></div>
  </div>
  <!--//basediv-->
  <!--//basediv-->
   <div style="height: 5px;"></div>
</form>
</body>
</html>
