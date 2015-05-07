package com.wiiy.core.service.export;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.User;

public interface HttpSessionService {
	
	void SetUris(Set<String> uris);
	
	Set<String> getSessionUris(HttpServletRequest request);
	
	HttpSession getSession();
	
	void removeSession(HttpServletRequest... request);
	
	Object getSessionAttribute(String property);
	
	User getSessionUser(HttpServletRequest... request);

	void setSessionUser(User user);

	void setResourceMap(Map<String, ResourceDto> resourceMap);
	
	Map<String, ResourceDto> getResourceMap();
	
	boolean isInResourceMap(String str);

	String getRemindEmailLink();
	String getRemindEmailLogo();

}
