package com.wiiy.crm.service.impl;


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
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.entity.ContractAgreementAtt;
import com.wiiy.crm.dao.ContractAgreementAttDao;
import com.wiiy.crm.service.ContractAgreementAttService;
import com.wiiy.crm.preferences.R;
/**
 * @author my
 */
public class ContractAgreementAttServiceImpl implements ContractAgreementAttService{
	
	private ContractAgreementAttDao contractAgreementAttDao;
	
	public void setContractAgreementAttDao(ContractAgreementAttDao contractAgreementAttDao) {
		this.contractAgreementAttDao = contractAgreementAttDao;
	}

	@Override
	public Result<ContractAgreementAtt> save(ContractAgreementAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractAgreementAttDao.save(t);
			return Result.success(R.ContractAgreementAtt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAgreementAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreementAtt> delete(ContractAgreementAtt t) {
		try {
			contractAgreementAttDao.delete(t);
			PbActivator.getResourcesService().delete(t.getNewName());
			return Result.success(R.ContractAgreementAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreementAtt> deleteById(Serializable id) {
		try {
			ContractAgreementAtt t = getBeanById(id).getValue();
			String path = t.getNewName();
			contractAgreementAttDao.delete(t);
			PbActivator.getResourcesService().delete(path);
			return Result.success(R.ContractAgreementAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreementAtt> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractAgreementAttDao.openSession();
			tr = session.beginTransaction();
			List<ContractAgreementAtt> list = session.createQuery(
					"from ContractAgreementAtt where id in (" + ids+")").list();
			for (ContractAgreementAtt Att : list) {
				String path = Att.getNewName();
				PbActivator.getResourcesService().delete(path);
				session.delete(Att);
			}
			tr.commit();
			return Result.success(R.ContractAgreementAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractAgreementAtt.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ContractAgreementAtt> update(ContractAgreementAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractAgreementAttDao.update(t);
			return Result.success(R.ContractAgreementAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAgreementAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreementAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contractAgreementAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreementAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractAgreementAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAgreementAtt>> getList() {
		try {
			return Result.value(contractAgreementAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAgreementAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractAgreementAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreementAtt.LOAD_FAILURE);
		}
	}

}
