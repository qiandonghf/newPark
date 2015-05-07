package com.wiiy.core.security;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.extensions.ResourceExtensions;
import com.wiiy.core.listener.InitListener;
import com.wiiy.core.service.export.ModuleService;
import com.wiiy.core.service.export.RoleAuthorityRefService;

public class SecurityFilter implements Filter {

	private Log logger = LogFactory.getLog(getClass());

	private Map<String, Set<String>> authorityUriMap;
	
	private Map<Long, Set<String>> roleAuthorityRefMap;
		
	private Class<?> bundleActivatorClazz;
	
	private List<String> freeURIPrefixs = Collections.emptyList();
	
	private Set<String> uris;
	
	@Override
	public void destroy() {
		
	}

	private Set<String> calculateMoudleMenuIds(Set<UserRoleRef> roleRefs) {
		Set<String> uris = putVisibleByGranted(roleRefs);
		return uris;
	}
	private Set<String> putVisibleByGranted(Set<UserRoleRef> roleRefs) {
		uris = new HashSet<String>();
		Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
		Map<String,ResourceDto> accessibleResourceMap = new HashMap<String, ResourceDto>();
		for (UserRoleRef userRoleRef : roleRefs) {
			if(userRoleRef!=null){
				Role role = userRoleRef.getRole();
				Set<RoleAuthorityRef> roleAuthorityRefs = role.getAuthorityRefs();
				for (RoleAuthorityRef roleAuthorityRef : roleAuthorityRefs) {
					if (roleAuthorityRef == null) continue;
					ResourceDto dto = resourceMap.get(String.valueOf(roleAuthorityRef.getAuthorityId()));
					if(dto!=null){
						String uri = dto.getUris();
						if(uri!=null&&!("").endsWith(uri)){
							uris.add(uri);
						}
						accessibleResourceMap.put(dto.getIdSpace(), dto);
						loadMap(accessibleResourceMap,dto,resourceMap);
					}
				}
			}
		}
		CoreActivator.getHttpSessionService().setResourceMap(accessibleResourceMap);
		return uris;
	}
	private Map<String,ResourceDto> loadMap(Map<String,ResourceDto> accessibleResourceMap,ResourceDto dto,Map<String,ResourceDto> resourceMap){
		if(dto.getParentId()!=null&&dto.getParentId().length()>0){
			if(resourceMap.get(dto.getParentId())!=null){
				String uri = resourceMap.get(dto.getParentId()).getUris();
				if(uri!=null && uri.trim().length()>0){
					uris.add(uri);
				}
			}
			ResourceDto parentDto = accessibleResourceMap.get(dto.getParentId());
			if(parentDto!=null){
				String type = parentDto.getType();
				if(("menu").equalsIgnoreCase(type) || ("module").equalsIgnoreCase(type)){
					accessibleResourceMap.put(dto.getParentId(), parentDto);
					loadMap(accessibleResourceMap,parentDto,resourceMap);
				}
			}
		}
		return accessibleResourceMap;
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain filterChain) throws IOException, ServletException {
		
		
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		
		String requestURI = request.getRequestURI();
		logger.debug("requestURI : " + requestURI);
		
		User user = getSessionUser(request);
		
		if(requestURI.startsWith("/core/index!") && user==null){
			logger.debug("The request without login.");
			String accept = request.getHeader("Accept");
			if (accept.indexOf("application/json") != -1) {
				response.setHeader("Content-Type", "application/json;charset=UTF-8");
				response.getWriter().write(
						"{\"msg\":\"未登录或会话过期，请重新登录\", \"success\":false, \"result\":{\"msg\":\"未登录或会话过期，请重新登录\",\"success\":false}}");
			} else {
				response.sendRedirect("/core/web/notLoginOrTimeout.html");
			}
			return;
		}
		if (isFree(requestURI)) {
			filterChain.doFilter(servletRequest, servletResponse);
			return;
		}
		
		String requestUriId = getRequestUriId(requestURI);
		if("/core/try.action".equalsIgnoreCase(requestUriId)){
			filterChain.doFilter(servletRequest, servletResponse);
			return ;
		}
		//sessionUser
		if (user == null) {
			logger.debug("The request without login.");
			String accept = request.getHeader("Accept");
			if (accept.indexOf("application/json") != -1) {
				response.setHeader("Content-Type", "application/json;charset=UTF-8");
				response.getWriter().write(
						"{\"msg\":\"未登录或会话过期，请重新登录\", \"success\":false, \"result\":{\"msg\":\"未登录或会话过期，请重新登录\",\"success\":false}}");
			} else {
				response.sendRedirect("/core/web/notLoginOrTimeout.html");
			}
			return;
		}
		//权限判断
		boolean notGranted = false;
		Set<String> uris = null;
		if(user!=null){
			Set<UserRoleRef> roleRefs;
			try {
				roleRefs = CoreActivator.getUserRoleRefById(user.getId());
				uris = calculateMoudleMenuIds(roleRefs);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*Set<String> uris = CoreActivator.getSessionUris(request);*/
		if(uris == null){
			logger.debug("The request uris was not granted.");
			String accept = request.getHeader("Accept");
			if (accept.indexOf("application/json") != -1) {
				response.setHeader("Content-Type", "application/json;charset=UTF-8");
				response.getWriter().write(
						"{\"msg\":\"未授权请求，请联系管理员\", \"success\":false, \"result\":{\"msg\":\"未授权请求，请联系管理员\",\"success\":false}}");
			} else {
				response.sendRedirect("/core/web/notGranted.html");
			}
			return;
		}
		for (String uri : uris) {
			if(uri.contains(requestUriId)){
				notGranted = true;
			}
		}
		boolean flag = false;
		Map<String,ResourceDto> resourceMap = ResourceExtensions.resourceMap;
		for (ResourceDto dto : resourceMap.values()) {
			if(dto.getUris().contains(requestUriId)){
				flag = true;
			}
		}
		if(!notGranted){
			logger.debug("The request uri was not granted.");
			String accept = request.getHeader("Accept");
			if (accept.indexOf("application/json") != -1 || flag) {
				response.sendRedirect("/core/web/notGranted.html");
				/*response.setHeader("Content-Type", "application/json;charset=UTF-8");
				response.getWriter().write(
						"{\"msg\":\"未授权请求，请联系管理员\", \"success\":false, \"result\":{\"msg\":\"未授权请求，请联系管理员\",\"success\":false}}");*/
			} else {
				response.sendRedirect("/core/web/accessDeny.html");
			}
			return;
		}
		
		if (user.getAdmin().equals(BooleanEnum.YES)) {
			filterChain.doFilter(servletRequest, servletResponse);
			return;
		}
		
		filterChain.doFilter(servletRequest, servletResponse);
	}

	private boolean isFree(String requestURI) {
		for (String freeUriPrefix : freeURIPrefixs) {
			if (requestURI.startsWith(freeUriPrefix)) return true;
		}
		return false;
	}

	private boolean anyRoleGrantedAnyAuthority(Set<String> authorityIds,
			Map<Long, Set<String>> roleAuthorityRefMap, Set<Long> roleRefIds) {
		boolean notGranted = true;
		for (Long roleId : roleRefIds) {
			Set<String> grantedRoleAuthorityIds = roleAuthorityRefMap.get(roleId);
			if (grantedRoleAuthorityIds == null) continue;
			for (String authorityId : authorityIds) {
				if (grantedRoleAuthorityIds.contains(authorityId)) {
					notGranted = false;
					break;
				}
			}
		}
		return notGranted;
	}

	private String getRequestUriId(String requestURI) {
		
		String requestUriId;
		
		if (requestURI.indexOf("?") != -1) {
			requestUriId = requestURI.substring(0, requestURI.indexOf("?"));
		} else {
			requestUriId = requestURI;
		}
		return requestUriId;
	}

	private Map<String, Set<String>> getAuthorityUriMap(ServletContext servletContext) {
		
		if (authorityUriMap == null) {
			try {
				Method getServiceMethod = 
						bundleActivatorClazz.getMethod("getService", new Class<?>[]{Class.class});
				
				ModuleService moduleService = 
						(ModuleService) getServiceMethod.invoke(
								bundleActivatorClazz, new Object[]{ModuleService.class});
				
				authorityUriMap = moduleService.getAuthorityUriMap();
			} catch (SecurityException e) {
				logger.error("getAuthorityUriMap failed.", e);
			} catch (NoSuchMethodException e) {
				logger.error("getAuthorityUriMap failed.", e);
			} catch (IllegalArgumentException e) {
				logger.error("getAuthorityUriMap failed.", e);
			} catch (IllegalAccessException e) {
				logger.error("getAuthorityUriMap failed.", e);
			} catch (InvocationTargetException e) {
				logger.error("getAuthorityUriMap failed.", e);
			}
		}
		
		return authorityUriMap;
	}

	private User getSessionUser(HttpServletRequest request) {
		
		User coreSessionUser = getCoreSessionUser(request);
		if(coreSessionUser==null){
			return coreSessionUser;
		}
		User localSessionUser = getLocalSessionUser(request);
		if (localSessionUser != null && localSessionUser.isValid()) {
			return localSessionUser;
		}
		request.getSession().setAttribute("login_user", coreSessionUser);
		return coreSessionUser;
	}
	
	private User getLocalSessionUser(HttpServletRequest request) {
		return (User)request.getSession().getAttribute("login_user");
	}
	
	private User getCoreSessionUser(HttpServletRequest request) {
		
		try {
			Method getSessionUserMethod = 
					bundleActivatorClazz.getMethod("getSessionUser", new Class<?>[]{HttpServletRequest.class});
			
			return (User) getSessionUserMethod.invoke(bundleActivatorClazz, new Object[]{request});
		} catch (SecurityException e) {
			logger.error("getSessionUser failed.", e);
		} catch (NoSuchMethodException e) {
			logger.error("getSessionUser failed.", e);
		} catch (IllegalArgumentException e) {
			logger.error("getSessionUser failed.", e);
		} catch (IllegalAccessException e) {
			logger.error("getSessionUser failed.", e);
		} catch (InvocationTargetException e) {
			logger.error("getSessionUser failed.", e);
		}
		return null;
	}

	private Map<Long, Set<String>> getRoleAuthorityRefMap(ServletContext servletContext) {
		
		if (roleAuthorityRefMap == null) {
			try {
				Method getServiceMethod = 
						bundleActivatorClazz.getMethod("getService", new Class<?>[]{Class.class});
				
				RoleAuthorityRefService roleAuthorityRefService = 
						(RoleAuthorityRefService) getServiceMethod.invoke(
								bundleActivatorClazz, new Object[]{RoleAuthorityRefService.class});
				
				roleAuthorityRefMap = roleAuthorityRefService.getRoleAuthorityRefMap();
			} catch (SecurityException e) {
				logger.error("getRoleAuthorityRefMap failed.", e);
			} catch (NoSuchMethodException e) {
				logger.error("getRoleAuthorityRefMap failed.", e);
			} catch (IllegalArgumentException e) {
				logger.error("getRoleAuthorityRefMap failed.", e);
			} catch (IllegalAccessException e) {
				logger.error("getRoleAuthorityRefMap failed.", e);
			} catch (InvocationTargetException e) {
				logger.error("getRoleAuthorityRefMap failed.", e);
			}
		}
		
		return roleAuthorityRefMap;
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		try {
			bundleActivatorClazz = Class.forName(filterConfig.getInitParameter("activatorClass"));
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String freeAccess = filterConfig.getInitParameter("freeAccess");
		if (StringUtils.isEmpty(freeAccess)) return;
		freeURIPrefixs = Arrays.asList(freeAccess.split("\\s+"));
	}
}
