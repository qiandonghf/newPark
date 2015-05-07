package com.wiiy.pb.activator;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceEvent;
import org.osgi.framework.ServiceListener;
import org.osgi.framework.ServiceReference;

import com.wiiy.commons.activator.AbstractActivator;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.export.AppConfig;
import com.wiiy.core.service.export.AppConfigManager;
import com.wiiy.core.service.export.AppParamService;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.core.service.export.FKService;
import com.wiiy.core.service.export.HttpSessionService;
import com.wiiy.core.service.export.ModuleRegister;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.core.service.export.RemindEmailService;
import com.wiiy.core.service.export.ResourcesService;
import com.wiiy.external.service.OperationLogPubService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.system.DataDictInit;
import com.wiiy.pb.system.InitSql;

public class PbActivator extends AbstractActivator {
	public static final String APP_CONFIG_NAME = "ParkManagement-AppName";	
		
	public static BundleContext bundleContext;
	
	private static AppConfigManager appConfigManager;
	/*public static Map<String,ProDefinition> processMap;
	public static JbpmService jbpmService;*/
	
	@Override
	public void startBundle(BundleContext context) throws Exception {
		bundleContext = context;
		addInitService(new ModuleRegister());
		appConfigManager = new AppConfigManager();
		addInitService(appConfigManager);
		logger.debug("bundle 【parkmanager.crm.war】 start");
		//initProcess();
	}
	public static RemindEmailService getRemindEmailService(){
		return getService(bundleContext, RemindEmailService.class);
	}
	/*protected void initProcess(){
		ServiceReference<JbpmService> serviceRef = bundleContext.getServiceReference(JbpmService.class);
		if (serviceRef != null) {
			loadProcess(getService(bundleContext, JbpmService.class));
		} else {
			bundleContext.addServiceListener(new ServiceListener() {
				@Override
				public void serviceChanged(ServiceEvent serviceEvent) {
					if (serviceEvent.getType() == ServiceEvent.REGISTERED){
						ServiceReference<?> serviceReference = serviceEvent.getServiceReference();
						Object registeredService = bundleContext.getService(serviceReference);
						if (registeredService instanceof JbpmService) {
							loadProcess((JbpmService) registeredService);
						}
					}
				}
			});
		}
	}
	
	protected void loadProcess(JbpmService service){
		jbpmService = service;
		processMap = new HashMap<String,ProDefinition>();
		Enumeration<String> urls = bundleContext.getBundle().getEntryPaths("WEB-INF/classes/process/");
		while (urls!=null && urls.hasMoreElements()) {
			String url = urls.nextElement();
			if(!url.endsWith(".zip")) continue;
			String name = url.substring(url.lastIndexOf("/")+1,url.lastIndexOf("."));
			System.out.println("-----------------------name---"+name+"-------------------------------");
			InputStream is = null;
			try {
				is = bundleContext.getBundle().getEntry(url).openStream();
				ProDefinition processDefinition = new ProDefinition();
				processDefinition.setName(name);
				String deployId = service.deployProcessDefinition(name, is);
				processDefinition.setDeployId(deployId);
				processMap.put(name,processDefinition);
			} catch (Exception e) {
				logger.error("Scan FX error from : " + url, e);
			} finally {
				if(is!=null){
					try {is.close();} catch (IOException e) {}
				}
			}
		}
	}*/
	
	public static AppConfig getAppConfig() {
		return appConfigManager.getAppConfig();
	}
	
	public static URL getURL(String entryPath){
		return bundleContext.getBundle().getEntry(entryPath);
	}
	public static AppParamService getAppParamService(){
		return getService(bundleContext, AppParamService.class);
	}

	protected void registryFK(){
		ServiceReference<FKService> fkServiceRef = bundleContext.getServiceReference(FKService.class);
		if (fkServiceRef != null) {
			FKService fkService = getService(bundleContext, FKService.class);
			registryFK(fkService);
		} else {
			bundleContext.addServiceListener(new ServiceListener() {
				@Override
				public void serviceChanged(ServiceEvent serviceEvent) {
					if (serviceEvent.getType() == ServiceEvent.REGISTERED){
						ServiceReference<?> serviceReference = serviceEvent.getServiceReference();
						Object registeredService = bundleContext.getService(serviceReference);
						if (registeredService instanceof FKService) {
							FKService fkService = (FKService) registeredService;
							registryFK(fkService);
						}
					}
				}
			});
		}
	}
	
	protected void registryFK(FKService fkService){
		fkService.registryFK(getFKDescription(bundleContext,"WEB-INF/classes/com/wiiy/pb/entity/"));
		fkService.registryFK(getFKDescription(bundleContext,"WEB-INF/classes/com/wiiy/crm/entity/"));
	}

	@Override
	public void stopBundle(BundleContext context) throws Exception {
		logger.debug("bundle 【parkmanager.pb.war】 stop");
	}
	
	public static String getFKMessage(String fk){
		FKService fkService = getService(bundleContext, FKService.class);
		String classDescription = fkService.getFKClassDescription(fk);
		return R.getFKMessage(classDescription);
	}
	
	public static HttpSessionService getHttpSessionService(){
		return getService(bundleContext, HttpSessionService.class);
	}
	
	public static User getSessionUser(){
		return getHttpSessionService().getSessionUser();
	}
	
	public static User getSessionUser(HttpServletRequest request){
		return getHttpSessionService().getSessionUser(new HttpServletRequest[]{request});
	}
	public static User getUserById(Long id){
		return getService(bundleContext, OsgiUserService.class).getById(id);
	}
	
	public static DataDictInitService getDataDictInitService(){
		return getService(bundleContext, DataDictInitService.class);
	}
	
	public static ResourcesService getResourcesService(){
		return getService(bundleContext, ResourcesService.class);
	}

	@Override
	protected void initDataDict() {
		
		ServiceReference<DataDictInitService> serviceRef = bundleContext.getServiceReference(DataDictInitService.class);
		if (serviceRef != null) {
			DataDictInitService dictInitService = getService(bundleContext, DataDictInitService.class);
			dictInitService.init(new DataDictInit().getList());
			dictInitService.init(new com.wiiy.crm.system.DataDictInit().getList());
		} else {
			bundleContext.addServiceListener(new ServiceListener() {
				@Override
				public void serviceChanged(ServiceEvent serviceEvent) {
					if (serviceEvent.getType() == ServiceEvent.REGISTERED){
						ServiceReference<?> serviceReference = serviceEvent.getServiceReference();
						Object registeredService = bundleContext.getService(serviceReference);
						if (registeredService instanceof DataDictInitService) {
							DataDictInitService dictInitService = getService(bundleContext, DataDictInitService.class);
							dictInitService.init(new DataDictInit().getList());
							dictInitService.init(new com.wiiy.crm.system.DataDictInit().getList());
							/*dictInitService.initSql(InitSql.sqls);*/
						}
					}
				}
			});
		}
	}
	public static OperationLogPubService getOperationLogService() {
		OperationLogPubService logService=getService(OperationLogPubService.class);
		String bundleName=bundleContext.getBundle().getHeaders().get(APP_CONFIG_NAME);
		if(bundleName==null)bundleName="默认模块";
		logService.initBundleName(bundleName);
		return logService;
	}
}
