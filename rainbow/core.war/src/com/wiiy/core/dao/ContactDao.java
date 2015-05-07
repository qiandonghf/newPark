package com.wiiy.core.dao;


import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.wiiy.hibernate.SessionService;


/**
 * @author my
 */
public class ContactDao {
	protected SessionFactory sessionFactory;
	
	public void setSessionService(SessionService sessionService) {
		sessionFactory = sessionService.getSessionFactory();
	}
	
	public Session openSession(){
		return sessionFactory.openSession();
	}
}