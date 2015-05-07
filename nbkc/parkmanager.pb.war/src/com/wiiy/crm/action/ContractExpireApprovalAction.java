package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.service.export.ApprovalService;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractExpireApproval;
import com.wiiy.crm.entity.ContractExpireApprovalAtt;
import com.wiiy.core.entity.Countersign;
import com.wiiy.core.preferences.enums.CountersignDoneEnum;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.service.ContractExpireApprovalAttService;
import com.wiiy.crm.service.ContractExpireApprovalService;
import com.wiiy.crm.service.ContractService;
import com.wiiy.core.service.export.CountersignService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ContractExpireApprovalAction extends JqGridBaseAction<ContractExpireApproval>{
	
	private ContractExpireApprovalService contractExpireApprovalService;
	private CountersignService countersignService;
	private ContractService contractService;
	private ContractExpireApprovalAttService contractExpireApprovalAttService;
	
	private Result result;
	private ContractExpireApproval contractExpireApproval;
	private Contract contract;
	private Long id;
	private String ids;
	
	private List<ContractExpireApprovalAtt> attList;
	
	private static Long yetId;
	private Long prevId;
	
	private Pager pager;
	private String name;
	private String status;
	
	private String businessmanSuggestion;
	
	
	public String checkExist(){
		Filter filter = new Filter(ContractExpireApproval.class);
		result=contractExpireApprovalService.getBeanByFilter(filter.eq("contractId", id));
		if(result.getValue()!=null){
			result=Result.failure("已经发起过会签");
		}else{
			result=Result.success();
		}
		return JSON;
	}
	
	public String add(){
		contract=contractService.getBeanById(id).getValue();
		businessmanSuggestion=contractExpireApprovalService.setBusinessmanSuggestion(contract);
		return "add";
	}
	
	public String open(){
		ContractExpireApproval contractExpireApproval=contractExpireApprovalService.getBeanById(id).getValue();
		contractExpireApproval.setCountersignStatus(CountersignOpenEnum.UNDONE);
		result=contractExpireApprovalService.update(contractExpireApproval);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
			if(countersign!=null){
				countersign.setCountersignOpen(CountersignOpenEnum.UNDONE);
				result=countersignService.update(countersign);
			}
		return JSON;
	}
	
	public String close(){
		ContractExpireApproval contractExpireApproval=contractExpireApprovalService.getBeanById(id).getValue();
		contractExpireApproval.setCountersignStatus(CountersignOpenEnum.CLOSE);
		result=contractExpireApprovalService.update(contractExpireApproval);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
		if(countersign!=null){
			countersign.setCountersignOpen(CountersignOpenEnum.CLOSE);
				result=countersignService.update(countersign);
		}
	return JSON;
	}
	
	public String cwzjApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractExpireApprovalService.approval(id,userId,"cwzj");
		CountersignOpenEnum status=contractExpireApprovalService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.EXPIRE)).getValue();
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
	
	public String gcbApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractExpireApprovalService.approval(id,userId,"gcb");
		CountersignOpenEnum status=contractExpireApprovalService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.EXPIRE)).getValue();
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
	public String zjlApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractExpireApprovalService.approval(id,userId,"zjl");
		CountersignOpenEnum status=contractExpireApprovalService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.EXPIRE)).getValue();
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
	public String cwbApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractExpireApprovalService.approval(id,userId,"cwb");
		CountersignOpenEnum status=contractExpireApprovalService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.EXPIRE)).getValue();
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
	public String khApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = contractExpireApprovalService.approval(id,userId,"kh");
		CountersignOpenEnum status=contractExpireApprovalService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.EXPIRE)).getValue();
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
	
	public String businessmanSuggestion(){
		result = contractExpireApprovalService.getBeanById(id);
		return "businessmanSuggestion";
	}
	
	public String updateBusinessmanSuggestion(){
		ContractExpireApproval dbBean = contractExpireApprovalService.getBeanById(id).getValue();
		dbBean.setBusinessmanSuggestion(contractExpireApproval.getBusinessmanSuggestion());
		result = contractExpireApprovalService.update(dbBean);
		result.setMsg("招商人员意见保存成功");
		return JSON;
	}
	
	public String save(){
		contractExpireApproval.setCountersignStatus(CountersignOpenEnum.UNDONE);
		result = contractExpireApprovalService.save(contractExpireApproval);
		return JSON;
	}
	
	public String view(){
		yetId=id;		
		contractExpireApproval= contractExpireApprovalService.getBeanById(id).getValue();
		result = Result.value(contractExpireApproval);
		if(contractExpireApproval!=null){
		attList = new ArrayList<ContractExpireApprovalAtt>(contractExpireApproval.getAtts());
		Collections.sort(attList, new Comparator<ContractExpireApprovalAtt>() {
			@Override
			public int compare(ContractExpireApprovalAtt o1, ContractExpireApprovalAtt o2) {
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
		contractExpireApproval = contractExpireApprovalService.getBeanByFilter(new Filter(ContractExpireApproval.class).eq("id", id)).getValue();
		result=Result.value(contractExpireApproval);
		if(contractExpireApproval!=null){
			attList = new ArrayList<ContractExpireApprovalAtt>(contractExpireApproval.getAtts());
		Collections.sort(attList, new Comparator<ContractExpireApprovalAtt>() {
			@Override
			public int compare(ContractExpireApprovalAtt o1, ContractExpireApprovalAtt o2) {
				if(o1.getCreateTime()==null)return -1;
				if(o2.getCreateTime()==null)return 1;
				if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
				return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
			}
		});
		}
		return "expireView";
	}
	
	public String edit(){
		result = contractExpireApprovalService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractExpireApproval dbBean = contractExpireApprovalService.getBeanById(contractExpireApproval.getId()).getValue();
		BeanUtil.copyProperties(contractExpireApproval, dbBean);
		result = contractExpireApprovalService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractExpireApprovalService.deleteById(id);
		} else if(ids!=null){
			result = contractExpireApprovalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public Countersign setCountersign(long id,long userId,CountersignOpenEnum status){
		Countersign countersign=new Countersign();
		countersign.setCountersignId(id);
		countersign.setName("合同到期审批单");
		
		countersign.setCountersignOpen(status);
		countersign.setCountersignDone(CountersignDoneEnum.WAIT);
		countersign.setCountersignType(CountersignTypeEnum.EXPIRE);
		countersign.setUserId(userId);
		return countersign;
	}
	
	public String list(){
		Filter filter = createFilter();	
		setPager(filter);
		result = contractExpireApprovalService.getListByFilter(filter);
		return "list";
	}
	
	private Filter createFilter(){
		Filter filter = new Filter(ContractExpireApproval.class);
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
	protected List<ContractExpireApproval> getListByFilter(Filter fitler) {
		return contractExpireApprovalService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractExpireApproval getContractExpireApproval() {
		return contractExpireApproval;
	}

	public void setContractExpireApproval(ContractExpireApproval contractExpireApproval) {
		this.contractExpireApproval = contractExpireApproval;
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

	public void setContractExpireApprovalService(ContractExpireApprovalService contractExpireApprovalService) {
		this.contractExpireApprovalService = contractExpireApprovalService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setCountersignService(CountersignService countersignService) {
		this.countersignService = countersignService;
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

	public static Long getYetId() {
		return yetId;
	}

	public static void setYetId(Long yetId) {
		ContractExpireApprovalAction.yetId = yetId;
	}

	public Long getPrevId() {
		return prevId;
	}

	public void setPrevId(Long prevId) {
		this.prevId = prevId;
	}

	public List<ContractExpireApprovalAtt> getAttList() {
		return attList;
	}

	public void setAttList(List<ContractExpireApprovalAtt> attList) {
		this.attList = attList;
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

	public String getBusinessmanSuggestion() {
		return businessmanSuggestion;
	}

	public void setBusinessmanSuggestion(String businessmanSuggestion) {
		this.businessmanSuggestion = businessmanSuggestion;
	}

	public void setContractExpireApprovalAttService(
			ContractExpireApprovalAttService contractExpireApprovalAttService) {
		this.contractExpireApprovalAttService = contractExpireApprovalAttService;
	}

	
	
}
