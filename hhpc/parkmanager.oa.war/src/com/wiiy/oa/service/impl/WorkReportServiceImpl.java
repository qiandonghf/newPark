package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.WorkReportDao;
import com.wiiy.oa.dto.WorkReportDto;
import com.wiiy.oa.entity.WorkDayReport;
import com.wiiy.oa.entity.WorkReport;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.WorkReportEnum;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;
import com.wiiy.oa.service.WorkReportService;

public class WorkReportServiceImpl implements WorkReportService {
	private WorkReportDao workReportDao;

	public void setWorkReportDao(WorkReportDao workReportDao) {
		this.workReportDao = workReportDao;
	}

	@Override
	public Result<WorkReport> save(WorkReport t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			workReportDao.save(t);
			if(t.getWeekNo()==null){
				OaActivator.getOperationLogService().logOP("添加【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月的月报");
			}else{
				OaActivator.getOperationLogService().logOP("添加【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月"+t.getWeekNo()+"】周的周报");
			}
			return Result.success(R.WorkReport.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil
					.getFieldDescriptionByColumnName(e.getUK(),
							WorkReport.class)));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> delete(WorkReport t) {
		try {
			if(t.getWeekNo()==null){
				OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月的月报");
			}else{
				OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月"+t.getWeekNo()+"】周的周报");
			}
			workReportDao.delete(t);
			return Result.success(R.WorkReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> deleteById(Serializable id) {
		try {
			WorkReport t = workReportDao.getBeanById(id);
			if(t.getWeekNo()==null){
				OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月的月报");
			}else{
				OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月"+t.getWeekNo()+"】周的周报");
			}
			workReportDao.deleteById(id);
			return Result.success(R.WorkReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				WorkReport t = workReportDao.getBeanById(Long.parseLong(id));
				if(t.getWeekNo()==null){
					OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月的月报");
				}else{
					OaActivator.getOperationLogService().logOP("删除【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月"+t.getWeekNo()+"】周的周报");
				}
			}
			workReportDao.deleteByIds(ids);
			return Result.success(R.WorkReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> update(WorkReport t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			workReportDao.update(t);
			if(t.getWeekNo()==null){
				OaActivator.getOperationLogService().logOP("编辑【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月的月报");
			}else{
				OaActivator.getOperationLogService().logOP("编辑【"+t.getYearNo()+"】年"+t.getMonthNo()+"】月"+t.getWeekNo()+"】周的周报");
			}
			return Result.success(R.WorkReport.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WorkReport.class)));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> getBeanById(Serializable id) {
		try {
			WorkReport t = workReportDao.getBeanById(id);
			return Result.value(workReportDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WorkReport> getBeanByFilter(Filter filter) {
		try {
			return Result.value(workReportDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkReport>> getList() {
		try {
			return Result.value(workReportDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WorkReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkReport>> getListByFilter(Filter filter) {
		try {
			return Result.value(workReportDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WorkReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkReport>> weekMonthReportList() {
		List<WorkReport> list = getListByFilter(new Filter(WorkReport.class).eq("status", WorkReportStatusEnum.REPORTED).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
		return Result.value(list);
	}
	//显示工作台日月周报信息
	@Override
	public Result<WorkReportDto> getWorkReportlList(Integer week,Integer month,Integer year) {
		int weekCount = 0;//已经提交的周报数量
		int monthCount = 0;//已经提交的月报数量
		Date preWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, -1).getTime();
		Date nextWeek = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, 1).getTime();
		Date preMonth = CalendarUtil.add(new Date(), Calendar.MONTH, -1).getTime();
		Date nextMonth = CalendarUtil.add(new Date(), Calendar.MONTH, 1).getTime();
		
		
		
		//我提交的当前周报
		WorkReport myWeekReport = getBeanByFilter(new Filter(WorkReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("status", WorkReportStatusEnum.REPORTED).eq("type", WorkReportEnum.WEEK).eq("weekNo", week).eq("monthNo", month).eq("yearNo", year)).getValue();
		//我提交的当前月报
		WorkReport myMonthReport = getBeanByFilter(new Filter(WorkReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("status", WorkReportStatusEnum.REPORTED).eq("type", WorkReportEnum.MONTH).eq("monthNo", month).eq("yearNo", year)).getValue();
		
		//当前时间前后一周已经提交的周报
		List<WorkReport> list = getListByFilter(new Filter(WorkReport.class).eq("status", WorkReportStatusEnum.REPORTED).eq("type", WorkReportEnum.WEEK).between("modifyTime", preWeek, nextWeek)).getValue();
		WorkReportDto dto = new WorkReportDto();
		for(WorkReport wr : list){
			for(String receiver : wr.getReceiver().split(",")){
				if(receiver.equals(OaActivator.getSessionUser().getRealName())){
					if(wr.getWeekNo()!=null){//提交给我的周报
						weekCount++;
					}
				}
			}
		}
		//当前时间前后一个月已经提交的月报
		List<WorkReport> list2 = getListByFilter(new Filter(WorkReport.class).eq("status", WorkReportStatusEnum.REPORTED).eq("type", WorkReportEnum.MONTH).between("modifyTime", preMonth, nextMonth)).getValue();
		for(WorkReport wr : list2){
			for(String receiver : wr.getReceiver().split(",")){
				if(receiver.equals(OaActivator.getSessionUser().getRealName())){
					monthCount++;
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
