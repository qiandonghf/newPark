package com.wiiy.crm.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.crm.dto.DataPropertyDto;
import com.wiiy.crm.entity.DataReportGroup;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.DataReportGroupService;
import com.wiiy.crm.service.DataReportPropertyService;
import com.wiiy.crm.service.DataReportToCustomerService;
import com.wiiy.crm.service.DataReportValueService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataReportToCustomerAction extends JqGridBaseAction<DataReportToCustomer>{
	
	private DataReportToCustomerService dataReportToCustomerService;
	private DataReportGroupService dataReportGroupService;
	private DataReportValueService dataReportValueService;
	private DataReportPropertyService dataReportPropertyService;
	private CustomerService customerService;
	
	private Result result;
	private DataReportToCustomer dataReportToCustomer;
	private Long id;
	private Long cId;
	private String ids;
	private DataTemplate dataTemplate;
	
	private List<DataPropertyDto> propertyDtoList;
	private List<DataReportGroup> reportGroupList;
	
	private String propertyIds;
	private String propertyValues;
	
	private CustomerReportStatusEnum status;
	private List<DataReportProperty> propertyList;
	private Map<Long, DataReportValue> dataReportValueMap;
	
	public String editLog(){
		if(id!=null){
			result = dataReportToCustomerService.getBeanById(id);
		} else {
			String reportId = ServletActionContext.getRequest().getParameter("reportId");
			String customerId = ServletActionContext.getRequest().getParameter("customerId");
			result = dataReportToCustomerService.getBeanByFilter(new Filter(DataReportToCustomer.class).eq("reportId", Long.valueOf(reportId)).eq("customerId", Long.valueOf(customerId)));
		}
		view();
		return "editLog";
	}
	
	public String back(){
		result = dataReportToCustomerService.back(id,ServletActionContext.getRequest().getParameter("suggestion"));
		return JSON;
	}
	
	public String deskTopList(){
		Filter filter = new Filter(DataReportToCustomer.class);
		filter.eq("status", CustomerReportStatusEnum.PUB);
		filter.orderBy("fillTime", Filter.DESC);
		filter.maxResults(4);
		result = dataReportToCustomerService.getListByFilter(filter);
		return "deskTopList";
	}
	
	public String reportPub(){
		result = dataReportToCustomerService.reportPub(id);
		return JSON;
	}
	
	public String listByCustomerId(){
		Filter filter = new Filter(DataReportToCustomer.class);
		filter.eq("customerId", customerService.getSessionUserCustomer().getValue().getId());
		filter.orderBy("finished", Filter.ASC);
		return refresh(filter);
	}
	
	public String countByCustomerId(){
		Filter filter = new Filter(DataReportToCustomer.class);
		filter.eq("customerId", customerService.getSessionUserCustomer().getValue().getId());
		filter.eq("finished", BooleanEnum.NO);
		result = dataReportToCustomerService.countByFilter(filter);
		return JSON;
	}
	
	public String save(){
		result = dataReportToCustomerService.save(dataReportToCustomer);
		return JSON;
	}
	
	public String report(){
		result = dataReportToCustomerService.report(id,status,propertyIds,propertyValues);
		return JSON;
	}
	
	public String view(){
		
		reportGroupList = dataReportGroupService.getList().getValue();
		DataReportToCustomer dataReportToCustomer = null;
		if(id!=null){
			 dataReportToCustomer = dataReportToCustomerService.getBeanById(id).getValue();
		} else {
			String reportId = ServletActionContext.getRequest().getParameter("reportId");
			String customerId = ServletActionContext.getRequest().getParameter("customerId");
			dataReportToCustomer = dataReportToCustomerService.getBeanByFilter(new Filter(DataReportToCustomer.class).eq("reportId", Long.valueOf(reportId)).eq("customerId", Long.valueOf(customerId))).getValue();
		}
		dataTemplate = dataReportToCustomer.getReport().getTemplate();
		result = Result.value(dataReportToCustomer);
		propertyList = dataReportPropertyService.getListByFilter(new Filter(DataReportProperty.class).eq("reportId",dataReportToCustomer.getReportId())).getValue();
		if(propertyList!=null) {
			propertyList = TreeUtil.generateTree(propertyList);
		}
		List<DataReportValue> dataReportValueList = dataReportValueService.getListByFilter(new Filter(DataReportValue.class).eq("reportCustomerId",dataReportToCustomer.getId())).getValue();
		dataReportValueMap = new HashMap<Long,DataReportValue>();
		for (DataReportValue dataReportValue : dataReportValueList) {
			dataReportValueMap.put(dataReportValue.getPropertyId(), dataReportValue);
		}
		return VIEW;
	}
	public String viewLog(){
		
		reportGroupList = dataReportGroupService.getList().getValue();
		DataReportToCustomer dataReportToCustomer = null;
		if(id!=null){
			dataReportToCustomer = dataReportToCustomerService.getBeanById(id).getValue();
		} else {
			String reportId = ServletActionContext.getRequest().getParameter("reportId");
			String customerId = ServletActionContext.getRequest().getParameter("customerId");
			dataReportToCustomer = dataReportToCustomerService.getBeanByFilter(new Filter(DataReportToCustomer.class).eq("reportId", Long.valueOf(reportId)).eq("customerId", Long.valueOf(customerId))).getValue();
		}
		dataTemplate = dataReportToCustomer.getReport().getTemplate();
		result = Result.value(dataReportToCustomer);
		propertyList = dataReportPropertyService.getListByFilter(new Filter(DataReportProperty.class).eq("reportId",dataReportToCustomer.getReportId())).getValue();
		if(propertyList!=null) {
			propertyList = TreeUtil.generateTree(propertyList);
		}
		List<DataReportValue> dataReportValueList = dataReportValueService.getListByFilter(new Filter(DataReportValue.class).eq("reportCustomerId",dataReportToCustomer.getId())).getValue();
		dataReportValueMap = new HashMap<Long,DataReportValue>();
		for (DataReportValue dataReportValue : dataReportValueList) {
			dataReportValueMap.put(dataReportValue.getPropertyId(), dataReportValue);
		}
		return "viewLog";
	}
	
	public String edit(){
		if(id!=null){
			result = dataReportToCustomerService.getBeanById(id);
		} else {
			String reportId = ServletActionContext.getRequest().getParameter("reportId");
			String customerId = ServletActionContext.getRequest().getParameter("customerId");
			result = dataReportToCustomerService.getBeanByFilter(new Filter(DataReportToCustomer.class).eq("reportId", Long.valueOf(reportId)).eq("customerId", Long.valueOf(customerId)));
		}
		view();
		return EDIT;
	}
	
	public String update(){
		DataReportToCustomer dbBean = dataReportToCustomerService.getBeanById(dataReportToCustomer.getId()).getValue();
		BeanUtil.copyProperties(dataReportToCustomer, dbBean);
		result = dataReportToCustomerService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataReportToCustomerService.deleteById(id);
		} else if(ids!=null){
			result = dataReportToCustomerService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DataReportToCustomer.class);
		if(ids!=null){
			id = Long.parseLong(ids.split(",")[0]);
			cId = Long.parseLong(ids.split(",")[1]);
		}
		filter.eq("reportId", id);
		//filter.eq("status", CustomerReportStatusEnum.PUB);
		if (cId != null) {
			filter.eq("customerId", cId);
		}
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<DataReportToCustomer> getListByFilter(Filter fitler) {
		return dataReportToCustomerService.getListByFilter(fitler).getValue();
	}
	
	
	public DataReportToCustomer getDataReportToCustomer() {
		return dataReportToCustomer;
	}

	public void setDataReportToCustomer(DataReportToCustomer dataReportToCustomer) {
		this.dataReportToCustomer = dataReportToCustomer;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getcId() {
		return cId;
	}
	public void setcId(Long cId) {
		this.cId = cId;
	}
	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	
	public void setDataReportToCustomerService(DataReportToCustomerService dataReportToCustomerService) {
		this.dataReportToCustomerService = dataReportToCustomerService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setDataReportPropertyService(
			DataReportPropertyService dataReportPropertyService) {
		this.dataReportPropertyService = dataReportPropertyService;
	}

	public DataTemplate getDataTemplate() {
		return dataTemplate;
	}

	public List<DataPropertyDto> getPropertyDtoList() {
		return propertyDtoList;
	}

	public void setPropertyIds(String propertyIds) {
		this.propertyIds = propertyIds;
	}

	public void setPropertyValues(String propertyValues) {
		this.propertyValues = propertyValues;
	}

	public void setDataReportValueService(
			DataReportValueService dataReportValueService) {
		this.dataReportValueService = dataReportValueService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public CustomerReportStatusEnum getStatus() {
		return status;
	}

	public void setStatus(CustomerReportStatusEnum status) {
		this.status = status;
	}

	public List<DataReportProperty> getPropertyList() {
		return propertyList;
	}

	public Map<Long, DataReportValue> getDataReportValueMap() {
		return dataReportValueMap;
	}
	
	public List<DataReportGroup> getReportGroupList() {
		return reportGroupList;
	}

	public void setDataReportGroupService(DataReportGroupService dataReportGroupService) {
		this.dataReportGroupService = dataReportGroupService;
	}
	
}
