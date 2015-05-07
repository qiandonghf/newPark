package com.wiiy.core.extensions;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.IExtension;
import org.eclipse.core.runtime.IExtensionDelta;
import org.eclipse.core.runtime.IExtensionRegistry;
import org.eclipse.core.runtime.IRegistryChangeEvent;
import org.eclipse.core.runtime.IRegistryChangeListener;
import org.eclipse.core.runtime.InvalidRegistryObjectException;

import com.wiiy.core.dto.ResourceDto;

public class ResourceExtensions implements IRegistryChangeListener{
	
	private static final Log logger = LogFactory.getLog(ResourceExtensions.class);
	private IExtensionRegistry registry;
	private List<IExtension> serviceExtensions = new ArrayList<IExtension>();
	private static final String NAMESPACE="core.war";
	private static final String EXTENSION_POINT="ResourceExtensions";
	public static Map<String,ResourceDto> resourceMap = new HashMap<String, ResourceDto>();
	public static List<ResourceDto> resourceList = new ArrayList<ResourceDto>();
	
	public static Map<String, ResourceDto> getResourceMap() {
		return resourceMap;
	}
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
			initResource();
		} catch (InvalidRegistryObjectException e) {
			e.printStackTrace();
		}
		
	}
	
	
	public void initResource(){
		List<ResourceDto> tList = getAttributes();
		try{
			Collections.sort(tList, new Comparator() {
				@Override
				public int compare(Object o1, Object o2) {
					ResourceDto a = (ResourceDto)o1;
					ResourceDto b = (ResourceDto)o2;
					if(!"operation".equals(a.getType()) && !"operation".equals(b.getType()) ){
						if(!"".equals(a.getOrder()) && !"".equals(b.getOrder())){
							int aOrder = Integer.valueOf(a.getOrder());
							int bOrder = Integer.valueOf(b.getOrder());
							return aOrder-bOrder;
						}
					}
					if("operation".equals(a.getType())){
						return 1;
					}
					return 0;
				}
			});  
		}catch(Exception e){
			e.printStackTrace();
		}
		for (ResourceDto resourceDto : tList) {
			resourceMap.put(resourceDto.getIdSpace(), resourceDto);
		}
		resourceList = new ArrayList<ResourceDto>();
		for (ResourceDto resourceDto : tList) {
			String parentId = resourceDto.getParentId();
			if(parentId.trim().length()>0){
				if(resourceMap.get(parentId)!=null){
					resourceMap.get(parentId).getChildren().add(resourceDto);
				}
			}else{
				resourceList.add(resourceDto);
			}
		}
	}
	
	class ComparatorResource implements Comparator{
		 public int compare(Object a, Object b) {
			 ResourceDto aDto = (ResourceDto)a;
			 ResourceDto bDto = (ResourceDto)b;
			 if("menu".equals(aDto.getType()) && "menu".equals(bDto.getType())){
				 Integer aOrder = Integer.valueOf(aDto.getOrder());
				 Integer bOrder = Integer.valueOf(bDto.getOrder());
				 return aOrder.compareTo(bOrder);
			 }else{
				 return 0;
			 }
			
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
	
	public List<ResourceDto> getAttributes() {
		List<ResourceDto> dtoList = new ArrayList<ResourceDto>();
		try {
			for (Iterator<IExtension> iter = serviceExtensions.iterator(); iter.hasNext();) {
				IExtension extension = (IExtension) iter.next();
				IConfigurationElement[] elements = extension.getConfigurationElements();
				for (int j = 0; j < elements.length; j++) {
					IConfigurationElement element = elements[j];
					ResourceDto service = new ResourceDto();
					service.setIdSpace(element.getAttribute("idSpace"));
					service.setUris(element.getAttribute("uris"));
					service.setName(element.getAttribute("name"));
					service.setIcon(element.getAttribute("icon"));
					service.setOrder(element.getAttribute("order"));
					service.setType(element.getAttribute("type"));
					service.setParentId(element.getAttribute("parentId"));
					service.setUri(element.getAttribute("uri"));
					if("".equals(service.getUri())){
						service.setUri("javascript:void(0)");
					}
					if("invisible".equalsIgnoreCase(service.getType())){
						service.setDisplay(false);
					}
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