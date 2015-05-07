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
import com.wiiy.pb.entity.RentOutContact;
import com.wiiy.pb.service.RentOutContactService;

/**
 * @author my
 */
public class RentOutContactAction extends JqGridBaseAction<RentOutContact>{
	
	private RentOutContactService rentOutContactService;
	private Result result;
	private RentOutContact rentOutContact;
	private Long id;
	private Long receiveId;
	private String ids;
	private String approvalType;
	private ContactStatusEnum status;
	private ContactResolveStatusEnum resolveStatus;
	private String opinion;
	private String fileName;
	private InputStream inputStream;
	
	
	
	public String revoke(){
		RentOutContact t = rentOutContactService.getBeanById(id).getValue();
		result = rentOutContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("退房联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			rentOutContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = rentOutContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = rentOutContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = rentOutContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = rentOutContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String approval(){
		result = rentOutContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = rentOutContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = rentOutContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = rentOutContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	public String save(){
		if(rentOutContactService.getBeanByFilter(new Filter(RentOutContact.class).eq("customerId", rentOutContact.getCustomerId()).eq("roomId", rentOutContact.getRoomId())).getValue()!=null){
			result =  Result.failure("已经存在该联系单");
			return JSON;
		}
		Long userId = PbActivator.getSessionUser().getId();
		result = rentOutContactService.save(rentOutContact,userId);
		if(result.isSuccess()){
			id = ((RentOutContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String myView(){
		result = rentOutContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = rentOutContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = rentOutContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = rentOutContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		RentOutContact dbBean = rentOutContactService.getBeanById(rentOutContact.getId()).getValue();
		BeanUtil.copyProperties(rentOutContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = rentOutContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = rentOutContactService.deleteById(id,ContactTypeEnum.RENTOUTCONTACT);
		} else if(ids!=null){
			result = rentOutContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(RentOutContact.class));
	}
	
	@Override
	protected List<RentOutContact> getListByFilter(Filter fitler) {
		return rentOutContactService.getListByFilter(fitler).getValue();
	}
	
	
	public RentOutContact getRentOutContact() {
		return rentOutContact;
	}

	public void setRentOutContact(RentOutContact rentOutContact) {
		this.rentOutContact = rentOutContact;
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

	public void setRentOutContactService(RentOutContactService rentOutContactService) {
		this.rentOutContactService = rentOutContactService;
	}
	
	public Result getResult() {
		return result;
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
