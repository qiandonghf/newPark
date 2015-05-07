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
import com.wiiy.cms.dao.DocShareDao;
import com.wiiy.cms.entity.Document;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.preferences.enums.DocTypeEnum;
import com.wiiy.cms.service.DocShareService;

public class DocShareServiceImpl implements DocShareService {
	
	private DocShareDao docShareDao;
	private int level = 0;
	
	public void setDocShareDao(DocShareDao docShareDao) {
		this.docShareDao = docShareDao;
	}

	@Override
	public Result<Document> save(Document t) {
		try {
			List<Document> docFolders = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.SHARED).eq("name", t.getName())).getValue();
			if(docFolders!=null && docFolders.size()>0){
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
			t.setDocType(DocTypeEnum.SHARED);
			t.setIsFolder(BooleanEnum.YES);
			t.setOwnerId(CmsActivator.getSessionUser().getId());
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds,t.getParentId());
			}
			t.setParentIds(parentIds);
			docShareDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加文档【"+t.getName()+"】");
			return Result.success(R.DocFolder.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.SAVE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		Document document = docShareDao.getBeanById(id);
		if(!document.getParentIds().equals(",")){
			parentIds = document.getParentIds()+id+",";
		}else{
			parentIds = ","+id+",";
		}
		return parentIds;
	}
	
	@Override
	public Result<Document> delete(Document t) {
		try {
			docShareDao.delete(t);
			return Result.success(R.DocShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> deleteById(Serializable id) {
		try {
			Document d = getBeanById(id).getValue();
			if(d.getFileName()==null){
				List<Document> documents = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.SHARED).ne("id", id).eq("parentId", id)).getValue();
				List<Document> shareDocs = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.PRIVATE).ne("id", id).like("shareToIds", ","+id+",")).getValue();
				if((documents!=null&&documents.size()>0)||(shareDocs!=null&&shareDocs.size()>0)){
					return Result.failure("请先删除文件夹内相关文档或文件");
				}
			}else{
				String path = getBeanById(id).getValue().getFileName();
				CmsActivator.getResourcesService().delete(path);
			}
			docShareDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除文件:id为【"+id+"】");
			return Result.success(R.DocShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> deleteByIds(String ids) {
		try {
			docShareDao.deleteByIds(ids);
			return Result.success(R.DocShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanByFilter(Filter filter) {
		try {
			return Result.value(docShareDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanById(Serializable id) {
		try {
			return Result.value(docShareDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DocShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getList() {
		try {
			return Result.value(docShareDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DocShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getListByFilter(Filter filter) {
		try {
			return Result.value(docShareDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocShare.LOAD_FAILURE);
		}
	}


	@Override
	public Result<Document> update(Document t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			docShareDao.update(t);
			return Result.success(R.DocShare.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocShare.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Document> share(Document t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			docShareDao.update(t);
			return Result.success(R.DocShare.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocShare.UPDATE_FAILURE);
		}
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
				docShareDao.update(docChild);
			}
			docShareDao.update(t);
			CmsActivator.getOperationLogService().logOP("移动文件【"+t.getName()+"】");
			return Result.success(R.DocShare.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocShare.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Document> shareDel(Long id,Long parentDocId) {
		try {
			Document doc=docShareDao.getBeanById(id);
			String share_ids=doc.getShareToIds();
			String parentDocIdString=parentDocId.toString();
			parentDocIdString=","+parentDocIdString+",";
			String new_share_ids=share_ids.replace(parentDocIdString, ",");
			doc.setShareToIds(new_share_ids);		
			return update(doc);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocShare.UPDATE_FAILURE);
		}
	}

}
