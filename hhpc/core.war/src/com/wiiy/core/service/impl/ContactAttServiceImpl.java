package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.core.entity.ContactAtt;
import com.wiiy.core.dao.ContactAttDao;
import com.wiiy.core.service.ContactAttService;
import com.wiiy.core.preferences.R;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.activator.CoreActivator;

/**
 * @author my
 */
public class ContactAttServiceImpl implements ContactAttService{
	
	private ContactAttDao contactAttDao;
	
	public void setContactAttDao(ContactAttDao contactAttDao) {
		this.contactAttDao = contactAttDao;
	}

	@Override
	public Result<ContactAtt> save(ContactAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contactAttDao.save(t);
			return Result.success(R.ContactAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContactAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> delete(ContactAtt t) {
		try {
			contactAttDao.delete(t);
			return Result.success(R.ContactAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> deleteById(Serializable id) {
		try {
			contactAttDao.deleteById(id);
			return Result.success(R.ContactAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> deleteByIds(String ids) {
		try {
			contactAttDao.deleteByIds(ids);
			return Result.success(R.ContactAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> update(ContactAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			contactAttDao.update(t);
			return Result.success(R.ContactAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContactAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contactAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContactAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contactAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContactAtt>> getList() {
		try {
			return Result.value(contactAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContactAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contactAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContactAtt.LOAD_FAILURE);
		}
	}

}
