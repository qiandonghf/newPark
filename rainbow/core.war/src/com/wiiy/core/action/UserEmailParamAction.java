package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserEmailParam;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.UserEmailParamService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class UserEmailParamAction extends JqGridBaseAction<UserEmailParam>{
	
	private UserEmailParamService userEmailParamService;
	private Result result;
	private UserEmailParam userEmailParam;
	private Long id;
	private String ids;
	private String email;
	
	public String emailByUserId(){
		result = userEmailParamService.getBeanByFilter(new Filter(UserEmailParam.class).eq("id", CoreActivator.getSessionUser().getId()));
		return "emailByUserId";
	}
	
	public String saveOrUpdate(){
		if(userEmailParam.getId()!=null){
			UserEmailParam dbBean = userEmailParamService.getBeanById(userEmailParam.getId()).getValue();
			BeanUtil.copyProperties(userEmailParam, dbBean);
			if(userEmailParamService.update(dbBean).isSuccess()){
				result = Result.success(R.UserEmailParam.UPDATE_SUCCESS);
				CoreActivator.getSessionUser().setUserEmailParam(dbBean);
				User user = CoreActivator.getSessionUser();
				CoreActivator.setSessionUser(user);
			}else{
				result = Result.failure(R.UserEmailParam.UPDATE_SUCCESS);
			}
		}else{
			userEmailParam.setId(CoreActivator.getSessionUser().getId());
			if(userEmailParamService.save(userEmailParam).isSuccess()){
				result = Result.success(R.UserEmailParam.SAVE_SUCCESS);
				CoreActivator.getSessionUser().setUserEmailParam(userEmailParam);
				User user = CoreActivator.getSessionUser();
				CoreActivator.setSessionUser(user);
			}else{
				result = Result.failure(R.UserEmailParam.SAVE_SUCCESS);
			}
		}
		return JSON;
	}
	
	public String view(){
		result = userEmailParamService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = userEmailParamService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		UserEmailParam dbBean = userEmailParamService.getBeanById(userEmailParam.getId()).getValue();
		BeanUtil.copyProperties(userEmailParam, dbBean);
		result = userEmailParamService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = userEmailParamService.deleteById(id);
		} else if(ids!=null){
			result = userEmailParamService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(UserEmailParam.class));
	}
	
	@Override
	protected List<UserEmailParam> getListByFilter(Filter fitler) {
		return userEmailParamService.getListByFilter(fitler).getValue();
	}
	
	
	public UserEmailParam getUserEmailParam() {
		return userEmailParam;
	}

	public void setUserEmailParam(UserEmailParam userEmailParam) {
		this.userEmailParam = userEmailParam;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setUserEmailParamService(UserEmailParamService userEmailParamService) {
		this.userEmailParamService = userEmailParamService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	
}
