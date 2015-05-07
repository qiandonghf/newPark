package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.OrgDao;
import com.wiiy.core.dao.RoleDao;
import com.wiiy.core.dao.UserDao;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.UserService;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.core.util.Cipher;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.OperationLogPubService;
import com.wiiy.external.service.dto.CardDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class UserServiceImpl implements UserService, OsgiUserService {
	
	
	private UserDao userDao;
	
	private RoleDao roleDao;
	
	private OrgDao orgDao;
	
	public void setOrgDao(OrgDao orgDao) {
		this.orgDao = orgDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	@Override
	public Result<User> save(User t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = userDao.openSession();
			tr = session.beginTransaction();
    		if (userDao.getBeanByFilter(new Filter(User.class).eq("username", t.getUsername()))!=null) {
    			return Result.failure(R.User.SAVE_FAILURE_DUPLICATED_NAME);
    		}
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			if(t.getEntityStatus()==null){
			t.setEntityStatus(EntityStatus.NORMAL);
			}
			session.save(t);
			/*if(t.getMsn()!=null&&!t.getMsn().equals("")){
				SMSPubService smsPubService = CoreActivator.getService(SMSPubService.class);
				String receiverMobile = "";
				if(t.getMobile()!=null){
					receiverMobile = t.getMobile();
				}
				String content = CoreActivator.getAppConfig().getConfig("accountCreate").getParameter("email");
				content = content.replace("${username}", t.getRealName());
				content = content.replace("${accountName}", t.getUsername()+"【"+t.getUserType().getTitle()+"】");
				if(smsPubService!=null) smsPubService.send(receiverMobile, content, t.getRealName(), session);
			}
			if(t.getEmail()!=null&&!t.getEmail().equals("")){
				SysEmailSenderPubService sysEmailSenderPubService = CoreActivator.getService(SysEmailSenderPubService.class);
				String receiverEmail = "";
				if(t.getEmail()!=null){
					receiverEmail = t.getEmail();
				}
				String content = CoreActivator.getAppConfig().getConfig("accountCreate").getParameter("email");
				content = content.replace("${username}", t.getRealName());
				content = content.replace("${accountName}", t.getUsername()+"【"+t.getUserType().getTitle()+"】");
				String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
				content = content.replace("${url}", path+"core/index.action");
				String subject = "帐号创建成功提醒";
				if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(receiverEmail, content,subject);
			}*/
			tr.commit();
			return Result.success(R.User.SAVE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.User.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<User> delete(User t) {
		try {
			userDao.delete(t);
			return Result.success(R.User.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
			
		} catch (Exception e) {
			return Result.failure(R.User.DELETE_FAILURE);
		}
	}

	@Override
	public Result<User> deleteById(Serializable id) {
		try {
			userDao.deleteById(id);
			return Result.success(R.User.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.User.DELETE_FAILURE);
		}
	}

	@Override
	public Result<User> deleteByIds(String ids) {
		try {
			userDao.deleteByIds(ids);
			return Result.success(R.User.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.User.DELETE_FAILURE);
		}
	}

	@Override
	public Result<User> update(User t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = userDao.openSession();
			tr = session.beginTransaction();
			User dbUserWithSameName = userDao.getBeanByFilter(new Filter(User.class).eq("username", t.getUsername()));
    		if (dbUserWithSameName != null && !t.getId().equals(dbUserWithSameName.getId())) {
    			return Result.failure(R.User.SAVE_FAILURE_DUPLICATED_NAME);
    		}
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			session.update(t);
			session.createQuery("delete UserRoleRef where User.id is null").executeUpdate();
			tr.commit();
			return Result.success(R.User.UPDATE_SUCCESS);
		} catch (Throwable e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.User.UPDATE_FAILURE);
//			return Result.failure(R.User.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<User> getBeanById(Serializable id) {
		try {
			return Result.value(userDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.User.LOAD_FAILURE);
		}
	}

	@Override
	public Result<User> getBeanByFilter(Filter filter) {
		try {
			return Result.value(userDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.User.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<User>> getList() {
		try {
			return Result.value(userDao.getList());
		} catch (Exception e) {
			return Result.failure(R.User.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<User>> getListByFilter(Filter filter) {
		try {
			return Result.value(userDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.User.LOAD_FAILURE);
		}
	}

	@Override
	public Result<User> login(User user) {
		OperationLogPubService logService=CoreActivator.getService(OperationLogPubService.class);
		if(logService!=null){
		}
		try {
			User dbUser = userDao.getBeanByFilter(new Filter(User.class).eq("username", user.getUsername()));
			if(dbUser.getEntityStatus()==EntityStatus.LOCKED){
				return Result.failure("用户状态为锁定");
			}
//			Set<UserRoleRef> userRoleRef = dbUser.getRoleRefs();
//			if(userRoleRef!=null){
//				for(UserRoleRef ref:userRoleRef){
//					Role role = ref.getRole();
//					if(role.getEntityStatus()==EntityStatus.LOCKED){
//						return Result.failure("用户状态为锁定");
//					}
//				}
//			}
			//if(dbUser.getOrg()!=null)
			if (Cipher.md5(user.getPassword()).equals(dbUser.getPassword())) {
				dbUser.setPreviousLoginTime(dbUser.getLastLoginTime());
				dbUser.setLastIp(dbUser.getIp());
				dbUser.setIp(user.getIp());
				dbUser.setLastLoginTime(new Date());
				dbUser.setRoleRefIds(populateIds(dbUser.getRoleRefs()));
				userDao.update(dbUser);
				return Result.value(dbUser);
			} else {
				return Result.failure("用户名或密码不对！");
			}
		} catch (Exception e) {
			return Result.failure("用户名或密码不对！");
		}
	}

	private Set<Long> populateIds(Set<UserRoleRef> roleRefs) {
		Set<Long> roleRefIds = new HashSet<Long>();
		for (UserRoleRef userRoleRef : roleRefs) {
			roleRefIds.add(userRoleRef.getRole().getId());
		}
		return roleRefIds;
	}

	@Override
	public User getById(Long id) {
		return userDao.getBeanById(id);
	}

	@Override
	public Result<User> updatePassword(
			User user, String oldPassword, String newPassword) {
		
		User dbUser = userDao.getBeanById(user.getId());
		
		String oldPasswordHash = Cipher.md5(oldPassword);
		
		if (!oldPasswordHash.equals(dbUser.getPassword())) {
			return Result.failure(R.User.UPDATE_PASSWORD_FAILURE);
		}
		
		try {
			dbUser.setPassword(Cipher.md5(newPassword));
			userDao.update(dbUser);
			return Result.success(R.User.UPDATE_PASSWORD_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.User.UPDATE_PASSWORD_FAILURE);
		}
	}

	@Override
	public Set<UserRoleRef> getUserRoleRefs(Long id) {
		Set<UserRoleRef> roleRefs = userDao.getBeanById(id).getRoleRefs();
		for (UserRoleRef userRoleRef : roleRefs) {
			if(userRoleRef!=null){
				userRoleRef.getRole().getAuthorityRefs();
			}
		}
		return roleRefs;
	}

	@Override
	public Result<User> merge(User t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			userDao.merge(t);
			return Result.success(R.User.UPDATE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.User.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<?> importCard(String ids) {
		try {
			Config config=CoreActivator.getAppConfig().getConfig("cardGroupName");
			String groupName=config.getParameter("name");
			
			
			//先将groupName的编码格式进行转换，不然虽然导入名片成功，但是会出现乱码
			//byte[] str = groupName.getBytes("ISO-8859-1");
			//String groupNewName = new String(str, "UTF-8");
			CardPubService cardPubService = CoreActivator.getService(CardPubService.class);
			List<CardDto> cardDtoList = new ArrayList<CardDto>();
			Filter filter = new Filter(User.class).eq("userType", UserTypeEnum.Center).eq("entityStatus", EntityStatus.NORMAL);
			if(!ids.equals("")){
				String [] idss = ids.split(",");
				Long[] idsl = new Long[idss.length];
				int index=0;
				for(String s : idss){
					idsl[index++] = Long.parseLong(idss[index-1]);
				}
				filter.in("id", idsl);
			}
			List<User> userList=getListByFilter(filter).getValue();
			for (User user : userList) {
				cardDtoList.add(populate(user, groupName));
			}
			cardPubService.ImportCards(cardDtoList);
			CoreActivator.getOperationLogService().logOP("导入名片组【"+groupName+"】");
			return Result.success("导入成功");
		} catch (Exception e) {
			return Result.failure("导入失败");
		}
	}

	private CardDto populate(User user, String groupName) {
		
		CardDto card=new CardDto();
		
		card.setGroupName(groupName);
		if(user.getUserType()==UserTypeEnum.Center){
			card.setCateName("中心用户");
		}
		else if(user.getUserType()==UserTypeEnum.Customer){
			card.setCateName("企业用户");
		}
		else{
			card.setCateName("未知类型");
		}
		
		
		card.setName(user.getRealName());
		card.setBirthDay(user.getBirthday());
		card.setMobile(user.getMobile());
		card.setMsn(user.getMsn());
		card.setGender(user.getGender());
		card.setOfficeTel(user.getTelephone());
		card.setEmail(user.getEmail());

		return card;
	}

	@Override
	public Result<?> resetPwd(Long id) {
		try{
			User user=userDao.getBeanById(id);
			if(user!=null){
				user.setPassword(Cipher.md5("123456"));
				userDao.update(user);
			}
			return Result.success("密码重置成功！");
		}catch (Exception e) {
			return Result.failure("密码重置失败");
		}
		
	}

	@Override
	public List<User> getUsersByIds(String[] ids) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<User> createUser(User t) {
		try{
			List<User> userList = getListByFilter(new Filter(User.class).eq("username", t.getUsername())).getValue();
			if(userList.size()>0 && userList!=null){
				return Result.failure("用户名已存在");
			}
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setEntityStatus(EntityStatus.NORMAL);
			userDao.save(t);
			return Result.success("创建用户成功");
	} catch (Exception e) {
		return Result.failure(R.User.SAVE_FAILURE);
	}
}

	@Override
	public Result<User> updateUser(Long id , String password) {
		try {
			User t = getById(id);
			if(t.getPassword().equals(Cipher.md5(password))){
				return Result.failure("新密码不能和旧密码相同");
			}
			t.setPassword(Cipher.md5(password));
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
//			userDao.update(t);
//			userDao.merge(t);
//			return updatePassword(t,t.getPassword(),password);
//			return Result.success("密码修改成功");
			return merge(t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),User.class)));
		} catch (Exception e) {
			return Result.failure(R.User.UPDATE_FAILURE);
		}
	}

	@Override
	public User getByHql(String hql) {
		return userDao.getBeanByHql(hql);
	}

	@Override
	public Set<UserRoleRef> getUserRoleRefById(Long id) {
		return this.getUserRoleRefs(id);
	}

}
