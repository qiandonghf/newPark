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

public class WorkScheduleAction extends JqGridBaseAction<WorkSchedule>{
	private WorkScheduleService workScheduleService;
	private WorkClassService workClassService;
	private WorkSchedule workSchedule;
	private WorkClass workClass;
	private Result result;
	private Long id;
	private String ids;
	private String day1Class;//周一的班次安排
	private String day2Class;//周二的班次安排
	private String day3Class;//周三的班次安排
	private String day4Class;//周四的班次安排
	private String day5Class;//周五的班次安排
	private String day6Class;//周六的班次安排
	private String day7Class;//周日的班次安排
	public String list(){
		List<WorkSchedule> workScheduleList = new ArrayList<WorkSchedule>();
		workScheduleList = workScheduleService.getListByFilter(new Filter(WorkSchedule.class)).getValue();
		//为了使班制中的班次数据和班次定义中的一致（用户可能会修改WorkClass的数据），每次都重新去WorkClass表中重新取一遍数据，然后将数据更新到班制表中
			for (WorkSchedule workSchedule : workScheduleList) {
				String workClassCfg = splitIdsToGetWorkClass(workSchedule);
				workSchedule.setWorkClassCfg(workClassCfg);
				workScheduleService.update(workSchedule);
			}
		Filter filter = new Filter(WorkSchedule.class);
		return refresh(filter);
	}
	
	public String save(){
		String workClassCfg = 
				"周日：【"+day7Class+"】周一：【"+day1Class+"】周二：【"+day2Class+"】周三：【"+day3Class
				+"】周四：【"+day4Class+"】周五：【"+day5Class+"】周六：【"+day6Class+"】";
		workSchedule.setWorkClassCfg(workClassCfg);
		result = workScheduleService.save(workSchedule);	
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = workScheduleService.deleteById(id);
		}else if(ids!=null){
			result = workScheduleService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String view(){
		result = workScheduleService.getBeanById(id);
		workSchedule = (WorkSchedule) result.getValue();
		splitIdsToGetWorkClass(workSchedule);
		return VIEW;
	}
	public String edit(){
		result = workScheduleService.getBeanById(id);
		workSchedule = (WorkSchedule) result.getValue();
		splitIdsToGetWorkClass(workSchedule);
		return EDIT;
	}
	
	public String update(){
		WorkSchedule dbBean = workScheduleService.getBeanById(workSchedule.getId()).getValue();
		BeanUtil.copyProperties(workSchedule, dbBean);
		String workClassCfg = 
				"周日：【"+day7Class+"】周一：【"+day1Class+"】周二：【"+day2Class+"】周三：【"+day3Class
				+"】周四：【"+day4Class+"】周五：【"+day5Class+"】周六：【"+day6Class+"】";
		dbBean.setWorkClassCfg(workClassCfg);
		result = workScheduleService.update(dbBean);
		return JSON;
	}
	
	/**
	 * 将表中的周一到周日存放的班次的ids取出来，并且分割成id，
	 * 再从WorkClass表中找到对应的班次名称，将名称拼接起来输出大JSP页面
	 */
	public String splitIdsToGetWorkClass(WorkSchedule workSchedule){
		if(workSchedule.getDay1().equals("")){
			day1Class="休息";
		}else{
			String[] day1 = workSchedule.getDay1().split(",");day1Class="";
			for(int i=0;i<day1.length;i++){
				if(i==day1.length-1){//最后一个班次后不需要加"/"，例如(早班/中班/夜班)
					day1Class+=workClassService.getBeanById(Long.parseLong(day1[i])).getValue().getName();
					break;
				}
				day1Class+=workClassService.getBeanById(Long.parseLong(day1[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay2().equals("")){
			day2Class="休息";
		}else{
			String[] day2 = workSchedule.getDay2().split(",");day2Class="";

			for(int i=0;i<day2.length;i++){
				if(i==day2.length-1){
					day2Class+=workClassService.getBeanById(Long.parseLong(day2[i])).getValue().getName();
					break;
				}
				day2Class+=workClassService.getBeanById(Long.parseLong(day2[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay3().equals("")){
			day3Class="休息";
		}else{
			String[] day3 = workSchedule.getDay3().split(",");day3Class="";
			for(int i=0;i<day3.length;i++){
				if(i==day3.length-1){
					day3Class+=workClassService.getBeanById(Long.parseLong(day3[i])).getValue().getName();
					break;
				}
				day3Class+=workClassService.getBeanById(Long.parseLong(day3[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay4().equals("")){
			day4Class="休息";
		}else{
			String[] day4 = workSchedule.getDay4().split(",");day4Class="";
			for(int i=0;i<day4.length;i++){
				if(i==day4.length-1){
					day4Class+=workClassService.getBeanById(Long.parseLong(day4[i])).getValue().getName();
					break;
				}
				day4Class+=workClassService.getBeanById(Long.parseLong(day4[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay5().equals("")){
			day5Class="休息";
		}else{
			String[] day5 = workSchedule.getDay5().split(",");day5Class="";
			for(int i=0;i<day5.length;i++){
				if(i==day5.length-1){
					day5Class+=workClassService.getBeanById(Long.parseLong(day5[i])).getValue().getName();
					break;
				}
				day5Class+=workClassService.getBeanById(Long.parseLong(day5[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay6().equals("")){
			day6Class="休息";
		}else{
			String[] day6 = workSchedule.getDay6().split(",");day6Class="";
			for(int i=0;i<day6.length;i++){
				if(i==day6.length-1){
					day6Class+=workClassService.getBeanById(Long.parseLong(day6[i])).getValue().getName();
					break;
				}
				day6Class+=workClassService.getBeanById(Long.parseLong(day6[i])).getValue().getName()+"/";
			}
		}
		if(workSchedule.getDay7().equals("")){
			day7Class="休息";
		}else{
			String[] day7 = workSchedule.getDay7().split(",");day7Class="";
			for(int i=0;i<day7.length;i++){
				if(i==day7.length-1){
					day7Class+=workClassService.getBeanById(Long.parseLong(day7[i])).getValue().getName();
					break;
				}
				day7Class+=workClassService.getBeanById(Long.parseLong(day7[i])).getValue().getName()+"/";
			}
		}
		
		String workClassCfg = 
				"周日：【"+day7Class+"】周一：【"+day1Class+"】周二：【"+day2Class+"】周三：【"+day3Class
				+"】周四：【"+day4Class+"】周五：【"+day5Class+"】周六：【"+day6Class+"】";
		return workClassCfg;
	}
	
	@Override
	protected List<WorkSchedule> getListByFilter(Filter fitler) {
		return workScheduleService.getListByFilter(fitler).getValue();
	}
	
	public WorkSchedule getWorkSchedule() {
		return workSchedule;
	}

	public void setWorkSchedule(WorkSchedule workSchedule) {
		this.workSchedule = workSchedule;
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

	public void setWorkScheduleService(WorkScheduleService workScheduleService) {
		this.workScheduleService = workScheduleService;
	}

	public String getDay1Class() {
		return day1Class;
	}

	public void setDay1Class(String day1Class) {
		this.day1Class = day1Class;
	}

	public String getDay2Class() {
		return day2Class;
	}

	public void setDay2Class(String day2Class) {
		this.day2Class = day2Class;
	}

	public String getDay3Class() {
		return day3Class;
	}

	public void setDay3Class(String day3Class) {
		this.day3Class = day3Class;
	}

	public String getDay4Class() {
		return day4Class;
	}

	public void setDay4Class(String day4Class) {
		this.day4Class = day4Class;
	}

	public String getDay5Class() {
		return day5Class;
	}

	public void setDay5Class(String day5Class) {
		this.day5Class = day5Class;
	}

	public String getDay6Class() {
		return day6Class;
	}

	public void setDay6Class(String day6Class) {
		this.day6Class = day6Class;
	}

	public String getDay7Class() {
		return day7Class;
	}

	public void setDay7Class(String day7Class) {
		this.day7Class = day7Class;
	}

	public void setWorkClassService(WorkClassService workClassService) {
		this.workClassService = workClassService;
	}

	public WorkClass getWorkClass() {
		return workClass;
	}

	public void setWorkClass(WorkClass workClass) {
		this.workClass = workClass;
	}
}
