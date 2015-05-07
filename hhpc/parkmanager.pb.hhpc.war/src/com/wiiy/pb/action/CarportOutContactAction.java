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
import com.wiiy.pb.service.CarportOutContactService;

/**
 * @author my
 */
public class CarportOutContactAction extends JqGridBaseAction<CarportOutContact>{
	
	private CarportOutContactService carportOutContactService;
	private Result result;
	private CarportOutContact carportOutContact;
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
		CarportOutContact t = carportOutContactService.getBeanById(id).getValue();
		result = carportOutContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("车位退租确认单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			carportOutContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = carportOutContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = carportOutContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = carportOutContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = carportOutContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String approval(){
		result = carportOutContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = carportOutContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = carportOutContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = carportOutContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = carportOutContactService.save(carportOutContact,userId);
		id = ((CarportOutContact)result.getValue()).getId();
		return JSON;
	}
	
	public String myView(){
		result = carportOutContactService.getBeanById(id);
		return "myView";
	}
	public String countersignView(){
		result = carportOutContactService.getBeanById(id);
		return "countersignView";
	}
	public String view(){
		result = carportOutContactService.getBeanById(id);
		return "view";
	}
	
	public String edit(){
		result = carportOutContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CarportOutContact dbBean = carportOutContactService.getBeanById(carportOutContact.getId()).getValue();
		BeanUtil.copyProperties(carportOutContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = carportOutContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = carportOutContactService.deleteById(id,ContactTypeEnum.CARPORTOUTCONTACT);
		} else if(ids!=null){
			result = carportOutContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CarportOutContact.class));
	}
	
	@Override
	protected List<CarportOutContact> getListByFilter(Filter fitler) {
		return carportOutContactService.getListByFilter(fitler).getValue();
	}
	
	
	public CarportOutContact getCarportOutContact() {
		return carportOutContact;
	}

	public void setCarportOutContact(CarportOutContact carportOutContact) {
		this.carportOutContact = carportOutContact;
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

	public void setCarportOutContactService(CarportOutContactService carportOutContactService) {
		this.carportOutContactService = carportOutContactService;
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
