package com.wiiy.core.action;

import javax.servlet.http.Cookie;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.BaseAction;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserEmailParam;
import com.wiiy.core.service.UserService;
import com.wiiy.hibernate.Result;

public class LoginAction extends BaseAction {
	
	private UserService userService;
	
	private User user;
	
	private String userType;
	
	private Result<?> result;
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Result<?> getResult() {
		return result;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public String execute() {
		return LOGIN;
	}
	
	public String login() {		
		String ip = ServletActionContext.getRequest().getRemoteAddr();
		user.setIp(ip);
		result = userService.login(user);
		User tuser=(User)result.getValue();
		if (result.isSuccess()){
			if(tuser.getUserType().name().equalsIgnoreCase(userType)){
				CoreActivator.getHttpSessionService().setSessionUser((User)result.getValue());
				ServletActionContext.getContext().getSession().put("login_user", tuser);
				UserEmailParam 
				emailParam=tuser.getUserEmailParam();
				System.out.println("LoginAction.login() emailParam="+emailParam);
				if(emailParam!=null){
					System.out.println("LoginAction.login():emailParam.getEmail()="+emailParam.getEmail());
				}
				CoreActivator.getOperationLogService().logLogin("登录系统");
				maybeAutoLogin();
			}
			else{
				result=new Result(false, null, "帐号类型不正确，请切换登录帐号类型！");
			}
		}
		return JSON;
	}
	
	private void maybeAutoLogin(){
		String autoLogin = ServletActionContext.getRequest().getParameter("autoLogin");
		if(autoLogin!=null && autoLogin.equals("true")){
			String userinfo = user.getUsername()+","+user.getPassword();
			Cookie cookie = new Cookie("autoLogin", userinfo);
			cookie.setMaxAge(1209600);//两周
			cookie.setPath("/");
			ServletActionContext.getResponse().addCookie(cookie);
		} else {
			Cookie[] cookies = ServletActionContext.getRequest().getCookies();
			if(cookies!=null)
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("autoLogin")){
					cookie.setMaxAge(0);//删除cookie
					ServletActionContext.getResponse().addCookie(cookie);
					break;
				}
			}
		}
	}
	
	private void cancelAutoLogin(){
		Cookie[] cookies = ServletActionContext.getRequest().getCookies();
		if(cookies!=null)
		for (Cookie cookie : cookies) {
			if(cookie.getName().equals("autoLogin")){
				cookie.setMaxAge(0);//删除cookie
				cookie.setPath("/");
				ServletActionContext.getResponse().addCookie(cookie);
				break;
			}
		}
	}
	
	public String lockScreen() {
		user = (User) ServletActionContext.getContext().getSession().get("login_user");
		return "lockScreen";
	}

	public String unlockScreen() {
		result = userService.login(user);
		return JSON;
	}

	public String logout() {
		cancelAutoLogin();
		User user = (User) ServletActionContext.getContext().getSession().get("login_user");
		if (user != null) {
			user.invalidate();
		}
		ServletActionContext.getRequest().getSession().invalidate();
		if(CoreActivator.getHttpSessionService()!=null)
			CoreActivator.getHttpSessionService().setSessionUser(null);
		return LOGIN;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
	
}
