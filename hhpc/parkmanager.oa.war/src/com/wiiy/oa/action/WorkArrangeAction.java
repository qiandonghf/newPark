package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.WorkArrangeDto;
import com.wiiy.oa.dto.WorkClassDto;
import com.wiiy.oa.entity.UserSign;
import com.wiiy.oa.entity.WorkArrange;
import com.wiiy.oa.entity.WorkClass;
import com.wiiy.oa.entity.WorkSchedule;
import com.wiiy.oa.preferences.enums.SignTypeEnum;
import com.wiiy.oa.service.UserSignService;
import com.wiiy.oa.service.WorkArrangeService;
import com.wiiy.oa.service.WorkClassService;
import com.wiiy.oa.service.WorkScheduleService;

public class WorkArrangeAction extends JqGridBaseAction<WorkArrange>{
	private WorkArrangeService workArrangeService;
	private WorkScheduleService workScheduleService;
	private WorkClassService workClassService;
	private UserSignService userSignService;
	private WorkArrange workArrange;
	private WorkSchedule workSchedule;
	private WorkClass workClass;
	private Result result;
	private Long id;
	private String ids;
	private String workerIds;//员工id集合
	private String workerNames;//员工姓名
	private List<WorkSchedule> workSchedules = new ArrayList<WorkSchedule>();
	private List<WorkArrange> workArranges;
	private List<WorkClass> workClasseList;
	private String isRest;//某一天是否不要上班，只是休息
	
	public String loadWorkArrangeToSign(){
			workClasseList = new ArrayList<WorkClass>();
			workArrange = workArrangeService.getBeanByFilter(new Filter(WorkArrange.class).eq("workerId", OaActivator.getSessionUser().getId())).getValue();
			if(workArrange==null){//为空，就说明该员工没有排班，应该使用缺省班制
				workSchedule = workScheduleService.getBeanByFilter(new Filter(WorkSchedule.class).eq("isDefault", BooleanEnum.YES)).getValue();
				
				if(workSchedule!=null){
					workClasseList = distinguishWeekDay(workSchedule);
				}
			}else{
				workSchedule = workScheduleService.getBeanById(workArrange.getScheduleId()).getValue();
				if(workSchedule!=null){
					workClasseList = distinguishWeekDay(workSchedule);
				}
			}
			
			WorkArrangeDto dto = new WorkArrangeDto();
			if(workClasseList.size()==0){
				dto.setRest(isRest);
			}else{
				List<WorkClassDto> dtoList = new ArrayList<WorkClassDto>();
				for(WorkClass w : workClasseList){
					WorkClassDto d = new WorkClassDto();
					d.setId(w.getId());
					d.setName(w.getName());
					d.setType(SignTypeEnum.IN);
					d.setIsSign(isSign(w.getId(),SignTypeEnum.IN));
					dtoList.add(d);
					
					WorkClassDto d2 = new WorkClassDto();
					d2.setId(w.getId());
					d2.setName(w.getName());
					d2.setType(SignTypeEnum.OUT);
					d2.setIsSign(isSign(w.getId(),SignTypeEnum.OUT));
					dtoList.add(d2);
				}
				dto.setWorkClassList(dtoList);
			}
		result = Result.value(dto);
		return JSON;
	}
	


	private Boolean isSign(Long id, SignTypeEnum type) {
		Boolean flag = false;
		Date date = new Date();
		String signTimeStr = DateUtil.format(date, "yyyy-MM-dd");
		List<UserSign> userSignList = userSignService.getListByFilter(
				new Filter(UserSign.class).eq("userId", OaActivator.getSessionUser().getId()).eq(
						"workClassId", id)).getValue();
		if (userSignList.size() > 0 && userSignList != null) {// 判断同一人同一天同一班次是否已经有签到记录
			for (UserSign userSignOld : userSignList) {
				String signTimeInDb = DateUtil.format(
						userSignOld.getSignTime(), "yyyy-MM-dd");
				if (signTimeStr.equals(signTimeInDb)
						&& userSignOld.getSignType().equals(type)) {
					flag = true;
				}
			}
		}
		return flag;
	}



	public List<WorkClass>  distinguishWeekDay(WorkSchedule workSchedule){//要区分是哪天进行签到,签退
		workClasseList = new ArrayList<WorkClass>();
		int weekDay = java.util.Calendar.getInstance().get(java.util.Calendar.DAY_OF_WEEK);//一个星期的第几天
		if(weekDay==1){
			if(workSchedule.getDay7().equals("")){
				isRest = "休息";//今天休息不需要签到
			}else{
				String[] workClassIdDay7 = workSchedule.getDay7().split(",");
				for(int i=0;i<workClassIdDay7.length;i++){
					workClass = workClassService.getBeanById(Long.parseLong(workClassIdDay7[i])).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==2){
			if(workSchedule.getDay1().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay1 = workSchedule.getDay1().split(",");
				for(String workClassId : workClassIdDay1){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==3){
			if(workSchedule.getDay2().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay2 = workSchedule.getDay2().split(",");
				for(String workClassId : workClassIdDay2){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==4){
			if(workSchedule.getDay3().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay3 = workSchedule.getDay3().split(",");
				for(String workClassId : workClassIdDay3){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==5){
			if(workSchedule.getDay4().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay4 = workSchedule.getDay4().split(",");
				for(String workClassId : workClassIdDay4){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==6){
			if(workSchedule.getDay5().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay5 = workSchedule.getDay5().split(",");
				for(String workClassId : workClassIdDay5){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		if(weekDay==7){
			if(workSchedule.getDay6().equals("")){
				isRest = "休息";
			}else{
				String[] workClassIdDay6 = workSchedule.getDay6().split(",");
				for(String workClassId : workClassIdDay6){
					workClass = workClassService.getBeanById(Long.parseLong(workClassId)).getValue();
					workClasseList.add(workClass);
				}
			}
		}
		return workClasseList;
	}
	
	public String list(){
		Filter filter = new Filter(WorkArrange.class);
		return refresh(filter);
	}
	public String workArrangeList(){
		workSchedules = workScheduleService.getListByFilter(new Filter(WorkSchedule.class)).getValue();
		return LIST;
	}
	public String add(){
		workSchedules = workScheduleService.getListByFilter(new Filter(WorkSchedule.class)).getValue();
		return"add";
	}
	public String save(){
		WorkArrange workArrangeTest = new WorkArrange();
		String[] strId = workerIds.split(",");
		for(int i=0;i<strId.length;i++){
			Long workerId = Long.parseLong(strId[i]);
			workArrangeTest = workArrangeService.getBeanByFilter(new Filter(WorkArrange.class).eq("workerId", workerId)).getValue();
			if(workArrangeTest!=null){
				result = Result.failure("有员工已被排班，请只勾选未排班的员工");
				return JSON;
			}
			workArrange.setWorkerId(workerId);
			result = workArrangeService.save(workArrange);
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = workArrangeService.deleteById(id);
		}else if(ids!=null){
			result = workArrangeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String view(){
		workSchedules = workScheduleService.getListByFilter(new Filter(WorkSchedule.class)).getValue();
		result = workArrangeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		workSchedules = workScheduleService.getListByFilter(new Filter(WorkSchedule.class)).getValue();
		result = workArrangeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		WorkArrange dbBean = workArrangeService.getBeanById(workArrange.getId()).getValue();
		BeanUtil.copyProperties(workArrange, dbBean);
		result = workArrangeService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<WorkArrange> getListByFilter(Filter fitler) {
		return workArrangeService.getListByFilter(fitler).getValue();
	}
	
	public WorkArrange getWorkArrange() {
		return workArrange;
	}
	public void setWorkArrange(WorkArrange workArrange) {
		this.workArrange = workArrange;
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
	public void setWorkArrangeService(WorkArrangeService workArrangeService) {
		this.workArrangeService = workArrangeService;
	}
	public void setWorkScheduleService(WorkScheduleService workScheduleService) {
		this.workScheduleService = workScheduleService;
	}
	public List<WorkSchedule> getWorkSchedules() {
		return workSchedules;
	}
	public void setWorkSchedules(List<WorkSchedule> workSchedules) {
		this.workSchedules = workSchedules;
	}
	public String getWorkerNames() {
		return workerNames;
	}
	public void setWorkerNames(String workerNames) {
		this.workerNames = workerNames;
	}
	public String getWorkerIds() {
		return workerIds;
	}
	public void setWorkerIds(String workerIds) {
		this.workerIds = workerIds;
	}
	public List<WorkArrange> getWorkArranges() {
		return workArranges;
	}
	public void setWorkArranges(List<WorkArrange> workArranges) {
		this.workArranges = workArranges;
	}
	public WorkSchedule getWorkSchedule() {
		return workSchedule;
	}
	public void setWorkSchedule(WorkSchedule workSchedule) {
		this.workSchedule = workSchedule;
	}
	public List<WorkClass> getWorkClasseList() {
		return workClasseList;
	}
	public void setWorkClasseList(List<WorkClass> workClasseList) {
		this.workClasseList = workClasseList;
	}
	public WorkClass getWorkClass() {
		return workClass;
	}
	public void setWorkClass(WorkClass workClass) {
		this.workClass = workClass;
	}
	public void setWorkClassService(WorkClassService workClassService) {
		this.workClassService = workClassService;
	}

	public String getIsRest() {
		return isRest;
	}

	public void setIsRest(String isRest) {
		this.isRest = isRest;
	}

	public void setUserSignService(UserSignService userSignService) {
		this.userSignService = userSignService;
	}
	
}
