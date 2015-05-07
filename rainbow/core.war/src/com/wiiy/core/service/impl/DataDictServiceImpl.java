package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.DataDictDao;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.DataDictService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataDictServiceImpl implements DataDictService{
	private static final Log logger = LogFactory.getLog(CoreActivator.class);
	
	private DataDictDao dataDictDao;
	
	public void setDataDictDao(DataDictDao dataDictDao) {
		this.dataDictDao = dataDictDao;
	}

	@Override
	public Result<DataDict> save(DataDict t) {
		try {
			dataDictDao.save(t);
			return Result.success(R.DataDict.SAVE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.DataDict.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataDict> delete(DataDict t) {
		try {
			dataDictDao.delete(t);
			return Result.success(R.DataDict.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataDict.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataDict> deleteById(Serializable id) {
		try {
			dataDictDao.deleteById(id);
			return Result.success(R.DataDict.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataDict.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataDict> deleteByIds(String ids) {
		try {
			dataDictDao.deleteByIds(ids);
			return Result.success(R.DataDict.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataDict.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataDict> update(DataDict t) {
		try {
			dataDictDao.update(t);
			return Result.success(R.DataDict.UPDATE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.DataDict.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataDict> getBeanById(Serializable id) {
		try {
			return Result.value(dataDictDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataDict.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataDict> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataDictDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataDict.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataDict>> getList() {
		try {
			return Result.value(dataDictDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataDict.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataDict>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataDictDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataDict.LOAD_FAILURE);
		}
	}
	
	public boolean init(List<DataDict> list){
		boolean r = true;
		if (list != null) {
			for (DataDict dict : list) {
				try {
					//logger.debug("数据：" + dict.getModuleName() + "-" + dict.getDataValue());
					dataDictDao.merge(dict);
				} catch (Exception e) {
					r = false;
					break;
				}
			}
		}
		return r;
	}

	@Override
	public Result<List<DataDict>> listCategory(String moduleName) {
		try {
			return Result.value(
					dataDictDao.getListByFilter(
							new Filter(DataDict.class)
								.like("id", moduleName+".", MatchMode.START)
								.isNull("parentId")));
		} catch (Exception e) {
			return Result.failure(R.DataDict.LOAD_FAILURE);
		}
	}

	@Override
	public void initSql(String sql) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataDictDao.openSession();
			tr = session.beginTransaction();
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void initSql(String[] sqls) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataDictDao.openSession();
			tr = session.beginTransaction();
			for (String sql : sqls) {
				try {
					System.out.println(sql);
					session.createSQLQuery(sql).executeUpdate();
					
				} catch (Exception e) {
				}
			}
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
		} finally {
			session.close();
		}
	}

}
