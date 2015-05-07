package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.DataTemplatePropertyConfigDao;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.DataTemplatePropertyConfigService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataTemplatePropertyConfigServiceImpl implements DataTemplatePropertyConfigService{
	
	private DataTemplatePropertyConfigDao dataTemplatePropertyConfigDao;
	
	public void setDataTemplatePropertyConfigDao(DataTemplatePropertyConfigDao dataTemplatePropertyConfigDao) {
		this.dataTemplatePropertyConfigDao = dataTemplatePropertyConfigDao;
	}

	@Override
	public Result<DataTemplatePropertyConfig> save(DataTemplatePropertyConfig t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataTemplatePropertyConfigDao.save(t);
			return Result.success(R.DataTemplatePropertyConfig.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataTemplatePropertyConfig.class)));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> delete(DataTemplatePropertyConfig t) {
		try {
			dataTemplatePropertyConfigDao.delete(t);
			return Result.success(R.DataTemplatePropertyConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> deleteById(Serializable id) {
		try {
			dataTemplatePropertyConfigDao.deleteById(id);
			return Result.success(R.DataTemplatePropertyConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> deleteByIds(String ids) {
		try {
			dataTemplatePropertyConfigDao.deleteByIds(ids);
			return Result.success(R.DataTemplatePropertyConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> update(DataTemplatePropertyConfig t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			dataTemplatePropertyConfigDao.update(t);
			return Result.success(R.DataTemplatePropertyConfig.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataTemplatePropertyConfig.class)));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> getBeanById(Serializable id) {
		try {
			return Result.value(dataTemplatePropertyConfigDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataTemplatePropertyConfig> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataTemplatePropertyConfigDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataTemplatePropertyConfig>> getList() {
		try {
			return Result.value(dataTemplatePropertyConfigDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataTemplatePropertyConfig>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataTemplatePropertyConfigDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataTemplatePropertyConfig.LOAD_FAILURE);
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Result<List<DataProperty>> getTemplatePropertys(Long templateId) {
		List<DataProperty> list = dataTemplatePropertyConfigDao.getObjectListByHql("select pc.property from DataTemplatePropertyConfig pc where pc.templateId = "+templateId);
		return Result.value(list);
	}
}
