package com.wiiy.core.service.impl;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.service.export.ResourcesService;

public class ResourcesServiceImpl implements ResourcesService{

	@Override
	public boolean delete(String path) {
		if(path==null)return false;
		//String root=CoreActivator.getAppConfig().getConfig("uploadConfig").getParameter("path");
		String root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		path.replace("/", File.separator);
		File file = new File(root+path);
		if(file.exists()){
			return file.delete();
		}
		return false;
	}
	@Override
	public File getFileByPath(String path) {
		if(path==null)return null;
		String root= System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		path.replace("/", File.separator);
		File file = new File(root+path);
		if(file.exists()){
			return file;
		}
		return null;
	}

	@Override
	public File saveFile(String path,InputStream in) {
		if(path==null)return null;
		String root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		path.replace("/", File.separator);
		try {
			File file = new File(root+path);
			if(!file.exists()){
				if(!file.getParentFile().exists()){
					file.getParentFile().mkdirs();
				}
				file.createNewFile();
			}
			FileOutputStream fileOut = new FileOutputStream(file);
			byte[] array = new byte[1024 * 64];
			int length;
			while ((length = in.read(array)) != -1) {
				fileOut.write(array, 0, length);
			}
			in.close();
			fileOut.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
