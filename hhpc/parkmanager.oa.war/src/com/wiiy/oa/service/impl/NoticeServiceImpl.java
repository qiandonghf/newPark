package com.wiiy.oa.service.impl;


import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.entity.Notice;
import com.wiiy.oa.entity.NoticeAtt;
import com.wiiy.oa.dao.NoticeDao;
import com.wiiy.oa.service.NoticeService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.NoticeStatusEnum;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class NoticeServiceImpl implements NoticeService{
	
	private NoticeDao noticeDao;
	
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

	@Override
	public Result save(Notice t, String attAddress) {
		Session session = null;
		Transaction tr = null;
		try {
			session = noticeDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(attAddress!=null && attAddress.length()>0){
				attAddress = attAddress.substring(0,attAddress.length()-1);
				String add[] = attAddress.split(";");
				for(int i=0; i<add.length;i++){
					NoticeAtt att = new NoticeAtt();
					att.setNotice(t);
					att.setNoticeId(t.getId());
					att.setCreateTime(new Date());
					att.setCreator(OaActivator.getSessionUser().getRealName());
					att.setCreatorId(OaActivator.getSessionUser().getId());
					att.setModifyTime(t.getCreateTime());
					att.setModifier(t.getCreator());
					att.setModifierId(t.getCreatorId());
					att.setEntityStatus(EntityStatus.NORMAL);
					String oneAdd[] = add[i].split(",");
					String path = oneAdd[0];
					String size = oneAdd[1];
					long sizeLong = Long.parseLong(size);
					String name = oneAdd[2];
					att.setName(name);
					att.setNewName(path);
					att.setSize(sizeLong);
					session.save(att);
				}
			}
			tr.commit();
			return Result.success(R.Notice.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Notice.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Notice.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<Notice> save(Notice t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			noticeDao.save(t);
			return Result.success(R.Notice.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Notice.class)));
		} catch (Exception e) {
			return Result.failure(R.Notice.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Notice> delete(Notice t) {
		try {
			noticeDao.delete(t);
			return Result.success(R.Notice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Notice.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Notice> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = noticeDao.openSession();
			tr = session.beginTransaction();
			session.createQuery("delete from NoticeAtt where noticeId = "+id).executeUpdate();
			session.createQuery("delete from Notice where id = "+id).executeUpdate();
			tr.commit();
			return Result.success(R.Notice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Notice.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<Notice> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = noticeDao.openSession();;
			tr = session.beginTransaction();
			StringBuilder sb = new StringBuilder(ids);
			sb.append(")");
			sb.insert(0,"(");
			ids = sb.toString();
			session.createQuery("delete from NoticeAtt where noticeId in "+ids).executeUpdate();
			session.createQuery("delete from Notice where id in "+ids).executeUpdate();
			tr.commit();
			return Result.success(R.Notice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Notice.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<Notice> update(Notice t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			noticeDao.update(t);
			return Result.success(R.Notice.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Notice.class)));
		} catch (Exception e) {
			return Result.failure(R.Notice.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Notice> update(Notice t,String attAddress) {
		Session session = null;
		Transaction tr = null;
		try {
			session = noticeDao.openSession();
			tr = session.beginTransaction();
			
			List<NoticeAtt> list = session.createQuery("from NoticeAtt where noticeId = "+t.getId()).list();
			for (NoticeAtt noticeAtt : list) {
				session.delete(noticeAtt);
			}
			if(attAddress!=null && !attAddress.equals("")){
				String[] files = attAddress.split(";");
				for (String string : files) {
					NoticeAtt noticeAtt = new NoticeAtt();
					noticeAtt.setName(string.split(",")[2]);
					noticeAtt.setSize(Long.parseLong(string.split(",")[1]));
					noticeAtt.setNewName(string.split(",")[0]);
					noticeAtt.setNoticeId(t.getId());
					setcreatemodify(noticeAtt);
					session.save(noticeAtt);
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			session.update(t);
			tr.commit();
			return Result.success(R.Notice.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Notice.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Notice.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	public void setcreatemodify(BaseEntity t){
		t.setCreateTime(new Date());
		t.setCreator(OaActivator.getSessionUser().getRealName());
		t.setCreatorId(OaActivator.getSessionUser().getId());
		t.setModifyTime(t.getCreateTime());
		t.setModifier(t.getCreator());
		t.setModifierId(t.getCreatorId());
		t.setEntityStatus(EntityStatus.NORMAL);
	}
	
	@Override
	public Result<Notice> getBeanById(Serializable id) {
		try {
			return Result.value(noticeDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Notice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Notice> getBeanByFilter(Filter filter) {
		try {
			return Result.value(noticeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Notice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Notice>> getList() {
		try {
			return Result.value(noticeDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Notice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Notice>> getListByFilter(Filter filter) {
		try {
			return Result.value(noticeDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Notice.LOAD_FAILURE);
		}
	}

	@Override
	public int getRowCount() {
		Session session = null;
		try{
			session = noticeDao.openSession();
			BigInteger count = (BigInteger) session.createSQLQuery("select count(*) from oa_notice where state = '"+NoticeStatusEnum.ISSUED+"' and issue_time <= now()").uniqueResult();
			return count.intValue();
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}finally{
			session.close();
		}
	}

}
