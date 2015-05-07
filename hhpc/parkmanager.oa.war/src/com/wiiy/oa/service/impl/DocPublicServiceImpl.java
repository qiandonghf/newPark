package com.wiiy.oa.service.impl;

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
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.DocPublicDao;
import com.wiiy.oa.entity.Document;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.DocTypeEnum;
import com.wiiy.oa.service.DocPublicService;

public class DocPublicServiceImpl implements DocPublicService {
	
	private DocPublicDao docPublicDao;
	private int level = 0;
	
	public void setDocPublicDao(DocPublicDao docPublicDao) {
		this.docPublicDao = docPublicDao;
	}

	@Override
	public Result<Document> save(Document t) {
		try {
			List<Document> docFolders = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.PUBLIC).eq("name", t.getName())).getValue();
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
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setDocType(DocTypeEnum.PUBLIC);
			t.setIsFolder(BooleanEnum.YES);
			t.setOwnerId(OaActivator.getSessionUser().getId());
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds,t.getParentId());
			}
			t.setParentIds(parentIds);
			docPublicDao.save(t);
			OaActivator.getOperationLogService().logOP("添加文档【"+t.getName()+"】");
			return Result.success(R.DocFolder.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocFolder.SAVE_FAILURE);
		}
	}
	
	@Override
	public Result<Document> delete(Document t) {
		try {
			docPublicDao.delete(t);
			return Result.success(R.DocPublic.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> deleteById(Serializable id) {
		try {
			Document d = getBeanById(id).getValue();
			if(d.getFileName()==null){
				List<Document> documents = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.PUBLIC).ne("id", id).eq("parentId", id)).getValue();
				List<Document> shareDocs = getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.PRIVATE).ne("id", id).like("shareToIds", ","+id+",")).getValue();
				if((documents!=null&&documents.size()>0)||(shareDocs!=null&&shareDocs.size()>0)){
					return Result.failure("请先删除文件夹内相关文档或文件");
				}
			}else{
				String path = getBeanById(id).getValue().getFileName();
				OaActivator.getResourcesService().delete(path);
			}
			docPublicDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除文件:id为【"+id+"】");
			return Result.success(R.DocPublic.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> deleteByIds(String ids) {
		try {
			docPublicDao.deleteByIds(ids);
			return Result.success(R.DocPublic.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanByFilter(Filter filter) {
		try {
			return Result.value(docPublicDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Document> getBeanById(Serializable id) {
		try {
			return Result.value(docPublicDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getList() {
		try {
			return Result.value(docPublicDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DocPublic.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Document>> getListByFilter(Filter filter) {
		try {
			return Result.value(docPublicDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.LOAD_FAILURE);
		}
	}


	@Override
	public Result<Document> update(Document t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			docPublicDao.update(t);
			return Result.success(R.DocPublic.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Document> share(Document t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			docPublicDao.update(t);
			return Result.success(R.DocPublic.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.UPDATE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		Document document = docPublicDao.getBeanById(id);
		if(!document.getParentIds().equals(",")){
			parentIds = document.getParentIds()+id+",";
		}else{
			parentIds = ","+id+",";
		}
		return parentIds;
	}
	
	public void docSize(Long id,Long size){
		Document d = getBeanById(id).getValue();
		if(d.getSize()!=null){
			d.setSize(d.getSize()+size);
		}else{
			d.setSize(size);
		}
		docPublicDao.update(d);
		if(d.getParentId()!=null){
			docSize(d.getParentId(),d.getSize());
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
				docPublicDao.update(docChild);
			}
			docPublicDao.update(t);
			OaActivator.getOperationLogService().logOP("移动文件【"+t.getName()+"】");
			return Result.success(R.DocPublic.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Document.class)));
		} catch (Exception e) {
			return Result.failure(R.DocPublic.UPDATE_FAILURE);
		}
	}

	@Override
	public Result publicDel(Long id, Long parentDocId) {		
		try {
			Document doc=docPublicDao.getBeanById(id);
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
