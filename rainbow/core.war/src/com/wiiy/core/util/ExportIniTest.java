package com.wiiy.core.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class ExportIniTest {
	public static void main(String[] args) {
		String encoding = "UTF8"; // 字符编码(可解决中文乱码问题 )  
		try {
			//Debug_Configurations--Settings--Use default location中
			File file = new File("E:/huaye/.metadata/.plugins/org.eclipse.pde.core/New_configuration/config.ini");
			InputStreamReader read = new InputStreamReader(new FileInputStream(file), encoding); 
			BufferedReader br = new BufferedReader(read);
			FileOutputStream out = null;
			String s;
			out = new FileOutputStream(new File("E:/config.ini"));
			while ((s=br.readLine())!=null) {
				if(s.contains(",")){
					s = s.replaceAll(",", ",\\\\"+"\r\n");
					if(s.contains("reference\\:file\\:E\\:/huaye")){
						//替换jar路径
						s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.lib", "./load");
					}
					/*
					./plugins/core.war_1.0.0.20120814.jar@3:start,\
					./plugins/parkmanager.dn.war_1.0.0.20120814.jar@3:start,\
					./plugins/parkmanager.edi.war_1.0.0.20120814.jar@3:start,\
					./plugins/parkmanager.oa.war_1.0.0.20120814.jar@3:start,\
					./plugins/platform.base.bundle_1.0.0.20120814.jar@3:start,\
					./plugins/platform.c3p0.bundle_1.0.0.20120814.jar@3:start,\
					./plugins/platform.catalina.cfg_1.0.0.20120814.jar@3,\
					./plugins/platform.log4j.config_1.0.0.20120814.jar@3,\
					./plugins/platform.lucene4.bundle_1.0.0.20120814.jar@3:start,\
					./plugins/platform.sms.boyong.bundle_1.0.0.20120814.jar@3:start,\
					./plugins/platform.struts2.bundle_1.0.0.20120814.jar@3:start 
					*/
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/core.war@start,\\\\", "./plugins/core.war_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.log4j.config,\\\\", "./plugins/platform.log4j.config_1.0.0.20120814.jar@3,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.c3p0.bundle@start,\\\\", "./plugins/platform.c3p0.bundle_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.catalina.config,\\\\", "./plugins/platform.catalina.cfg_1.0.0.20120814.jar@3,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/parkmanager.dn.war@start,\\\\", "./plugins/parkmanager.dn.war_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.base.bundle@start,\\\\", "./plugins/platform.base.bundle_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.sms.boyong.bundle@start,\\\\", "./plugins/platform.sms.boyong.bundle_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/parkmanager.mockup.war@start,\\\\", "");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/platform.struts2.bundle@start,\\\\", "./plugins/platform.struts2.bundle_1.0.0.20120814.jar@3:start,\\\\");
					s = s.replaceAll("reference\\\\:file\\\\:E\\\\:/huaye/parkmanager.oa.war@start,\\\\", "./plugins/parkmanager.oa.war_1.0.0.20120814.jar@3:start,\\\\");
					out.write(s.getBytes());
				}
			}
			System.out.println("导出成功");
			read.close();
			br.close();
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
