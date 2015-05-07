package com.wiiy.core.extensions;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.IExtension;
import org.eclipse.core.runtime.IExtensionDelta;
import org.eclipse.core.runtime.IExtensionRegistry;
import org.eclipse.core.runtime.IRegistryChangeEvent;
import org.eclipse.core.runtime.IRegistryChangeListener;
import org.eclipse.core.runtime.InvalidRegistryObjectException;

import com.wiiy.core.dto.CoreWorkbenchTipDto;

public class CoreWorkbenchTipExtensions implements IRegistryChangeListener{
	
	private static final Log logger = LogFactory.getLog(CoreWorkbenchTipExtensions.class);
	private IExtensionRegistry registry;
	private List<IExtension> serviceExtensions = new ArrayList<IExtension>();
	private static final String NAMESPACE="core.war";
	private static final String EXTENSION_POINT="CoreWorkbenchTipExtensions";
	
	public IExtensionRegistry getRegistry() {
		return registry;
	}
	public void setRegistry(IExtensionRegistry registry) {
		this.registry = registry;
        try {
			registry.addRegistryChangeListener(this, NAMESPACE);
			IExtension[] extensions = registry.getExtensionPoint(NAMESPACE+"."+EXTENSION_POINT).getExtensions();
			logger.info(NAMESPACE+"."+EXTENSION_POINT+"  init extensions");
			for (int i = 0; i < extensions.length; i++) {
				logger.info(NAMESPACE+"."+EXTENSION_POINT+"  ADDED extensions:"+extensions[i].getLabel());
				serviceExtensions.add(extensions[i]);
			}
		} catch (InvalidRegistryObjectException e) {
			e.printStackTrace();
		}
		
	}
	@Override
	public void registryChanged(IRegistryChangeEvent event) {
		IExtensionDelta[] deltas = event.getExtensionDeltas(NAMESPACE,EXTENSION_POINT);
	    if (deltas.length == 0)
	    	return;
	    for (int i = 0; i < deltas.length; i++) {
	    	switch (deltas[i].getKind()) {
	    		case IExtensionDelta.ADDED:
	    			logger.info(NAMESPACE+"."+EXTENSION_POINT+"  ADDED extension:  "+deltas[i].getExtension().getLabel());
	    			serviceExtensions.add(deltas[i].getExtension());
	    			break;
	    		case IExtensionDelta.REMOVED:
	    			logger.info(NAMESPACE+"."+EXTENSION_POINT+"  REMOVED extension:  "+deltas[i].getExtension().getLabel());
	    			serviceExtensions.remove(deltas[i].getExtension());
	    			break;
	    		default:
	    			break;
	    	}
	    }
	}
	
	public List<CoreWorkbenchTipDto> getTips() {
		List<CoreWorkbenchTipDto> dtoList = new ArrayList<CoreWorkbenchTipDto>();
		try {
			for (Iterator<IExtension> iter = serviceExtensions.iterator(); iter.hasNext();) {
				IExtension extension = (IExtension) iter.next();
				IConfigurationElement[] elements = extension.getConfigurationElements();
				for (int j = 0; j < elements.length; j++) {
					IConfigurationElement element = elements[j];
					CoreWorkbenchTipDto service = new CoreWorkbenchTipDto();
					service.setUrl(element.getAttribute("url"));
					service.setName(element.getAttribute("name"));
					service.setDataUrl(element.getAttribute("dataUrl"));
					service.setIcon(element.getAttribute("icon"));
					service.setTabName(element.getAttribute("tabName"));
					dtoList.add(service);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(NAMESPACE+"."+EXTENSION_POINT+"  addService error ");
		}
		return dtoList;
	}
}