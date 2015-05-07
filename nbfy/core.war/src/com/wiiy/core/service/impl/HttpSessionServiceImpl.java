package com.wiiy.core.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.CustomerDto;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.User;
import com.wiiy.core.listener.InitListener;
import com.wiiy.core.service.export.HttpSessionService;
import com.wiiy.core.service.export.RemindEmailService;

public class HttpSessionServiceImpl implements HttpSessionService {
	protected CachedLog logger = CachedLog.getLog(getClass());
	private User sessionUser;
	private static Map<String, ResourceDto> resourceMap = new HashMap<String, ResourceDto>();
	private static Map<String, ResourceDto> accessibleResourceMap = new HashMap<String, ResourceDto>();
	
	
	
	@Override
	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	@Override
	public Object getSessionAttribute(String property) {
		return getSession().getAttribute(property);
	}
	@Override
	public void SetUris(Set<String> uris) {
		HttpSession httpSession=ServletActionContext.getRequest().getSession();
		httpSession.setAttribute("uris", uris);
		ServletActionContext.getServletContext().setAttribute("session"+httpSession.getId(), httpSession);
		
	}
	@Override
	public Set<String> getSessionUris(HttpServletRequest request) {
		ServletContext sc=InitListener.servletContext.getContext("/core");
		//request = new HttpServletRequest[]{ServletActionContext.getRequest()};
		HttpSession httpSession= (HttpSession)sc.getAttribute("session"+request.getSession().getId());
		
		Set<String> uris=null;
		
		String cookieName = "JSESSIONID";   
		if(request!=null){
			logger.debug("request:"+request);
			Cookie[] cookies = request.getCookies();
			logger.debug("cookies:"+cookies);
			int len = cookies.length; 
			boolean found=false;
			for(int i=0; i<len; i++) {   
				Cookie cookie = cookies[i];   
				String c_name = cookie.getName();   
				if(c_name.equalsIgnoreCase(cookieName)) {   
					HttpSession session=(HttpSession)sc.getAttribute("session"+cookie.getValue()); 
					if(session!=null){
						uris=(Set<String>)session.getAttribute("uris");
						found = true;
						break;
					}
				}  
				else if(c_name.equalsIgnoreCase("sessionId")) {   
					HttpSession session=(HttpSession)sc.getAttribute("session"+cookie.getValue()); 
					if(session!=null){
						uris=(Set<String>)session.getAttribute("uris");
						found = true;
						break;
					}
				}  
			}
			if(!found){
				uris = (Set<String>) request.getSession().getAttribute("uris");
			}
			if(uris==null){
				logger.debug("无法获取用户URIS信息");
			}
		}
		else{
			logger.debug("无法获取Request信息");
		}
		return uris;
	}
	
	@Override
	public User getSessionUser(HttpServletRequest... request) {
		ServletContext sc=InitListener.servletContext.getContext("/core");
		User user=null;
		String cookieName = "JSESSIONID";   
		if(request==null||request.length==0)
			request=new HttpServletRequest[]{ServletActionContext.getRequest()};
		if(request[0]!=null){
			logger.debug("request:"+request[0]);
			Cookie[] cookies = request[0].getCookies();
			logger.debug("cookies:"+cookies);
			int len = cookies.length; 
			boolean found=false;
			for(int i=0; i<len; i++) {   
				Cookie cookie = cookies[i];   
				String c_name = cookie.getName();   
				if(c_name.equalsIgnoreCase(cookieName)) {   
					HttpSession session=(HttpSession)sc.getAttribute("session"+cookie.getValue()); 
					if(session!=null){
						user=(User)session.getAttribute("user");
						found = true;
						break;
					}
				}  
				else if(c_name.equalsIgnoreCase("sessionId")) {   
					HttpSession session=(HttpSession)sc.getAttribute("session"+cookie.getValue()); 
					if(session!=null){
						user=(User)session.getAttribute("user");
						found = true;
						break;
					}
				}  
			}
			if(!found){
				user = (User) request[0].getSession().getAttribute("user");
			}
			if(user==null){
				logger.debug("无法获取用户Session信息");
			}
		}
		else{
			logger.debug("无法获取Request信息");
		}
		//测试使用 user写死
//		User user = new User();
//		//User user = sessionUser;
//		user.setId(1l);
//		user.setRealName("admin");
//		user.setAdmin(BooleanEnum.YES);
		CustomerDto customerDto = new CustomerDto();
		customerDto.setId(17l);
		customerDto.setName("杭州维二科技有限公司");
		if(user!=null){
			user.setCustomerDto(customerDto);
		}
		return user;
	}

	@Override
	public void setSessionUser(User user) {
		sessionUser = user;
		HttpSession httpSession=ServletActionContext.getRequest().getSession();
		httpSession.setAttribute("user", user);
		
		String realName="";
		if(user!=null)realName=user.getRealName();
		ServletActionContext.getServletContext().setAttribute("session"+httpSession.getId(), httpSession);
		
		
		Cookie[] cookies = ServletActionContext.getRequest().getCookies();
		int len = cookies.length; 
		String sessionId=httpSession.getId();
		boolean found=false;
		for(int i=0; i<len; i++) {   
			Cookie cookie = cookies[i];   
			String c_name = cookie.getName();   
			if(c_name.equalsIgnoreCase("JSESSIONID")) {   
				sessionId=cookie.getValue();
				ServletActionContext.getServletContext().setAttribute("session"+cookie.getValue(), httpSession);
				logger.debug("设置用户Session信息:"+realName);
				found=true;
				break;
			}   
		}
		if(!found){
			ServletActionContext.getServletContext().setAttribute("session"+sessionId, httpSession);
			Cookie cookie = new Cookie("JSESSIONID", sessionId);   
			cookie.setMaxAge(-1);   
			cookie.setPath("/");   
			ServletActionContext.getResponse().addCookie(cookie);   
			logger.debug("设置用户Session信息:"+realName);
//			logger.debug("无法设置用户Session信息");
		}
		Cookie cookie = new Cookie("sessionId", sessionId);   
		cookie.setMaxAge(-1);   
		cookie.setPath("/");   
		ServletActionContext.getResponse().addCookie(cookie);   
	}

	@Override
	public void setResourceMap(Map<String, ResourceDto> resourceMap) {
		this.accessibleResourceMap = resourceMap;
	}
	
	@Override
	public Map<String, ResourceDto> getResourceMap() {
		return accessibleResourceMap;
	}

	@Override
	public boolean isInResourceMap(String str) {
		if(accessibleResourceMap.get(str)!=null && accessibleResourceMap.get(str).isDisplay()){
			return true;
		}
		return false;
	}

	@Override
	public String getRemindEmailLink() {
		return CoreActivator.getAppConfig().getConfig("msgLink").getParameter("name");
	}
	
	@Override
	public String getRemindEmailLogo() {
		return CoreActivator.getAppConfig().getConfig("msgLogo").getParameter("name");
	}

}
