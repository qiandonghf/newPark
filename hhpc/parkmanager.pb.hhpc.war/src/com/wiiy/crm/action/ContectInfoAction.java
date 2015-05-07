package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.ContectInfo;
import com.wiiy.crm.service.ContectInfoService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ContectInfoAction extends JqGridBaseAction<ContectInfo>{
	
	private ContectInfoService contectInfoService;
	private CustomerService customerService;
	private Result result;
	private ContectInfo contectInfo;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = contectInfoService.save(contectInfo);
		return JSON;
	}
	
	public String view(){
		result = contectInfoService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contectInfoService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContectInfo dbBean = contectInfoService.getBeanById(contectInfo.getId()).getValue();
		BeanUtil.copyProperties(contectInfo, dbBean);
		result = contectInfoService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contectInfoService.deleteById(id);
		} else if(ids!=null){
			result = contectInfoService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(ContectInfo.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<ContectInfo> getListByFilter(Filter fitler) {
		return contectInfoService.getListByFilter(fitler).getValue();
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

	public ContectInfo getContectInfo() {
		return contectInfo;
	}

	public void setContectInfo(ContectInfo contectInfo) {
		this.contectInfo = contectInfo;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public void setContectInfoService(ContectInfoService contectInfoService) {
		this.contectInfoService = contectInfoService;
	}
	
	public Result getResult() {
		return result;
	}

}
