<%@page import="com.wiiy.web.listener.InitListener"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div id="footer">
  <div class=ftop>
	  <a href="easy.action?type=contact" target=_blank>联系我们</a> | 
	  <a href="easy.action?type=legal" target=_blank>法律公告</a> | 
	  <a href="easy.action?type=privacy" target=_blank>隐私保护</a> | 
	  <a href="easy.action?type=drafting" target=_blank>招贤纳士</a> | 
	  <a href="easy.action?type=navigation" target=_blank>网站导航</a> | 
	  <a href="easy.action?type=feedback" target=_blank>意见反馈</a> 
  </div>
  <div class="finfo">
    <div class="left"><img src="images/db_logo.gif" width="67" height="62" /></div>
    <div class="finfor"><%=InitListener.webParam.getCopyright() %></div>
    <div class="finfol">
    	技术支持：杭州维一科技有限公司<br />
   		 技术支持电话：0571-87985585 <br />
		 传真：0571-87985585
	</div>
  </div>
</div>
<%-- <td><%=InitListener.webParam.getCopyright() %></td> --%>
