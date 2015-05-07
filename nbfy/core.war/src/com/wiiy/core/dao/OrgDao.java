package com.wiiy.core.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;

import com.wiiy.core.entity.Org;
import com.wiiy.hibernate.BaseDao;

public class OrgDao extends BaseDao<Org>{
	
    public void updateSiblingOrder(Org org, int add) {
    	Session session = this.openSession();
        String pathCodePrefix = org.getParent().getPathCode() + ",";
        Query query = session.createQuery(
                "update from Org o " +
                        "set o.orderCode = o.orderCode + (" + add + "), o.pathCode = CONCAT(?, o.orderCode) " +
                        "where o.parent.id = ? and o.orderCode >= ?");
        query.setString(0, pathCodePrefix)
                .setLong(1, org.getParent().getId())
                .setInteger(2, org.getOrderCode());
        query.executeUpdate();
        if(session!=null)session.close();
    }

    @SuppressWarnings("unchecked")
    public List<Org> listByPathCode() {
    	Session session = this.openSession();
    	List<Org> list = session.createCriteria(Org.class).addOrder(Order.asc("pathCode")).list();
    	if(session!=null)session.close();
        return list;
    }

	public Org findOrgByName(String name) {
		Session session = this.openSession();
		try {
	        Query query = session.createQuery(
	                "select o from Org o where o.name=?").setString(0, name);
	        return (Org) query.uniqueResult();
		} catch (Exception e) {
			return null;
		}finally{
			if(session!=null)session.close();
		}
	}
}
