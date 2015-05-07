<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Random"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<title>JSP上传文件</title>
</head>
<body>
<%
String path = request.getContextPath() + "/";
if(ServletFileUpload.isMultipartContent(request)){
	String callback = request.getParameter("CKEditorFuncNum");//获取回调JS的函数Num
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
	servletFileUpload.setHeaderEncoding("UTF-8");//解决文件名乱码的问题
	List<FileItem> fileItemsList = servletFileUpload.parseRequest(request);
	for (FileItem item : fileItemsList) {
		if (!item.isFormField()) {
			String fileName = item.getName();
			
			String root = "uploads";
			Date uploadTime = new Date();
			String folder = new SimpleDateFormat("yyyyMMdd").format(uploadTime);
			if(!new File(root+"/"+folder).exists()){
				new File(root+"/"+folder).mkdirs();
			}
			String nowTime = new SimpleDateFormat("yyyyMMddHHmmss").format(uploadTime);
			String extName = "";
			if (fileName.lastIndexOf(".") >= 0) {
				extName = fileName.substring(fileName.lastIndexOf("."));
			}
			int random = new Random().nextInt(50);
			String realName = nowTime + random + extName;
			String filePath = root + "/" + folder + "/" + realName;

			//保存文件到服务器上
			File file = new File(request.getSession().getServletContext().getRealPath(filePath));
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			item.write(file);

			//打印一段JS，调用parent页面的CKEditor的函数，传递函数编号和上传后文件的路径；这句很重要，成败在此一句
			out.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("+callback+",'"+path+filePath+"')</script>");
			break;
		}
	}
}
 %>
</body>
</html>