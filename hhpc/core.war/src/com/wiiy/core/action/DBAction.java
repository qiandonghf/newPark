package com.wiiy.core.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.wiiy.commons.action.BaseAction;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.DBDto;
import com.wiiy.core.service.DBService;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.hibernate.Pager;

public class DBAction extends BaseAction {
	
	private List<DBDto> dbBackupList;
	private Pager pager;
	protected Integer page = 0;
	private String fileName;
	private String msg;
	private InputStream inputStream;
	private DBService dbService;

	public List<DBDto> getDbBackupList() {
		return dbBackupList;
	}

	public void setDbService(DBService dbService) {
		this.dbService = dbService;
	}
	public String delete(){
		int dayCnt=30;//清理30天以前的数据
		try {
			dbService.deleteByDayCnt(dayCnt);
			CoreActivator.getOperationLogService().logOP("清理了"+dayCnt+"天前的数据库备份文件");
			msg="清理成功!";
		} catch (Exception e) {
			e.printStackTrace();
			msg="清理失败!";
		}
		
		pager = new Pager(1,10);
		dbBackupList=dbService.loadBackupList(pager);
		return this.LIST;
	}
	public String list(){
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		dbBackupList=dbService.loadBackupList(pager);
		return this.LIST;
	}
	public String doBackup(){
		try {
			msg=dbService.doBackup();
			CoreActivator.getOperationLogService().logOP("新建了一个数据库备份");
		} catch (Exception e) {
			e.printStackTrace();
			msg="系统异常备份失败!";
		}
		pager = new Pager(1,10);
		dbBackupList=dbService.loadBackupList(pager);
		return this.LIST;
		
	}
	public String download(){
		
		//Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
		//String path=config.getParameter("path");
		String path=System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/dbbackup/";
		
		
		if(fileName!=null&&fileName.length()>0){
			try {
				fileName=new String(fileName.getBytes("ISO_8859_1"),"utf-8");
				FileInputStream input=new FileInputStream(path+"/"+fileName);
				int size=input.available();
				byte[] me=new byte[size];
				input.read(me);
				input.close();
				fileName=StringUtil.URLEncoderToUTF8(fileName);
				inputStream = new ByteArrayInputStream(me);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "download";
	}

	
	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
}
