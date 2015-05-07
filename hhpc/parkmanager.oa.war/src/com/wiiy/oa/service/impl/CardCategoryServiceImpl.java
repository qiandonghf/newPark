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
import com.wiiy.oa.dao.CardCategoryDao;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;
import com.wiiy.oa.service.CardCategoryService;

public class CardCategoryServiceImpl implements CardCategoryService{
	private CardCategoryDao cardCategoryDao;
	private int level = 0;
	
	public void setCardCategoryDao(CardCategoryDao cardCategoryDao) {
		this.cardCategoryDao = cardCategoryDao;
	}

	@Override
	public Result<CardCategory> save(CardCategory t) {
		try {
			if(t.getParentId()!=null){
				List<CardCategory> cardCategories = getListByFilter(new Filter(CardCategory.class).eq("parentId", t.getParentId()).eq("name", t.getName()).eq("ownerId", OaActivator.getSessionUser().getId())).getValue();
				if(cardCategories!=null && cardCategories.size()>0){
					return Result.failure("名片夹已存在");
				}
				CardCategory cardCategory = getBeanByFilter(new Filter(CardCategory.class).eq("id", t.getParentId())).getValue();
				t.setLevel(cardCategory.getLevel()+1);
			}else{
				List<CardCategory> cardCategories = getListByFilter(new Filter(CardCategory.class).isNull("parentId").eq("name", t.getName())).getValue();
				if(cardCategories!=null && cardCategories.size()>0){
					return Result.failure("名片夹已存在");
				}
				t.setLevel(level);
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setOwnerId(OaActivator.getSessionUser().getId());
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds, t.getParentId());
			}
			t.setParentIds(parentIds);
			cardCategoryDao.save(t);
			OaActivator.getOperationLogService().logOP("添加名片夹【"+t.getName()+"】");
			return Result.success(R.CardCategory.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CardCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.SAVE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		CardCategory cardCategory = cardCategoryDao.getBeanById(id);
		if(!cardCategory.getParentIds().equals(",")){
			parentIds = cardCategory.getParentIds()+id+",";
		}else{
			parentIds = ","+id+",";
		}
		return parentIds;
	}

	@Override
	public Result<CardCategory> delete(CardCategory t) {
		try {
			cardCategoryDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除名片夹【"+t.getName()+"】");
			return Result.success(R.CardCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CardCategory> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的名片夹");
			cardCategoryDao.deleteById(id);
			return Result.success(R.CardCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CardCategory> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的名片夹");
			}
			cardCategoryDao.deleteByIds(ids);
			return Result.success(R.CardCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CardCategory> update(CardCategory t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			cardCategoryDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑名片夹【"+t.getName()+"】");
			return Result.success(R.CardCategory.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CardCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CardCategory> getBeanById(Serializable id) {
		try {
			return Result.value(cardCategoryDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CardCategory> getBeanByFilter(Filter filter) {
		try {
			return Result.value(cardCategoryDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CardCategory>> getList() {
		try {
			return Result.value(cardCategoryDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CardCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CardCategory>> getListByFilter(Filter filter) {
		try {
			return Result.value(cardCategoryDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CardCategory.LOAD_FAILURE);
		}
	}
}
