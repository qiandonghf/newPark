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
import com.wiiy.pb.entity.FinanceContact;
import com.wiiy.pb.entity.TenementCenterContact;
import com.wiiy.pb.service.TenementCenterContactService;

/**
 * @author my
 */
public class TenementCenterContactAction extends JqGridBaseAction<TenementCenterContact>{
	
	private TenementCenterContactService tenementCenterContactService;
	private Result result;
	private TenementCenterContact tenementCenterContact;
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
		TenementCenterContact t = tenementCenterContactService.getBeanById(id).getValue();
		result = tenementCenterContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("物业客户服务中心联系单(退房)")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			tenementCenterContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = tenementCenterContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String approval(){
		result = tenementCenterContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = tenementCenterContactService.save(tenementCenterContact,userId);
		if(result.isSuccess()){
			id = ((TenementCenterContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = tenementCenterContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = tenementCenterContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = tenementCenterContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = tenementCenterContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = tenementCenterContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = tenementCenterContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	
	public String myView(){
		result = tenementCenterContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = tenementCenterContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = tenementCenterContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = tenementCenterContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		TenementCenterContact dbBean = tenementCenterContactService.getBeanById(tenementCenterContact.getId()).getValue();
		BeanUtil.copyProperties(tenementCenterContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = tenementCenterContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = tenementCenterContactService.deleteById(id,ContactTypeEnum.TENEMENTCENTERCONTACT);
		} else if(ids!=null){
			result = tenementCenterContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(TenementCenterContact.class));
	}
	
	@Override
	protected List<TenementCenterContact> getListByFilter(Filter fitler) {
		return tenementCenterContactService.getListByFilter(fitler).getValue();
	}
	
	
	public TenementCenterContact getTenementCenterContact() {
		return tenementCenterContact;
	}

	public void setTenementCenterContact(TenementCenterContact tenementCenterContact) {
		this.tenementCenterContact = tenementCenterContact;
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

	public void setTenementCenterContactService(TenementCenterContactService tenementCenterContactService) {
		this.tenementCenterContactService = tenementCenterContactService;
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
