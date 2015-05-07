package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Patent;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.PatentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class PatentAction extends JqGridBaseAction<Patent>{
	
	private PatentService patentService;
	private CustomerService customerService;
	private Result result;
	private Patent patent;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		if(patent.getTypeId().equals("")){
			patent.setTypeId(null);
		}
		if(patent.getSourceId().equals("")){
			patent.setSourceId(null);
		}
		result = patentService.save(patent);
		return JSON;
	}
	
	public String view(){
		result = patentService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = patentService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Patent dbBean = patentService.getBeanById(patent.getId()).getValue();
		BeanUtil.copyProperties(patent, dbBean);
		if(dbBean.getTypeId().equals("")){
			dbBean.setTypeId(null);
		}
		if(dbBean.getSourceId().equals("")){
			dbBean.setSourceId(null);
		}
		result = patentService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = patentService.deleteById(id);
		} else if(ids!=null){
			result = patentService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Patent.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<Patent> getListByFilter(Filter fitler) {
		return patentService.getListByFilter(fitler).getValue();
	}
	
	
	public Patent getPatent() {
		return patent;
	}

	public void setPatent(Patent patent) {
		this.patent = patent;
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

	public void setPatentService(PatentService patentService) {
		this.patentService = patentService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
