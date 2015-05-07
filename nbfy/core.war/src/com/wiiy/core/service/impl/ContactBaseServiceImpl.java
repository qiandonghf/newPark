package com.wiiy.core.service.impl;

import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.ContactBaseDao;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.preferences.ContactBaseR;
import com.wiiy.core.preferences.enums.ContactResolveStatusEnum;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public abstract class ContactBaseServiceImpl<T extends ContactEntity> implements ContactBaseService<T> {

	private Class<?> c;

	protected abstract ContactBaseDao<T> getDao();

	public ContactBaseServiceImpl() {
		c = (Class<?>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}

//	public Result<?> listMyAll() {
//		Session session = null;
//		Transaction tr = null;
//		try {
//			session = getDao().openSession();
//			tr = session.beginTransaction();
//
//			String sql = "select id,type,creator,modify_time from contactTotal ";
//			List<?> list = session.createSQLQuery(sql).list();
//			tr.commit();
//			return Result.value(list);
//		} catch (Exception e) {
//			e.printStackTrace();
//			tr.rollback();
//			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
//		} finally {
//			session.close();
//		}
//	}

	public Result<?> revoke(T t){
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String opinionNow = t.getOpinionNow();
			String usedIds = t.getUsedIds();
			if(usedIds!=null){
				String newUsedIds = usedIds.substring(0,usedIds.length()-1);
				Long i = Long.valueOf(newUsedIds.substring(newUsedIds.lastIndexOf(",")+1));
				t.setReceiveId(i);
				if(newUsedIds.lastIndexOf(",")==0){//如果处理过的人只有一个：比如 usedIds为（,7,）    那么要把7这个人设为recievid  且将usedIds置空      usedIds 不能为空字符串   不然下次发送会发生错误。
					t.setUsedIds(null);
				}else{
					t.setUsedIds(newUsedIds.substring(0, newUsedIds.lastIndexOf(",")+1));
				}
			}else{
				t.setReceiveId(null);
			}
			String setOpinion = "set"+StringUtil.convertFirstCharToUpperCase(opinionNow);
			String setOpinionId = "set"+StringUtil.convertFirstCharToUpperCase(opinionNow+"Id");
			c.getMethod(setOpinion,String.class).invoke(t, BeanUtil.emptyObject());
			c.getMethod(setOpinionId,Long.class).invoke(t, BeanUtil.emptyObject());
			session.update(t);
			
			
			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(t.getId());
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			Long userId = CoreActivator.getSessionUser().getId();
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单撤回");
			session.save(contactLog);
			
			tr.commit();
			return Result.success("撤回成功");
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
		} finally {
			session.close();
		}
		
	}
	
	@Override
	public Result<?> accept(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String hql = "UPDATE " + c.getSimpleName() + " SET status = '" + ContactStatusEnum.ACCEPT + "' WHERE id =" + id;
			session.createQuery(hql).executeUpdate();

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为受理状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.ACCEPT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.ACCEPT_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> close(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET status = '" + ContactStatusEnum.CLOSE + "' WHERE id =" + id;
			session.createQuery(sql).executeUpdate();

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为关闭状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.CLOSE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.CLOSE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> partsolved(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET resolveStatus = '" + ContactResolveStatusEnum.PARTSOLVED + "' WHERE id =" + id;
			session.createQuery(sql).executeUpdate();;

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为部分解决状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.UPDATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> print(Long id, OutputStream out) {
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Result<?> send(Long id, Long receiveId, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET receiveId = " + receiveId + " WHERE id =" + id;
			session.createQuery(sql).executeUpdate();;

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			String sqlForReceiveName = "select real_name from core_user where id = " + receiveId;
			String receiveName = session.createSQLQuery(sqlForReceiveName).uniqueResult().toString();
			contactLog.setContent("将联系单发送给" + receiveName);
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.SEND_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.SEND_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> solved(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET resolveStatus = '" + ContactResolveStatusEnum.SOLVED + "' WHERE id =" + id;
			session.createQuery(sql).executeUpdate();;

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为解决状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.UPDATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> suspend(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET status = '" + ContactStatusEnum.SUSPEND + "' WHERE id =" + id;
			session.createQuery(sql).executeUpdate();

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为挂起状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.SUSPEND_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.SUSPEND_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<?> unSolved(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			String sql = "UPDATE " + c.getSimpleName() + " SET resolveStatus = '" + ContactResolveStatusEnum.UNSOLVED + "' WHERE id =" + id;
			session.createQuery(sql).executeUpdate();;

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单设为为解决状态");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.UPDATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	public Result<T> delete(T t, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			getDao().delete(t);

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(t.getId());
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单删除");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	public Result<T> deleteById(Long id, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			getDao().deleteById(id);

			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			contactLog.setCreateTime(new Date());
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("将联系单删除");
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	public Result<?> deleteById(Long id ,ContactTypeEnum type){
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();
			getDao().deleteById(id);
			String sql = "delete from core_contact_log where contact_type = '"+type+"' and contact_id = "+id;
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	public Result<T> deleteByIds(String ids, Long userId) {
		try {
			getDao().deleteByIds(ids);
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		}
	}

	@Override
	public Result<T> getBeanByFilter(Filter filter) {
		try {
			ContactBaseDao<T> dao = getDao();
			return Result.value(dao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<T> getBeanById(Serializable id) {
		try {
			return Result.value(getDao().getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<T>> getList() {
		try {
			return Result.value(getDao().getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<T>> getListByFilter(Filter filter) {
		try {
			return Result.value(getDao().getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.LOAD_FAILURE);
		}
	}

	public Result<T> save(T t, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();
			
			String sqlForUserName = "select real_name from core_user where id = " + userId;
			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
			t.setCreateTime(new Date());
			t.setCreatorId(userId);
			t.setCreator(userName);
			t.setModifier(userName);
			t.setModifierId(userId);
			t.setModifyTime(t.getCreateTime());
			t.setStatus(ContactStatusEnum.ACCEPT);
			Serializable id = getDao().save(t);
			
			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(t.getId());
			contactLog.setCreateTime(new Date());
			
			contactLog.setCreatorId(userId);
			contactLog.setCreator(userName);
			contactLog.setModifier(userName);
			contactLog.setModifierId(userId);
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContent("新建联系单");
			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure("已经发起过该联系单");
		}catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	public Result<T> update(T t, Long userId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();

			getDao().update(t);

//			ContactLog contactLog = new ContactLog();
//			contactLog.setContactId(t.getId());
//			contactLog.setContactType(ContactTypeEnum.valueOf(c.getSimpleName().toUpperCase()));
//			contactLog.setCreateTime(new Date());
//			String sqlForUserName = "select real_name from core_user where id = " + userId;
//			String userName = session.createSQLQuery(sqlForUserName).uniqueResult().toString();
//			contactLog.setCreatorId(userId);
//			contactLog.setCreator(userName);
//			contactLog.setModifier(userName);
//			contactLog.setModifierId(userId);
//			contactLog.setModifyTime(contactLog.getCreateTime());
//			contactLog.setContent("更新了联系单");
//			session.save(contactLog);
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.UPDATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	public Result<T> save(T t) {
		try {
			getDao().save(t);
			return Result.success(ContactBaseR.ContactBase.SAVE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.SAVE_FAILURE);
		}
	}

	public Result<T> update(T t) {
		try {
			getDao().update(t);
			return Result.success(ContactBaseR.ContactBase.UPDATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.UPDATE_FAILURE);
		}
	}

	public Result<T> delete(T t) {
		try {
			getDao().delete(t);
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		}
	}

	public Result<T> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = getDao().openSession();
			tr = session.beginTransaction();
			getDao().deleteById(id);
			String sql = "delete core_contact_log where contact_id="+id+"and contact_type ='"+c.getSimpleName()+"'";
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	public Result<T> deleteByIds(String ids) {
		try {
			getDao().deleteByIds(ids);
			return Result.success(ContactBaseR.ContactBase.DELETE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(ContactBaseR.ContactBase.DELETE_FAILURE);
		}
	}
}
