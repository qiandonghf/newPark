package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.SubjectNetworkDao;
import com.wiiy.crm.entity.SubjectNetwork;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.SubjectNetworkService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class SubjectNetworkServiceImpl implements SubjectNetworkService{
	
	private SubjectNetworkDao subjectNetworkDao;
	
	public void setSubjectNetworkDao(SubjectNetworkDao subjectNetworkDao) {
		this.subjectNetworkDao = subjectNetworkDao;
	}

	@Override
	public Result<SubjectNetwork> save(SubjectNetwork t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			subjectNetworkDao.save(t);
			return Result.success(R.SubjectNetwork.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SubjectNetwork.class)));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> delete(SubjectNetwork t) {
		try {
			subjectNetworkDao.delete(t);
			return Result.success(R.SubjectNetwork.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> deleteById(Serializable id) {
		try {
			subjectNetworkDao.deleteById(id);
			return Result.success(R.SubjectNetwork.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> deleteByIds(String ids) {
		try {
			subjectNetworkDao.deleteByIds(ids);
			return Result.success(R.SubjectNetwork.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> update(SubjectNetwork t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			subjectNetworkDao.update(t);
			return Result.success(R.SubjectNetwork.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SubjectNetwork.class)));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> getBeanById(Serializable id) {
		try {
			return Result.value(subjectNetworkDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SubjectNetwork> getBeanByFilter(Filter filter) {
		try {
			return Result.value(subjectNetworkDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SubjectNetwork>> getList() {
		try {
			return Result.value(subjectNetworkDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SubjectNetwork>> getListByFilter(Filter filter) {
		try {
			return Result.value(subjectNetworkDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SubjectNetwork.LOAD_FAILURE);
		}
	}

}
