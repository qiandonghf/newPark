package com.wiiy.core.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.DBDto;
import com.wiiy.core.service.DBService;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.SessionService;
/**
 * 
 * @author Aswan
 *
 */
public class DBServiceImpl implements DBService {
	protected CachedLog logger = CachedLog.getLog(getClass());
	@Override
	public List<DBDto> loadBackupList(Pager pager) {
		//Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
		//String path=config.getParameter("path");
		String path=System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/dbbackup/";
		
		File root = new File(path);
		if (!root.exists()) {
			root.mkdir();
		}
		File[] files = root.listFiles();
		files=sort(files);
		
		pager.setRecords(files.length);
		List<DBDto> fileList = new ArrayList<DBDto>();
		for (int i = (pager.getPage()-1)*pager.getRows(); i < pager.getPage()*pager.getRows() && i < files.length; i++) {
			DBDto dbFile=new DBDto();
			dbFile.setPath(path);
			dbFile.setName(files[i].getName());
			dbFile.setSize(files[i].length());
			Date d=new Date(files[i].lastModified());
			dbFile.setCreateTime(d);
			fileList.add(dbFile);
		}
		return fileList;
	}
	public static File[] sort(File[] files) {
		File[] buffer = files;
		Arrays.sort(files, new Comparator<File>() {
			public int compare(File file1, File file2) {
				return file1.lastModified() < file2.lastModified() ? 1 : -1;
			}
		});
		return buffer;
	}
	@Override
	public String doBackup()throws Exception {
		String msg="";
		SessionService sessionService=CoreActivator.getService(SessionService.class);
		if(sessionService!=null){
			ComboPooledDataSource ds = sessionService.getDs();
			if(ds!=null){
				String driver = ds.getDriverClass();//"com.mysql.jdbc.Driver";
				String url = ds.getJdbcUrl();
				String user = ds.getUser();//"root";
				String password = ds.getPassword();//"password";
				String tmp=url.substring(13);
				String dbName=tmp.substring(tmp.indexOf("/")+1,tmp.indexOf("?"));
				//System.out.println("dbName:"+dbName);
				tmp=tmp.substring(0, tmp.indexOf("/"));
				String host="";
				String port="3306";
				String[] tt=tmp.split(":");
				if(tt.length==1){
					host=tt[0];
				}
				else if(tt.length==2){
					host=tt[0];
					port=tt[1];
				}
				logger.debug("DBServiceImpl.loadBackupList():dbName:"+dbName);
				logger.debug("DBServiceImpl.loadBackupList():driver="+driver);
				logger.debug("DBServiceImpl.loadBackupList():host="+host);
				logger.debug("DBServiceImpl.loadBackupList():port="+port);
				logger.debug("DBServiceImpl.loadBackupList():user="+user);
				logger.debug("DBServiceImpl.loadBackupList():password="+password);
				
				String cmdPath=CoreActivator.getBundleRootPath();
				cmdPath=cmdPath.substring(0, cmdPath.lastIndexOf("/"));
				cmdPath=cmdPath+"/platform.lib/mysql5.1/bin/";
				Runtime rt = Runtime.getRuntime();
				//Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
				//String path=config.getParameter("path");
				
				String path=System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/dbbackup/";
				
				Date d=new Date();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmss_SSS");
				String fileName="db"+sdf.format(d)+".sql";
				logger.debug("备份开始.......");
				logger.debug("fileName:"+fileName);
				logger.debug("path:"+path);
				logger.debug("cmdPath:"+cmdPath);
				cmdPath="";
				String cmd=cmdPath+"mysqldump -h "+host+" -P"+port+" -u"+user+" -p"+password+" "+dbName+"  --set-charset=utf8";//+" --set-charset=utf8";
				logger.debug("cmd:"+cmd);
				Process child = rt.exec(cmd);// 设置导出编码为utf8。这里必须是utf8
				InputStream in = child.getInputStream();// 控制台的输出信息作为输入流
				InputStreamReader is = new InputStreamReader(in, "utf8");// 设置输出流编码为utf8。这里必须是utf8，否则从流中读入的是乱码
				String inStr;
				BufferedReader br = new BufferedReader(is);
				File dbbuckup = new File(path);
				if(!dbbuckup.exists()){
					dbbuckup.mkdir();
				}
				String sqlFile = dbbuckup.getPath()+"/"+fileName;
				FileOutputStream fout = new FileOutputStream(sqlFile);
				
				logger.debug("创建文件:"+sqlFile);
				OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8");
				// 组合控制台输出信息字符串
				logger.debug("读取控制台");
				
				while ((inStr = br.readLine()) != null) {
					//logger.debug("控制台输出:"+inStr);
					inStr+="\r\n";
					fout.write(inStr.getBytes("utf8"));
					
					//logger.debug("-------------------inStr="+inStr);
				}
				
				// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免
				writer.flush();
				// 别忘记关闭输入输出流
				in.close();
				is.close();
				br.close();
				writer.close();
				fout.close();
				
				msg="备份成功!";
			}
			else{
				logger.debug("DBServiceImpl.loadBackupList():properties=null");
				msg="无法获取数据库连接信息，备份已取消!";
			}
			
		}
		else{
			logger.debug("DBServiceImpl.loadBackupList():sessionService=null");
			msg="无法获取系统服务接口，备份已取消!";
		}
		//Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
		//String path=config.getParameter("path");
		String path=System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/dbbackup/";
		
		logger.debug(msg);
		return msg;
	}
	@Override
	public void deleteByDayCnt(int days) throws Exception {
		//Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
		//String path=config.getParameter("path");
		String path=System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/dbbackup/";
		
		
		GregorianCalendar calendar=new GregorianCalendar();
		
		calendar.add(Calendar.DAY_OF_YEAR, -days);
		
		long deleteTime=calendar.getTime().getTime();
		
		File root = new File(path);
		if (!root.exists()) {
			root.mkdir();
		}
		File[] files = root.listFiles();
		for(File file:files){
			logger.debug("file.lastModified():"+file.lastModified()+",deleteTime:"+deleteTime);
			if(file.lastModified()<deleteTime){//30天以前
				boolean r=file.delete();
				if(r)logger.debug("删除文件成功:"+file.getName());
				else logger.debug("删除文件失败:"+file.getName());
			}
		}
	}

}
