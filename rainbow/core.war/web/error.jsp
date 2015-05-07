<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%response.setStatus(HttpServletResponse.SC_OK);%>
<body>
程序发生了错误，有可能该页面正在调试或者是设计上的缺陷.<br/>
你可以选择<br/> 联系管理员（0571-87985585） 或者<br/><a href="javascript:history.go(-1)">返回上一页</a>
<hr width=80%>
<h2><font color=#DB1260>JSP Error Page</font></h2>
<p>An exception was thrown: <b> <%=exception.getClass()%>:<%=exception.getMessage()%></b></p>
<%
Enumeration<String> e = request.getHeaderNames();
String key;
while(e.hasMoreElements()){
  key = e.nextElement();
}
e = request.getAttributeNames();
while(e.hasMoreElements()){
  key = e.nextElement();
}
e = request.getParameterNames();
while(e.hasMoreElements()){
  key = e.nextElement();
}
%>
<%=request.getAttribute("javax.servlet.forward.request_uri") %><br>
<%=request.getAttribute("javax.servlet.forward.servlet_path") %>
<p>With the following stack trace:</p>
<pre>
<%
  exception.printStackTrace();
  ByteArrayOutputStream ostr = new ByteArrayOutputStream();
  exception.printStackTrace(new PrintStream(ostr));
  out.print(ostr);
%>
</pre>
<hr width=80%>
</body>
