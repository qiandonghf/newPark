package com.wiiy.crm.action;


import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.export.ApprovalService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;



import com.wiiy.core.entity.Countersign;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentProcess;
import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.core.preferences.enums.CountersignDoneEnum;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.core.service.export.CountersignService;
import com.wiiy.crm.service.InvestmentProcessAttService;
import com.wiiy.crm.service.InvestmentProcessService;
import com.wiiy.crm.service.InvestmentService;

/**
 * @author my
 */
public class InvestmentProcessAction extends JqGridBaseAction<InvestmentProcess>{
	
	private InvestmentProcessService investmentProcessService;
	private InvestmentProcessAttService investmentProcessAttService;
	private CountersignService countersignService;
	private InvestmentService investmentService;
	
	private Result result;
	private InvestmentProcess investmentProcess;
	private Investment investment;
	private Long id;
	private String ids;
	
	private List<InvestmentProcessAtt> attList;

	private static Long yetId;
	private Long prevId;
		
	private Pager pager;
	private String processViewTYPE;
	private String name;
	private String status;
	
	private String fileName;
	private InputStream inputStream;
	
	public String checkExist(){
		result=investmentProcessService.getBeanByFilter(new Filter(InvestmentProcess.class).eq("investmentId",id));
		if(result.getValue()!=null){
			result = Result.failure("会签已存在");
		}else{
			result=Result.success();
		}
		return JSON;
	}
	
	public String add(){
		result=investmentService.getBeanById(id);
		return "add";
	}
	
	public String open(){
		InvestmentProcess investmentProcess=investmentProcessService.getBeanById(id).getValue();
		investmentProcess.setCountersignStatus(CountersignOpenEnum.UNDONE);
		result=investmentProcessService.update(investmentProcess);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
			if(countersign!=null){
				countersign.setCountersignOpen(CountersignOpenEnum.UNDONE);
				result=countersignService.update(countersign);
			}
		return JSON;
	}
	
	public String close(){
		InvestmentProcess investmentProcess=investmentProcessService.getBeanById(id).getValue();
		investmentProcess.setCountersignStatus(CountersignOpenEnum.CLOSE);
		result=investmentProcessService.update(investmentProcess);
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("countersignId",id)).getValue();
		if(countersign!=null){
			countersign.setCountersignOpen(CountersignOpenEnum.CLOSE);
				result=countersignService.update(countersign);
		}
	return JSON;
	}
	
//	public String print() {
//		fileName = StringUtil.URLEncoderToUTF8("基本信息")+".doc";
//		try {
//			ByteArrayOutputStream out = new ByteArrayOutputStream();
//			investmentProcessService.print(id, out);
//			inputStream = new ByteArrayInputStream(out.toByteArray());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return "print";
//	}
	
	public String businessmanSuggestion(){
		result = investmentProcessService.getBeanById(id);
		return "businessmanSuggestion";
	}
	
	public String updateBusinessmanSuggestion(){
		InvestmentProcess dbBean = investmentProcessService.getBeanById(id).getValue();
		dbBean.setBusinessmanSuggestion(investmentProcess.getBusinessmanSuggestion());
		result = investmentProcessService.update(dbBean);
		result.setMsg("招商人员意见保存成功");
		return JSON;
	}
	
	public String cwbApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = investmentProcessService.approval(id,userId,"cwb");
		CountersignOpenEnum status=investmentProcessService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.PROCESS)).getValue();
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
		result = investmentProcessService.approval(id,userId,"gcb");
		CountersignOpenEnum status=investmentProcessService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.PROCESS)).getValue();
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

	public String rzqyApproval(){
		Long userId = Long.parseLong(ServletActionContext.getRequest().getParameter("userId"));
		result = investmentProcessService.approval(id,userId,"rzqy");
		CountersignOpenEnum status=investmentProcessService.getBeanById(id).getValue().getCountersignStatus();
		Countersign countersign=countersignService.getBeanByFilter(new Filter(Countersign.class).eq("userId",userId).eq("countersignId",id).eq("countersignType",CountersignTypeEnum.PROCESS)).getValue();
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
		countersign.setName("入驻企业流程单");
		
		countersign.setCountersignOpen(status);
		countersign.setCountersignDone(CountersignDoneEnum.WAIT);
		countersign.setCountersignType(CountersignTypeEnum.PROCESS);
		countersign.setUserId(userId);
		return countersign;
	}
	public String save(){
		prevId=yetId;
		result = investmentProcessService.save(investmentProcess);
		return JSON;
	}
	
	public String view(){	
		yetId=id;		
		investmentProcess= investmentProcessService.getBeanById(id).getValue();
		result = Result.value(investmentProcess);
		if(investmentProcess!=null){
			Investment investment = investmentService.getBeanById(investmentProcess.getInvestmentId()).getValue();
		attList = new ArrayList<InvestmentProcessAtt>(investment.getAtts());
		Collections.sort(attList, new Comparator<InvestmentProcessAtt>() {
			@Override
			public int compare(InvestmentProcessAtt o1, InvestmentProcessAtt o2) {
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
		investmentProcess=investmentProcessService.getBeanByFilter(new Filter(InvestmentProcess.class).eq("id", id)).getValue();
		result=Result.value(investmentProcess);
		if(investmentProcess!=null){
			Investment investment = investmentService.getBeanById(investmentProcess.getInvestmentId()).getValue();
			attList = new ArrayList<InvestmentProcessAtt>(investment.getAtts());
		Collections.sort(attList, new Comparator<InvestmentProcessAtt>() {
			@Override
			public int compare(InvestmentProcessAtt o1, InvestmentProcessAtt o2) {
				if(o1.getCreateTime()==null)return -1;
				if(o2.getCreateTime()==null)return 1;
				if(o1.getCreateTime().getTime()==o2.getCreateTime().getTime())return 0;
				return o1.getCreateTime().getTime()>o2.getCreateTime().getTime() ? 1 : -1;
			}
		});
		}
		return "processView";
		
	}
	
//	public String approvalView(){
//		result = investmentProcessService.getBeanById(id);
//		if(processViewTYPE.equals("all")){
//			return "approvalView";
//		}else{
//			return "waitApprovalView";
//		}
//		
//		
//	}
	
	
	
	public String edit(){
		result = investmentProcessService.getBeanById(id);
		return EDIT;
	}
	
	
	public String update(){
		InvestmentProcess dbBean = investmentProcessService.getBeanById(investmentProcess.getId()).getValue();
		BeanUtil.copyProperties(investmentProcess, dbBean);
		result = investmentProcessService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null&&yetId!=id){
			result = investmentProcessService.deleteById(id);
			prevId = yetId;
			id=null;
		}else if(id!=null&&yetId==id){
			result = investmentProcessService.deleteById(id);
			prevId=id=yetId=null;
		}else if(ids!=null){
			result = investmentProcessService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = createFilter();	
		setPager(filter);
		result = investmentProcessService.getListByFilter(filter);
		return "list";
	}
	public String waitList(){
		Filter filter = createFilter();
		filter.or(filter.NotNull("cwbApprovalId"), filter.NotNull("gcbApprovalId"), filter.NotNull("rzqyApprovalId"));	
		filter.eq("creatorId", PbActivator.getSessionUser().getId());
		setPager(filter);
		result = investmentProcessService.getListByFilter(filter);
		return "waitList";
	}
	private Filter createFilter(){
		Filter filter = new Filter(InvestmentProcess.class);
		if(name!=null && name.length()>0){
			name = StringUtil.ISOToUTF8(name);
			filter.like("name", name);
		}
		if(status!=null && status.length()>0){
//			System.out.println(status);
//			if(CountersignOpenEnum.CLOSE.toString().equals(status)){
//				filter.eq("countersignStatus", CountersignOpenEnum.CLOSE);
//			}else if(CountersignOpenEnum.UNDONE.toString().equals(status)){
//				filter.eq("countersignStatus", CountersignOpenEnum.UNDONE);
//			}
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
	protected List<InvestmentProcess> getListByFilter(Filter fitler) {
		return investmentProcessService.getListByFilter(fitler).getValue();
	}
	
	
	public InvestmentProcess getInvestmentProcess() {
		return investmentProcess;
	}

	public void setInvestmentProcess(InvestmentProcess investmentProcess) {
		this.investmentProcess = investmentProcess;
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

	public void setInvestmentProcessService(InvestmentProcessService investmentProcessService) {
		this.investmentProcessService = investmentProcessService;
	}
	
	public Result getResult() {
		return result;
	}

	public static Long getYetId() {
		return yetId;
	}

	public static void setYetId(Long yetId) {
		InvestmentProcessAction.yetId = yetId;
	}

	public Long getPrevId() {
		return prevId;
	}

	public void setPrevId(Long prevId) {
		this.prevId = prevId;
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


	public String getProcessViewTYPE() {
		return processViewTYPE;
	}

	public void setProcessViewTYPE(String processViewTYPE) {
		this.processViewTYPE = processViewTYPE;
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

	public List<InvestmentProcessAtt> getAttList() {
		return attList;
	}

	public void setAttList(List<InvestmentProcessAtt> attList) {
		this.attList = attList;
	}

	public void setInvestmentService(InvestmentService investmentService) {
		this.investmentService = investmentService;
	}

	public Investment getInvestment() {
		return investment;
	}

	public void setInvestment(Investment investment) {
		this.investment = investment;
	}

	public void setInvestmentProcessAttService(
			InvestmentProcessAttService investmentProcessAttService) {
		this.investmentProcessAttService = investmentProcessAttService;
	}


	


}
