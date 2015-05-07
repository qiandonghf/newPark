package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.BusinessPlan;
import com.wiiy.crm.entity.BusinessPlanAtt;
import com.wiiy.crm.service.BusinessPlanService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class BusinessPlanAction extends JqGridBaseAction<BusinessPlan>{
	
	private BusinessPlanService businessPlanService;
	private Result result;
	private BusinessPlan businessPlan;
	private Long id;
	private String ids;
	private List<BusinessPlanAtt> attList;
	
	
	public String save(){
		result = businessPlanService.save(businessPlan);
		return JSON;
	}
	
	public String view(){
		Filter filter = new Filter(BusinessPlan.class);
		filter.createAlias("investment", "investment");
		filter.eq("investment.id", id);
		businessPlan = businessPlanService.getBeanByFilter(filter).getValue();
		result = Result.value(businessPlan);
		if(businessPlan!=null){
		attList = new ArrayList<BusinessPlanAtt>(businessPlan.getAtts());
		Collections.sort(attList, new Comparator<BusinessPlanAtt>() {
			@Override
			public int compare(BusinessPlanAtt o1, BusinessPlanAtt o2) {
				if(o1.getCreateTime()==null)return -1;
				if(o2.getCreateTime()==null)return 1;
				if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
				return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
			}
		});
		}
		return VIEW;
	}
	
	public String edit(){
		result = businessPlanService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		BusinessPlan dbBean = businessPlanService.getBeanById(businessPlan.getId()).getValue();
		BeanUtil.copyProperties(businessPlan, dbBean);
		result = businessPlanService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = businessPlanService.deleteById(id);
		} else if(ids!=null){
			result = businessPlanService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(BusinessPlan.class));
	}
	
	@Override
	protected List<BusinessPlan> getListByFilter(Filter fitler) {
		return businessPlanService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	public String mySave(){
		result = businessPlanService.save(businessPlan);
		return JSON;
	}
	
	public String myView(){
		Filter filter = new Filter(BusinessPlan.class);
		filter.createAlias("investment", "investment");
		filter.eq("investment.id", id);
		businessPlan = businessPlanService.getBeanByFilter(filter).getValue();
		//businessPlan = businessPlanService.getBeanById(id).getValue();
		result = Result.value(businessPlan);
		if(businessPlan!=null){
			attList = new ArrayList<BusinessPlanAtt>(businessPlan.getAtts());
			Collections.sort(attList, new Comparator<BusinessPlanAtt>() {
				@Override
				public int compare(BusinessPlanAtt o1, BusinessPlanAtt o2) {
					if(o1.getCreateTime()==null)return -1;
					if(o2.getCreateTime()==null)return 1;
					if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
					return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
				}
			});
		}
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = businessPlanService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		BusinessPlan dbBean = businessPlanService.getBeanById(businessPlan.getId()).getValue();
		BeanUtil.copyProperties(businessPlan, dbBean);
		result = businessPlanService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = businessPlanService.deleteById(id);
		} else if(ids!=null){
			result = businessPlanService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		return refresh(new Filter(BusinessPlan.class));
	}
	
	
	
	
	
	public BusinessPlan getBusinessPlan() {
		return businessPlan;
	}

	public void setBusinessPlan(BusinessPlan businessPlan) {
		this.businessPlan = businessPlan;
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

	public void setBusinessPlanService(BusinessPlanService businessPlanService) {
		this.businessPlanService = businessPlanService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<BusinessPlanAtt> getAttList() {
		return attList;
	}
	
}
