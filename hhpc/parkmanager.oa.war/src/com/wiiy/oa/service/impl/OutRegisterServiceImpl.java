package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.OutRegisterDao;
import com.wiiy.oa.entity.OutRegister;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.OutRegisterService;

public class OutRegisterServiceImpl implements OutRegisterService {
	private OutRegisterDao outRegisterDao;

	@Override
	public Result<OutRegister> save(OutRegister t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			outRegisterDao.save(t);
			OaActivator.getOperationLogService().logOP("新建id为【"+t.getId()+"】的外出登记");
			return Result.success(R.OutRegister.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),OutRegister.class)));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.SAVE_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> update(OutRegister t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			outRegisterDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的外出登记");
			return Result.success(R.OutRegister.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),OutRegister.class)));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> delete(OutRegister t) {
		try {
			outRegisterDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的外出登记");
			return Result.success(R.OutRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> deleteById(Serializable id) {
		try {
			outRegisterDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的外出登记");
			return Result.success(R.OutRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> deleteByIds(String ids) {
		try {
			outRegisterDao.deleteByIds(ids);
			for (String id : ids.split(",")) {
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的外出登记");
			}
			return Result.success(R.OutRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> getBeanByFilter(Filter filter) {
		try {
			return Result.value(outRegisterDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<OutRegister> getBeanById(Serializable id) {
		try {
			return Result.value(outRegisterDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<OutRegister>> getList() {
		try {
			return Result.value(outRegisterDao.getList());
		} catch (Exception e) {
			return Result.failure(R.OutRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<OutRegister>> getListByFilter(Filter filter) {
		try {
			return Result.value(outRegisterDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.OutRegister.LOAD_FAILURE);
		}
	}

	public void setOutRegisterDao(OutRegisterDao outRegisterDao) {
		this.outRegisterDao = outRegisterDao;
	}

}
