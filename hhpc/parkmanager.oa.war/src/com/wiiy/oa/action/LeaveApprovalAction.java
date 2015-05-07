package com.wiiy.oa.action;

import java.util.List;

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
import com.wiiy.oa.entity.LeaveApproval;
import com.wiiy.oa.entity.LeaveRegister;
import com.wiiy.oa.preferences.enums.LeaveApprovalStatusEnum;
import com.wiiy.oa.service.LeaveApprovalService;
import com.wiiy.oa.service.LeaveRegisterService;
import com.wiiy.oa.util.RemindUtil;
import com.wiiy.oa.util.ScheduleUtil;

public class LeaveApprovalAction extends JqGridBaseAction<LeaveApproval>{
	private LeaveApprovalService leaveApprovalService;;
	private LeaveRegisterService leaveRegisterService;
	private LeaveApproval leaveApproval;
	private Long id;
	private String ids;
	private Result result;
	private String approver;
	private Long applyId;
	private Long approverId;
	private Integer day;
	
	private List<LeaveApproval> leaveApprovalList;
	
	public String listById(){
		Filter filter = new Filter(LeaveApproval.class).eq("approverId", OaActivator.getSessionUser().getId());
		return refresh(filter);
	}
	
	public String save(){
		result = leaveApprovalService.save(leaveApproval);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = leaveApprovalService.deleteById(id);
		}
		if(ids!=null){
			result = leaveApprovalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		leaveApproval = leaveApprovalService.getBeanById(id).getValue();
		leaveApprovalList = leaveApprovalService.getListByFilter(new Filter(LeaveApproval.class).eq("applyId", leaveApproval.getApplyId()).ne("id", id).ne("status", LeaveApprovalStatusEnum.PENDING)).getValue();
		day = ScheduleUtil.getDiffDays(leaveApproval.getApply().getStartTime(),leaveApproval.getApply().getEndTime());
		return EDIT;
	}
	
	public String update(){
		LeaveApproval dbean = leaveApprovalService.getBeanById(leaveApproval.getId()).getValue();
		BeanUtil.copyProperties(leaveApproval, dbean);
		result = leaveApprovalService.update(dbean);
		LeaveRegister leaveRegister = leaveRegisterService.getBeanById(dbean.getApplyId()).getValue();
		try {
			JSONArray array = JSONArray.fromObject(leaveRegister.getApprovals());
			for (int i = 0; i < array.size(); i++) {
				JSONObject jsonObject = array.getJSONObject(i);
				if(jsonObject.getLong("id")==leaveApproval.getId().longValue()){
					jsonObject.put("status", leaveApproval.getStatus().getTitle());
				}
			}
			leaveRegister.setApprovals(array.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*if(leaveApproval.getStatus()!=null && leaveApproval.getStatus() != LeaveApprovalStatusEnum.PENDING){
			sendMail(leaveRegister);
		}*/
		leaveRegisterService.update(leaveRegister);
		return JSON;
	}
	
	/*public void sendMail(LeaveRegister leaveRegister){
		User user = OaActivator.getUserById(leaveRegister.getCreatorId());
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		String content = OaActivator.getAppConfig().getConfig("leaveApprovalRemind").getParameter("email");
		content = content.replace("${applicant}", leaveRegister.getApplicant());
		String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
		String url = path+"parkmanager.oa/leaveRegister!view.action?id="+leaveRegister.getId();
		content = content.replace("${url}", url);
		String subject = "请假登记提醒";
		if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(user.getEmail(), content,subject);
	}*/
	
	//送审
	public String approve(){
		leaveApproval = new LeaveApproval();
		leaveApproval.setApplyId(applyId);
		leaveApproval.setApprover(approver);
		leaveApproval.setApproverId(approverId);
		result = leaveApprovalService.save(leaveApproval);
		LeaveRegister leaveRegister = leaveRegisterService.getBeanById(applyId).getValue();
		
		JSONArray array = JSONArray.fromObject(leaveRegister.getApprovals());
		array.add(JSONObject.fromObject(new ApprovalDto(leaveApproval.getId(),leaveApproval.getApprover(), leaveApproval.getStatus().getTitle())));
		leaveRegister.setApprovals(array.toString());
		if(result.isSuccess()){
			User user = OaActivator.getUserById(approverId);
			if(RemindUtil.emailActive("leaveApplyRemind")){
				sendMail(leaveRegister,user);
			}
			if(RemindUtil.smsActive("leaveApplyRemind")){
				SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
				if(smsPubService!=null && RemindUtil.smsActive("sealApplyRemind")){
					String receiverMobile = user.getMobile();
					String receiverName = user.getRealName();
					String content = OaActivator.getAppConfig().getConfig("sealApplyRemind").getParameter("smsModule");
					content = content.replace("${title}", leaveRegister.getLeaveType().getTitle());
					RemindUtil.sendSms(receiverMobile,content,receiverName,smsPubService);
				}
			}
		}
		leaveRegisterService.update(leaveRegister);
		return JSON;
	}
	
	
	private void sendMail(LeaveRegister leaveRegister, User user) {
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		if(sysEmailSenderPubService!=null ){
			String content = "";
			StringBuffer data = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html");
			content = data.toString();
			String subject = "请假申请审批提醒";
			content = content.replace("${subject}", leaveRegister.getLeaveType().getTitle());
			content = content.replace("${msgType}", "请假申请审批提醒");
			content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.oa/leaveRegister!view.action?id="+leaveRegister.getId());
			content = content.replace("${receiver}",  user.getRealName());
			content = content.replace("${customerName}", user.getRealName());
			content = content.replace("${sender}",leaveRegister.getApplicant());
			content = content.replace("${content}", leaveRegister.getMemo());
			content = content.replace("${msgLink}", OaActivator.getHttpSessionService().getRemindEmailLink());
			RemindUtil.sendMail( user.getRealName(), user.getEmail(),subject,content,sysEmailSenderPubService);
		}
	}
	
	public String approveView(){
		leaveApproval = leaveApprovalService.getBeanById(id).getValue();
		
		return "";
	}
	
	//审核
	public String examine(){
		return JSON;
	}
	
	@Override
	protected List<LeaveApproval> getListByFilter(Filter filter) {
		return leaveApprovalService.getListByFilter(filter).getValue();
	}
	
	public LeaveApproval getLeaveApproval() {
		return leaveApproval;
	}

	public void setLeaveApproval(LeaveApproval leaveApproval) {
		this.leaveApproval = leaveApproval;
	}

	public void setLeaveApprovalService(LeaveApprovalService leaveApprovalService) {
		this.leaveApprovalService = leaveApprovalService;
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
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public Long getApplyId() {
		return applyId;
	}

	public void setApplyId(Long applyId) {
		this.applyId = applyId;
	}

	public Long getApproverId() {
		return approverId;
	}

	public void setApproverId(Long approverId) {
		this.approverId = approverId;
	}

	public void setLeaveRegisterService(LeaveRegisterService leaveRegisterService) {
		this.leaveRegisterService = leaveRegisterService;
	}

	public List<LeaveApproval> getLeaveApprovalList() {
		return leaveApprovalList;
	}

	public void setLeaveApprovalList(List<LeaveApproval> leaveApprovalList) {
		this.leaveApprovalList = leaveApprovalList;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

}
