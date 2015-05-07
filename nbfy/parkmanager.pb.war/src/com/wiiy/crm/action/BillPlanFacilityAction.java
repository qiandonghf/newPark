package com.wiiy.crm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.SubjectNetwork;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.service.BillPlanFacilityService;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.SubjectNetworkService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.service.FacilityOrderService;

public class BillPlanFacilityAction extends JqGridBaseAction<BillPlanFacility>{
	private BillPlanFacilityService billPlanFacilityService;
	private SubjectNetworkService subjectNetworkService;
	private FacilityOrderService facilityOrderService;
	private ContractService contractService;
	private CustomerService customerService;
	
	
	private Contract contract;
	private BillPlanFacility billPlanFacility;
	private Facility facility;
	private FacilityOrder facilityOrder;
	
	private Result result;
	private String ids;
	private Long id;
	private Long facilityOrderId;
	private Pager pager;
	
	private List<SubjectNetwork> subjectNetworkList;
	
	public String batchCheckout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean autoRemind = request.getParameter("autoRemind") != null;
		String types = request.getParameter("types");
		result = billPlanFacilityService.batchCheckout(ids,types.split(","),autoRemind);
		return JSON;
	}
	
	public String checkinById(){
		result = billPlanFacilityService.checkoutById(id, BillPlanStatusEnum.INCHECKED);
		return JSON;
	}
	public String checkoutById(){
		result = billPlanFacilityService.checkoutById(id, BillPlanStatusEnum.OUTCHECKED);
		return JSON;
	}
	public String viewNetworkPlan(){
		return "viewNetworkPlan";
	}
	
	public String editNetworkPlan(){
		BillPlanFacility plan = billPlanFacilityService.getBeanById(id).getValue();
		id = plan.getContractId();
		subjectNetworkList = subjectNetworkService.getListByFilter(new Filter(SubjectNetwork.class).eq("contractId", id)).getValue();
		result = Result.value(plan);
		return "editNetworkPlan";
	}
	public String addNetworkPlan(){
		subjectNetworkList = subjectNetworkService.getListByFilter(new Filter(SubjectNetwork.class).eq("contractId", id)).getValue();
		return "addNetworkPlan";
	}
	
	public String listByFacilityOrderId(){
		Filter filter = new Filter(BillPlanFacility.class).eq("facilityOrderId", facilityOrderId);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		List<BillPlanFacility> list = billPlanFacilityService.getListByFilter(filter).getValue();
		ServletActionContext.getRequest().setAttribute("list",list);
		ServletActionContext.getRequest().setAttribute("facilityOrderId",facilityOrderId);
		return "listByFacilityOrderId";
	}
	
	public String serviceListByFacilityOrderId(){
		Filter filter = new Filter(BillPlanFacility.class).eq("facilityOrderId", facilityOrderId);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		List<BillPlanFacility> list = billPlanFacilityService.getListByFilter(filter).getValue();
		ServletActionContext.getRequest().setAttribute("list",list);
		ServletActionContext.getRequest().setAttribute("facilityOrderId",facilityOrderId);
		return "serviceListByFacilityOrderId";
	}
	
	public String addByFacilityId(){
		facilityOrder = facilityOrderService.getBeanById(facilityOrderId).getValue();
		if(facilityOrder.getContractId()!=null){
			contract = contractService.getBeanById(facilityOrder.getContractId()).getValue();
		}
		return "addByFacilityOrderId";
	}
	
	
	public String save(){
		if(billPlanFacility.getAutoCheck()==null){
			billPlanFacility.setAutoCheck(BooleanEnum.NO);
		}
		if(billPlanFacility.getStatus()==null){
			billPlanFacility.setStatus(BillPlanStatusEnum.UNCHECK);
		}
		result = billPlanFacilityService.save(billPlanFacility);
		return JSON;
	}
	
	public String edit(){
		result = billPlanFacilityService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		BillPlanFacility dbBean = billPlanFacilityService.getBeanById(billPlanFacility.getId()).getValue();
		BeanUtil.copyProperties(billPlanFacility, dbBean);
		result = billPlanFacilityService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = billPlanFacilityService.deleteById(id);
		}
		if(ids!=null){
			result = billPlanFacilityService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String view(){
		result = billPlanFacilityService.getBeanById(id);
		return VIEW;
	}
	
	
	public String list(){
		fetchDepth = 2;
		Filter filter = new Filter(BillPlanFacility.class).createAlias("facility", "facility");
		if(filters.indexOf("contract.")!=-1){
			filter.createAlias("contract", "contract");
		}
		return refresh(filter);
	}
	
	public String listAll(){
		Filter filter = new Filter(BillPlanFacility.class);
		filter.createAlias("facility", "facility");
		filter.createAlias("customer", "customer");
		fetchDepth = 2;
		return refresh(filter);
	}
	
	public String listByCustomerId(){
		Customer c = customerService.getBeanByFilter(new Filter(Customer.class).eq("userId", PbActivator.getSessionUser().getId())).getValue();
		Filter filter = new  Filter(BillPlanFacility.class).createAlias("facilityOrder", "facilityOrder").eq("facilityOrder.customerId", c.getId());
		fetchDepth = 2;
		return refresh(filter);
	}
	
	
	@Override
	protected List<BillPlanFacility> getListByFilter(Filter filter) {
		return billPlanFacilityService.getListByFilter(filter).getValue();
	}

	public void setBillPlanFacilityService(
			BillPlanFacilityService billPlanFacilityService) {
		this.billPlanFacilityService = billPlanFacilityService;
	}

	public BillPlanFacility getBillPlanFacility() {
		return billPlanFacility;
	}

	public void setBillPlanFacility(BillPlanFacility billPlanFacility) {
		this.billPlanFacility = billPlanFacility;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getFacilityOrderId() {
		return facilityOrderId;
	}

	public void setFacilityOrderId(Long facilityOrderId) {
		this.facilityOrderId = facilityOrderId;
	}

	public void setFacilityOrderService(FacilityOrderService facilityOrderService) {
		this.facilityOrderService = facilityOrderService;
	}

	public Facility getFacility() {
		return facility;
	}

	public void setFacility(Facility facility) {
		this.facility = facility;
	}

	public FacilityOrder getFacilityOrder() {
		return facilityOrder;
	}

	public void setFacilityOrder(FacilityOrder facilityOrder) {
		this.facilityOrder = facilityOrder;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}

	public List<SubjectNetwork> getSubjectNetworkList() {
		return subjectNetworkList;
	}

	public void setSubjectNetworkService(SubjectNetworkService subjectNetworkService) {
		this.subjectNetworkService = subjectNetworkService;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

}
