package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.ArchivesDao;
import com.wiiy.oa.entity.Archives;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.ArchivesService;

public class ArchivesServiceImpl implements ArchivesService{
	private ArchivesDao archivesDao;
	public void setArchivesDao(ArchivesDao archivesDao) {
		this.archivesDao = archivesDao;
	}

	@Override
	public Result<Archives> save(Archives t) {
		try {
			List<Archives> archivesList = getListByFilter(new Filter(Archives.class).eq("serialNo", t.getSerialNo())).getValue();
			if(archivesList!=null && archivesList.size()>0){
				return Result.failure("档案编号已经存在");
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			archivesDao.save(t);
			OaActivator.getOperationLogService().logOP("添加档案编号为【"+t.getSerialNo()+"】的档案");
			return Result.success(R.Archives.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Archives.class)));
		} catch (Exception e) {
			return Result.failure(R.Archives.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Archives> delete(Archives t) {
		try {
			OaActivator.getResourcesService().delete(t.getPhoto());
			archivesDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除档案编号为【"+t.getSerialNo()+"】的档案");
			return Result.success(R.Archives.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Archives.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Archives> deleteById(Serializable id) {
		try {
			Archives archives = getBeanById(id).getValue();
			if(archives.getPhoto()!= null){
				String path = archives.getPhoto().replace("core/resources/", "");
				OaActivator.getResourcesService().delete(path);
			}
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的档案");
			archivesDao.deleteById(id);
			return Result.success(R.Archives.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Archives.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Archives> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				Archives archives = getBeanById(Long.valueOf(id)).getValue();
				if(archives.getPhoto()!= null){
					String path = archives.getPhoto().replace("core/resources/", "");
					OaActivator.getResourcesService().delete(path);
				}
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的档案");
			}
			archivesDao.deleteByIds(ids);
			return Result.success(R.Archives.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Archives.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Archives> update(Archives t) {
		try {
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			archivesDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑档案编号为【"+t.getSerialNo()+"】的档案");
			return Result.success(R.Archives.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Archives.class)));
		} catch (Exception e) {
			return Result.failure(R.Archives.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Archives> getBeanById(Serializable id) {
		try {
			return Result.value(archivesDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Archives.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Archives> getBeanByFilter(Filter filter) {
		try {
			return Result.value(archivesDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Archives.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Archives>> getList() {
		try {
			return Result.value(archivesDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Archives.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Archives>> getListByFilter(Filter filter) {
		try {
			return Result.value(archivesDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Archives.LOAD_FAILURE);
		}
	}

}
