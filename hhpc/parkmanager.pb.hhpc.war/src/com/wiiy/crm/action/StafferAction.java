package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.StafferService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class StafferAction extends JqGridBaseAction<Staffer>{
	
	private StafferService stafferService;
	private CustomerService customerService;
	private Result result;
	private Staffer staffer;
	private Long id;
	private String ids;
	private String isManager;
	private String isLegal;
	private Long customerId;
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public Long getCustomerId() {
		return customerId;
	}
	
	public String check(){
		Filter filter = new Filter(Staffer.class);
		filter.eq("customerId",customerId).or(Filter.Eq("manager", BooleanEnum.YES),Filter.Eq("legal", BooleanEnum.YES));
		if(id!=null){
			filter.ne("id", id);
		}
		List<Staffer> staffers = stafferService.getListByFilter(filter).getValue();
		result = Result.success("");
		if(staffers != null && staffers.size()>0){
			for (Staffer staffer : staffers) {
				if(staffer.getManager() == BooleanEnum.YES && isManager.equals("YES")){
					result = Result.failure("该企业已存在总经理,是否替换");
				}else if(staffer.getLegal() == BooleanEnum.YES && isLegal.equals("YES")){
					result = Result.failure("该企业已存在法人,是否替换");
				}
			}
		}
		return JSON;
	}
	
	public String importCard(){
		result = stafferService.importCard(ids);
		return JSON;
	}
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = stafferService.save(staffer);
		return JSON;
	}
	
	public String view(){
		result = stafferService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = stafferService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Staffer dbBean = stafferService.getBeanById(staffer.getId()).getValue();
		BeanUtil.copyProperties(staffer, dbBean);
		result = stafferService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = stafferService.deleteById(id);
		} else if(ids!=null){
			result = stafferService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Staffer.class);
		filter.createAlias("customer", "customer");
		return refresh(filter.orderBy("createTime", Filter.ASC));
	}
	
	@Override
	protected List<Staffer> getListByFilter(Filter fitler) {
		return stafferService.getListByFilter(fitler).getValue();
	}
	
	
	public Staffer getStaffer() {
		return staffer;
	}

	public void setStaffer(Staffer staffer) {
		this.staffer = staffer;
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

	public void setStafferService(StafferService stafferService) {
		this.stafferService = stafferService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public Result getResult() {
		return result;
	}
	public String getIsManager() {
		return isManager;
	}

	public void setIsManager(String isManager) {
		this.isManager = isManager;
	}

	public String getIsLegal() {
		return isLegal;
	}

	public void setIsLegal(String isLegal) {
		this.isLegal = isLegal;
	}

}
