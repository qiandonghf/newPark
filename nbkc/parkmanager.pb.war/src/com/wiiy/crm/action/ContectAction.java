package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.service.ContectService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ContectAction extends JqGridBaseAction<Contect>{
	
	private ContectService contectService;
	private CustomerService customerService;
	private Result result;
	private Contect contect;
	private Long id;
	private String ids;
	
	public String importCard(){
		result = contectService.importCard(ids);
		return JSON;
	}
	
	
	public String select(){
		return SELECT;
	}
	
	public String loadContectsByCustomerId(){
		result = contectService.getListByFilter(new Filter(Contect.class).include("id").include("name").eq("customerId", id));
		return JSON;
	}
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = contectService.save(contect);
		return JSON;
	}
	
	public String view(){
		result = contectService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contectService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = contectService.update(contect);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contectService.deleteById(id);
		} else if(ids!=null){
			result = contectService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Contect.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<Contect> getListByFilter(Filter fitler) {
		return contectService.getListByFilter(fitler).getValue();
	}
	
	
	public Contect getContect() {
		return contect;
	}

	public void setContect(Contect contect) {
		this.contect = contect;
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

	public void setContectService(ContectService contectService) {
		this.contectService = contectService;
	}
	
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public Result getResult() {
		return result;
	}

}
