package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.service.export.ApprovalService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractReview;
import com.wiiy.crm.entity.ContractReviewAtt;
import com.wiiy.core.entity.Countersign;
import com.wiiy.core.preferences.enums.CountersignDoneEnum;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.service.ContractReviewAttService;
import com.wiiy.crm.service.ContractReviewService;
import com.wiiy.crm.service.ContractService;
import com.wiiy.core.service.export.CountersignService;

/**
 * @author my
 */
public class ContractReviewAction extends JqGridBaseAction<ContractReview>{
	
	private ContractReviewService contractReviewService;
	private ContractReviewAttService contractReviewAttService;
	private CountersignService countersignService;
	private ContractService contractService;
	
	private Result result;
	private ContractReview contractReview;
	private Contract contract;
	private Long id;
	private String ids;
	
	private List<ContractReviewAtt> attList;
	 
	private static Long yetId;
	private Long prevId;
	
	private Pager pager;
	private String name;
	private String status;
	
	
	public String checkExist(){
		Filter filter = new Filter(ContractReview.class);
		result=contractReviewService.getBeanByFilter(filter.eq("contractId", id));
		if(result.getValue()!=null){
			result=Result.failure("已经发起过会签");
		}else{
		    contract=contractService.getBeanById(id).getValue();
			ContractReview contractReview = new ContractReview();
			contractReview.setCountersignStatus(CountersignOpenEnum.UNDONE);
			contractReview.setContractId(id);
			contractReview.setContract(contract);
			contractReview.setContractNo(contract.getContractNo());
			contractReview.setDate(new Date());
			contractReview.setDepartment("招商部");
			result = contractReviewService.save(contractReview);
			contract=null;
		}
		return JSON;
	}
	
	public String add(){
		contract=contractService.getBeanById(id).getValue();
		return "add";
	}
	
	public String open(){
		ContractReview contractReview=contractReviewService.getBeanById(id).getValue();
		contractReview.setCountersignStatus(CountersignOpenEnum.UNDONE);
		result=contractReviewService.update(contractReview);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
			if(countersign!=null){
				countersign.setCountersignOpen(CountersignOpenEnum.UNDONE);
				result=countersignService.update(countersign);
			}
		return JSON;
	}
	
	public String close(){
		ContractReview contractReview=contractReviewService.getBeanById(id).getValue();
		contractReview.setCountersignStatus(CountersignOpenEnum.CLOSE);
		result=contractReviewService.update(contractReview);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
		if(countersign!=null){
			countersign.setCountersignOpen(CountersignOpenEnum.CLOSE);
				result=countersignService.update(countersign);
		}
	return JSON;
	}
	
	public String jbApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractReviewService.approval(id,userId,"jb");
		CountersignOpenEnum status=contractReviewService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.REVIEW)).getValue();
		if(countersign!=null){
			if(result.isSuccess()){
				countersign.setCountersignDone(CountersignDoneEnum.WAIT);
				countersignService.update(countersign);
			}
			return JSON;
		}else{
		countersign=setCountersign(id,userId,status);		
		countersignService.save(countersign);
		}
		return JSON;
	}
	public String spApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractReviewService.approval(id,userId,"sp");
		CountersignOpenEnum status=contractReviewService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.REVIEW)).getValue();
		if(countersign!=null){
			if(result.isSuccess()){
				countersign.setCountersignDone(CountersignDoneEnum.WAIT);
				countersignService.update(countersign);
			}
			return JSON;
		}else{
		countersign=setCountersign(id,userId,status);		
		countersignService.save(countersign);
		}
		return JSON;
	}
	public String shApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractReviewService.approval(id,userId,"sh");
		CountersignOpenEnum status=contractReviewService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.REVIEW)).getValue();
		if(countersign!=null){
			if(result.isSuccess()){
				countersign.setCountersignDone(CountersignDoneEnum.WAIT);
				countersignService.update(countersign);
			}
			return JSON;
		}else{
		countersign=setCountersign(id,userId,status);		
		countersignService.save(countersign);
		}
		return JSON;
	}
	public String hqApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractReviewService.approval(id,userId,"hq");
		CountersignOpenEnum status=contractReviewService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.REVIEW)).getValue();
		if(countersign!=null){
			if(result.isSuccess()){
				countersign.setCountersignDone(CountersignDoneEnum.WAIT);
				countersignService.update(countersign);
			}
			return JSON;
		}else{
		countersign=setCountersign(id,userId,status);		
		countersignService.save(countersign);
		}
		return JSON;
	}
	public Countersign setCountersign(long id,long userId,CountersignOpenEnum status){
		Countersign countersign=new Countersign();
		countersign.setCountersignId(id);
		countersign.setName("合同会签审核单");
		
		countersign.setCountersignOpen(status);
		countersign.setCountersignDone(CountersignDoneEnum.WAIT);
		countersign.setCountersignType(CountersignTypeEnum.REVIEW);
		countersign.setUserId(userId);
		return countersign;
	}
	public String save(){
		contractReview.setCountersignStatus(CountersignOpenEnum.UNDONE);
		result = contractReviewService.save(contractReview);
		return JSON;
	}
	
	public String view(){
		yetId=id;		
		contractReview= contractReviewService.getBeanById(id).getValue();
		result = Result.value(contractReview);
		if(contractReview!=null){
		attList = new ArrayList<ContractReviewAtt>(contractReview.getAtts());
		Collections.sort(attList, new Comparator<ContractReviewAtt>() {
			@Override
			public int compare(ContractReviewAtt o1, ContractReviewAtt o2) {
				if(o1.getCreateTime()==null)return -1;
				if(o2.getCreateTime()==null)return 1;
				if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
				return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
			}
		});
		}
		return VIEW;
	}
	
	public String countersignView(){
		contractReview= contractReviewService.getBeanByFilter(new Filter(ContractReview.class).eq("id", id)).getValue();
		result=Result.value(contractReview);
		if(contractReview!=null){
			attList = new ArrayList<ContractReviewAtt>(contractReview.getAtts());
		Collections.sort(attList, new Comparator<ContractReviewAtt>() {
			@Override
			public int compare(ContractReviewAtt o1, ContractReviewAtt o2) {
				if(o1.getCreateTime()==null)return -1;
				if(o2.getCreateTime()==null)return 1;
				if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
				return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
			}
		});
		}
		return "reviewView";
	}
	
	public String edit(){
		result = contractReviewService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractReview dbBean = contractReviewService.getBeanById(contractReview.getId()).getValue();
		BeanUtil.copyProperties(contractReview, dbBean);
		result = contractReviewService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractReviewService.deleteById(id);
		} else if(ids!=null){
			result = contractReviewService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = createFilter();	
		setPager(filter);
		result = contractReviewService.getListByFilter(filter);
		return "list";
	}
	
	private Filter createFilter(){
		Filter filter = new Filter(ContractReview.class);
		if(name!=null && name.length()>0){
			name = StringUtil.ISOToUTF8(name);
			filter.createAlias("contract", "contract");
			filter.like("contract.name", name);			
		}
		if(status!=null && status.length()>0){
			status = StringUtil.ISOToUTF8(status);
			filter.eq("countersignStatus", status);
		}
		return filter;
	}
	
	private void setPager(Filter filter){
		if(page!=0){
			pager = new Pager(page,15);
		} else {
			pager = new Pager(1,15);
		}
		filter.pager(pager);
	}
	
	@Override
	protected List<ContractReview> getListByFilter(Filter fitler) {
		return contractReviewService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractReview getContractReview() {
		return contractReview;
	}

	public void setContractReview(ContractReview contractReview) {
		this.contractReview = contractReview;
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

	public void setContractReviewService(ContractReviewService contractReviewService) {
		this.contractReviewService = contractReviewService;
	}
	
	public Result getResult() {
		return result;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setCountersignService(CountersignService countersignService) {
		this.countersignService = countersignService;
	}

	public List<ContractReviewAtt> getAttList() {
		return attList;
	}

	public void setAttList(List<ContractReviewAtt> attList) {
		this.attList = attList;
	}

	public static Long getYetId() {
		return yetId;
	}

	public static void setYetId(Long yetId) {
		ContractReviewAction.yetId = yetId;
	}

	public Long getPrevId() {
		return prevId;
	}

	public void setPrevId(Long prevId) {
		this.prevId = prevId;
	}

	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public void setContractReviewAttService(
			ContractReviewAttService contractReviewAttService) {
		this.contractReviewAttService = contractReviewAttService;
	}

	
}
