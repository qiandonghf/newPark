package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.WorkClass;
import com.wiiy.oa.entity.WorkSchedule;
import com.wiiy.oa.service.WorkClassService;
import com.wiiy.oa.service.WorkScheduleService;

public class WorkClassAction extends JqGridBaseAction<WorkClass>{
	private WorkClassService workClassService;
	private WorkScheduleService workScheduleService;
	private WorkClass workClass;
	private Result result;
	private Long id;
	private String ids;
	private String startTimeHour;//上班时间(时)
	private String startTimeMinute;//上班时间(分钟)
	private String signInStartTimeHour;//签到开始时间(时)
	private String signInStartTimeMinute;//签到开始时间(分钟)
	private String signInEndTimeHour;//签到结束时间(时)
	private String signInEndTimeMinute;//签到结束时间(分钟)
	private String endTimeHour;//下班时间(时)
	private String endTimeMinute;//下班时间(分钟)
	private String signOutStartTimeHour;//签退开始时间(时)
	private String signOutStartTimeMinute;//签退开始时间(分钟)
	private String signOutEndTimeHour;//签退结束时间(时)
	private String signOutEndTimeMinute;//签退结束时间(分钟)
	private List<WorkClass> workClasseList = new ArrayList<WorkClass>();
	
	public String list(){
		Filter filter = new Filter(WorkClass.class);
		return refresh(filter);
	}
	
	public String save(){
		/**
		 * 将时、分拼接起来，存到对应的字段中
		 */
		workClass.setStartTime(startTimeHour+":"+startTimeMinute);
		workClass.setSignInStartTime(signInStartTimeHour+":"+signInStartTimeMinute);
		workClass.setSignInEndTime(signInEndTimeHour+":"+signInEndTimeMinute);
		workClass.setEndTime(endTimeHour+":"+endTimeMinute);
		workClass.setSignOutStartTime(signOutStartTimeHour+":"+signOutStartTimeMinute);
		workClass.setSignOutEndTime(signOutEndTimeHour+":"+signOutEndTimeMinute);
		result = workClassService.save(workClass);	
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			WorkSchedule day1 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day1", id.toString())).getValue();
			WorkSchedule day2 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day2", id.toString())).getValue();
			WorkSchedule day3 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day3", id.toString())).getValue();
			WorkSchedule day4 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day4", id.toString())).getValue();
			WorkSchedule day5 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day5", id.toString())).getValue();
			WorkSchedule day6 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day6", id.toString())).getValue();
			WorkSchedule day7 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day7", id.toString())).getValue();
			if(day1!=null||day2!=null||day3!=null||day4!=null||day5!=null||day6!=null||day7!=null){
				result = Result.failure("班制定义中有相关数据，请先删除");
				return JSON;
			}
			result = workClassService.deleteById(id);
		}else if(ids!=null){
			String[]idArray = ids.split(",");
			for(int i=0;i<idArray.length;i++){
				WorkSchedule day1 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day1", idArray[i])).getValue();
				WorkSchedule day2 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day2", idArray[i])).getValue();
				WorkSchedule day3 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day3", idArray[i])).getValue();
				WorkSchedule day4 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day4", idArray[i])).getValue();
				WorkSchedule day5 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day5", idArray[i])).getValue();
				WorkSchedule day6 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day6", idArray[i])).getValue();
				WorkSchedule day7 = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).like("day7", idArray[i])).getValue();
				if(day1!=null||day2!=null||day3!=null||day4!=null||day5!=null||day6!=null||day7!=null){
					result = Result.failure("班制定义中有相关数据，请先删除");
					return JSON;
				}
			}
			result = workClassService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		/**
		 * 将(String类型)时间切开，分为时、分，传到jsp页面显示出来
		 */
		workClass = workClassService.getBeanById(id).getValue();
		String[] startTime = workClass.getStartTime().split(":");
		startTimeHour = startTime[0];
		startTimeMinute = startTime[1];
		String[] signInStartTime = workClass.getSignInStartTime().split(":");
		signInStartTimeHour =  signInStartTime[0];
		signInStartTimeMinute = signInStartTime[1];
		String[] signInEndTime = workClass.getSignInEndTime().split(":");
		signInEndTimeHour = signInEndTime[0];
		signInEndTimeMinute = signInEndTime[1];
		String[] endTime = workClass.getEndTime().split(":");
		endTimeHour = endTime[0];
		endTimeMinute = endTime[1];
		String[] signOutStartTime = workClass.getSignOutStartTime().split(":");
		signOutStartTimeHour = signOutStartTime[0];
		signOutStartTimeMinute = signOutStartTime[1];
		String[] signOutEndTime = workClass.getSignOutEndTime().split(":");
		signOutEndTimeHour = signOutEndTime[0];
		signOutEndTimeMinute = signOutEndTime[1];
		return EDIT;
	}
	public String view(){
		/**
		 * 将(String类型)时间切开，分为时、分，传到jsp页面显示出来
		 */
		workClass = workClassService.getBeanById(id).getValue();
		String[] startTime = workClass.getStartTime().split(":");
		startTimeHour = startTime[0];
		startTimeMinute = startTime[1];
		String[] signInStartTime = workClass.getSignInStartTime().split(":");
		signInStartTimeHour =  signInStartTime[0];
		signInStartTimeMinute = signInStartTime[1];
		String[] signInEndTime = workClass.getSignInEndTime().split(":");
		signInEndTimeHour = signInEndTime[0];
		signInEndTimeMinute = signInEndTime[1];
		String[] endTime = workClass.getEndTime().split(":");
		endTimeHour = endTime[0];
		endTimeMinute = endTime[1];
		String[] signOutStartTime = workClass.getSignOutStartTime().split(":");
		signOutStartTimeHour = signOutStartTime[0];
		signOutStartTimeMinute = signOutStartTime[1];
		String[] signOutEndTime = workClass.getSignOutEndTime().split(":");
		signOutEndTimeHour = signOutEndTime[0];
		signOutEndTimeMinute = signOutEndTime[1];
		return VIEW;
	}
	
	public String update(){
		WorkClass dbBean = workClassService.getBeanById(workClass.getId()).getValue();
		BeanUtil.copyProperties(workClass, dbBean);
		/**
		 * 将时、分拼接起来，存到对应的字段中
		 */
		dbBean.setStartTime(startTimeHour+":"+startTimeMinute);
		dbBean.setSignInStartTime(signInStartTimeHour+":"+signInStartTimeMinute);
		dbBean.setSignInEndTime(signInEndTimeHour+":"+signInEndTimeMinute);
		dbBean.setEndTime(endTimeHour+":"+endTimeMinute);
		dbBean.setSignOutStartTime(signOutStartTimeHour+":"+signOutStartTimeMinute);
		dbBean.setSignOutEndTime(signOutEndTimeHour+":"+signOutEndTimeMinute);
		result = workClassService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<WorkClass> getListByFilter(Filter fitler) {
		return workClassService.getListByFilter(fitler).getValue();
	}
	public WorkClass getWorkClass() {
		return workClass;
	}
	public void setWorkClass(WorkClass workClass) {
		this.workClass = workClass;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
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
	public void setWorkClassService(WorkClassService workClassService) {
		this.workClassService = workClassService;
	}
	public String getStartTimeHour() {
		return startTimeHour;
	}

	public void setStartTimeHour(String startTimeHour) {
		this.startTimeHour = startTimeHour;
	}

	public String getStartTimeMinute() {
		return startTimeMinute;
	}

	public void setStartTimeMinute(String startTimeMinute) {
		this.startTimeMinute = startTimeMinute;
	}

	public String getSignInStartTimeHour() {
		return signInStartTimeHour;
	}

	public void setSignInStartTimeHour(String signInStartTimeHour) {
		this.signInStartTimeHour = signInStartTimeHour;
	}

	public String getSignInStartTimeMinute() {
		return signInStartTimeMinute;
	}

	public void setSignInStartTimeMinute(String signInStartTimeMinute) {
		this.signInStartTimeMinute = signInStartTimeMinute;
	}

	public String getSignInEndTimeHour() {
		return signInEndTimeHour;
	}

	public void setSignInEndTimeHour(String signInEndTimeHour) {
		this.signInEndTimeHour = signInEndTimeHour;
	}

	public String getSignInEndTimeMinute() {
		return signInEndTimeMinute;
	}

	public void setSignInEndTimeMinute(String signInEndTimeMinute) {
		this.signInEndTimeMinute = signInEndTimeMinute;
	}

	public String getEndTimeHour() {
		return endTimeHour;
	}

	public void setEndTimeHour(String endTimeHour) {
		this.endTimeHour = endTimeHour;
	}

	public String getEndTimeMinute() {
		return endTimeMinute;
	}

	public void setEndTimeMinute(String endTimeMinute) {
		this.endTimeMinute = endTimeMinute;
	}

	public String getSignOutEndTimeHour() {
		return signOutEndTimeHour;
	}

	public void setSignOutEndTimeHour(String signOutEndTimeHour) {
		this.signOutEndTimeHour = signOutEndTimeHour;
	}

	public String getSignOutEndTimeMinute() {
		return signOutEndTimeMinute;
	}

	public void setSignOutEndTimeMinute(String signOutEndTimeMinute) {
		this.signOutEndTimeMinute = signOutEndTimeMinute;
	}
	public List<WorkClass> getWorkClasseList() {
		return workClasseList;
	}
	public void setWorkClasseList(List<WorkClass> workClasseList) {
		this.workClasseList = workClasseList;
	}
	public void setWorkScheduleService(WorkScheduleService workScheduleService) {
		this.workScheduleService = workScheduleService;
	}

	public String getSignOutStartTimeHour() {
		return signOutStartTimeHour;
	}

	public void setSignOutStartTimeHour(String signOutStartTimeHour) {
		this.signOutStartTimeHour = signOutStartTimeHour;
	}

	public String getSignOutStartTimeMinute() {
		return signOutStartTimeMinute;
	}

	public void setSignOutStartTimeMinute(String signOutStartTimeMinute) {
		this.signOutStartTimeMinute = signOutStartTimeMinute;
	}
}
