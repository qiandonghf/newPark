package com.wiiy.core.service.export;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.osgi.framework.BundleContext;
import org.springframework.osgi.context.BundleContextAware;

import com.wiiy.commons.service.InitService;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.Menu;
import com.wiiy.core.dto.Module;
import com.wiiy.core.dto.Operation;

public class ModuleRegister extends InitService<ModuleService> implements BundleContextAware {

	protected Log logger = LogFactory.getLog(getClass());

	private static final String DEFAULT_CONFIG_FILE = "/WEB-INF/module.xml";

	private String configFile = DEFAULT_CONFIG_FILE;

	private ModuleService moduleService;

	private BundleContext bundleContext;

	public void setConfigFile(String configFile) {
		this.configFile = configFile;
	}

	public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	}

	@Override
	public void setBundleContext(BundleContext bundleContext) {
		this.bundleContext = bundleContext;
	}

	public void registerModule() {

		long startTime = System.currentTimeMillis();

		logger.info("Start register module : " + bundleContext.getBundle().getSymbolicName());
		
		URL url = bundleContext.getBundle().getResource(configFile);

		InputStream is = null;
		try {
			is = url.openStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		Document doc = null;
		try {
			doc = new SAXReader().read(is);
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception e) {
				}
			}
		}

		if (moduleService == null) {
			moduleService = getDependOnService();
		}
		List<Module> modules = resolveModules(doc);
		for (Module module : modules) {
			System.out.println(module.getName());
			moduleService.register(module);
		}

		logger.info("Module register successfully! " + (System.currentTimeMillis() - startTime));
	}

	public static Module loadModule() {
		URL url = CoreActivator.bundleContext.getBundle().getResource(DEFAULT_CONFIG_FILE);
		InputStream is = null;
		try {
			is = url.openStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Document doc = null;
		try {
			doc = new SAXReader().read(is);
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception e) {
				}
			}
		}
		Element root = doc.getRootElement();
		Module module = populateModule(root);
		List<Menu> menuList = new ArrayList<Menu>();
		for (Iterator<?> iterator = root.elementIterator(); iterator.hasNext();) {
			Element element = (Element) iterator.next();
			Menu menu = resolveMenu(element, module, null);
			menuList.add(menu);
		}
		module.setMenus(menuList);
		return module;
	}
	
	public static List<Module> loadModules() {
		URL url = CoreActivator.bundleContext.getBundle().getResource(DEFAULT_CONFIG_FILE);
		InputStream is = null;
		try {
			is = url.openStream();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Document doc = null;
		try {
			doc = new SAXReader().read(is);
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception e) {
				}
			}
		}
		List<Module> moduleList = new ArrayList<Module>();
		Element root = doc.getRootElement();
		for (Object o : root.elements()) {
			Element el = (Element)o;
			Module module = populateModule(el);
			List<Menu> menuList = new ArrayList<Menu>();
			for (Iterator<?> iterator = el.elementIterator(); iterator.hasNext();) {
				Element element = (Element) iterator.next();
				if (element.getName().equals("menu")) {
					Menu menu = resolveMenu(element, module, null);
					menuList.add(menu);
				}
			}
			module.setMenus(menuList);
			moduleList.add(module);
		}
		return moduleList;
	}

	private static List<Module> resolveModules(Document doc) {
		List<Module> moduleList = new ArrayList<Module>();
		Element root = doc.getRootElement();
		for (Object o : root.elements()) {
			Element el = (Element)o;
			Module module = populateModule(el);
			List<Menu> menuList = new ArrayList<Menu>();
			List<Operation> operationList = new ArrayList<Operation>();
			for (Iterator<?> iterator = el.elementIterator(); iterator.hasNext();) {
				Element element = (Element) iterator.next();
				if (element.getName().equals("menu")) {
					menuList.add(resolveMenu(element, module, null));
					continue;
				}
				if (element.getName().equals("operation")) {
					Operation operation = populateOperation(element);
					operation.setModule(module);
					operationList.add(operation);
				}
			}
			module.setMenus(menuList);
			module.setOperationList(operationList);
			moduleList.add(module);
		}
		return moduleList;
	}

	private static Module resolveModule(Document doc) {
		Element root = doc.getRootElement();
		Module module = populateModule(root);
		List<Menu> menuList = new ArrayList<Menu>();
		List<Operation> operationList = new ArrayList<Operation>();
		for (Iterator<?> iterator = root.elementIterator(); iterator.hasNext();) {
			Element element = (Element) iterator.next();
			if (element.getName().equals("menu")) {
				menuList.add(resolveMenu(element, module, null));
				continue;
			}
			if (element.getName().equals("operation")) {
				Operation operation = populateOperation(element);
				operation.setModule(module);
				operationList.add(operation);
			}
		}
		module.setMenus(menuList);
		module.setOperationList(operationList);
		return module;
	}

	private static Menu resolveMenu(Element element, Module module, Menu parentMenu) {
		Menu menu = populateMenu(element);
		menu.setModule(module);
		menu.setParent(parentMenu);
		List<Menu> subMenuList = new ArrayList<Menu>();
		List<Operation> operationList = new ArrayList<Operation>();
		Iterator<?> subIterator = element.elementIterator();
		while (subIterator.hasNext()) {
			Element subElement = (Element) subIterator.next();
			if (subElement.getName().equals("menu")) {
				subMenuList.add(resolveMenu(subElement, module, menu));
				continue;
			}
			if (subElement.getName().equals("operation")) {
				Operation operation = populateOperation(subElement);
				operation.setModule(module);
				operationList.add(operation);
			}
		}
		menu.setSubMenus(subMenuList);
		menu.setOperationList(operationList);
		return menu;
	}

	private static Module populateModule(Element root) {
		Module module = new Module();
		module.setId(root.attributeValue("idSpace"));
		module.setName(root.attributeValue("name"));
		module.setIcon(root.attributeValue("icon"));
		module.setOrderCode(Integer.valueOf(root.attributeValue("order")));
		module.setDisplay(true);
		if(root.attributeValue("display")!=null){
			module.setDisplay(Boolean.valueOf(root.attributeValue("display")));
		}
		return module;
	}

	private static Menu populateMenu(Element element) {
		Menu menu = new Menu();
		menu.setId(element.attributeValue("id"));
		menu.setName(element.attributeValue("name"));
		try {
			menu.setOrderCode(Integer.valueOf(element.attributeValue("order")));
		} catch (Exception e) {
			menu.setOrderCode(0);
		}
		menu.setIcon(element.attributeValue("icon"));
		menu.setUris(element.attributeValue("uris"));
		return menu;
	}

	private static Operation populateOperation(Element element) {
		Operation operation = new Operation();
		operation.setId(element.attributeValue("id"));
		operation.setName(element.attributeValue("name"));
		operation.setUris(element.attributeValue("uris"));
		return operation;
	}

	@Override
	public void init() {
		registerModule();
	}
}
