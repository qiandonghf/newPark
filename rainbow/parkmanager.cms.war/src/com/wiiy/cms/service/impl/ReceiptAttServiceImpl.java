package com.wiiy.cms.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.entity.ReceiptAtt;
import com.wiiy.cms.dao.ReceiptAttDao;
import com.wiiy.cms.service.ReceiptAttService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class ReceiptAttServiceImpl implements ReceiptAttService{
	
	private ReceiptAttDao receiptAttDao;
	
	public void setReceiptAttDao(ReceiptAttDao receiptAttDao) {
		this.receiptAttDao = receiptAttDao;
	}

	@Override
	public Result<ReceiptAtt> save(ReceiptAtt t) {
		try {
			t.setCreateTime(new Date());
			User user = CmsActivator.getSessionUser();
			if (user != null) {
				t.setCreator(user.getRealName());
				t.setCreatorId(user.getId());
				t.setModifier(t.getCreator());
				t.setModifierId(t.getCreatorId());
			}
			t.setModifyTime(t.getCreateTime());
			t.setEntityStatus(EntityStatus.NORMAL);
			receiptAttDao.save(t);
			return Result.success(R.ReceiptAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ReceiptAtt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> delete(ReceiptAtt t) {
		try {
			receiptAttDao.delete(t);
			return Result.success(R.ReceiptAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> deleteById(Serializable id) {
		try {
			receiptAttDao.deleteById(id);
			return Result.success(R.ReceiptAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> deleteByIds(String ids) {
		try {
			receiptAttDao.deleteByIds(ids);
			return Result.success(R.ReceiptAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> update(ReceiptAtt t) {
		try {
			t.setModifyTime(new Date());
			if (CmsActivator.getSessionUser() != null) {
				t.setModifier(CmsActivator.getSessionUser().getRealName());
				t.setModifierId(CmsActivator.getSessionUser().getId());
			}
			receiptAttDao.update(t);
			return Result.success(R.ReceiptAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ReceiptAtt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> getBeanById(Serializable id) {
		try {
			return Result.value(receiptAttDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ReceiptAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(receiptAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ReceiptAtt>> getList() {
		try {
			return Result.value(receiptAttDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ReceiptAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(receiptAttDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ReceiptAtt.LOAD_FAILURE);
		}
	}

}
