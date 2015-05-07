package com.wiiy.pb.action;

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
import com.wiiy.pb.entity.CarportOutContact;
import com.wiiy.pb.entity.FinanceContact;
import com.wiiy.pb.service.FinanceContactService;

/**
 * @author my
 */
public class FinanceContactAction extends JqGridBaseAction<FinanceContact>{
	
	private FinanceContactService financeContactService;
	private Result result;
	private FinanceContact financeContact;
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
		FinanceContact t = financeContactService.getBeanById(id).getValue();
		result = financeContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("财务联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			financeContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = financeContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String approval(){
		result = financeContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = financeContactService.save(financeContact,userId);
		if(result.isSuccess()){
			id = ((FinanceContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = financeContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = financeContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = financeContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = financeContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = financeContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = financeContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	
	public String myView(){
		result = financeContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = financeContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = financeContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = financeContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		FinanceContact dbBean = financeContactService.getBeanById(financeContact.getId()).getValue();
		BeanUtil.copyProperties(financeContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = financeContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = financeContactService.deleteById(id,ContactTypeEnum.FINANCECONTACT);
		} else if(ids!=null){
			result = financeContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(FinanceContact.class));
	}
	
	@Override
	protected List<FinanceContact> getListByFilter(Filter fitler) {
		return financeContactService.getListByFilter(fitler).getValue();
	}
	
	
	public FinanceContact getFinanceContact() {
		return financeContact;
	}

	public void setFinanceContact(FinanceContact financeContact) {
		this.financeContact = financeContact;
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

	public void setFinanceContactService(FinanceContactService financeContactService) {
		this.financeContactService = financeContactService;
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
