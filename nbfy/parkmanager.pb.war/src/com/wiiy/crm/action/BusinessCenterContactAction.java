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

import com.wiiy.crm.entity.BusinessCenterContact;
import com.wiiy.crm.service.BusinessCenterContactService;

/**
 * @author my
 */
public class BusinessCenterContactAction extends JqGridBaseAction<BusinessCenterContact>{
	
	private BusinessCenterContactService businessCenterContactService;
	private Result result;
	private BusinessCenterContact businessCenterContact;
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
		BusinessCenterContact t = businessCenterContactService.getBeanById(id).getValue();
		result = businessCenterContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("创业服务中心工作联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			businessCenterContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = businessCenterContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String approval(){
		result = businessCenterContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = businessCenterContactService.save(businessCenterContact,userId);
		if(result.isSuccess()){
			id = ((BusinessCenterContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = businessCenterContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = businessCenterContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = businessCenterContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = businessCenterContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = businessCenterContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = businessCenterContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	
	public String myView(){
		result = businessCenterContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = businessCenterContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = businessCenterContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = businessCenterContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		BusinessCenterContact dbBean = businessCenterContactService.getBeanById(businessCenterContact.getId()).getValue();
		BeanUtil.copyProperties(businessCenterContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = businessCenterContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = businessCenterContactService.deleteById(id,ContactTypeEnum.BUSINESSCENTERCONTACT);
		} else if(ids!=null){
			result = businessCenterContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(BusinessCenterContact.class));
	}
	
	@Override
	protected List<BusinessCenterContact> getListByFilter(Filter fitler) {
		return businessCenterContactService.getListByFilter(fitler).getValue();
	}
	
	
	public BusinessCenterContact getBusinessCenterContact() {
		return businessCenterContact;
	}

	public void setBusinessCenterContact(BusinessCenterContact businessCenterContact) {
		this.businessCenterContact = businessCenterContact;
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

	public void setBusinessCenterContactService(BusinessCenterContactService businessCenterContactService) {
		this.businessCenterContactService = businessCenterContactService;
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
