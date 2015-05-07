<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<style type="text/css" >
body{ margin:0px; padding:0px;}
.div{ width:550px; height:auto; padding:20px;}
.div h1{ font-size:29px; text-align:center; font-weight:normal;}
.div h2{ font-size:18px; font-weight:normal;}
.div ul li{line-height:30px; font-size:14px;list-style:none}
.ttable{ border-top:1px solid #c9c9c9; border-left:1px solid #c9c9c9;}
.td{ border-bottom:1px solid #c9c9c9; border-right:1px solid #c9c9c9; text-align:center; height:25px; line-height:25px;}
.th{ background:#f2f2f2; border-bottom:1px solid #c9c9c9; border-right:1px solid #c9c9c9; text-align:center; height:25px; line-height:25px;}
</style>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="div">
	<div id="content">
	<h1>缴费通知单</h1>
	<h2>测试企业.....:</h2>
	<ul>
		<li><p>　　请你公司在收到通知之日起六天内到农业银行交纳以下款项,再凭银行回单来我中心企业部开具发票。为了使创业园能及时支付电业局和水务集团的水电费，及时将租金上缴财政，请配合园区工作，及时交纳，谢谢支持！<br/>
		全称：杭州三略科技技术有限公司<br/>
		开户行： 农行开发区支行<br/>
		    <strong>租金缴入以下帐户</strong><br/>
		    <strong>帐号: 312-220101040003766-0100</strong><br/>
		    <strong>押金、物业费、水电费、宽带费缴入以下帐户</strong><br/>
		    <strong>帐号：312-220101040003766-0402-0213</strong></p>
	  </li>
	  <li>
	    <table width="80%" class="ttable" border="0" cellspacing="0" cellpadding="0">
	    	<tr>
	    	  <td class="th">类型</td>
	    	  <td class="th">费用</td>
    	  </tr>
	    	<tr>
	    	  <td class="td">水费</td>
	    	  <td class="td">￥50.00元</td>
    	  </tr>
	    	<tr>
	            <td class="td">费用合计</td>
	            <td class="td">
	            	￥00.00元	            </td>
          </tr>
        </table>
	    <br />
	      水电费用联系电话:0577-86581051;<br />
	      租金等其他费用联系电话:0577-86581007,86581005; 
		  <p style="padding-left:160px;">杭州三略科技技术有限公司<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		2012年02月08日</p>
	  </li>
	</ul>
</div>
  <div class="buttondiv">
  <label><input name="Submit" type="button" class="allbtn" value=" 打印" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</div>
</body>
</html>
