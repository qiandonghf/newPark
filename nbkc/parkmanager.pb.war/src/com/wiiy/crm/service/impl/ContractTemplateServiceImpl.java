package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.ContractTemplateDao;
import com.wiiy.crm.entity.ContractTemplate;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.ContractTemplateService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractTemplateServiceImpl implements ContractTemplateService{
	
	private ContractTemplateDao contractTemplateDao;
	
	public void setContractTemplateDao(ContractTemplateDao contractTemplateDao) {
		this.contractTemplateDao = contractTemplateDao;
	}

	@Override
	public Result<ContractTemplate> save(ContractTemplate t) {
		try {
			List<ContractTemplate> list = getListByFilter(new Filter(ContractTemplate.class).eq("type", t.getType()).eq("chief", BooleanEnum.YES)).getValue();
			if(list==null || list.size()==0){
				t.setChief(BooleanEnum.YES);
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractTemplateDao.save(t);
			return Result.success(R.ContractTemplate.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractTemplate.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> delete(ContractTemplate t) {
		try {
			contractTemplateDao.delete(t);
			PbActivator.getResourcesService().delete(t.getNewName());
			return Result.success(R.ContractTemplate.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> deleteById(Serializable id) {
		try {
			ContractTemplate c = contractTemplateDao.getBeanById(id);
			String path = c.getNewName();
			contractTemplateDao.deleteById(id);
			PbActivator.getResourcesService().delete(path);
			return Result.success(R.ContractTemplate.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> deleteByIds(String ids) {
		try {
			contractTemplateDao.deleteByIds(ids);
			List<String> newNames= contractTemplateDao.getObjectListByHql("select new_name from ContractTemplate where id in ("+ids+")");
			for(String newName:newNames){
				PbActivator.getResourcesService().delete(newName);
			}
			return Result.success(R.ContractTemplate.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> update(ContractTemplate t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractTemplateDao.update(t);
			return Result.success(R.ContractTemplate.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractTemplate.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> getBeanById(Serializable id) {
		try {
			return Result.value(contractTemplateDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractTemplate> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractTemplateDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractTemplate>> getList() {
		try {
			return Result.value(contractTemplateDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractTemplate>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractTemplateDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractTemplate.LOAD_FAILURE);
		}
	}

	@Override
	public Result chief(Long id) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contractTemplateDao.openSession();
			tr = session.beginTransaction();
			ContractTemplate contractTemplate = getBeanById(id).getValue();
			List<ContractTemplate> list = getListByFilter(new Filter(ContractTemplate.class).eq("type", contractTemplate.getType()).eq("chief", BooleanEnum.YES)).getValue();
			if(list!=null && list.size()>0){
				for (ContractTemplate contractTemplate2 : list) {
					contractTemplate2.setChief(BooleanEnum.NO);
					session.update(contractTemplate2);
				}
			}
			contractTemplate.setChief(BooleanEnum.YES);
			session.update(contractTemplate);
			tr.commit();
			return Result.success("模板设置成功");
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("模板设置失败");
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("模板设置失败");
		} finally{
			session.close();
		}
	}

}
