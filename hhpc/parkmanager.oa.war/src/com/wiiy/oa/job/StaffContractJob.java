package com.wiiy.oa.job;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Archives;
import com.wiiy.oa.job.RepeatJob.JobTask;
import com.wiiy.oa.preferences.enums.PositionConditionEnum;
import com.wiiy.oa.service.ArchivesService;
import com.wiiy.oa.util.RemindUtil;

public class StaffContractJob extends RepeatJob{
	
	private ArchivesService archivesService;
	
	private List<Archives> list;
	
	public StaffContractJob(ApplicationContext applicationContext) {
		super(applicationContext);
		archivesService = applicationContext.getBean(ArchivesService.class);
	}
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	@Override
	protected void execute() {
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		if(sysEmailSenderPubService!=null && RemindUtil.emailActive("staffContractRemind")){
			list = archivesService.getListByFilter(new Filter(Archives.class).eq("status", PositionConditionEnum.WORK).le("endTime", CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 7).getTime())).getValue();
			String[] receiverEmail = new String[]{};
			String[] content = new String[]{};
			int i=0,j=0;
			String subject = "员工合同到期提醒";
			for (Archives archives : list) {
				if(archives.getCreatorId()!=null){
					receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
					content = Arrays.copyOf(content, content.length+1);
					User user = OaActivator.getUserById(archives.getCreatorId());
					receiverEmail[i] = user.getEmail();
					content[j] = "";
					content[j] = formContent(content[j],archives,user);
					i++;j++;
				}
			}
			sysEmailSenderPubService.send(receiverEmail, content,subject);
		}
		SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
		if(smsPubService!=null && RemindUtil.smsActive("staffContractRemind")){
			if(list==null){
				list = archivesService.getListByFilter(new Filter(Archives.class).eq("status", PositionConditionEnum.WORK).le("endTime", CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 7))).getValue();
			}
			String[] receiverMobile = new String[]{};
			String[] receiverName = new String[]{};
			String[] content = new String[]{};
			int i=0,j=0,k=0;
			for (Archives archives : list) {
				if(archives.getCreatorId()!=null){
					receiverMobile = Arrays.copyOf(receiverMobile, receiverMobile.length+1);
					receiverName = Arrays.copyOf(receiverName, receiverName.length+1);
					content = Arrays.copyOf(content, content.length+1);
					User user = OaActivator.getUserById(archives.getCreatorId());
					receiverMobile[i] = user.getMobile();
					content[j] = OaActivator.getAppConfig().getConfig("staffContractRemind").getParameter("smsModule");
					content[j] = content[j].replace("${title}", archives.getName()+"的合同即将到期");
					receiverName[k] = user.getRealName();
					i++;j++;k++;
				}
			}
			smsPubService.sendByAdmin(receiverMobile, content, receiverName);
		}
	}
	
	private String formContent(String content,Archives archives,User user){
		//邮件负责人
		User user2 = OaActivator.getUserById(Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name")));
		content = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html").toString();
		content = content.replace("${subject}", "员工合同到期提醒");
		content = content.replace("${msgType}", "员工合同到期提醒");
		content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.oa/archives!view.action?id="+archives.getId());
		content = content.replace("${receiver}", user.getRealName());
		content = content.replace("${customerName}", user.getRealName());
		content = content.replace("${sender}", user2.getRealName());
		content = content.replace("${content}", archives.getName()+"的合同即将到期");
		content = content.replace("${msgLink}", OaActivator.getHttpSessionService().getRemindEmailLink());
		return content;
	}
}