package com.wiiy.web.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import com.wiiy.web.util.StringUtil;



public class StreamAction {
	public InputStream inputStream;
	public String fileName;
	private File upload;
    private String uploadFileName;
    private String uploadContentType;
    private String path;
    
    private String getRoot(){
    	String rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
    	System.out.println(rootPath);
    	return  rootPath;
    	//return PlatformContext.getParam("10001").getValue();
    }
    
    public String download(){
    	try {
//    		fileName=path;
//    		ArticleAtt att=articleAttService.getBeanByFilter(new Filter(ArticleAtt.class).eq("newName", path).maxResults(1)).getValue();
//			if(att!=null){
//				try {
//					fileName=URLEncoder.encode(att.getOldName(),"UTF-8");
//				} catch (Exception e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
    		inputStream = new FileInputStream(new File(getRoot()+path));
    		if (fileName !=null &&  fileName.trim().length()>0 ) {
				fileName = StringUtil.ISOToUTF8(fileName);
				fileName = StringUtil.URLEncoderToUTF8(fileName);
			}
			return "download";
		} catch (FileNotFoundException e) {
			return "fileNotFound";
		}
    }
    
    public String image(){
    	String[] paths = null;
    	try {
//    		if(path!=null){
//    			paths = path.split(",");
//    		}
			inputStream = new FileInputStream(new File(getRoot()+path));
			return "image";
		} catch (FileNotFoundException e) {
			return "fileNotFound";
		}
    }
    public String Image(){
    	try {
			inputStream = new FileInputStream(new File(getRoot()+"upload/"));
			if (fileName !=null &&  fileName.trim().length()>0 ) {
				fileName = StringUtil.ISOToUTF8(fileName);
				fileName = StringUtil.URLEncoderToUTF8(fileName);
			}
			return "Image";
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			return "fileNotFound";
		}
    }
    
    public String video(){
    	try {
    		inputStream = new FileInputStream(new File(getRoot()+"/"+path));
    		return "video";
    	} catch (FileNotFoundException e) {
    		return "fileNotFound";
    	}
    }
   

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}



	
}
