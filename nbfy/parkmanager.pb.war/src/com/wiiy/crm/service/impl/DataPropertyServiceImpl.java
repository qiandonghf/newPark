package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.DataPropertyDao;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.DataPropertyService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataPropertyServiceImpl implements DataPropertyService{
	
	private DataPropertyDao dataPropertyDao;
	
	public void setDataPropertyDao(DataPropertyDao dataPropertyDao) {
		this.dataPropertyDao = dataPropertyDao;
	}

	@Override
	public Result<DataProperty> save(DataProperty t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			if(t.getParentId()!=null){
				Integer count = dataPropertyDao.getRowCount(new Filter(DataProperty.class).eq("parentId", t.getParentId()).eq("name", t.getName()));
				if(count>0){
					return Result.failure("数据项已经存在");
				}
				DataProperty parent = dataPropertyDao.getBeanById(t.getParentId());
				parent.setLeaf(false);
				session.update(parent);
				t.setLevel(parent.getLevel()+1);
				t.setParentIds(parent.getParentIds()+t.getParentId()+",");
			} else {
				Integer count = dataPropertyDao.getRowCount(new Filter(DataProperty.class).isNull("parentId").eq("name", t.getName()));
				if(count>0){
					return Result.failure("数据项已经存在");
				}
				t.setLevel(0);
				t.setParentIds(",");
				
			}
			t.setLeaf(true);
			
			String hql = "from DataProperty where level = "+t.getLevel()+" and parentId";
			if(t.getParentId()!=null){
				hql += " = '"+t.getParentId()+"' ";
			} else {
				hql += " is Null ";
			}
			hql += "order by order desc";
			TreeEntity brother = (TreeEntity) session.createQuery(hql).setMaxResults(1).uniqueResult();
			if(brother!=null){
				t.setOrder(brother.getOrder()+1);
			} else {
				t.setOrder(1);
			}
			
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setFixed(BooleanEnum.NO);
			
			session.save(t);
			tr.commit();
			return Result.success(R.DataProperty.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataProperty.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataProperty.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<DataProperty> delete(DataProperty t) {
		try {
			dataPropertyDao.delete(t);
			return Result.success(R.DataProperty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataProperty.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataProperty> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			DataProperty dataProperty = (DataProperty) session.get(DataProperty.class, id);
			if(dataProperty.getFixed() == BooleanEnum.YES){
				return Result.failure("不能删除系统预设的数据项");
			} else {
				session.createQuery("delete DataProperty where id="+id).executeUpdate();
				Object count = session.createQuery("select count(*) from DataProperty where parentId="+dataProperty.getParentId()).uniqueResult();
				if(count instanceof Integer) {
					Integer c = Integer.class.cast(count);
					if(c==0){
						session.createQuery("update DataProperty set leaf = "+true+" where id = "+dataProperty.getParentId()).executeUpdate();
					}
				} else if(count instanceof Long){
					Long c = Long.class.cast(count);
					if(c==0){
						session.createQuery("update DataProperty set leaf = "+true+" where id = "+dataProperty.getParentId()).executeUpdate();
					}
				}
				tr.commit();
			}
			return Result.success(R.DataProperty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataProperty.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<DataProperty> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			List<DataProperty> dataPropertyList = session.createQuery(
					"from dataProperty where id in ("+ids+")").list();
			for (DataProperty dataProperty : dataPropertyList) {
				if(dataProperty.getFixed() == BooleanEnum.YES){
					return Result.failure("不能删除系统预设的数据项分组");
				}else{
					session.delete(dataProperty);
				}
			}
			tr.commit();
			return Result.success(R.DataProperty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataProperty.DELETE_FAILURE);
		} finally{
			session.close();
		}
	}

	@Override
	public Result<DataProperty> update(DataProperty t) {
		Session session = null;
		Transaction tr = null;
		try {
			if(t.getFixed() == BooleanEnum.YES){
				return Result.failure("不能修改系统预设的数据项分组");
			}
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			DataProperty old = dataPropertyDao.getBeanById(t.getId());
			if(!(old.getParentId()==null && t.getParentId()==null)){
				if(old.getParentId()!=null){
					DataProperty oldParent = dataPropertyDao.getBeanById(old.getParentId());
					List<DataProperty> brothers = dataPropertyDao.getListByFilter(new Filter(DataProperty.class).eq("parentId",old.getParentId()));
					if(brothers.size()==1){
						oldParent.setLeaf(true);
						session.update(oldParent);
					}
				}
				if(t.getParentId()!=null){
					DataProperty newParent = dataPropertyDao.getBeanById(t.getParentId());
					if(newParent.getLeaf()) {
						newParent.setLeaf(false);
						session.update(newParent);
					}
					t.setParentIds(newParent.getParentIds()+newParent.getId()+",");
				} else {
					t.setParentIds(",");
				}
				List<DataProperty> children = dataPropertyDao.getListByFilter(new Filter(DataProperty.class).eq("parentId",t.getId()));
				if(children!=null){
					for (DataProperty dataProperty : children) {
						dataProperty.setParentIds(dataProperty.getParentIds().replace(old.getParentIds(), t.getParentIds()));
						session.update(dataProperty);
					}
				}
			}
			session.update(t);
			tr.commit();
			return Result.success(R.DataProperty.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataProperty.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataProperty.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<DataProperty> getBeanById(Serializable id) {
		try {
			return Result.value(dataPropertyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataProperty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataProperty> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataPropertyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataProperty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataProperty>> getList() {
		try {
			return Result.value(dataPropertyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataProperty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataProperty>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataPropertyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataProperty.LOAD_FAILURE);
		}
	}

	@Override
	public Result up(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			DataProperty property = (DataProperty) session.get(DataProperty.class, id);
			int order = property.getOrder();
			String hql = "from DataProperty where level = "+property.getLevel()+" and parentId";
			if(property.getParentId()!=null){
				hql += " = '"+property.getParentId()+"' ";
			} else {
				hql += " is Null ";
			}
			hql += "and order < "+order+" order by order desc";
			TreeEntity brother = (TreeEntity) session.createQuery(hql).setMaxResults(1).uniqueResult();
			if(brother!=null){
				property.setOrder(brother.getOrder());
				brother.setOrder(order);
				session.update(property);
				session.update(brother);
				tr.commit();
			}
			return Result.success();
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("");
		} finally {
			session.close();
		}
	}

	@Override
	public Result down(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataPropertyDao.openSession();
			tr = session.beginTransaction();
			DataProperty property = (DataProperty) session.get(DataProperty.class, id);
			int order = property.getOrder();
			String hql = "from DataProperty where level = "+property.getLevel()+" and parentId";
			if(property.getParentId()!=null){
				hql += " = '"+property.getParentId()+"' ";
			} else {
				hql += " is Null ";
			}
			hql += "and order > "+order+" order by order asc";
			TreeEntity brother = (TreeEntity) session.createQuery(hql).setMaxResults(1).uniqueResult();
			if(brother!=null){
				property.setOrder(brother.getOrder());
				brother.setOrder(order);
				session.update(property);
				session.update(brother);
				tr.commit();
			}
			return Result.success();
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("");
		} finally {
			session.close();
		}
	}

	@Override
	public Result<List<DataProperty>>  getListByConfigIds(String ids){
			
		String sql = "SELECT p.id,p.parent_id,p.leaf,p.level,p.name  FROM "+ModulePrefixNamingStrategy.classToTableName(DataProperty.class)+
				" p LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(DataTemplatePropertyConfig.class)+
				" c ON p.id = c.property_id  WHERE c.property_id in ("+ids+") GROUP BY p.id,p.parent_id,p.leaf,p.level,p.name";
		List<Object> list = new ArrayList<Object>();
		list = dataPropertyDao.getObjectListBySql(sql);
		List<DataProperty> dpList = new ArrayList<DataProperty>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long id = Long.parseLong(String.valueOf(objects[0]));
			Long parentId = null;
			if(objects[1]!=null){
				parentId = Long.parseLong(String.valueOf(objects[1]));
			}
			Boolean leaf = Boolean.valueOf(String.valueOf(objects[2]));
			Integer level = Integer.parseInt(String.valueOf(objects[3]));
			String name = String.valueOf(objects[4]);
			DataProperty dp = new DataProperty();
			dp.setId(id);
			dp.setParentId(parentId);
			dp.setLeaf(leaf);
			dp.setLevel(level);
			dp.setName(name);
			dpList.add(dp);
		}
		List<DataProperty> newList = new ArrayList<DataProperty>();
		for(DataProperty d : dpList){
			if(d.getParentId()==null){
				newList.add(d);
			}
		}
		return Result.value(newList);
	}
}
