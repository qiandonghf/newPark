<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%> 
<%@ page import="org.apache.commons.fileupload.FileItem"%> 
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="com.wiiy.platform.*"%> 
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%
String saveFile1="" ;
String realPath = request.getRealPath("/");
//String path = request.getContextPath();
//String basePath = BaseAction.rootLocation+path+"/";
String rootPath = PlatformContext.getParam("10001").getValue(); 
//String rootPath = realPath + "/upload/"; 
try{ 
		//common upload start
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(64*1024);
		// maximum size that will be stored in memory也就是允许传的最小的文件大小
		File file = new File("C:\\TEMP");
		if(!file.isDirectory()){
			file.mkdir();
		}
		factory.setRepository(file); 
		// the location for saving data that is larger than getSizeThreshold()设置临时目录
		ServletFileUpload fu = new ServletFileUpload(factory);
		fu.setSizeMax(200*1024*1024);
		request.setCharacterEncoding("UTF-8");
		List fileItems = fu.parseRequest(request); 
		Iterator iter = fileItems.iterator();
		String newname="";
		while(iter.hasNext()) {
			FileItem item = (FileItem)iter.next();
			if (item.isFormField()) {
		       //则为一般传递的参数，用item.getFieldName()和item.getString()判断取值-------
			}
			if (!item.isFormField()) {
		        saveFile1=item.getName();	//获取文件名	
				/*重命名并存入Session*/
				String ext="";
				if(saveFile1.indexOf(".")>-1){
					ext=saveFile1.substring(saveFile1.lastIndexOf("."),saveFile1.length());
				}
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmsssss");
				 newname=sdf.format(Calendar.getInstance().getTime());
				newname=newname+ext; 
				System.out.println("saveFile1:"+saveFile1+",newname:"+newname);
				request.getSession().setAttribute(saveFile1,newname);
				String fileName = rootPath + newname;
		        InputStream   instr=item.getInputStream();
		        File checkFile = new File(fileName); 
				if(checkFile.exists()){
					return;
				} 
				File fileDir = new File(rootPath); 
				if(!fileDir.exists()){ 
					fileDir.mkdirs(); 
				}
				FileOutputStream fileOut = new FileOutputStream(fileName);
				 byte[] buffer=new byte[1024];
		           int len=0;
		           while((len=instr.read(buffer))!=-1){
		               fileOut.write(buffer, 0, len);
		           }
		
				fileOut.close();  
		         
			}
		}
		response.getWriter().print(newname);
}catch(Exception ex){ 
	throw new ServletException(ex.getMessage()); 
}
%> 