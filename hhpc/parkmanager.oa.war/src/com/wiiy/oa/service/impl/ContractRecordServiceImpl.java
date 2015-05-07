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
import com.wiiy.oa.entity.ContractRecord;
import com.wiiy.oa.entity.ContractRecordAtt;
import com.wiiy.oa.dao.ContractRecordDao;
import com.wiiy.oa.service.ContractRecordService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class ContractRecordServiceImpl implements ContractRecordService{
	
	private ContractRecordDao contractRecordDao;
	
	public void setContractRecordDao(ContractRecordDao contractRecordDao) {
		this.contractRecordDao = contractRecordDao;
	}

	@Override
	public Result<ContractRecord> save(ContractRecord t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractRecordDao.save(t);
			return Result.success(R.ContractRecord.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> delete(ContractRecord t) {
		try {
			contractRecordDao.delete(t);
			return Result.success(R.ContractRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> deleteById(Serializable id) {
		try {
			contractRecordDao.deleteById(id);
			return Result.success(R.ContractRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> deleteByIds(String ids) {
		try {
			contractRecordDao.deleteByIds(ids);
			return Result.success(R.ContractRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> update(ContractRecord t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			contractRecordDao.update(t);
			return Result.success(R.ContractRecord.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> getBeanById(Serializable id) {
		try {
			return Result.value(contractRecordDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractRecordDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractRecord>> getList() {
		try {
			return Result.value(contractRecordDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractRecord>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractRecordDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractRecord> save(ContractRecord t,List<ContractRecordAtt> sessionContractRecordAttList) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractRecordDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(sessionContractRecordAttList!=null){
				for (ContractRecordAtt contractRecordAtt : sessionContractRecordAttList) {
					contractRecordAtt.setContractRecordId(t.getId());
					contractRecordAtt.setCreateTime(new Date());
					contractRecordAtt.setCreator(OaActivator.getSessionUser().getRealName());
					contractRecordAtt.setCreatorId(OaActivator.getSessionUser().getId());
					contractRecordAtt.setModifyTime(t.getCreateTime());
					contractRecordAtt.setModifier(t.getCreator());
					contractRecordAtt.setModifierId(t.getCreatorId());
					contractRecordAtt.setEntityStatus(EntityStatus.NORMAL);
					session.save(contractRecordAtt);
				}
			}
			tr.commit();
			return Result.success(R.ContractRecord.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractRecord.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractRecord.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

}
