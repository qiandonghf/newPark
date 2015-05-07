package com.wiiy.core.dao;

import java.util.List;

import org.hibernate.Session;

import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.hibernate.BaseDao;

public class RoleDao  extends BaseDao<Role>{
	
/*	@SuppressWarnings("unchecked")
	public Set<RoleAuthorityRef> getRoleAuthorityRefs(Long roleId) {
		
			List<RoleAuthorityRef> roleAuthorityRefs = 
					getSession().createCriteria(RoleAuthorityRef.class)
							.add(Property.forName("role.id").eq(roleId))
							.list();
			
			return roleAuthorityRefs;
	}
*/
	public void cleanAuthoritiesInModule(Long roleId, Long moduleId) {
			Session session=this.openSession();
			session.createQuery("delete from RoleAuthorityRef r where r.role.id="+roleId+" and r.moduleId="+moduleId).executeUpdate();
			if(session!=null)session.close();
	}
	public void saveAuthoritiesInModule(
			List<RoleAuthorityRef> authorityRefsInModlue) {
			Session session=this.openSession();
			for (RoleAuthorityRef roleAuthorityRef : authorityRefsInModlue) {
				session.save(roleAuthorityRef);
			}
			if(session!=null)session.close();
	}

	public Role getByName(String name) {
		Session session=this.openSession();
		try {
			
			return (Role) session.createQuery("select r from Role r where r.name = ?").setString(0, name).uniqueResult();
		} catch (Exception e) {
			return null;
		}finally{
			if(session!=null)session.close();
		}
		
	}
}
