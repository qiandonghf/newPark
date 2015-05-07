package com.wiiy.core.external.service.impl;

import com.wiiy.commons.preferences.enums.LogTypeEnum;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.OperationLog;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.OperationLogService;
import com.wiiy.external.service.OperationLogPubService;
import com.wiiy.hibernate.Result;

public class OperationLogPubServiceImpl implements OperationLogPubService {
	private OperationLogService operationLogService;
	private String bundleName;
	
	public OperationLogService getOperationLogService() {
		return operationLogService;
	}
	public void setOperationLogService(OperationLogService operationLogService) {
		this.operationLogService = operationLogService;
	}
	
	@Override
	public void initBundleName(String bundleName) {
		this.bundleName = bundleName;
	}
	@Override
	public Result logOP(String msg) {
		OperationLog log=new OperationLog();
		log.setBundleName(bundleName);
		log.setMsg(msg);
		log.setLogType(LogTypeEnum.OP);
		User u=CoreActivator.getSessionUser();
		if(u!=null){
			Org org=u.getOrg();
			if(org!=null){
				log.setOrgName(org.getName());
				log.setOrgId(org.getId());
			}
			log.setIp(u.getIp());
		}
		return operationLogService.save(log);
	}
	@Override
	public Result logLogin(String msg) {
		OperationLog log=new OperationLog();
		log.setBundleName(bundleName);
		log.setMsg(msg);
		log.setLogType(LogTypeEnum.LOGIN);
		User u=CoreActivator.getSessionUser();
		if(u!=null){
			Org org=u.getOrg();
			if(org!=null){
				log.setOrgName(org.getName());
				log.setOrgId(org.getId());
			}
			log.setIp(u.getIp());
		}
		return operationLogService.save(log);
	}
	@Override
	public Result logLogout(String msg) {
		OperationLog log=new OperationLog();
		log.setBundleName(bundleName);
		log.setMsg(msg);
		log.setLogType(LogTypeEnum.LOGOUT);
		User u=CoreActivator.getSessionUser();
		if(u!=null){
			Org org=u.getOrg();
			if(org!=null){
				log.setOrgName(org.getName());
				log.setOrgId(org.getId());
			}
			log.setIp(u.getIp());
		}
		return operationLogService.save(log);
	}
	

}
