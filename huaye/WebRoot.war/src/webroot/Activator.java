package webroot;

import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.osgi.framework.BundleContext;

import com.wiiy.commons.activator.AbstractActivator;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.export.AppConfig;
import com.wiiy.core.service.export.AppConfigManager;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.core.service.export.HttpSessionService;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.core.service.export.RemindEmailService;
import com.wiiy.core.service.export.ResourcesService;
import com.wiiy.core.system.Param;
import com.wiiy.external.service.OperationLogPubService;


public class Activator extends AbstractActivator {
	public static final String APP_CONFIG_NAME = "WebRoot-AppName";	
	public static BundleContext bundleContext;
	private static AppConfigManager appConfigManager;
	
	
	@Override
	public void startBundle(BundleContext context) throws Exception {
		bundleContext = context;
		appConfigManager = new AppConfigManager();
		try {
			appConfigManager.setBundleContext(context);
			System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++appConfigManager"+appConfigManager.getAppConfig().getConfig("copyright").getParameter("str"));
			Param.copyright=appConfigManager.getAppConfig().getConfig("copyright").getParameter("str");
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("bundle start WebRoot.war");
	}
	
	public static AppConfig getAppConfig() {
		return appConfigManager.getAppConfig();
	}
	
	protected void registryFK(){
	}
	@Override
	public void stopBundle(BundleContext context) throws Exception {
		logger.debug("bundle stop WebRoot.war");
	}
	
	public static String getFKMessage(String fk){
		return null;
	}
	
	public static RemindEmailService getRemindEmailService(){
		return getService(bundleContext, RemindEmailService.class);
	}
	
	public static HttpSessionService getHttpSessionService(){
		return getService(bundleContext, HttpSessionService.class);
	}
	
	public static URL getURL(String entryPath){
		return bundleContext.getBundle().getEntry(entryPath);
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
		
	}
	
	public static OperationLogPubService getOperationLogService() {
		return null;
	}
}
