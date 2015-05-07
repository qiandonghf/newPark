<%@page import="java.io.File" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<title>图片浏览</title>
		<script type="text/javascript">
			//这段函数是重点，不然不能和CKEditor互动了
			function funCallback(funcNum,fileUrl){
				var parentWindow = ( window.parent == window ) ? window.opener : window.parent;
				parentWindow.CKEDITOR.tools.callFunction(funcNum, fileUrl);
				window.close();
			}
		</script>
	</head>
	<body>
	<%
		String path = request.getContextPath() + "/";
		String rootFolder = "uploads";
		File root = new File(request.getSession().getServletContext().getRealPath(rootFolder));
		if(!root.exists()){
			root.mkdirs();
		}
		String callback = request.getParameter("CKEditorFuncNum");
		File[] files = root.listFiles();
		if(files.length > 0){
			for(File folder : files ) {
				if(folder.isDirectory())
				for(File file : folder.listFiles() ) {
					String src = path + rootFolder + "/" + folder.getName() + "/" + file.getName();
					out.println("<img width='110px' height='70px' src='" + src + "' alt='" + file.getName() + "' onclick=\"funCallback("+callback+",'"+ src +"')\">");
				}
			}
		}else{
			out.println("<h3>未检测到资源。</h3>");
		}
	 %>
</body>
</html>