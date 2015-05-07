package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Certification;
import com.wiiy.crm.service.CertificationService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CertificationAction extends JqGridBaseAction<Certification>{
	
	private CertificationService certificationService;
	private CustomerService customerService;
	private Result result;
	private Certification certification;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = certificationService.save(certification);
		return JSON;
	}
	
	public String view(){
		result = certificationService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = certificationService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Certification dbBean = certificationService.getBeanById(certification.getId()).getValue();
		BeanUtil.copyProperties(certification, dbBean);
		result = certificationService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = certificationService.deleteById(id);
		} else if(ids!=null){
			result = certificationService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Certification.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<Certification> getListByFilter(Filter fitler) {
		return certificationService.getListByFilter(fitler).getValue();
	}
	
	
	public Certification getCertification() {
		return certification;
	}

	public void setCertification(Certification certification) {
		this.certification = certification;
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

	public void setCertificationService(CertificationService certificationService) {
		this.certificationService = certificationService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public Result getResult() {
		return result;
	}
	
}
