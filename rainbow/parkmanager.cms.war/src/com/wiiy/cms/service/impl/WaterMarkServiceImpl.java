package com.wiiy.cms.service.impl;

import java.io.FileInputStream;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.WaterMarkDao;
import com.wiiy.cms.entity.WaterMark;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.WaterMarkService;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class WaterMarkServiceImpl implements WaterMarkService{
	private WaterMarkDao waterMarkDao;

	@Override
	public Result<WaterMark> save(WaterMark t) {
		try{
			Session session = waterMarkDao.openSession();
			session.getLobHelper().createBlob(null);
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			waterMarkDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的图片水印");
			return Result.success(R.WaterMark.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WaterMark.class)));
		}catch (Exception e) {
			return Result.failure(R.WaterMark.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> update(WaterMark t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			waterMarkDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的图片水印");
			return Result.success(R.WaterMark.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WaterMark.class)));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> delete(WaterMark t) {
		try {
			waterMarkDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的图片水印");
			return Result.success(R.WaterMark.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> deleteById(Serializable id) {
		try {
			waterMarkDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的图片水印");
			return Result.success(R.WaterMark.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> deleteByIds(String ids) {
		try {
			waterMarkDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的图片水印");
			}
			return Result.success(R.WaterMark.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> getBeanByFilter(Filter filter) {
		try {
			return Result.value(waterMarkDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> getBeanById(Serializable id) {
		try {
			return Result.value(waterMarkDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WaterMark>> getList() {
		try {
			return Result.value(waterMarkDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WaterMark.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WaterMark>> getListByFilter(Filter filter) {
		try {
			return Result.value(waterMarkDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WaterMark.LOAD_FAILURE);
		}
	}

	public void setWaterMarkDao(WaterMarkDao waterMarkDao) {
		this.waterMarkDao = waterMarkDao;
	}

	@Override
	public Result<WaterMark> save(WaterMark t, FileInputStream fin) {
		try{
			Session session = waterMarkDao.openSession();
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			session.close();
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的图片水印");
			return Result.success(R.WaterMark.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WaterMark.class)));
		}catch (Exception e) {
			return Result.failure(R.WaterMark.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WaterMark> update(WaterMark t, FileInputStream fin) {
		try{
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			waterMarkDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的图片水印");
			return Result.success(R.WaterMark.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WaterMark.class)));
		}catch (Exception e) {
			return Result.failure(R.WaterMark.SAVE_FAILURE);
		}
	}

	@Override
	public void deleteByParamId(Long paramId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = waterMarkDao.openSession();
			tr = session.beginTransaction();
			String sql = "DELETE FROM cms_water_mark WHERE param_id="+paramId;
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
