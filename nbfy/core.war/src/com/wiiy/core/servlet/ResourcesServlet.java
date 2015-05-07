package com.wiiy.core.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wiiy.commons.util.StringUtil;

public class ResourcesServlet extends HttpServlet {
	private String root;
	private ServletContext servletContext;
	private static final long serialVersionUID = 1L;
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		url = url.replaceAll("/core/resources/", "");
		url = URLDecoder.decode(url,"utf-8");
		url.replace("/", File.separator);
		if(url.endsWith("-d")){
			url = url.replace("-d", "");
			File file = new File(root+url);
			if(file.exists()){
				boolean b = false;
				try {
					b = file.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
				response.getWriter().println(b);
			} else {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("您请求的资源不存在 或 已被删除 ");
				out.flush();
				out.close();
			}
		} else {
			File file = new File(root+url);
			if(file.exists()){
				response.setContentType(servletContext.getMimeType(url));
				request.setCharacterEncoding("utf-8");
				String name = request.getParameter("name");
				if(name!=null && name.length()>0){
					if(name.indexOf(".")==-1){
						name += url.substring(url.lastIndexOf("."), url.length());
					}
					name = new String(name.getBytes("ISO-8859-1"),"UTF-8");
					name = StringUtil.URLEncoderToUTF8(name);
					response.setHeader("Content-Disposition","attachment;filename="+name);
				}
				try {
					OutputStream out = response.getOutputStream();
					InputStream in = new FileInputStream(file);
					byte bytes[] = new byte[1024 * 64];
					int len;
					while ((len = in.read(bytes)) != -1) {
						out.write(bytes, 0, len);
					}
					in.close();
					out.flush();
					out.close();
				} catch (Exception e) {
				}
			} else {
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				out.println("您请求的资源不存在 或 已被删除 ");
				out.flush();
				out.close();
			}
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		servletContext = config.getServletContext();
		root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
	}
}
