package com.wiiy.crm.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ContactResolveStatusEnum;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.crm.entity.InvestmentContact;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.entity.InvestmentInvestor;
import com.wiiy.crm.service.InvestmentContactService;
import com.wiiy.crm.service.InvestmentDirectorService;
import com.wiiy.crm.service.InvestmentInvestorService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class InvestmentContactAction extends JqGridBaseAction<InvestmentContact>{
	
	private InvestmentContactService investmentContactService;
	private InvestmentInvestorService investmentInvestorService;
	private InvestmentDirectorService investmentDirectorService;
	private Result result;
	private InvestmentContact investmentContact;
	private Long id;
	private Long receiveId;
	private String ids;
	private InvestmentDirector linkman;
	private List<InvestmentInvestor> investorList;
	private String approvalType;
	private String opinion;
	private ContactStatusEnum status;
	private ContactResolveStatusEnum resolveStatus;
	private String fileName;
	private InputStream inputStream;
	
	public String revoke(){
		InvestmentContact t = investmentContactService.getBeanById(id).getValue();
		result = investmentContactService.revoke(t);
		return JSON;
	}
	
	public String print(){
		fileName = StringUtil.URLEncoderToUTF8("招商项目审批联系单")+".doc";
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			investmentContactService.print(id, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "print";
	}
	
	public String send(){
		result = investmentContactService.send(id, receiveId, approvalType);
		return JSON;
	}
	
	public String approval(){
		result = investmentContactService.approval(approvalType,id,opinion);
		return JSON;
	}
	
	public String save(){
		Long userId = PbActivator.getSessionUser().getId();
		result = investmentContactService.save(investmentContact,userId);
		if(result.isSuccess()){
			id = ((InvestmentContact) result.getValue()).getId();
		}
		return JSON;
	}
	
	public String setStatus(){
		if(status == ContactStatusEnum.ACCEPT){
			result = investmentContactService.accept(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.CLOSE){
			result = investmentContactService.close(id, PbActivator.getSessionUser().getId());
		}else if(status == ContactStatusEnum.SUSPEND){
			result = investmentContactService.suspend(id, PbActivator.getSessionUser().getId());
		}
		
		return JSON;
	}
	
	public String setSolved(){
		if(resolveStatus == ContactResolveStatusEnum.SOLVED){
			result = investmentContactService.solved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.PARTSOLVED){
			result = investmentContactService.partsolved(id, PbActivator.getSessionUser().getId());
		}else if(resolveStatus == ContactResolveStatusEnum.UNSOLVED){
			result = investmentContactService.unSolved(id, PbActivator.getSessionUser().getId());
		}
		return JSON;
	}
	
	public String myView(){
		result = investmentContactService.getBeanById(id);
		Long linkmanId = ((InvestmentContact)result.getValue()).getLinkmanId();
		Long investmentId = ((InvestmentContact)result.getValue()).getInvestmentId();
		if(linkmanId!=null){
			linkman = investmentDirectorService.getBeanById(linkmanId).getValue();
		}
		investorList = investmentInvestorService.getListByFilter(new Filter(InvestmentInvestor.class).eq("investmentId", investmentId)).getValue();
		return "myView";
	}
	public String countersignView(){
		result = investmentContactService.getBeanById(id);
		Long linkmanId = ((InvestmentContact)result.getValue()).getLinkmanId();
		Long investmentId = ((InvestmentContact)result.getValue()).getInvestmentId();
		if(linkmanId!=null){
			linkman = investmentDirectorService.getBeanById(linkmanId).getValue();
		}
		investorList = investmentInvestorService.getListByFilter(new Filter(InvestmentInvestor.class).eq("investmentId", investmentId)).getValue();
		return "countersignView";
	}
	public String view(){
		result = investmentContactService.getBeanById(id);
		Long linkmanId = ((InvestmentContact)result.getValue()).getLinkmanId();
		Long investmentId = ((InvestmentContact)result.getValue()).getInvestmentId();
		if(linkmanId!=null){
			linkman = investmentDirectorService.getBeanById(linkmanId).getValue();
		}
		
		investorList = investmentInvestorService.getListByFilter(new Filter(InvestmentInvestor.class).eq("investmentId", investmentId)).getValue();
		return "view";
	}
	
	public String edit(){
		result = investmentContactService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentContact dbBean = investmentContactService.getBeanById(investmentContact.getId()).getValue();
		BeanUtil.copyProperties(investmentContact, dbBean);
		Long userId = PbActivator.getSessionUser().getId();
		result = investmentContactService.update(dbBean,userId);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentContactService.deleteById(id,ContactTypeEnum.INVESTMENTCONTACT);
		} else if(ids!=null){
			result = investmentContactService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(InvestmentContact.class));
	}
	
	@Override
	protected List<InvestmentContact> getListByFilter(Filter fitler) {
		return investmentContactService.getListByFilter(fitler).getValue();
	}
	
	
	public InvestmentContact getInvestmentContact() {
		return investmentContact;
	}

	public void setInvestmentContact(InvestmentContact investmentContact) {
		this.investmentContact = investmentContact;
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

	public void setInvestmentContactService(InvestmentContactService investmentContactService) {
		this.investmentContactService = investmentContactService;
	}
	
	public Result getResult() {
		return result;
	}

	public InvestmentDirector getLinkman() {
		return linkman;
	}

	public void setLinkman(InvestmentDirector linkman) {
		this.linkman = linkman;
	}

	public List<InvestmentInvestor> getInvestorList() {
		return investorList;
	}

	public void setInvestorList(List<InvestmentInvestor> investorList) {
		this.investorList = investorList;
	}

	public void setInvestmentInvestorService(InvestmentInvestorService investmentInvestorService) {
		this.investmentInvestorService = investmentInvestorService;
	}

	public void setInvestmentDirectorService(
			InvestmentDirectorService investmentDirectorService) {
		this.investmentDirectorService = investmentDirectorService;
	}

	public String getApprovalType() {
		return approvalType;
	}

	public void setApprovalType(String approvalType) {
		this.approvalType = approvalType;
	}

	public Long getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(Long receiveId) {
		this.receiveId = receiveId;
	}

	public String getOpinion() {
		return opinion;
	}

	public void setOpinion(String opinion) {
		this.opinion = opinion;
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
