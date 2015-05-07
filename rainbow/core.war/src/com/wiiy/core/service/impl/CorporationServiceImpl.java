package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.CorporationDao;
import com.wiiy.core.entity.Corporation;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.CorporationService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class CorporationServiceImpl implements CorporationService{
	
	private CorporationDao corporationDao;
	
	public void setCorporationDao(CorporationDao corporationDao) {
		this.corporationDao = corporationDao;
	}

	@Override
	public Result<Corporation> save(Corporation t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			corporationDao.save(t);
			return Result.success(R.Corporation.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Corporation.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Corporation> delete(Corporation t) {
		try {
			corporationDao.delete(t);
			return Result.success(R.Corporation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Corporation> deleteById(Serializable id) {
		try {
			corporationDao.deleteById(id);
			return Result.success(R.Corporation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Corporation> deleteByIds(String ids) {
		try {
			corporationDao.deleteByIds(ids);
			return Result.success(R.Corporation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Corporation> update(Corporation t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			corporationDao.update(t);
			return Result.success(R.Corporation.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Corporation.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Corporation> getBeanById(Serializable id) {
		try {
			return Result.value(corporationDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Corporation> getBeanByFilter(Filter filter) {
		try {
			return Result.value(corporationDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Corporation>> getList() {
		try {
			return Result.value(corporationDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Corporation>> getListByFilter(Filter filter) {
		try {
			return Result.value(corporationDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Corporation.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<String> generateCode() {
		String code = "[JTGS]";
		Corporation corporation = corporationDao.getBeanByFilter(//
				new Filter(Corporation.class).//
				ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)).//
				orderBy("id", Filter.DESC).maxResults(1));
		int count = corporationDao.getRowCount(//
				new Filter(Corporation.class).//
				ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)));
		try {
			if (corporation != null && corporation.getCode() != null) {
				String oldCode = corporation.getCode();
				count = Integer.parseInt(//
						oldCode.replace(code, ""));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumIntegerDigits(6);
		code = code + nf.format(count+1);
		return Result.value(code);
	}


}
