package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.WorkDayReportDao;
import com.wiiy.oa.dto.WorkReportDto;
import com.wiiy.oa.entity.WorkDayReport;
import com.wiiy.oa.entity.WorkReport;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.WorkReportEnum;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;
import com.wiiy.oa.service.WorkDayReportService;

public class WorkDayReportServiceImpl implements WorkDayReportService {
	private WorkDayReportDao workDayReportDao;
	public void setWorkDayReportDao(WorkDayReportDao workDayReportDao) {
		this.workDayReportDao = workDayReportDao;
	}

	@Override
	public Result<WorkDayReport> save(WorkDayReport t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			workDayReportDao.save(t);
			return Result.success(R.WorkDayReport.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WorkDayReport.class)));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WorkDayReport> update(WorkDayReport t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			workDayReportDao.update(t);
			return Result.success(R.WorkDayReport.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WorkDayReport.class)));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.UPDATE_FAILURE);
		}
	}
	@Override
	public Result<WorkDayReport> delete(WorkDayReport t) {
		try {
			workDayReportDao.delete(t);
			return Result.success(R.WorkDayReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkDayReport> deleteById(Serializable id) {
		try {
			workDayReportDao.deleteById(id);
			return Result.success(R.WorkDayReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkDayReport> deleteByIds(String ids) {
		try {
			workDayReportDao.deleteByIds(ids);
			return Result.success(R.WorkDayReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkDayReport> getBeanByFilter(Filter filter) {
		try {
			return Result.value(workDayReportDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WorkDayReport> getBeanById(Serializable id) {
		try {
			return Result.value(workDayReportDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkDayReport>> getList() {
		try {
			return Result.value(workDayReportDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkDayReport>> getListByFilter(Filter filter) {
		try {
			return Result.value(workDayReportDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WorkDayReport.LOAD_FAILURE);
		}
	}

	@Override
	public List<WorkDayReport> getListByDepIds(String year, String month, String week,
			String depIds) {
		List<WorkDayReport> list = new ArrayList<WorkDayReport>();
		String sql = "";
		Integer yearInt = Integer.parseInt(year);
		if(week!=null){
			Integer weekInt = Integer.parseInt(week);
			sql = "SELECT w.id,w.content,w.process_string,w.play_content  FROM "+ModulePrefixNamingStrategy.classToTableName(WorkDayReport.class)+" w " +
				 " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(User.class)+" u ON w.reporter_id=u.id " +
				 " WHERE u.org_id in ("+depIds+") AND w.year_no="+yearInt+" AND w.week_no="+weekInt+" AND w.day_no is null "+
				 " GROUP BY  w.id,w.content,w.process_string,w.play_content";
		}else{
			Integer monthInt = Integer.parseInt(month);
			sql = "SELECT w.id,w.content,w.process_string,w.play_content  FROM "+ModulePrefixNamingStrategy.classToTableName(WorkDayReport.class)+" w " +
				 " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(User.class)+" u ON w.reporter_id=u.id " +
				 " WHERE u.org_id in ("+depIds+") AND w.year_no="+yearInt+" AND w.month_no="+monthInt+" AND w.week_no is null "+
				 " GROUP BY  w.id,w.content,w.process_string,w.play_content";
		}
		
		List<Object> objectList = new ArrayList<Object>();
		objectList = workDayReportDao.getObjectListBySql(sql);
		for (Object object : objectList) {
			Object[] objects = (Object[])object;
			Long id =  Long.parseLong(String.valueOf(objects[0]));
			String content = String.valueOf(objects[1]);
			String processString = String.valueOf(objects[2]);
			String playContent = String.valueOf(objects[3]);
			
			WorkDayReport wdr = new WorkDayReport();
			wdr.setId(id);
			wdr.setContent(content);
			wdr.setProcessStr(processString);
			wdr.setPlayContent(playContent);
			list.add(wdr);
		}
		
		return list;
	}
	
	public Result<WorkReportDto> getWorkReportlList(Integer week,Integer month,Integer year) {
		int weekCount = 0;//已经提交的周报数量
		int monthCount = 0;//已经提交的月报数量
		Date preWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, -1).getTime();
		Date nextWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, 1).getTime();
		Date preMonth = CalendarUtil.add(new Date(), Calendar.MONTH, -1).getTime();
		Date nextMonth = CalendarUtil.add(new Date(), Calendar.MONTH, 1).getTime();
		
		
		
		//我提交的当前周报
		WorkDayReport myWeekReport = getBeanByFilter(new Filter(WorkDayReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("status", WorkReportStatusEnum.REPORTED).eq("weekNo", week).eq("monthNo", month).eq("yearNo", year).isNull("dayNo")).getValue();
		//我提交的当前月报
		WorkDayReport myMonthReport = getBeanByFilter(new Filter(WorkDayReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("status", WorkReportStatusEnum.REPORTED).eq("monthNo", month).eq("yearNo", year).isNull("weekNo").isNull("dayNo")).getValue();
		
		//当前时间前后一周已经提交的周报
		List<WorkDayReport> list = getListByFilter(new Filter(WorkDayReport.class).eq("status", WorkReportStatusEnum.REPORTED).isNull("dayNo").notNull("weekNo").between("modifyTime", preWeek, nextWeek)).getValue();
		WorkReportDto dto = new WorkReportDto();
		for(WorkDayReport wr : list){
			if(wr.getReceiver()!=null){
			for(String receiver : wr.getReceiver().split(",")){
				if(receiver.equals(OaActivator.getSessionUser().getRealName())){
					if(wr.getWeekNo()!=null){//提交给我的周报
						weekCount++;
					}
				}
			}
			}
		}
		//当前时间前后一个月已经提交的月报
		List<WorkDayReport> list2 = getListByFilter(new Filter(WorkDayReport.class).eq("status", WorkReportStatusEnum.REPORTED).isNull("dayNo").isNull("weekNo").between("modifyTime", preMonth, nextMonth)).getValue();
		for(WorkDayReport wr : list2){
			if(wr.getReceiver()!=null){
			for(String receiver : wr.getReceiver().split(",")){
				if(receiver.equals(OaActivator.getSessionUser().getRealName())){
					monthCount++;
				}
			}
			}
		}
		dto.setWeekCount(weekCount);
		dto.setMonthCount(monthCount);
		if(myWeekReport!=null){
			dto.setReportedWeek(true);//true ,本周周报已经提交过
		}
		if(myMonthReport!=null){
			dto.setReportedMonth(true);//true ,本月月报已经提交过
		}
		return Result.value(dto);
	}

}
