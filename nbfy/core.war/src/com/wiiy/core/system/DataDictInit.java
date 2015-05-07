package com.wiiy.core.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.ResourceDto;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.extensions.ResourceExtensions;

public class DataDictInit {
	protected CachedLog logger = CachedLog.getLog(getClass());
	private List<DataDict> list=new ArrayList<DataDict>();
	public boolean init(){
		boolean r=true;
		//this.newData("core.0001", null, "核心模块", "上传路径", "d:\\upload\\", 1, 0,1);
		
		logger.debug("------系统初始化(admin)--------");
		/*initAdmin();*/
		return r;
	}
	
	/*
	 * 初始化admin帐号 超级管理员角色 admin权限
	 * 初始化顶级组织名称
	 * 
	 */
	public void initAdmin(){
		SessionFactory sessionFactory=CoreActivator.getService(SessionFactory.class);
		Session session=sessionFactory.openSession();
		
		Transaction tr=session.beginTransaction();
		try {
			String companyName=CoreActivator.getAppConfig().getConfig("companyName").getParameter("name");
			Org org=(Org)session.get(Org.class, (Long)1l);
			if(org==null){
				logger.debug("------++++++++++初始化顶级组织【"+companyName+"】++++++++--------");
				org=new Org();
				org.setId(1l);
				org.setName(companyName);
				org.setMemo("");
				org.setOrderCode(1);
				org.setLevelCode(0);
				org.setPathCode("1");
				org.setChildrenCount(0);
				org.setParent(null);
				session.save(org);
			}
			Org org2=(Org)session.get(Org.class, (Long)2l);
			if(org2==null){
				logger.debug("------++++++++++初始化 企业部门++++++++--------");
				org2=new Org();
				org2.setId(2l);
				org2.setName("企业部门");
				org2.setMemo("");
				org2.setOrderCode(2);
				org2.setLevelCode(1);
				org2.setPathCode("1");
				org2.setChildrenCount(0);
				org2.setParent(null);
				session.save(org2);
			}
			/*Org org3=(Org)session.get(Org.class, (Long)3l);
			if(org3==null){
				logger.debug("------++++++++++初始化 协会部门++++++++--------");
				org3=new Org();
				org3.setId(3l);
				org3.setName("协会部门");
				org3.setMemo("");
				org3.setOrderCode(3);
				org3.setLevelCode(1);
				org3.setPathCode("1");
				org3.setChildrenCount(0);
				org3.setParent(null);
				session.save(org3);
			}*/
			
			User user=(User)session.get(User.class, (Long)1l);
			if(user==null){
				logger.debug("------++++++++++初始化帐号【admin】++++++++--------");
				user=new User();
				user.setAdmin(BooleanEnum.YES);
				user.setBirthday(new Date());
				user.setEmail("");
				user.setGender(GenderEnum.Male);
				user.setId(1l);
				user.setIp(null);
				user.setLastIp(null);
				user.setLastLoginTime(null);
				user.setMobile("");
				user.setMsn("");
				user.setOrg(org);
				user.setUsername("admin");
				user.setPassword("e10adc3949ba59abbe56e057f20f883e");
				user.setRealName("超级管理员");
				user.setUserType(UserTypeEnum.Center);
				session.save(user);
				Role role=(Role)session.get(Role.class, (Long)1l);
				if(role==null){
					logger.debug("------++++++++++初始化角色【超级管理员】++++++++--------");
					role=new Role();
					role.setMemo("超级管理员");
					role.setName("admin");
					role.setId(1l);
					session.save(role);
					//加入核心系统的菜单
					logger.debug("------++++++++++初始化角色权限【超级管理员】++++++++--------");
					
					
					ResourceDto dto = ResourceExtensions.resourceMap.get("core");
					RoleAuthorityRef ref=new RoleAuthorityRef();
					ref.setId((long)1l);
					ref.setModuleId(0+"");
					ref.setAuthorityId(dto.getIdSpace());
					ref.setAuthorityType(dto.getType());
					ref.setRole(role);
					session.save(ref);
					List<ResourceDto> children = dto.getChildren();
					loadChildren(children,session,role);
				
					//加入核心系统模块
					logger.debug("------++++++++++初始化帐号权限【admin】++++++++--------");
					UserRoleRef userRoleRef=new UserRoleRef();
					userRoleRef.setId(1l);
					userRoleRef.setRole(role);
					userRoleRef.setUser(user);
					session.save(userRoleRef);
				}
			}
			Role role=(Role)session.get(Role.class, (Long)2l);
			if(role==null){
				logger.debug("------++++++++++初始化角色【企业帐号】++++++++--------");
				role=new Role();
				role.setMemo("企业帐号");
				role.setName("customer");
				role.setId(2l);
				session.save(role);
				
				ResourceDto dto = ResourceExtensions.resourceMap.get("ps");
				RoleAuthorityRef ref=new RoleAuthorityRef();
				ref.setModuleId(1+"");
				ref.setAuthorityId(dto.getIdSpace());
				ref.setAuthorityType(dto.getType());
				ref.setRole(role);
				session.save(ref);
				List<ResourceDto> children = dto.getChildren();
				loadChildren(children,session,role);
			}
			/*Role role2=(Role)session.get(Role.class, (Long)3l);
			if(role2==null){
				logger.debug("------++++++++++初始化角色【协会帐号】++++++++--------");
				role2=new Role();
				role2.setMemo("协会帐号");
				role2.setName("association");
				role2.setId(2l);
				session.save(role2);
			}*/
			tr.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
		}finally{
			if(session!=null)session.close();
		}
	}
	private void loadChildren(List<ResourceDto> children,Session session,Role role) {
		if(children!=null){
			for (ResourceDto resourceDto : children) {
				RoleAuthorityRef ref=new RoleAuthorityRef();
				ref.setModuleId(0+"");
				ref.setAuthorityId(resourceDto.getIdSpace());
				ref.setAuthorityType(resourceDto.getType());
				ref.setRole(role);
				session.save(ref);
				List<ResourceDto> subChildren = resourceDto.getChildren();
				loadChildren(subChildren,session,role);
			}
		}
	}

	/**
	 * 
	 * @param id
	 * @param parentId
	 * @param moduleName
	 * @param dataName
	 * @param value
	 * @param fixed 1 系统 0用户
	 * @param type 0单一值 1列表值
	 */
	private void newData(String id,String parentId,String moduleName,String dataName,String value,Integer fixed,Integer type,Integer order){
		DataDict dataDict=new DataDict();
		dataDict.setId(id);
		dataDict.setModuleName(moduleName);
		dataDict.setDataName(dataName);
		dataDict.setDataValue(value);
		dataDict.setFixed(fixed);
		dataDict.setParentId(parentId);
		dataDict.setType(type);
		dataDict.setDisplayOrder(order);
		list.add(dataDict);
	}
	public List<DataDict> getList() {
		init();
		return list;
	}
	
}
