package com.wiiy.core.action;

import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.ApprovalService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ApprovalAction extends JqGridBaseAction<Approval>{
	
	private ApprovalService approvalService;
	private Result result;
	private Approval approval;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = approvalService.save(approval);
		return JSON;
	}
	
	public String view(){
		result = approvalService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = approvalService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Approval dbBean = approvalService.getBeanById(approval.getId()).getValue();
		BeanUtil.copyProperties(approval, dbBean);
		dbBean.setApprovalTime(new Date());
		result = approvalService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = approvalService.deleteById(id);
		} else if(ids!=null){
			result = approvalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String consoleList(){
		result = approvalService.getListByFilter(new Filter(Approval.class).eq("status", ApprovalStatusEnum.UNDETERMINED).eq("userId", CoreActivator.getSessionUser().getId()).orderBy("createTime", Filter.DESC).maxResults(5));
		return "consoleList";
	}
	
	public String list(){
		Filter filter = new Filter(Approval.class);
		String groupId = ServletActionContext.getRequest().getParameter("groupId");
		if(groupId!=null){
			filter.eq("groupId", Long.valueOf(groupId));
		}
		String type = ServletActionContext.getRequest().getParameter("type");
		if(type!=null){
			filter.eq("type", ApprovalTypeEnum.valueOf(type));
		}
		return refresh(filter);
	}
	
	/**
	 * 合同会签审批列表
	 * @return
	 */
	public String listContractApproval(){
		Filter filter = new Filter(Approval.class);
		String groupId = ServletActionContext.getRequest().getParameter("groupId");
		String[] groupIds = groupId.split(",");
		if(!groupIds[0].equals("null") && !groupIds[1].equals("null")){
			filter.or((Filter.And(Filter.Eq("groupId", Long.valueOf(groupIds[0])), Filter.Eq("type", ApprovalTypeEnum.EXPIRE))),(Filter.And(Filter.Eq("groupId", Long.valueOf(groupIds[1])), Filter.Eq("type", ApprovalTypeEnum.REVIEW))));
		}else if(!groupIds[0].equals("null") && groupIds[1].equals("null")){
			filter.eq("groupId", Long.valueOf(groupIds[0])).eq("type", ApprovalTypeEnum.EXPIRE);
		}else if(groupIds[0].equals("null") && !groupIds[1].equals("null")){
			filter.eq("groupId", Long.valueOf(groupIds[1])).eq("type", ApprovalTypeEnum.REVIEW);
		}else{
			return JSON;
		}
		
		return refresh(filter);
	}

	@Override
	protected List<Approval> getListByFilter(Filter fitler) {
		return approvalService.getListByFilter(fitler).getValue();
	}
	
	
	public Approval getApproval() {
		return approval;
	}

	public void setApproval(Approval approval) {
		this.approval = approval;
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

	public void setApprovalService(ApprovalService approvalService) {
		this.approvalService = approvalService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
