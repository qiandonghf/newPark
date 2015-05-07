package com.wiiy.crm.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.preferences.enums.ContactResolveStatusEnum;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

import com.wiiy.crm.entity.CustomerServiceContact;
import com.wiiy.crm.service.CustomerServiceContactService;

/**
 * @author my
 */
public class CustomerServiceContactAction extends JqGridBaseAction<CustomerServiceContact>{
	
	private CustomerServiceContactService customerServiceContactService;
	private Result result;
	private CustomerServiceContact customerServiceContact;
	private Long id;
	private String ids;
	private Long receiveId;
	private String approvalType;
	private String opinion;
	private String comment;
	private ContactStatusEnum status;
	private ContactResolveStatusEnum resolveStatus;
	private String fileName;
	private InputStream inputStream;
	
	
	public String revoke(){
		CustomerServiceContact t = customerServiceContactService.getBeanById(id).getValue();
		result = customerServiceContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("客服联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			customerServiceContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = customerServiceContactService.send(id, receiveId);
		return JSON;
	}
	
	public String approval(){
		result = customerServiceContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = customerServiceContactService.save(customerServiceContact,userId);
		if(result.isSuccess()){
			id = ((CustomerServiceContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = customerServiceContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = customerServiceContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = customerServiceContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = customerServiceContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = customerServiceContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = customerServiceContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	
	public String myView(){
		result = customerServiceContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = customerServiceContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = customerServiceContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = customerServiceContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerServiceContact dbBean = customerServiceContactService.getBeanById(customerServiceContact.getId()).getValue();
		BeanUtil.copyProperties(customerServiceContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = customerServiceContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerServiceContactService.deleteById(id,ContactTypeEnum.BUSINESSCENTERCONTACT);
		} else if(ids!=null){
			result = customerServiceContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerServiceContact.class));
	}
	
	@Override
	protected List<CustomerServiceContact> getListByFilter(Filter fitler) {
		return customerServiceContactService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerServiceContact getCustomerServiceContact() {
		return customerServiceContact;
	}

	public void setCustomerServiceContact(CustomerServiceContact customerServiceContact) {
		this.customerServiceContact = customerServiceContact;
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

	public void setCustomerServiceContactService(CustomerServiceContactService customerServiceContactService) {
		this.customerServiceContactService = customerServiceContactService;
	}
	
	public Result getResult() {
		return result;
	}

	public Long getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(Long receiveId) {
		this.receiveId = receiveId;
	}

	public String getApprovalType() {
		return approvalType;
	}

	public void setApprovalType(String approvalType) {
		this.approvalType = approvalType;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public ContactStatusEnum getStatus() {
		return status;
	}

	public void setStatus(ContactStatusEnum status) {
		this.status = status;
	}

	public ContactResolveStatusEnum getResolveStatus() {
		return resolveStatus;
	}

	public void setResolveStatus(ContactResolveStatusEnum resolveStatus) {
		this.resolveStatus = resolveStatus;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	
}
