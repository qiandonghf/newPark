package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.TaskDao;
import com.wiiy.oa.dto.TaskDto;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.entity.TaskDepartConfig;
import com.wiiy.oa.entity.TaskLog;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.SubTaskStatusEnum;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.util.RemindUtil;
import com.wiiy.oa.util.ScheduleUtil;

/**
 * @author my
 */
public class TaskServiceImpl implements TaskService{
	
	private TaskDao taskDao;
	
	public void setTaskDao(TaskDao taskDao) {
		this.taskDao = taskDao;
	}

	@Override
	public Result<Task> save(Task t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			taskDao.save(t);
			Task newTask = new Task();
			t.setId(t.getId());
			return Result.success(R.Task.SAVE_SUCCESS,newTask);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			return Result.failure(R.Task.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Task> delete(Task t) {
		try {
			taskDao.delete(t);
			return Result.success(R.Task.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Task.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Task> deleteById(Serializable id) {
		try {
			taskDao.deleteById(id);
			return Result.success(R.Task.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Task.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Task> deleteByIds(String ids) {
		try {
			taskDao.deleteByIds(ids);
			return Result.success(R.Task.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Task.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Task> update(Task t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(t.getModifier());
			t.setModifierId(t.getModifierId());
			taskDao.update(t);
			return Result.success(R.Task.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			return Result.failure(R.Task.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Task> getBeanById(Serializable id) {
		try {
			return Result.value(taskDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Task.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Task> getBeanByFilter(Filter filter) {
		try {
			return Result.value(taskDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Task.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Task>> getList() {
		try {
			return Result.value(taskDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Task.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Task>> getListByFilter(Filter filter) {
		try {
			return Result.value(taskDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Task.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Task> save(Task t, List<TaskAtt> sessionTaskAttList, String[] departIds, String sendIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			User user = OaActivator.getUserById(t.getReceiverId());
			t.setCreator(user.getRealName());
			t.setCreatorId(user.getId());
			t.setModifierId(user.getId());
			t.setModifier(user.getRealName());
			t.setModifyTime(t.getCreateTime());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(sessionTaskAttList!=null){
				for (TaskAtt taskAtt : sessionTaskAttList) {
					taskAtt.setTaskId(t.getId());
					taskAtt.setCreateTime(new Date());
					taskAtt.setCreator(OaActivator.getSessionUser().getRealName());
					taskAtt.setCreatorId(OaActivator.getSessionUser().getId());
					taskAtt.setModifyTime(t.getCreateTime());
					taskAtt.setModifier(t.getCreator());
					taskAtt.setModifierId(t.getCreatorId());
					taskAtt.setEntityStatus(EntityStatus.NORMAL);
					session.save(taskAtt);
				}
			}
			if(departIds!=null){
				for (String string : departIds) {
					long departId = Long.parseLong(string.trim());
					TaskDepartConfig config = new TaskDepartConfig();
					config.setTaskId(t.getId());
					config.setDepartId(departId);
					config.setCreateTime(new Date());
					config.setCreator(OaActivator.getSessionUser().getRealName());
					config.setCreatorId(OaActivator.getSessionUser().getId());
					config.setModifyTime(t.getCreateTime());
					config.setModifier(t.getCreator());
					config.setModifierId(t.getCreatorId());
					config.setEntityStatus(EntityStatus.NORMAL);
					session.save(config);
				}
			}
			/*if(sendIds!=null && sendIds.length()>0){
				SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
				SMSDto sms = new SMSDto();
				sms.setCreatorId(OaActivator.getSessionUser().getId());
				sms.setCreator(OaActivator.getSessionUser().getRealName());
				sms.setContent("任务提醒:"+t.getTitle()+"[OA系统]");
				sms.setTimeType(SendTimeTypeEnum.CUSTOMER);
				sms.setSendTime(t.getPromotTime());
				List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
				List<EmailReceiverDto> emaiReceiverList = new ArrayList<EmailReceiverDto>();
				List<Task> appointList = new ArrayList<Task>();
				for (Long sendId : StringUtil.splitToLongArray(sendIds)) {
					SMSReceiverDto receiverDto = new SMSReceiverDto();
					User receiver = OaActivator.getUserById(sendId);
					receiverDto.setPhone(receiver.getMobile());
					receiverDto.setReceiverName(receiver.getRealName());
					appointList.add(t);
					receiverList.add(receiverDto);
					
					EmailReceiverDto emailReDto = new EmailReceiverDto();
					emailReDto.setAddress("811208477@qq.com");
					emailReDto.setReceiverId(receiver.getId());
					emailReDto.setReceiverName(receiver.getRealName());
					emaiReceiverList.add(emailReDto);
				}
				sms.setReceiverList(receiverList);
				if(t.getSms()!=null && t.getSms().equals(BooleanEnum.YES)){
					OaActivator.getService(SMSPubService.class).send(sms,session);
					t.setSmsId(sms.getSmsId());
					smsPubService.send(sms, session);
				}
				
				SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
				EmailDto email = new EmailDto();
				email.setCreatorId(OaActivator.getSessionUser().getId());
				email.setCreator(OaActivator.getSessionUser().getRealName());
				email.setContent("任务提醒:"+t.getTitle()+"[OA系统]");
				email.setTimeType(SendTimeTypeEnum.CUSTOMER);
				email.setSendTime(t.getPromotTime());
				email.setReceiverList(emaiReceiverList);
				//附件
				List<File> attList =  new ArrayList<File>();
				for(TaskAtt taskAtt : t.getAtts()){
					
				}
				email.setAttList(attList);
				if(t.getEmail()!=null && t.getEmail().equals(BooleanEnum.YES)){
					OaActivator.getService(SysEmailSenderPubService.class).send(email, session);
					t.setEmailId(email.getId());
					sysEmailSenderPubService.send(email, session);
				}
				if(t.getEmail()!=null && t.getDefaultEmail().equals(BooleanEnum.YES)){
					OaActivator.getService(SysEmailSenderPubService.class).send(email, session);
					t.setDefaultEmailId(email.getId());
				}
				session.merge(t);
				for (int i = 0; i < appointList.size(); i++) {
					appointList.get(i).setSmsId(sms.getReceiverList().get(i).getSmsReceiverId());
					session.merge(appointList.get(i));
				}
			}*/
			tr.commit();
			Task newTask = new Task();
			newTask.setProgress(t.getProgress());
			newTask.setId(t.getId());
			return Result.success(R.Task.SAVE_SUCCESS,newTask);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Task.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	@Override
	public Result<Task> update(Task t, String[] departIds, String sendIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.merge(t);
			if(departIds!=null){
				session.createQuery("delete TaskDepartConfig where taskId = "+t.getId()).executeUpdate();
				for (String string : departIds) {
					long departId = Long.parseLong(string.trim());
					TaskDepartConfig config = new TaskDepartConfig();
					config.setTaskId(t.getId());
					config.setDepartId(departId);
					config.setCreateTime(new Date());
					config.setCreator(OaActivator.getSessionUser().getRealName());
					config.setCreatorId(OaActivator.getSessionUser().getId());
					config.setModifyTime(t.getCreateTime());
					config.setModifier(t.getCreator());
					config.setModifierId(t.getCreatorId());
					config.setEntityStatus(EntityStatus.NORMAL);
					session.save(config);
				}
			}
			if(sendIds!=null){
				
			}
			tr.commit();
			return Result.success(R.Task.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Task.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}
	@Override
	public Result<Task> update(Task t, String[] departIds) {
		return update(t, departIds, null);
	}

	@Override
	public Result setDepart(Long id, String departIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
			Task t = (Task) session.get(Task.class, id);
			if(departIds!=null){
				session.createQuery("delete TaskDepartConfig where taskId = "+id).executeUpdate();
				for (String string : departIds.split(",")) {
					long departId = Long.parseLong(string.trim());
					TaskDepartConfig config = new TaskDepartConfig();
					config.setTaskId(t.getId());
					config.setDepartId(departId);
					config.setCreateTime(new Date());
					config.setCreator(OaActivator.getSessionUser().getRealName());
					config.setCreatorId(OaActivator.getSessionUser().getId());
					config.setModifyTime(config.getCreateTime());
					config.setModifier(config.getCreator());
					config.setModifierId(config.getCreatorId());
					config.setEntityStatus(EntityStatus.NORMAL);
					session.save(config);
				}
			}
			tr.commit();
			Task task = new Task();
			task.setProgress(t.getProgress());
			return Result.success(R.TaskDepartConfig.SAVE_SUCCESS,task);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.TaskDepartConfig.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	//工作派送
	@Override
	public Result taskSend(Long id, String ids) {
		Session session = null;
		Transaction tr = null;
		User user = OaActivator.getSessionUser();
		Task task = new Task();
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
			if(ids!=null){
				task = (Task) session.get(Task.class, id);
/*				//将原有的任务的短信提醒和邮件提醒删除
				OaActivator.getService(SMSPubService.class).deleteReceiverById(task.getId(), session);
				OaActivator.getService(SysEmailSenderPubService.class).deleteById(task.getId(), session);*/
				//将原有的任务,派送给选择的人并根据原有任务的提醒方式进行相应提醒
				loop:for(String stringId : ids.split(",")){
					long receiverId = Long.parseLong(stringId.trim());
					User user2 = OaActivator.getUserById(receiverId);
					Task newTask = new Task();
					BeanUtil.copyProperties(task, newTask);
					newTask.setId(null);
					if(task.getReceiverId().longValue()==receiverId){
						newTask.setChildStatus(SubTaskStatusEnum.SIGNED);
					}else{
						newTask.setChildStatus(SubTaskStatusEnum.PENDING);
					}
					newTask.setParentId(task.getId());
					newTask.setCreateTime(new Date());
					newTask.setCreator(user2.getRealName());
					newTask.setCreatorId(user2.getId());
					newTask.setModifier(user2.getRealName());
					newTask.setModifierId(user2.getId());
					newTask.setModifyTime(newTask.getCreateTime());
					newTask.setEntityStatus(EntityStatus.NORMAL);
					newTask.setParentIds("");
					newTask.setReceiverId(receiverId);
					newTask.setReceiver(OaActivator.getUserById(receiverId));
					newTask.setStatus(TaskStatusEnum.PENDING);
					session.save(newTask);
					
					/*TaskLog log = new TaskLog();
					log.setCreateTime(new Date());
					log.setCreator(user2.getRealName());
					log.setCreatorId(user2.getId());
					log.setEntityStatus(EntityStatus.NORMAL);
					log.setExecuteUserId(user2.getId());
					log.setExecuteUserName(user2.getRealName());
					log.setExecuteTime(log.getCreateTime());
					log.setMemo("任务未签收");
					log.setProgress(newTask.getProgress());
					log.setTask(newTask);
					log.setTaskId(newTask.getId());
					log.setModifier(user.getRealName());
					log.setModifierId(user.getId());
					log.setModifyTime(log.getCreateTime());
					session.save(log);*/
					
					Set<TaskAtt> attList = new HashSet<TaskAtt>();
					for(TaskAtt att : task.getAtts()){
						TaskAtt newAtt = new TaskAtt();
						BeanUtil.copyProperties(att, newAtt);
						newAtt.setId(null);
						attList.add(newAtt);
						session.save(newAtt);
					}
					newTask.setAtts(attList);
					
					Set<TaskDepartConfig> tdcList = new HashSet<TaskDepartConfig>();
					for(TaskDepartConfig tdc : task.getDepartConfigs()){
						TaskDepartConfig newTdc = new TaskDepartConfig();
						BeanUtil.copyProperties(tdc, newTdc);
						newTdc.setId(null);
						newTdc.setTask(newTask);
						newTdc.setTaskId(newTask.getId());
						tdcList.add(newTdc);
						session.save(newTdc);
					}
					newTask.setDepartConfigs(tdcList);
					
					
					/*List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
					List<EmailReceiverDto> emaiReceiverList = new ArrayList<EmailReceiverDto>();
					List<Task> appointList = new ArrayList<Task>();
					SMSReceiverDto receiverDto = new SMSReceiverDto();
					User receiver = OaActivator.getUserById(receiverId);
					receiverDto.setPhone(receiver.getMobile());
					receiverDto.setReceiverName(receiver.getRealName());
					receiverList.add(receiverDto);
					
					EmailReceiverDto emailReDto = new EmailReceiverDto();
					emailReDto.setAddress(receiver.getEmail());
					emailReDto.setReceiverId(receiver.getId());
					emailReDto.setReceiverName(receiver.getRealName());
					emaiReceiverList.add(emailReDto);
					
					appointList.add(task);*/
				if(task.getSms()!=null && task.getSms().equals(BooleanEnum.YES)){
					SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
					if(smsPubService!=null && RemindUtil.smsActive("taskSendRemind")){
						String receiverMobile = user2.getMobile();
						String receiverName = user2.getRealName();
						String content = OaActivator.getAppConfig().getConfig("taskSendRemind").getParameter("smsModule");
						content = content.replace("${title}", task.getTitle());
						RemindUtil.sendSms(receiverMobile,content,receiverName,smsPubService);
					}
				}
				if(task.getEmail()!=null && task.getEmail().equals(BooleanEnum.YES)){
					SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
					if(sysEmailSenderPubService!=null && RemindUtil.emailActive("taskSendRemind")){
						String content = "";
						StringBuffer data = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html");
						content = data.toString();
						String subject = "工作派送提醒";
						content = content.replace("${subject}", task.getTitle());
						content = content.replace("${msgType}", "工作派送提醒");
						content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.pb/task!view.action?id="+task.getId());
						content = content.replace("${receiver}", user2.getRealName());
						content = content.replace("${customerName}", user2.getRealName());
						content = content.replace("${sender}", user.getRealName());
						content = content.replace("${content}", task.getMemo());
						content = content.replace("${msgLink}",OaActivator.getHttpSessionService().getRemindEmailLink());
						RemindUtil.sendMail(user2.getRealName(),user2.getEmail(),subject,content,sysEmailSenderPubService);
					}
				}
				session.merge(newTask);
			 }
			}
			tr.commit();
			Task t = new Task();
			t.setProgress(task.getProgress());
			return Result.success(R.Task.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Task.SAVE_FAILURE);
		} finally {
			session.close();
			updateParentTask(task,ids);
		}
	}

	@Override
	public Result save(List<Task> insertList) {
		Session session = null;
		Transaction tr = null;
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
			for (Task t : insertList) {
				t.setCreateTime(new Date());
				t.setModifyTime(t.getCreateTime());
				session.save(t);
			}
			tr.commit();
			return Result.success();
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("");
		} finally {
			session.close();
		}
	}

	@Override
	public Result sqlQuery(String sql) {
		return Result.value(taskDao.getObjectListBySql(sql));
	}

	@Override
	public Result<Integer> getRowCount(Filter filter) {
		return Result.value(taskDao.getRowCount(filter));
	}

	@Override
	public Result<List<TaskDto>> getPendingTask() {
		//我的待办任务
		Filter filter = new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).in("childStatus",SubTaskStatusEnum.SIGNED).le("createTime", new Date()).notIn("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).orderBy("endTime", Filter.ASC).maxResults(5);
		//我未签收的任务
		Filter filter2 = new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).eq("childStatus", SubTaskStatusEnum.PENDING).notIn("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).orderBy("endTime", Filter.ASC).maxResults(5);
		//我派出的任务
		String userIds = OaActivator.getSessionUser().getId()+"";
		Filter filter3 = new Filter(Task.class).eq("creator", OaActivator.getSessionUser().getRealName()).isNull("receiverId").ne("receiverIds", userIds).notIn("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).orderBy("endTime", Filter.ASC).maxResults(5);
		
		List<Task> list = getListByFilter(filter).getValue();
		List<Task> list2 = getListByFilter(filter2).getValue();
		List<Task> list3 = getListByFilter(filter3).getValue();
		List<TaskDto> taskDtoList = new ArrayList<TaskDto>();
		for(Task t : list){
			TaskDto dto = new TaskDto();
			dto.setTaskStatus(0);
			dto.setPriority(t.getPriority());
			if(t.getPriority()!=null){
				dto.setPriorityName(t.getPriority().toString());
			}
			dto.setId(t.getId());
			dto.setTitle(t.getTitle());
			dto.setCreateTime(t.getCreateTime());
			dto.setStartTime(t.getStartTime());
			dto.setProgress(t.getProgress());
			dto.setDay(ScheduleUtil.getDiffDays(new Date(), t.getEndTime()));
			taskDtoList.add(dto);
		}
		for(Task t : list2){
			TaskDto dto = new TaskDto();
			dto.setTaskStatus(-1);
			dto.setPriority(t.getPriority());
			if(t.getPriority()!=null){
				dto.setPriorityName(t.getPriority().toString());
			}
			dto.setId(t.getId());
			dto.setTitle(t.getTitle());
			dto.setCreateTime(t.getCreateTime());
			dto.setStartTime(t.getStartTime());
			dto.setProgress(t.getProgress());
			dto.setDay(ScheduleUtil.getDiffDays(new Date(), t.getEndTime()));
			taskDtoList.add(dto);
		}
		for(Task t : list3){
			TaskDto dto = new TaskDto();
			dto.setTaskStatus(1);
			dto.setPriority(t.getPriority());
			if(t.getPriority()!=null){
				dto.setPriorityName(t.getPriority().toString());
			}
			dto.setId(t.getId());
			dto.setTitle(t.getTitle());
			dto.setCreateTime(t.getCreateTime());
			dto.setStartTime(t.getStartTime());
			dto.setProgress(t.getProgress());
			dto.setDay(ScheduleUtil.getDiffDays(new Date(), t.getEndTime()));
			taskDtoList.add(dto);
		}
		return Result.value(taskDtoList);
	}

	@Override
	public Result taskMove(Long id, Long moveId) {
		Session session = null;
		Transaction tr = null;
		User user = OaActivator.getSessionUser();
		Task task = new Task();
		try {
			session = taskDao.openSession();
			tr = session.beginTransaction();
				task = (Task) session.get(Task.class, id);
				//将原有的任务的短信提醒和邮件提醒删除
				if(task.getReceiverId()!=moveId){
//				OaActivator.getService(SMSPubService.class).deleteReceiverById(task.getId(), session);
//				OaActivator.getService(SysEmailSenderPubService.class).deleteById(task.getId(), session);
				//将原有的任务,派送给选择的人并根据原有任务的提醒方式进行相应提醒
					long receiverId = moveId;
					Long oldReceiverId = task.getReceiverId();
					User user2 = OaActivator.getUserById(receiverId);
					TaskLog log = new TaskLog();
					if(task.getReceiverId().longValue()==receiverId){
						task.setChildStatus(SubTaskStatusEnum.SIGNED);
						log.setMemo("任务已签收");
					}/*else{
						task.setChildStatus(SubTaskStatusEnum.PENDING);
						task.setStatus(TaskStatusEnum.PENDING);
						log.setMemo("任务未签收");
					}*/
					task.setCreator(user2.getRealName());
					task.setCreatorId(user2.getId());
					task.setModifier(user2.getRealName());
					task.setModifierId(user2.getId());
					task.setModifyTime(task.getCreateTime());
					task.setEntityStatus(EntityStatus.NORMAL);
					task.setParentIds("");
					task.setReceiverId(receiverId);
					task.setReceiver(OaActivator.getUserById(receiverId));
					session.update(task);
					
					updateParentTask(task,moveId,oldReceiverId);
					
					/*log.setCreateTime(new Date());
					log.setCreator(user2.getRealName());
					log.setCreatorId(user2.getId());
					log.setEntityStatus(EntityStatus.NORMAL);
					log.setExecuteUserId(user2.getId());
					log.setExecuteUserName(user2.getRealName());
					log.setExecuteTime(log.getCreateTime());
					log.setProgress(task.getProgress());
					log.setTask(task);
					log.setTaskId(task.getId());
					log.setModifier(user2.getRealName());
					log.setModifierId(user2.getId());
					log.setModifyTime(log.getCreateTime());
					session.save(log);*/
					
					if(task.getSms()!=null && task.getSms().equals(BooleanEnum.YES)){
						SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
						if(smsPubService!=null && RemindUtil.smsActive("taskMoveRemind")){
							String receiverMobile = user2.getMobile();
							String receiverName = user2.getRealName();
							String content = OaActivator.getAppConfig().getConfig("taskMoveRemind").getParameter("smsModule");
							content = content.replace("${title}", task.getTitle());
							RemindUtil.sendSms(receiverMobile,content,receiverName,smsPubService);
						}
					}
					if(task.getEmail()!=null && task.getEmail().equals(BooleanEnum.YES)){
						SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
						if(sysEmailSenderPubService!=null && RemindUtil.emailActive("taskMoveRemind")){
							String content = "";
							StringBuffer data = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html");
							content = data.toString();
							String subject = "工作移交提醒";
							content = content.replace("${subject}", task.getTitle());
							content = content.replace("${msgType}", "工作移交提醒");
							content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.pb/task!view.action?id="+task.getId());
							content = content.replace("${receiver}", user2.getRealName());
							content = content.replace("${customerName}", user2.getRealName());
							content = content.replace("${sender}", user.getRealName());
							content = content.replace("${content}", task.getMemo());
							content = content.replace("${msgLink}",OaActivator.getHttpSessionService().getRemindEmailLink());
							RemindUtil.sendMail(user2.getRealName(),user2.getEmail(),subject,content,sysEmailSenderPubService);
						}
					}
					
					/*List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
					List<EmailReceiverDto> emaiReceiverList = new ArrayList<EmailReceiverDto>();
					List<Task> appointList = new ArrayList<Task>();
					SMSReceiverDto receiverDto = new SMSReceiverDto();
					User receiver = OaActivator.getUserById(receiverId);
					receiverDto.setPhone(receiver.getMobile());
					receiverDto.setReceiverName(receiver.getRealName());
					receiverList.add(receiverDto);
					
					EmailReceiverDto emailReDto = new EmailReceiverDto();
					emailReDto.setAddress(receiver.getEmail());
					emailReDto.setReceiverId(receiver.getId());
					emailReDto.setReceiverName(receiver.getRealName());
					emaiReceiverList.add(emailReDto);
					
					appointList.add(task);
				if(task.getSms()!=null && task.getSms().equals(BooleanEnum.YES)){
					SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
					SMSDto sms = new SMSDto();
					sms.setCreatorId(OaActivator.getSessionUser().getId());
					sms.setCreator(OaActivator.getSessionUser().getRealName());
					sms.setContent("任务提醒:"+task.getTitle()+"[OA系统]");
					sms.setTimeType(SendTimeTypeEnum.CUSTOMER);
					sms.setSendTime(task.getPromotTime());
					sms.setReceiverList(receiverList);
					OaActivator.getService(SMSPubService.class).send(sms,session);
					task.setSmsId(sms.getSmsId());
					smsPubService.send(sms, session);
				}
				if(task.getEmail()!=null && task.getEmail().equals(BooleanEnum.YES)){
					SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
					EmailDto email = new EmailDto();
					email.setCreatorId(OaActivator.getSessionUser().getId());
					email.setCreator(OaActivator.getSessionUser().getRealName());
					email.setContent("任务提醒:"+task.getTitle()+"[OA系统]");
					email.setTimeType(SendTimeTypeEnum.CUSTOMER);
					email.setSendTime(task.getPromotTime());
					email.setReceiverList(emaiReceiverList);
					//附件
					List<File> taskAttList =  new ArrayList<File>();
					for(TaskAtt taskAtt : task.getAtts()){
						
					}
					email.setAttList(taskAttList);
					OaActivator.getService(SysEmailSenderPubService.class).send(email, session);
					task.setEmailId(email.getId());
					if(task.getDefaultEmail()!=null && task.getDefaultEmail().equals(BooleanEnum.YES)){
						task.setDefaultEmailId(email.getId());
					}
					sysEmailSenderPubService.send(email, session);
				}*/
				session.merge(task);
			tr.commit();
			Task t = new Task();
			t.setParentId(task.getParentId());
			t.setProgress(task.getProgress());
			return Result.success(R.Task.SAVE_SUCCESS,t);
		}else{
			return Result.success(R.Task.SAVE_SUCCESS);
		}
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Task.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Task.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	protected void updateParentTask(Task task,Long moveId,Long oldId){
		if(task.getParentId()!=null){
			Task parentTask = taskDao.getBeanById(task.getParentId());
			String newIds = "";
			for(String rId : parentTask.getReceiverIds().split(",")){
					String myId = oldId+"";
					if(!rId.equals(myId)){
						newIds += rId+",";
					}
				}
			newIds = newIds+(moveId+"");
			parentTask.setReceiverIds(newIds);
			taskDao.update(parentTask);
	  }
	}
	protected void updateParentTask(Task task,String ids){
		task.setReceiverIds(ids);
		task.setReceiverId(null);
		task.setReceiver(null);
		task.setChildStatus(null);
		taskDao.update(task);
	}
}
