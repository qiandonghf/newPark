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
import com.wiiy.oa.entity.ContractRecordAtt;
import com.wiiy.oa.dao.ContractRecordAttDao;
import com.wiiy.oa.service.ContractRecordAttService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;
/**
 * @author my
 */
public class ContractRecordAttServiceImpl implements ContractRecordAttService{
	
	private ContractRecordAttDao contractRecordAttDao;
	
	public void setContractRecordAttDao(ContractRecordAttDao contractRecordAttDao) {
		this.contractRecordAttDao = contractRecordAttDao;
	}

	@Override
	public Result<ContractRecordAtt> save(ContractRecordAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractRecordAttDao.save(t);
			return Result.success(R.ContractRecordAtt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractRecordAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecordAtt> delete(ContractRecordAtt t) {
		try {
			contractRecordAttDao.delete(t);
			return Result.success(R.ContractRecordAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecordAtt> deleteById(Serializable id) {
		try {
			ContractRecordAtt contractRecordAtt = getBeanById(id).getValue();
			String path = contractRecordAtt.getNewName();
			OaActivator.getResourcesService().delete(path);
			contractRecordAttDao.deleteById(id);
			return Result.success(R.ContractRecordAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecordAtt> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractRecordAttDao.openSession();
			tr = session.beginTransaction();
			List<ContractRecordAtt> list = session.createQuery(
					"from ContractRecordAtt where id in (" + ids+")").list();
			for (ContractRecordAtt contractRecordAtt : list) {
				String path = contractRecordAtt.getNewName();
				OaActivator.getResourcesService().delete(path);
				session.delete(contractRecordAtt);
			}
			tr.commit();
			return Result.success(R.ContractRecordAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractRecordAtt.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<ContractRecordAtt> update(ContractRecordAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			contractRecordAttDao.update(t);
			return Result.success(R.ContractRecordAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractRecordAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractRecordAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contractRecordAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractRecordAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractRecordAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractRecordAtt>> getList() {
		try {
			return Result.value(contractRecordAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractRecordAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractRecordAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractRecordAtt.LOAD_FAILURE);
		}
	}

}
