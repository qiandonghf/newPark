package com.wiiy.core.service.export;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.wiiy.core.dto.Module;

public interface ModuleService {
	
	void register(Module module);

	void unregister(Module module);

	List<Module> listModules();
	
	Map<String, Set<String>> getAuthorityUriMap();

}
