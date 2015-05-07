package com.wiiy.core.service.export;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.eclipse.core.runtime.FileLocator;
import org.osgi.framework.Bundle;
import com.wiiy.commons.util.XMLUtil;

/**
 * @author lewisw
 *
 */
public class AppConfig {

	private static final String DEFAULT_APP_CONFIG_FILE = "/WEB-INF/appConfig.xml";
	
	private String appId;
		
	private Bundle bundle;
	
	private List<Config> configList = new ArrayList<Config>();

	private AppConfig(Bundle bundle) {
		this.bundle = bundle;
	}
	
	public String getAppId() {
		return appId;
	}

	public List<Config> getConfigList() {
		return configList;
	}
	
	public Long getBundleId() {
		return bundle.getBundleId();
	}
	
	public static AppConfig load(Bundle currentBundle) {
		File file = getFile(DEFAULT_APP_CONFIG_FILE, currentBundle);
		Document doc = XMLUtil.loadDocument(file);
		AppConfig appConfig = new AppConfig(currentBundle);
		appConfig.resolve(doc);
		return appConfig;
	}
	
	/**
	 * 使用时调用，不要在初始化代码中调用
	 * @param key
	 * @return
	 */
	public Config getConfig(String key) {
		return findConfig(key);
	}
	
    private Config findConfig(String key) {
    	for (Config config : configList) {
    		if (config.getKey().equals(key)) {
    			return config;
    		}
    	}
		return null;
	}

	private void resolve(Document doc) {
        
        Element root = doc.getRootElement();
        
        for (Iterator<?> iterator = root.elementIterator(); iterator.hasNext(); ) {
            Element element = (Element) iterator.next();
            configList.add(resolveConfig(element));
        }
    }
	
	
	
	private Config resolveConfig(Element element) {
		Config config = polulateCofig(element);
		List<Parameter> parameterList = polulateParameterList(element);
		config.setParameterList(parameterList);
		return config;
	}

	private List<Parameter> polulateParameterList(Element element) {
		List<Parameter> parameterList = new ArrayList<Parameter>();
        for (Iterator<?> iterator = element.elementIterator(); iterator.hasNext(); ) {
            Element subElement = (Element) iterator.next();
            parameterList.add(resolveParameter(subElement));
        }
		return parameterList;
	}

	private Parameter resolveParameter(Element element) {
		
		String key = element.attributeValue("key");
		String label = element.attributeValue("label");
		String value = element.attributeValue("value");
		String render = element.attributeValue("render");
		
		Parameter parameter = new Parameter(NameEntry.name(key, label), value, render);
		
		if (render.equalsIgnoreCase("radio") || 
				render.equalsIgnoreCase("checkbox") || 
				render.equalsIgnoreCase("select")) {
			
	        for (Iterator<?> iterator = element.elementIterator(); iterator.hasNext(); ) {
	            Element subElement = (Element) iterator.next();
	            parameter.addChoice(subElement.attributeValue("label"), subElement.attributeValue("value"));
	        }
		} 
		
		return parameter;
	}

	private Config polulateCofig(Element element) {
		Config config = new Config();
		config.setKey(element.attributeValue("key"));
		config.setLabel(element.attributeValue("label"));
		return config;
	}

		
	public static class Config {
		private String key;
		private String label;
		private List<Parameter> parameterList = new ArrayList<Parameter>();
		public String getKey() {
			return key;
		}
		public void setKey(String key) {
			this.key = key;
		}
		public String getLabel() {
			return label;
		}
		public void setLabel(String label) {
			this.label = label;
		}
		public List<Parameter> getParameterList() {
			return parameterList;
		}
		public void setParameterList(List<Parameter> parameterList) {
			this.parameterList = parameterList;
		}
		public String getParameter(String key) {
			for (Parameter parameter : parameterList) {
				if (parameter.getEntry().getKey().equals(key)) {
					return parameter.getValue();
				}
			}
			return null;
		}
	}
	
	public static class Parameter {

		private NameEntry entry;
		private String value;
		private String render;
		private List<Choice> choices = new ArrayList<Choice>();
		
		public Parameter(NameEntry entry, String value, String render) {
			this.entry = entry;
			this.value = value;
			this.render = render;
		}

		public NameEntry getEntry() {
			return entry;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		
		public String getRender() {
			return render;
		}

		public List<Choice> getChoices() {
			return choices;
		}

		public Parameter addChoice(String label, String value) {
			choices.add(new Choice(label, value));
			return this;
		}
		
		public String[] getSplitValues() {
			if (value == null) {
				return null;
			} 
			return value.split("(\\s)*\\,(\\s)*");
		}
	}

	public static class NameEntry {
		
		private String key;
		private String label;
		
		public static NameEntry name(String key, String label) {
			return new NameEntry(key, label);
		}
		public NameEntry(String key, String label) {
			super();
			this.key = key;
			this.label = label;
		}
		public String getKey() {
			return key;
		}
		public void setKey(String key) {
			this.key = key;
		}
		public String getLabel() {
			return label;
		}
		public void setLabel(String label) {
			this.label = label;
		}
	}
	
	public static class Choice {
		private String label;
		private String value;
		
		public Choice(String label, String value) {
			this.label = label;
			this.value = value;
		}
		public String getLabel() {
			return label;
		}
		public String getValue() {
			return value;
		}
		
	}

	public void persist() {
		File file = getFile(DEFAULT_APP_CONFIG_FILE, bundle);
		Document doc = XMLUtil.loadDocument(file);
		
		for (int i = 0; i < configList.size(); i ++) {
			List<Parameter> parameterList = configList.get(i).getParameterList();
			for (int j = 0; j < parameterList.size(); j ++) {
				Attribute valueAttribute = (Attribute) doc.selectSingleNode("/appConfig/config["+(i+1)+"]/parameter["+(j+1)+"]/@value");
				valueAttribute.setValue(parameterList.get(j).getValue());
			}
		}
		
		XMLUtil.writeDocument(file, doc);
	}
	
	public static File getFile(String pathBasedBundle, Bundle bundle) {
		/*URL urlBasedBundle =  bundle.getEntry(pathBasedBundle);
		try {
			URL fileUrl = FileLocator.toFileURL(urlBasedBundle);
			return new File(fileUrl.getPath());*/
		return new File(System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/"+bundle.getSymbolicName()+"/"+pathBasedBundle);
		/*} catch (IOException e) {
			throw new IllegalStateException(e);
		}*/
	}
}
