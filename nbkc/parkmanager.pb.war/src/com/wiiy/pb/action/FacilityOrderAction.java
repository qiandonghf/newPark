package com.wiiy.pb.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.service.FacilityOrderService;

/**
 * @author my
 */
public class FacilityOrderAction extends JqGridBaseAction<FacilityOrder>{
	private FacilityOrderService facilityOrderService;
	private CustomerService customerService;
	private Result result;
	private ContractService contractService;
	private FacilityOrder facilityOrder;
	private List<FacilityOrder> facilityOrderList;
	private Long id;
	private String ids;
	private Long facilityId;
	private Long customerId;
	private String customerName;
	private List<Contract> contractList;
	private Pager pager;
	
	public String workBenchFacilityOrder(){
		facilityOrderList = facilityOrderService.getListByFilter(new Filter(FacilityOrder.class).orderBy("startTime", Filter.DESC).maxResults(4)).getValue();
		return "workBenchFacilityOrder";
	}

	public String add(){
		contractList = contractService.getList().getValue();
		return "add";
	}
	
	public String save(){
		if(facilityOrder.getContractId()!=null){
			facilityOrder.setContractPath(contractService.getBeanById(facilityOrder.getContractId()).getValue().getName());
		}
		result = facilityOrderService.save(facilityOrder);
		/*if(result.isSuccess()){
			User user = PbActivator.getUserById(Long.valueOf(PbActivator.getAppConfig().getConfig("Writor").getParameter("facilityOrder"))); 
			String receiverEmail = user.getEmail();
			String content = PbActivator.getAppConfig().getConfig("facilityOrderApplyRemind").getParameter("email");
			content = content.replace("${approver}", user.getRealName());
			String subject = "公共设施使用申请提醒";
			sendMail(receiverEmail,content,subject);
			String receiverMobile = "";
			if(user.getMobile()!=null){
				receiverMobile = user.getMobile();
			}
			String content2 = PbActivator.getAppConfig().getConfig("facilityOrderApplyRemind").getParameter("sms");
			content2 = content2.replace("${approver}", user.getRealName());
			sendSms(receiverMobile,content2,user.getRealName());
		}*/
		return JSON;
	}
	
	/*public void sendMail(String receiverEmail,String content,String subject){
		SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}*/
	
	/*public void sendSms(String receiverMobile,String content,String receiverName){
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		smsPubService.send(receiverMobile, content, receiverName);
	}*/
	
	public String addByCustomerId(){
		customerName = PbActivator.getSessionUser().getCustomerDto().getName();
		contractList = contractService.getList().getValue();
		return "addByCustomerId";
	}
	
	public String view(){
		result = facilityOrderService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = facilityOrderService.getBeanById(id);
		contractList = contractService.getList().getValue();
		return EDIT;
	}
	
	public String update(){
		if(facilityOrder.getContractId()!=null){
			facilityOrder.setContractPath(contractService.getBeanById(facilityOrder.getContractId()).getValue().getName());
		}
		result = facilityOrderService.update(facilityOrder);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = facilityOrderService.deleteById(id);
		} else if(ids!=null){
			result = facilityOrderService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter;
		if(facilityId!=null){
			filter = new Filter(FacilityOrder.class).eq("facilityId", facilityId);
		}else{
			filter = new Filter(FacilityOrder.class);
		}
		return refresh(filter);
	}
	
	public String serviceList(){
		Filter filter = new Filter(FacilityOrder.class);
		if(PbActivator.getSessionUser().getUserType().equals(UserTypeEnum.Center)){
			if(facilityId!=null){
				filter = new Filter(FacilityOrder.class).eq("facilityId", facilityId);
			}else{
				filter = new Filter(FacilityOrder.class);
			}
		}else if(PbActivator.getSessionUser().getUserType().equals(UserTypeEnum.Customer)){
			Customer customer = customerService.getBeanByFilter(new Filter(Customer.class).eq("userId", PbActivator.getSessionUser().getId()).orderBy("modifyTime", Filter.DESC)).getValue();
			filter.eq("customerId", customer.getId());
		}
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		List<FacilityOrder> list = facilityOrderService.getListByFilter(filter).getValue();
		ServletActionContext.getRequest().setAttribute("list", list);
		return "facilityOrder_serverList";
	}
	
	@Override
	protected List<FacilityOrder> getListByFilter(Filter fitler) {
		return facilityOrderService.getListByFilter(fitler).getValue();
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public FacilityOrder getFacilityOrder() {
		return facilityOrder;
	}

	public void setFacilityOrder(FacilityOrder facilityOrder) {
		this.facilityOrder = facilityOrder;
	}

	public List<FacilityOrder> getFacilityOrderList() {
		return facilityOrderList;
	}

	public void setFacilityOrderList(List<FacilityOrder> facilityOrderList) {
		this.facilityOrderList = facilityOrderList;
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

	public Long getFacilityId() {
		return facilityId;
	}

	public void setFacilityId(Long facilityId) {
		this.facilityId = facilityId;
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public List<Contract> getContractList() {
		return contractList;
	}

	public void setContractList(List<Contract> contractList) {
		this.contractList = contractList;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public void setFacilityOrderService(FacilityOrderService facilityOrderService) {
		this.facilityOrderService = facilityOrderService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}
}
