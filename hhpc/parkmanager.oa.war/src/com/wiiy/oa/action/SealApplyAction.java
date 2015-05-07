package com.wiiy.oa.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.ApprovalDto;
import com.wiiy.oa.entity.SealApply;
import com.wiiy.oa.entity.SealApproval;
import com.wiiy.oa.preferences.enums.SealApprovalStatusEnum;
import com.wiiy.oa.service.SealApplyService;
import com.wiiy.oa.service.SealApprovalService;
import com.wiiy.oa.util.RemindUtil;

/**
 * @author my
 */
public class SealApplyAction extends JqGridBaseAction<SealApply>{
	
	private SealApplyService sealApplyService;
	private SealApprovalService sealApprovalService;
	private Result result;
	private SealApply sealApply;
	private Long id;
	private Long approverId;
	private String ids;
	
	private List<SealApproval> sealApprovalList;
	
	public String configApproval(){
		SealApproval approval = new SealApproval();
		approval.setApplyId(id);
		approval.setApproverId(approverId);
		approval.setApprover(ids);
		approval.setStatus(SealApprovalStatusEnum.PENDING);
		approval.setMemo("");
		result = sealApprovalService.save(approval);
		SealApply sealApply = sealApplyService.getBeanById(id).getValue();
		try {
			JSONArray array = JSONArray.fromObject(sealApply.getApprovals());
			array.add(JSONObject.fromObject(new ApprovalDto(approval.getId(),approval.getApprover(), approval.getStatus().getTitle())));
			sealApply.setApprovals(array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result.isSuccess()){
			User user = OaActivator.getUserById(approverId);
			sendMail(sealApply,user);
			SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
			if(smsPubService!=null && RemindUtil.smsActive("sealApplyRemind")){
				String receiverMobile = user.getMobile();
				String receiverName = user.getRealName();
				String content = OaActivator.getAppConfig().getConfig("sealApplyRemind").getParameter("smsModule");
				content = content.replace("${title}", sealApply.getName());
				RemindUtil.sendSms(receiverMobile,content,receiverName,smsPubService);
			}
		}
		sealApplyService.update(sealApply);
		return JSON;
	}
	
	private void sendMail(SealApply sealApply,User user){
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		if(sysEmailSenderPubService!=null && RemindUtil.emailActive("sealApplyRemind")){
			String content = "";
			StringBuffer data = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html");
			content = data.toString();
			String subject = "用印申请审批提醒";
			content = content.replace("${subject}", sealApply.getName());
			content = content.replace("${msgType}", "用印申请审批提醒");
			content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.pb/sealApply!view.action?id="+sealApply.getId());
			content = content.replace("${receiver}",  user.getRealName());
			content = content.replace("${customerName}", user.getRealName());
			content = content.replace("${sender}",sealApply.getApplicant());
			content = content.replace("${content}", sealApply.getContent());
			content = content.replace("${msgLink}", OaActivator.getHttpSessionService().getRemindEmailLink());
			RemindUtil.sendMail( user.getRealName(), user.getEmail(),subject,content,sysEmailSenderPubService);
		}
	}
	
	public String save(){
		sealApply.setApprovals("[]");
		result = sealApplyService.save(sealApply);
		return JSON;
	}
	
	public String view(){
		result = sealApplyService.getBeanById(id);
		sealApprovalList = sealApprovalService.getListByFilter(new Filter(SealApproval.class).eq("applyId", id)).getValue();
		return VIEW;
	}
	
	public String edit(){
		result = sealApplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SealApply dbBean = sealApplyService.getBeanById(sealApply.getId()).getValue();
		BeanUtil.copyProperties(sealApply, dbBean);
		result = sealApplyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = sealApplyService.deleteById(id);
		} else if(ids!=null){
			result = sealApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(SealApply.class));
	}
	
	@Override
	protected List<SealApply> getListByFilter(Filter fitler) {
		return sealApplyService.getListByFilter(fitler).getValue();
	}
	
	
	public SealApply getSealApply() {
		return sealApply;
	}

	public void setSealApply(SealApply sealApply) {
		this.sealApply = sealApply;
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

	public void setSealApplyService(SealApplyService sealApplyService) {
		this.sealApplyService = sealApplyService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setSealApprovalService(SealApprovalService sealApprovalService) {
		this.sealApprovalService = sealApprovalService;
	}

	public Long getApproverId() {
		return approverId;
	}

	public void setApproverId(Long approverId) {
		this.approverId = approverId;
	}

	public List<SealApproval> getSealApprovalList() {
		return sealApprovalList;
	}
}