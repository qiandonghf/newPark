package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.GardenApplyDao;
import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.GardenApplyService;
import com.wiiy.pb.util.ImageUtil;

/**
 * @author my
 */
public class GardenApplyServiceImpl implements GardenApplyService{
	
	private GardenApplyDao gardenApplyDao;
	
	public void setGardenApplyDao(GardenApplyDao gardenApplyDao) {
		this.gardenApplyDao = gardenApplyDao;
	}

	@Override
	public Result<GardenApply> save(GardenApply t) {
		try {
			t.setCreateTime(new Date());
			User user = PbActivator.getSessionUser();
			if (user != null) {
				t.setCreator(user.getRealName());
				t.setCreatorId(user.getId());
				t.setModifier(t.getCreator());
				t.setModifierId(t.getCreatorId());
			}
			t.setModifyTime(t.getCreateTime());
			t.setEntityStatus(EntityStatus.NORMAL);
			gardenApplyDao.save(t);
			if(t.getPhoto() !=null){
				ImageUtil.limitPhoto(t.getPhoto());
			}
			return Result.success(R.GardenApply.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApply.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.SAVE_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> delete(GardenApply t) {
		try {
			gardenApplyDao.delete(t);
			return Result.success(R.GardenApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> deleteById(Serializable id) {
		try {
			gardenApplyDao.deleteById(id);
			return Result.success(R.GardenApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> deleteByIds(String ids) {
		try {
			gardenApplyDao.deleteByIds(ids);
			return Result.success(R.GardenApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> update(GardenApply t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			gardenApplyDao.update(t);
			if(t.getPhoto() !=null){
				ImageUtil.limitPhoto(t.getPhoto());
			}
			return Result.success(R.GardenApply.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApply.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> getBeanById(Serializable id) {
		try {
			return Result.value(gardenApplyDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<GardenApply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApply>> getList() {
		try {
			return Result.value(gardenApplyDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApply>> getListByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApply.LOAD_FAILURE);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GardenApply> getListByConditions(Pager pager,String conditions,
			String searchName, String field,
			String[] fields) {
		Session session = gardenApplyDao.openSession();
		StringBuilder builder = new StringBuilder();
		for (String str : fields) {
			builder.append(",'"+str+"'");
		}
		String hql = "from GardenApply WHERE 1=1 ";
		if (conditions != null) {
			hql += conditions;
		}
		if (searchName != null) {
			hql += "AND projectName like '%"+searchName+"%' ";
		}
		hql += "ORDER BY FIELD ("+field+builder.toString()+")";
		org.hibernate.Query query = session.createQuery(hql);
		int all = query.list().size();
		if (pager != null) {
			int page = pager.getPage();
			int rows = pager.getRows();
			query.setFirstResult((page-1)*rows);
			query.setMaxResults(page*rows);
		}
		pager.setRecords(all);
		return query.list();
	}

}
