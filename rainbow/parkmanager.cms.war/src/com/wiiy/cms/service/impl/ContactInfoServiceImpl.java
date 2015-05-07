package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.ContactInfoDao;
import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.ContactInfoService;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ContactInfoServiceImpl implements ContactInfoService{
	private ContactInfoDao contactInfoDao;

	@Override
	public Result<ContactInfo> save(ContactInfo t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contactInfoDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的联系方式");
			return Result.success(R.ContactInfo.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContactInfo.class)));
		}catch (Exception e) {
			return Result.failure(R.ContactInfo.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContactInfo> update(ContactInfo t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			contactInfoDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的联系方式");
			return Result.success(R.ContactInfo.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContactInfo.class)));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<ContactInfo> delete(ContactInfo t) {
		try {
			contactInfoDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的联系方式");
			return Result.success(R.ContactInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactInfo> deleteById(Serializable id) {
		try {
			contactInfoDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的联系方式");
			return Result.success(R.ContactInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactInfo> deleteByIds(String ids) {
		try {
			contactInfoDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的联系方式");
			}
			return Result.success(R.ContactInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContactInfo> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contactInfoDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContactInfo> getBeanById(Serializable id) {
		try {
			return Result.value(contactInfoDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContactInfo>> getList() {
		try {
			return Result.value(contactInfoDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContactInfo>> getListByFilter(Filter filter) {
		try {
			return Result.value(contactInfoDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContactInfo.LOAD_FAILURE);
		}
	}

	public void setContactInfoDao(ContactInfoDao contactInfoDao) {
		this.contactInfoDao = contactInfoDao;
	}

	@Override
	public void deleteByParamId(Long paramId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contactInfoDao.openSession();
			tr = session.beginTransaction();
			String sql = "DELETE FROM cms_contact_info WHERE param_id="+paramId;
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
		}finally{
			if (session != null) {
				session.close();
			}
		}
		
	}

}
