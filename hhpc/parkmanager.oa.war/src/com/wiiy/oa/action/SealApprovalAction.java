package com.wiiy.oa.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.SealApply;
import com.wiiy.oa.entity.SealApproval;
import com.wiiy.oa.preferences.enums.SealApprovalStatusEnum;
import com.wiiy.oa.service.SealApplyService;
import com.wiiy.oa.service.SealApprovalService;

/**
 * @author my
 */
public class SealApprovalAction extends JqGridBaseAction<SealApproval>{
	
	private SealApprovalService sealApprovalService;
	private SealApplyService sealApplyService;
	private Result result;
	private SealApproval sealApproval;
	private List<SealApproval> sealApprovalList;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = sealApprovalService.save(sealApproval);
		return JSON;
	}
	
	public String view(){
		result = sealApprovalService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		sealApproval = sealApprovalService.getBeanById(id).getValue();
		sealApprovalList = sealApprovalService.getListByFilter(new Filter(SealApproval.class).ne("status", SealApprovalStatusEnum.PENDING).eq("applyId", sealApproval.getApplyId()).ne("id", id)).getValue();
		result = Result.value(sealApproval);
		return EDIT;
	}
	
	public String update(){
		SealApproval dbBean = sealApprovalService.getBeanById(sealApproval.getId()).getValue();
		BeanUtil.copyProperties(sealApproval, dbBean);
		result = sealApprovalService.update(dbBean);
		SealApply sealApply = sealApplyService.getBeanById(dbBean.getApplyId()).getValue();
		try {
			JSONArray array = JSONArray.fromObject(sealApply.getApprovals());
			for (int i = 0; i < array.size(); i++) {
				JSONObject jsonObject = array.getJSONObject(i);
				if(jsonObject.getLong("id")==sealApproval.getId().longValue()){
					jsonObject.put("status", sealApproval.getStatus().getTitle());
				}
			}
			sealApply.setApprovals(array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(sealApproval.getStatus()!=null && sealApproval.getStatus() != SealApprovalStatusEnum.PENDING){
			sendMail(sealApply);
		}
		sealApplyService.update(sealApply);
		return JSON;
	}
	
	public void sendMail(SealApply sealApply){
		User user = OaActivator.getUserById(sealApply.getCreatorId());
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		String content = OaActivator.getAppConfig().getConfig("sealApprovalRemind").getParameter("email");
		content = content.replace("${applicant}", sealApply.getApplicant());
		content = content.replace("${project}", sealApply.getProject());
		String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
		String url = path+"parkmanager.oa/sealApply!view.action?id="+sealApply.getId();
		content = content.replace("${url}", url);
		String subject = "用印申请审批完成提醒";
		if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(user.getEmail(), content,subject);
	}
	
	public String delete(){
		if(id!=null){
			result = sealApprovalService.deleteById(id);
		} else if(ids!=null){
			result = sealApprovalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(SealApproval.class));
	}
	
	@Override
	protected List<SealApproval> getListByFilter(Filter fitler) {
		return sealApprovalService.getListByFilter(fitler).getValue();
	}
	
	
	public SealApproval getSealApproval() {
		return sealApproval;
	}

	public void setSealApproval(SealApproval sealApproval) {
		this.sealApproval = sealApproval;
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

	public void setSealApprovalService(SealApprovalService sealApprovalService) {
		this.sealApprovalService = sealApprovalService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<SealApproval> getSealApprovalList() {
		return sealApprovalList;
	}

	public void setSealApplyService(SealApplyService sealApplyService) {
		this.sealApplyService = sealApplyService;
	}
	
}
