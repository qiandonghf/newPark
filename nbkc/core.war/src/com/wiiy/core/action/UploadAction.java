package com.wiiy.core.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.UploadResult;

public class UploadAction {
	
	private static final Log logger = LogFactory.getLog(UploadAction.class);
	private File upload;
	private String uploadFileName;
	private String root;
	private String module;
	private String directory;
	
	public UploadAction() {
		root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		//root=CoreActivator.getAppConfig().getConfig("uploadConfig").getParameter("path");
	}
	
	public void execute() {
		FileOutputStream fos = null;
		FileInputStream fis = null;
		String path = "";
		try {
			UploadResult result = new UploadResult();
			result.setOriginalName(uploadFileName);
			result.setSize(upload.length());
			if(directory!=null && directory.length()>0) path += directory;
			if(module!=null && module.length()>0) path += File.separator + module;
			if(!new File(root+path).exists()){
				new File(root+path).mkdirs();
			}
			Date uploadTime = new Date();
			String nowTime = new SimpleDateFormat("yyyyMMddHHmmss").format(uploadTime);
			String suffixName = "";
			if (uploadFileName.indexOf(".") >= 0) {
				suffixName = uploadFileName.substring(uploadFileName.lastIndexOf("."));
			}
			result.setSuffixName(suffixName);
			int random = new Random().nextInt(50);
			String fileName  = nowTime + random + suffixName;
			result.setName(fileName);
			result.setPath((path + File.separator + fileName).replace(File.separator, "/"));
			String filePath = root + result.getPath();
			fos = new FileOutputStream(filePath);
			fis = new FileInputStream(upload);
			byte[] buf = new byte[10240];
			int len = -1;
			while ((len = fis.read(buf)) != -1) {
				fos.write(buf, 0, len);
			}
			logger.debug("file upload complate "+result.getPath());
			ServletActionContext.getResponse().getWriter().println(JSONObject.fromObject(result).toString());//回调数据
			fos.flush();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public String getRoot(){
		return root;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public void setModule(String module) {
		this.module = module;
	}
	public void setDirectory(String directory) {
		this.directory = directory;
	}
}