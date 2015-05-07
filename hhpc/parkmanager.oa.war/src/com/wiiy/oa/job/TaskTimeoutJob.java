package com.wiiy.oa.job;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.export.RemindEmailService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.job.RepeatJob.JobTask;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.util.RemindUtil;

public class TaskTimeoutJob extends RepeatJob{
	protected CachedLog logger = CachedLog.getLog(getClass());
	private TaskService taskService;
	private List<Task> list;
	
	public TaskTimeoutJob(ApplicationContext applicationContext) {
		super(applicationContext);
		taskService = applicationContext.getBean(TaskService.class);
	}
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	@Override
	protected void execute() {
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		list = taskService.getListByFilter(new Filter(Task.class).ne("status", TaskStatusEnum.FINISHED).le("endTime", (Calendar.getInstance()).getTime())).getValue();
		if(list!=null&&list.size()>0){
			if(sysEmailSenderPubService!=null && RemindUtil.emailActive("taskTimeOutRemind")){
				String[] receiverEmail = new String[]{};
				String[] content = new String[]{};
				int i=0,j=0;
				String subject = "工作逾期提醒";
				for (Task task : list) {
					if(task.getReceiverId()!=null){
						receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
						content = Arrays.copyOf(content, content.length+1);
						User user = OaActivator.getUserById(task.getReceiverId());
						receiverEmail[i] = user.getEmail();
						content[j] = "";
						content[j] = formContent(content[j],task,user);
						i++;j++;
					}
					if(task.getReceiverIds()!=null){
						String[] ids = task.getReceiverIds().split(",");
						for (String id : ids) {
							receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
							content = Arrays.copyOf(content, content.length+1);
							User user = OaActivator.getUserById(Long.valueOf(id));
							receiverEmail[i] = user.getEmail();
							content[j] = "";
							content[j] = formContent(content[j],task,user);
							i++;j++;
						}
					}
				}
				sysEmailSenderPubService.send(receiverEmail, content,subject);
			}
			SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
			if(smsPubService!=null && RemindUtil.smsActive("taskTimeOutRemind")){
	/*			if(list==null){
					list = taskService.getListByFilter(new Filter(Task.class).ne("status", TaskStatusEnum.FINISHED).le("endTime", (Calendar.getInstance()).getTime())).getValue();
				}
	*/			String[] receiverMobile = new String[]{};
				String[] receiverName = new String[]{};
				String[] content = new String[]{};
				int i=0,j=0,k=0;
				for (Task task : list) {
					if(task.getReceiverId()!=null){
						receiverMobile = Arrays.copyOf(receiverMobile, receiverMobile.length+1);
						receiverName = Arrays.copyOf(receiverName, receiverName.length+1);
						content = Arrays.copyOf(content, content.length+1);
						User user = OaActivator.getUserById(task.getReceiverId());
						receiverMobile[i] = user.getMobile();
						content[j] = OaActivator.getAppConfig().getConfig("taskTimeOutRemind").getParameter("smsModule");
						content[j] = content[j].replace("${title}", task.getTitle());
						receiverName[k] = user.getRealName();
						i++;j++;k++;
					}
					if(task.getReceiverIds()!=null){
						String[] ids = task.getReceiverIds().split(",");
						for (String id : ids) {
							receiverMobile = Arrays.copyOf(receiverMobile, receiverMobile.length+1);
							content = Arrays.copyOf(content, content.length+1);
							receiverName = Arrays.copyOf(receiverName, receiverName.length+1);
							User user = OaActivator.getUserById(Long.valueOf(id));
							receiverMobile[i] = user.getMobile();
							content[j] = OaActivator.getAppConfig().getConfig("taskTimeOutRemind").getParameter("smsModule");
							content[j] = content[j].replace("${title}", task.getTitle());
							receiverName[k] = user.getRealName();
							i++;j++;k++;
						}
					}
				}
				smsPubService.sendByAdmin(receiverMobile, content, receiverName);
			}
		}
	}
	
	private String formContent(String content,Task task,User user){
		//邮件负责人
		User user2 = OaActivator.getUserById(Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name")));
		content = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html").toString();
		content = content.replace("${subject}", task.getTitle());
		content = content.replace("${msgType}", "工作逾期提醒");
		content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.oa/task!view.action?id="+task.getId());
		content = content.replace("${receiver}", user.getRealName());
		content = content.replace("${customerName}", user.getRealName());
		content = content.replace("${sender}", user2.getRealName());
		content = content.replace("${content}", task.getMemo());
		content = content.replace("${msgLink}", /*remindEmailService.getRemindEmailLink()*/OaActivator.getHttpSessionService().getRemindEmailLink());
		
		return content;
	}
}