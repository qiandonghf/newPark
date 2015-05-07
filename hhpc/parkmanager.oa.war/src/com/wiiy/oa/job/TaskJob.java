package com.wiiy.oa.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.job.RepeatJob.JobTask;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.RepeatEnum;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.util.ScheduleUtil;

public class TaskJob extends RepeatJob{
	
	private TaskService taskService;

	public TaskJob(ApplicationContext applicationContext) {
		super(applicationContext);
		taskService = applicationContext.getBean(TaskService.class);
	}
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	@Override
	protected void execute() {
		List<Task> list = taskService.getListByFilter(new Filter(Task.class).ne("repeatType",RepeatEnum.NOREPEAT).between("startTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH), CalendarUtil.getLatest(Calendar.DAY_OF_MONTH))).getValue();
		if(list!=null && list.size()>0){
			List<Long> taskParentIds = new ArrayList<Long>();
			for (Task task : list) {
				if(task.getParentId()!=null){
					taskParentIds.add(task.getParentId());
				} else {
					taskParentIds.add(task.getId());
				}
			}
			Map<Long, Task> nextTaskMap = new HashMap<Long, Task>();
			if(taskParentIds!=null && taskParentIds.size()>0){
				List<Task> existList = taskService.getListByFilter(new Filter(Task.class).ge("startTime", CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH)).in("parentId", taskParentIds.toArray())).getValue();
				for (Task task : existList) {
					nextTaskMap.put(task.getParentId(), task);
				}
			}
			List<Task> insertList = new ArrayList<Task>();
			for (Task task : list) {
				Date nextStartDate = ScheduleUtil.getNextRepeatDate(task.getStartTime(), task.getRepeatType());
				if(task.getParentId()==null){
					if(nextTaskMap.get(task.getId())!=null && nextTaskMap.get(task.getId()).getStartTime()!=task.getStartTime()){
						continue;
					} else {
						Task next = new Task();
						BeanUtil.copyProperties(task, next);
						next.setParentId(task.getId());
						next.setProgress(0);
						next.setStartTime(nextStartDate);
						setPromotTime(task);
						next.setEndTime(ScheduleUtil.getNextRepeatDate(task.getEndTime(), task.getRepeatType()));
						insertList.add(next);
					}
				} else {
					if(nextTaskMap.get(task.getParentId())!=null && nextTaskMap.get(task.getParentId()).getStartTime()!=task.getStartTime()){
						continue;
					} else {
						Task next = new Task();
						BeanUtil.copyProperties(task, next);
						next.setProgress(0);
						next.setStartTime(nextStartDate);
						setPromotTime(task);
						next.setEndTime(ScheduleUtil.getNextRepeatDate(task.getEndTime(), task.getRepeatType()));
						insertList.add(next);
					}
				}
			}
			taskService.save(insertList);
		}
	}
	private void setPromotTime(Task task){
		if(task.getPromot()!=null && !task.getPromot().equals(PromotEnum.NOPROMOT)){
			if(task.getStartTime()==null) return;
			String time = DateUtil.format(task.getStartTime());
			switch (task.getPromot()) {
			case LASTDAY:
			case CURRENTDAY:
				time += " "+task.getPromotDetail();
				break;
			case SPECIALDAY:
				time += task.getPromotDetail();
				break;
			}
			task.setPromotTime(DateUtil.parse(time,"yyyy-MM-dd HH"));
		}
	}
}
