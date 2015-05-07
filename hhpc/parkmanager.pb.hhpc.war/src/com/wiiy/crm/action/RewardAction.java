package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.Reward;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.RewardService;

/**
 * @author my
 */
public class RewardAction extends JqGridBaseAction<Reward>{
	
	private RewardService rewardService;
	private Result result;
	private Reward reward;
	private Long id;
	private String ids;
	private boolean service;
	private CustomerService customerService;
	
	public String loadByCustomerId(){
		return "loadByCustomerId";
	}
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = rewardService.save(reward);
		return JSON;
	}
	
	public String view(){
		result = rewardService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = rewardService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Reward dbBean = rewardService.getBeanById(reward.getId()).getValue();
		BeanUtil.copyProperties(reward, dbBean);
		result = rewardService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = rewardService.deleteById(id);
		} else if(ids!=null){
			result = rewardService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Reward.class));
	}
	
	@Override
	protected List<Reward> getListByFilter(Filter fitler) {
		return rewardService.getListByFilter(fitler).getValue();
	}
	
	
	public Reward getReward() {
		return reward;
	}

	public void setReward(Reward reward) {
		this.reward = reward;
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

	public void setRewardService(RewardService rewardService) {
		this.rewardService = rewardService;
	}
	
	public Result getResult() {
		return result;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public boolean isService() {
		return service;
	}

	public void setService(boolean service) {
		this.service = service;
	}
}
