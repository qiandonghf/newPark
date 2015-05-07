package com.wiiy.cms.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.entity.Receipt;
import com.wiiy.cms.dao.ReceiptDao;
import com.wiiy.cms.service.ReceiptAttService;
import com.wiiy.cms.service.ReceiptService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class ReceiptServiceImpl implements ReceiptService{
	
	private ReceiptDao receiptDao;

	public void setReceiptDao(ReceiptDao receiptDao) {
		this.receiptDao = receiptDao;
	}

	@Override
	public Result<Receipt> save(Receipt t) {
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
			receiptDao.save(t);
			return Result.success(R.Receipt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Receipt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Receipt> delete(Receipt t) {
		try {
			receiptDao.delete(t);
			return Result.success(R.Receipt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Receipt> deleteById(Serializable id) {
		try {
			receiptDao.deleteById(id);
			return Result.success(R.Receipt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure("请先删除相关附件");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Receipt> deleteByIds(String ids) {
		try {
			receiptDao.deleteByIds(ids);
			return Result.success(R.Receipt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Receipt> update(Receipt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			receiptDao.update(t);
			return Result.success(R.Receipt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Receipt.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Receipt> getBeanById(Serializable id) {
		try {
			return Result.value(receiptDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Receipt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(receiptDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Receipt>> getList() {
		try {
			return Result.value(receiptDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Receipt>> getListByFilter(Filter filter) {
		try {
			return Result.value(receiptDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Receipt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Receipt> deleteByIds(String ids, Long articleId) {
		Transaction tr = null;
		Session session = null;
		try {
			receiptDao.deleteByIds(ids);
			session = receiptDao.openSession();
			tr = session.beginTransaction();
			String sql = "SELECT * FROM cms_receipt WHERE article_id="+articleId;
			@SuppressWarnings("rawtypes")
			List list = session.createSQLQuery(sql).list();
			if (list!= null && list.size() == 0) {
				sql = "UPDATE cms_article SET record="+null+" WHERE id="+articleId;
				session.createSQLQuery(sql).executeUpdate();
				tr.commit();
			}
			return Result.success(R.Receipt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			if (tr != null) {
				tr.rollback();
			}
			e.printStackTrace();
			return Result.failure("请先删除相关附件");
		} catch (Exception e) {
			if (tr != null) {
				tr.rollback();
			}
			e.printStackTrace();
			return Result.failure(R.Receipt.DELETE_FAILURE);
		}finally{
			if (session != null) {
				session.close();
			}
		}
	}

}
