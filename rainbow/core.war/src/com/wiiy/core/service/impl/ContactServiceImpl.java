package com.wiiy.core.service.impl;



import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.core.dao.ContactDao;
import com.wiiy.core.dto.ContactDto;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.preferences.ContactBaseR;
import com.wiiy.core.preferences.enums.ContactStatusEnum;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.service.ContactService;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ContactServiceImpl implements ContactService{
	
	private ContactDao contactDao;
	
	public void setContactDao(ContactDao contactDao) {
		this.contactDao = contactDao;
	}

	@Override
	public List<ContactDto> listMyAll(Pager pager,Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select id,type,creator,modify_time,status,create_time from contactTotal where creator_id = "+userId+" ORDER BY status ASC , create_time DESC "+" limit "+(pager.getPage()-1)*pager.getRows()+" , "+pager.getRows();
		    List<Object> list = session.createSQLQuery(sql).list();
		    List<ContactDto> dtoList = new ArrayList<ContactDto>();
		    if(list.size()>0){
		    	for(Object ob : list){
		    		Object[] objects = (Object[]) ob;
		    		ContactDto dto = new ContactDto();
		    		if(objects[0]!=null){
		    		dto.setId(((BigInteger)objects[0]).longValue());
		    		}
		    		if(objects[1]!=null){
		    		dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
		    		}
		    		if(objects[2]!=null){
		    		dto.setUserName((String) objects[2]);
		    		}
		    		if(objects[3]!=null){
		    		dto.setModify_time((Date) objects[3]);
		    		}
		    		if(objects[4]!=null){
		    		dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]) );
		    		}
		    		if(objects[5]!=null){
		    		dto.setCreate_time((Date)objects[5]);
		    		}
		    		dtoList.add(dto);
		    	}
		    }
		    tr.commit();
		    return dtoList;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}
	@Override
	public List<ContactDto> listMyAll(Pager pager,Long userId,ContactTypeEnum type) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select id,type,creator,modify_time,status,create_time from contactTotal where creator_id = "+userId+" and type = '"+type+"' ORDER BY status ASC , create_time DESC "+" limit "+(pager.getPage()-1)*pager.getRows()+" , "+pager.getRows();
			List<Object> list = session.createSQLQuery(sql).list();
			List<ContactDto> dtoList = new ArrayList<ContactDto>();
			if(list.size()>0){
				for(Object ob : list){
					Object[] objects = (Object[]) ob;
					ContactDto dto = new ContactDto();
					if(objects[0]!=null){
						dto.setId(((BigInteger)objects[0]).longValue());
					}
					if(objects[1]!=null){
						dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
					}
					if(objects[2]!=null){
						dto.setUserName((String) objects[2]);
					}
					if(objects[3]!=null){
						dto.setModify_time((Date) objects[3]);
					}
					if(objects[4]!=null){
						dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]) );
					}
					if(objects[5]!=null){
						dto.setCreate_time((Date)objects[5]);
					}
					dtoList.add(dto);
				}
			}
			tr.commit();
			return dtoList;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}
	
	@Override
	public List<ContactDto> listAll(Pager pager) {
		return listAll(pager,null);
	}
	
	@Override
	public List<ContactDto> listAll(Pager pager,ContactTypeEnum type) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select id,type,creator,modify_time,status,create_time from contactTotal";
			if (type != null) {
				sql += " WHERE type = '"+type+"'";
			}
			sql += " ORDER BY status ASC , create_time DESC limit "+(pager.getPage()-1)*pager.getRows()+" , "+pager.getRows();
		    List<Object> list = session.createSQLQuery(sql).list();
		    List<ContactDto> dtoList = new ArrayList<ContactDto>();
		    if(list.size()>0){
		    	for(Object ob : list){
		    		Object[] objects = (Object[]) ob;
		    		ContactDto dto = new ContactDto();
		    		if(objects[0]!=null){
		    		dto.setId(((BigInteger)objects[0]).longValue());
		    		}
		    		if(objects[1]!=null){
		    		dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
		    		}
		    		if(objects[2]!=null){
		    		dto.setUserName((String) objects[2]);
		    		}
		    		if(objects[3]!=null){
		    		dto.setModify_time((Date) objects[3]);
		    		}
		    		if(objects[4]!=null){
		    		dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]) );
		    		}
		    		if(objects[5]!=null){
		    		dto.setCreate_time((Date)objects[5]);
		    		}
		    		dtoList.add(dto);
		    	}
		    }
		    tr.commit();
		    return dtoList;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ContactLog> getContactLogList(ContactTypeEnum type, Long id) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			List<ContactLog> list = new ArrayList<ContactLog>();
			String hql = "from ContactLog where contactType = '"+type+"' and contactId = "+id;
			list = session.createQuery(hql).list();
			tr.commit();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
				
		
	}

	@Override
	public ContactDto getContactDto(ContactTypeEnum type, Long id) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select * from contactTotal where type = '"+type+"' and id = "+id;
			Object object = session.createSQLQuery(sql).uniqueResult();
			if(object == null){
				tr.commit();
				return null;
			}
			Object[] objects = (Object[]) object;
    		ContactDto dto = new ContactDto();
    		if(objects[0]!=null){
    			dto.setId(((BigInteger)objects[0]).longValue());
    		}
    		if(objects[1]!=null){
    			dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
    		}
    		if(objects[2]!=null){
    			dto.setUserName((String) objects[2]);
    		}
    		if(objects[3]!=null){
    			dto.setModify_time((Date) objects[3]);
    		}
    		if(objects[4]!=null){
    			dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]));
    		}
    		if(objects[5]!=null){
	    		dto.setCreate_time((Date)objects[5]);
	    	}
			tr.commit();
			return dto;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@Override
	public int totalCount() {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select count(*) from contactTotal";
			int total = ((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
			tr.commit();
			return total;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return 0;
		}finally{
			session.close();
		}
	}

	@Override
	public int myTotalCount(Long userId,ContactTypeEnum type) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select count(*) from contactTotal where creator_id = "+userId+" and type = '"+type+"'";
			int total = ((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
			tr.commit();
			return total;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return 0;
		}finally{
			session.close();
		}
	}
	@Override
	public int myTotalCount(Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select count(*) from contactTotal where creator_id = "+userId;
			int total = ((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
			tr.commit();
			return total;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return 0;
		}finally{
			session.close();
		}
	}

	@Override
	public int myTotalWaitCountersignCount(Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select count(*) from contactTotal where receive_id = "+userId;
			int total = ((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
			tr.commit();
			return total;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return 0;
		}finally{
			session.close();
		}
	}
	@Override
	public int myTotalDidCountersignCount(Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String likeId = ","+userId+",";
			String sql = "select count(*) from contactTotal where used_ids like '%"+likeId+"%'";
			int total = ((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
			tr.commit();
			return total;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return 0;
		}finally{
			session.close();
		}
	}

	@Override
	public List<ContactDto> listMyDidCountersignAll(Pager pager, Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String likeId = ","+userId+",";
				String sql = "select id,type,creator,modify_time,status,create_time from contactTotal where used_ids like '%"+likeId+"%'";
				 List<Object> list = session.createSQLQuery(sql).list();
				    List<ContactDto> dtoList = new ArrayList<ContactDto>();
				    if(list.size()>0){
				    	for(Object ob : list){
				    		Object[] objects = (Object[]) ob;
				    		ContactDto dto = new ContactDto();
				    		if(objects[0]!=null){
				    		dto.setId(((BigInteger)objects[0]).longValue());
				    		}
				    		if(objects[1]!=null){
				    		dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
				    		}
				    		if(objects[2]!=null){
				    		dto.setUserName((String) objects[2]);
				    		}
				    		if(objects[3]!=null){
				    		dto.setModify_time((Date) objects[3]);
				    		}
				    		if(objects[4]!=null){
				    		dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]) );
				    		}
				    		if(objects[5]!=null){
				    		dto.setCreate_time((Date)objects[5]);
				    		}
				    		dtoList.add(dto);
				    	}
				    }
				    tr.commit();
				    return dtoList;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@Override
	public List<ContactDto> listMyWaitCountersignAll(Pager pager, Long userId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = contactDao.openSession();
			tr = session.beginTransaction();
			String sql = "select id,type,creator,modify_time,status,create_time from contactTotal where receive_id = "+userId;
			 List<Object> list = session.createSQLQuery(sql).list();
			    List<ContactDto> dtoList = new ArrayList<ContactDto>();
			    if(list.size()>0){
			    	for(Object ob : list){
			    		Object[] objects = (Object[]) ob;
			    		ContactDto dto = new ContactDto();
			    		if(objects[0]!=null){
			    		dto.setId(((BigInteger)objects[0]).longValue());
			    		}
			    		if(objects[1]!=null){
			    		dto.setType(ContactTypeEnum.valueOf((String) objects[1]));
			    		}
			    		if(objects[2]!=null){
			    		dto.setUserName((String) objects[2]);
			    		}
			    		if(objects[3]!=null){
			    		dto.setModify_time((Date) objects[3]);
			    		}
			    		if(objects[4]!=null){
			    		dto.setStatus(ContactStatusEnum.valueOf((String) objects[4]) );
			    		}
			    		if(objects[5]!=null){
			    		dto.setCreate_time((Date)objects[5]);
			    		}
			    		dtoList.add(dto);
			    	}
			    }
			    tr.commit();
			    return dtoList;
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}


	


}
