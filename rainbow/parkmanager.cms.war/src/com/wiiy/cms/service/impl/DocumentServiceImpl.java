package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.DocumentDao;
import com.wiiy.cms.entity.Document;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.preferences.enums.DocTypeEnum;
import com.wiiy.cms.service.DocumentService;

public class DocumentServiceImpl implements DocumentService{

	private DocumentDao documentDao;
	private int level = 0;
	
	public void setDocumentDao(DocumentDao documentDao) {
		this.documentDao = documentDao;
	}
	
	@Override
	public Result<Document> save(Document t) {
		try {
			if(t.getParentId()!=null){
				List<Document> documents = getListByFilter(new Filter(Document.class).eq("parentId", t.getParentId()).eq("name", t.getName())).getValue();
				if(documents!=null && documents.size()>0){
					return Result.failure("文档已存在");
				}
				Document document = getBeanByFilter(new Filter(Document.class).eq("id", t.getParentId())).getValue();
				t.setLevel(document.getLevel()+1);
			}else{
				List<Document> documents = getListByFilter(new Filter(Document.class).isNull("parentId").eq("ownerId", CmsActivator.getSessionUser().getId()).eq("docType", DocTypeEnum.PRIVATE).eq("name", t.getName())).getValue();
				if(documents!=null && documents.size()>0){
					return Result.failure("文档已存在");
				}
				t.setLevel(level);
			}
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setDocType(DocTypeEnum.PRIVATE);
			t.setIsFolder(BooleanEnum.NO);
			t.setOwnerId(CmsActivator.getSessionUser().getId());
			String suffixName = t.getName().substring(t.getName().lastIndexOf(".")+1);
			t.setFileExt(suffixName);
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds,t.getParentId());
			}
			t.setParentIds(parentIds);
			documentDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加文档【"+t.getName()+"】");
			return Result.success(R.Document.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.Document.SAVE_FAILURE);
		}
	}
	
	@Override
	public Result<Document> delete(Document t) {
		try {
			documentDao.delete(t);
			return Result.success(R.Document.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Document.DELETE_FAILURE);
		}
	}
	@Override
	public Result<Document> deleteById(Serializable id) {
		try {
			Document d = getBeanById(id).getValue();
			if(d.getFileName()==null){
				List<Document> documents = getListByFilter(new Filter(Document.class).eq("parentId", id)).getValue();
				if(documents.size()!=0){
					return Result.failure("请先删除文件夹内相关文档或文件");
				}
			}else{
				String path = getBeanById(id).getValue().getFileName();
				CmsActivator.getResourcesService().delete(path);
			}
			documentDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除文件:id为【"+id+"】");
			return Result.success(R.Document.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Document.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> deleteByIds(String ids) {
		try {
			documentDao.deleteByIds(ids);
			return Result.success(R.Document.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Document.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanByFilter(Filter filter) {
		try {
			return Result.value(documentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Document.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanById(Serializable id) {
		try {
			return Result.value(documentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Document.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getList() {
		try {
			return Result.value(documentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Document.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getListByFilter(Filter filter) {
		try {
			return Result.value(documentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Document.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<Document> updateFolder(Document t) {
		try {
			if(t.getParentId()!=null){
				List<Document> docFolders = getListByFilter(new Filter(Document.class).eq("ownerId", CmsActivator.getSessionUser().getId()).eq("docType", t.getDocType()).eq("level", t.getLevel()).eq("name", t.getName()).ne("id", t.getId())).getValue();
				if(docFolders!=null&&docFolders.size()>0){
					return Result.failure("文件夹名称不能重复");
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			documentDao.update(t);
			CmsActivator.getOperationLogService().logOP("更新文件夹【"+t.getName()+"】");
			return Result.success(R.Document.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.Document.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Document> update(Document t) {
		try {
			if(t.getParentId()!=null){
				List<Document> documents = getListByFilter(new Filter(Document.class).eq("parentId", t.getParentId()).eq("name", t.getName())).getValue();
				if(documents!=null&&documents.size()>0){
					return Result.failure("文档名称不能重复");
				}
			}else{
				List<Document> documents = getListByFilter(new Filter(Document.class).isNull("parentId").eq("name", t.getName())).getValue();
				if(documents!=null&&documents.size()>0){
					return Result.failure("文档名称不能重复");
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			documentDao.update(t);
			CmsActivator.getOperationLogService().logOP("更新文档【"+t.getName()+"】");
			return Result.success(R.Document.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.Document.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Document> saveFolder(Document t) {
		try {
			List<Document> docFolders = getListByFilter(new Filter(Document.class).eq("ownerId", CmsActivator.getSessionUser().getId()).eq("docType", DocTypeEnum.PRIVATE).eq("name", t.getName())).getValue();
			if(docFolders!=null&&docFolders.size()>0){
				return Result.failure("文件名称不能重复");
			}
			if(t.getParentId()!=null){
				Document document = getBeanByFilter(new Filter(Document.class).eq("id", t.getParentId())).getValue();
				t.setLevel(document.getLevel()+1);
			}else{
				t.setLevel(level);
			}
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setDocType(DocTypeEnum.PRIVATE);
			t.setIsFolder(BooleanEnum.YES);
			t.setOwnerId(CmsActivator.getSessionUser().getId());
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds,t.getParentId());
			}
			t.setParentIds(parentIds);
			documentDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加文件夹【"+t.getName()+"】");
			return Result.success(R.DocFolder.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.SAVE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		Document document = documentDao.getBeanById(id);
		parentIds = document.getParentIds()+id+",";
		return parentIds;
	}
	
	@Override
	public Result<Document> moveTo(Long id,Long toId) {
		try {
			Document t = getBeanByFilter(new Filter(Document.class).eq("id", id)).getValue();
			Document toDoc = getBeanByFilter(new Filter(Document.class).eq("id", toId)).getValue();
			String oldParentIds = t.getParentIds();
			String newParentIds = toDoc.getParentIds()+toId+",";
			int levelDif = (toDoc.getLevel()+1) - t.getLevel();
			t.setParentId(toId);
			t.setLevel(t.getLevel()+levelDif);
			t.setParentIds(toDoc.getParentIds()+toId+",");
			List<Document> documents = getListByFilter(new Filter(Document.class).like("parentIds", ","+t.getId()+",")).getValue();
			for (Document docChild : documents) {
				docChild.setParentIds(docChild.getParentIds().replace(oldParentIds, newParentIds));
				docChild.setLevel(docChild.getLevel()+levelDif);
				documentDao.update(docChild);
			}
			documentDao.update(t);
			CmsActivator.getOperationLogService().logOP("移动文件【"+t.getName()+"】");
			return Result.success(R.Document.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.Document.UPDATE_FAILURE);
		}
	}
}
