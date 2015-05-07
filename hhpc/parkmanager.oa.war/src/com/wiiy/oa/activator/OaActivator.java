package com.wiiy.oa.activator;

import java.net.URL;

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
import com.wiiy.core.service.export.ResourcesService;
import com.wiiy.external.service.OperationLogPubService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.system.DataDictInit;

public class OaActivator extends AbstractActivator {
	public static final String APP_CONFIG_NAME = "ParkManagement-AppName";	
	public static BundleContext bundleContext;
	private static AppConfigManager appConfigManager;
	
	
	@Override
	public void startBundle(BundleContext context) throws Exception {
		bundleContext = context;
		addInitService(new ModuleRegister());
		appConfigManager = new AppConfigManager();
		addInitService(appConfigManager);
		logger.debug("bundle 【parkmanager.oa.war】 start");
		//initProcess();
	}
	
	public static AppConfig getAppConfig() {
		return appConfigManager.getAppConfig();
	}
	public static AppParamService getAppParamService(){
		return getService(bundleContext, AppParamService.class);
	}
	protected void registryFK(){
		ServiceReference<FKService> fkServiceRef = bundleContext.getServiceReference(FKService.class);
		if (fkServiceRef != null) {
			FKService fkService = getService(bundleContext, FKService.class);
			fkService.registryFK(getFKDescription(bundleContext,"WEB-INF/classes/com/wiiy/oa/entity/"));
		} else {
			bundleContext.addServiceListener(new ServiceListener() {
				@Override
				public void serviceChanged(ServiceEvent serviceEvent) {
					if (serviceEvent.getType() == ServiceEvent.REGISTERED){
						ServiceReference<?> serviceReference = serviceEvent.getServiceReference();
						Object registeredService = bundleContext.getService(serviceReference);
						if (registeredService instanceof FKService) {
							FKService fkService = (FKService) registeredService;
							fkService.registryFK(getFKDescription(bundleContext,"WEB-INF/classes/com/wiiy/oa/entity/"));
						}
					}
				}
			});
		}
	}

	@Override
	public void stopBundle(BundleContext context) throws Exception {
		logger.debug("bundle 【parkmanager.oa.war】 stop");
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
	
	public static ResourcesService getResourcesService(){
		return getService(bundleContext, ResourcesService.class);
	}
	
	public static DataDictInitService getDataDictInitService(){
		return getService(bundleContext, DataDictInitService.class);
	}
	
	@Override
	protected void initDataDict() {
		ServiceReference<DataDictInitService> serviceRef = bundleContext.getServiceReference(DataDictInitService.class);
		if (serviceRef != null) {
			DataDictInitService dictInitService = getService(bundleContext, DataDictInitService.class);
			dictInitService.init(new DataDictInit().getList());
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
						}
					}
				}
			});
		}
	}
	
	
	public static URL getURL(String entryPath){
		return bundleContext.getBundle().getEntry(entryPath);
	}
	
	public static OperationLogPubService getOperationLogService() {
		OperationLogPubService logService=getService(OperationLogPubService.class);
		String bundleName=bundleContext.getBundle().getHeaders().get(APP_CONFIG_NAME);
		if(bundleName==null)bundleName="默认模块";
		logService.initBundleName(bundleName);
		return logService;
	}
}
