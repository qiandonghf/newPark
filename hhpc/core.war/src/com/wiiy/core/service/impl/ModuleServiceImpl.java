package com.wiiy.core.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.wiiy.core.dto.Menu;
import com.wiiy.core.dto.Module;
import com.wiiy.core.dto.Operation;
import com.wiiy.core.service.export.ModuleService;

public class ModuleServiceImpl implements ModuleService {
	
	private static final Log logger = LogFactory.getLog(ModuleServiceImpl.class);

	private List<Module> moduleList = new ArrayList<Module>();
	
	private Map<String, Set<String>> authorityUriMap = new HashMap<String, Set<String>>();

	@Override
	public void register(Module module) {
		
		logger.debug("Register Module : \n" + module);
		
		validateIds(module);
		
		populateUriFromMenus(module.getMenus());
		populateUriFromOperations(module.getOperationList());

		moduleList.add(module);
		Collections.sort(moduleList, new Comparator<Module>(){
			@Override
			public int compare(Module module1, Module module2) {
				return  module1.getOrderCode() - module2.getOrderCode();
			}
		});
	}	

	private void validateIds(Module module) {
		for (Module registeredModule : moduleList) {
			if (module.getId() == registeredModule.getId()) {
				throw new RuntimeException(
						"Register module failed with module id " + module.getId() +" : " + module.getName() + "." +
								"\nIt has been used in module : " + registeredModule.getName());
			}
		}
		final Set<String> idSet = new HashSet<String>();
		validateAndPutMenuIds(module.getMenus(), idSet);
	}

	private void validateAndPutMenuIds(List<Menu> menus, Set<String> idSet) {
		
		for (Menu menu : menus) {
			if (idSet.contains(menu.getId())) {
				throw new RuntimeException(
						"Duplicated id " + menu.getId() + " in module : " + menu.getModule().getName());
			}
			idSet.add(menu.getId());
			validateAndPutMenuIds(menu.getSubMenus(), idSet);
			validateAndPutOperationIds(menu.getOperationList(), idSet);
		}
	}

	private void validateAndPutOperationIds(List<Operation> operationList, Set<String> idSet) {
		
		for (Operation operation : operationList) {
			if (idSet.contains(operation.getId())) {
				throw new RuntimeException(
						"Duplicated id " + operation.getId() + " in module : " + operation.getModule().getName());
			}
			idSet.add(operation.getId());
		}
	}

	private void populateUriFromMenus(List<Menu> menus) {
		
		for (Menu menu : menus) {
			
			List<Menu> subMenus = menu.getSubMenus();
			
			if (subMenus != null && subMenus.size() > 0) {
				
				populateUriFromMenus(subMenus);
				
			} else {
				String[] uris = menu.getUris();
				for (String uri : uris) {
					Set<String> authorityIds = authorityUriMap.get(uri);
					if (authorityIds == null) {
						authorityIds = new HashSet<String>();
						authorityUriMap.put(uri, authorityIds);
					}
					authorityIds.add(menu.getGlobalId());
				}
				
				populateUriFromOperations(menu.getOperationList());
			}
		}
	}

	private void populateUriFromOperations(List<Operation> operationList) {
		
		for (Operation operation : operationList) {

			String[] uris = operation.getUris();
			
			for (String uri : uris) {

				Set<String> authorityIds = authorityUriMap.get(uri);
				
				if (authorityIds == null) {
					authorityIds = new HashSet<String>();
					authorityUriMap.put(uri, authorityIds);
				}
				
				authorityIds.add(operation.getGlobalId());
			}
		}
	}

	@Override
	public void unregister(Module module) {
		moduleList.remove(module);
	}

	@Override
	public List<Module> listModules() {
		
		return moduleList;
	}

	@Override
	public Map<String, Set<String>> getAuthorityUriMap() {
		return authorityUriMap;
	}

}
