package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
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
import com.wiiy.crm.entity.ContractAgreement;
import com.wiiy.crm.entity.ContractAgreementAtt;
import com.wiiy.crm.dao.ContractAgreementDao;
import com.wiiy.crm.service.ContractAgreementAttService;
import com.wiiy.crm.service.ContractAgreementService;
import com.wiiy.crm.preferences.R;
/**
 * @author my
 */
public class ContractAgreementServiceImpl implements ContractAgreementService{
	
	private ContractAgreementDao contractAgreementDao;
	private ContractAgreementAttService contractAgreementAttService;
	
	public void setContractAgreementAttService(
			ContractAgreementAttService contractAgreementAttService) {
		this.contractAgreementAttService = contractAgreementAttService;
	}

	public void setContractAgreementDao(ContractAgreementDao contractAgreementDao) {
		this.contractAgreementDao = contractAgreementDao;
	}

	@Override
	public Result<ContractAgreement> save(ContractAgreement t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractAgreementDao.save(t);
			return Result.success(R.ContractAgreement.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAgreement.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> delete(ContractAgreement t) {
		try {
			contractAgreementDao.delete(t);
			return Result.success(R.ContractAgreement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractAgreementDao.openSession();
			tr = session.beginTransaction();
			ContractAgreement c = getBeanById(id).getValue();
			if(c.getAtts()!=null&&c.getAtts().size()>0){
				List<ContractAgreementAtt> list = new ArrayList<ContractAgreementAtt>(c.getAtts());
				for(ContractAgreementAtt att : list){
					session.delete(att);
				}
			}
			session.delete(c);
			tr.commit();
			return Result.success(R.ContractAgreement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractAgreementDao.openSession();
			tr = session.beginTransaction();
			List<ContractAgreement> list = session.createQuery(
					"from ContractAgreement where id in (" + ids+")").list();
			for (ContractAgreement c : list) {
				if(c.getAtts()!=null&&c.getAtts().size()>0){
					List<ContractAgreementAtt> atts = new ArrayList<ContractAgreementAtt>(c.getAtts());
					for(ContractAgreementAtt att : atts){
						session.delete(att);
					}
				}
				session.delete(c);
			}
			tr.commit();
			return Result.success(R.ContractAgreement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractAgreement.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ContractAgreement> update(ContractAgreement t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractAgreementDao.update(t);
			return Result.success(R.ContractAgreement.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAgreement.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> getBeanById(Serializable id) {
		try {
			return Result.value(contractAgreementDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractAgreementDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAgreement>> getList() {
		try {
			return Result.value(contractAgreementDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAgreement>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractAgreementDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAgreement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractAgreement> save(ContractAgreement t,List<ContractAgreementAtt> sessionContractAgreementAttList) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractAgreementDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(sessionContractAgreementAttList!=null){
				for (ContractAgreementAtt contractAgreementAtt : sessionContractAgreementAttList) {
					contractAgreementAtt.setContractAgreementId(t.getId());
					contractAgreementAtt.setCreateTime(new Date());
					contractAgreementAtt.setCreator(PbActivator.getSessionUser().getRealName());
					contractAgreementAtt.setCreatorId(PbActivator.getSessionUser().getId());
					contractAgreementAtt.setModifyTime(t.getCreateTime());
					contractAgreementAtt.setModifier(t.getCreator());
					contractAgreementAtt.setModifierId(t.getCreatorId());
					contractAgreementAtt.setEntityStatus(EntityStatus.NORMAL);
					session.save(contractAgreementAtt);
				}
			}
			tr.commit();
			return Result.success(R.ContractAgreement.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAgreement.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractAgreement.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

}
