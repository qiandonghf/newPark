package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.AgencyDao;
import com.wiiy.crm.entity.Agency;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.AgencyEnum;
import com.wiiy.crm.service.AgencyService;
import com.wiiy.crm.util.Cipher;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.dto.CardDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

public class AgencyServiceImpl implements AgencyService{
	private AgencyDao agencyDao;
	public void setAgencyDao(AgencyDao agencyDao) {
		this.agencyDao = agencyDao;
	}

	@Override
	public Result<Agency> save(Agency t) {
		try{
			List<Agency> list = getListByFilter(new Filter(Agency.class).eq("name", t.getName())).getValue();
			if(list!=null && list.size()>0){
				return Result.failure("服务机构已存在");
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			agencyDao.save(t);
			PbActivator.getOperationLogService().logOP("添加服务机构【"+t.getName()+"】");
			return Result.success(R.Agency.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Agency.class)));
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Agency.SAVE_FAILURE);
		}
	}
	@Override
	public Result<Agency> delete(Agency t) {
		try {
			agencyDao.delete(t);
			PbActivator.getOperationLogService().logOP("删除服务机构【"+t.getName()+"】");
			return Result.success(R.Agency.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Agency.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Agency> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = agencyDao.openSession();
			tr = session.beginTransaction();
			Agency agency = agencyDao.getBeanById(id);
			if(agency.getUserId()!=null){
				//删除机构,同时删除机构对应的登录用户信息
				session.createQuery("delete UserRoleRef where user_id = "+agency.getUserId()).executeUpdate();
				session.createQuery("delete User where id = "+agency.getUserId()).executeUpdate();
			}
			session.delete(agency);
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的服务机构");
			return Result.success(R.Agency.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Agency.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Agency> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = agencyDao.openSession();
			tr = session.beginTransaction();
			//删除机构,同时删除机构对应的登录用户信息
			List<Long> userIdList = agencyDao.getObjectListByHql("select userId from Agency where id in ("+ids+")");
			if(userIdList!=null && userIdList.size()>0){
				String userIds = "";
				for(int i=0;i<userIdList.size();i++){
					userIds += userIdList.get(i)+",";
				}
				String s = userIds.substring(userIds.length()-1);
				if(s.equals(",")){
					userIds = userIds.substring(0,userIds.length()-1);
					session.createQuery("delete UserRoleRef where user_id in ("+userIds+")").executeUpdate();
					session.createQuery("delete User where id in ("+userIds+")").executeUpdate();
				}
			}
			session.createQuery("delete Agency where id in ("+ids+")").executeUpdate();
			tr.commit();
			PbActivator.getOperationLogService().logOP("删除id为【"+ids+"】的服务机构");
			return Result.success(R.Agency.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Agency.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Agency> update(Agency t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			agencyDao.update(t);
			PbActivator.getOperationLogService().logOP("编辑服务机构【"+t.getName()+"】");
			return Result.success(R.Agency.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Agency.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Agency.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Agency> getBeanById(Serializable id) {
		try {
			return Result.value(agencyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Agency.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Agency> getBeanByFilter(Filter filter) {
		try {
			return Result.value(agencyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Agency.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Agency>> getList() {
		try {
			return Result.value(agencyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Agency.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Agency>> getListByFilter(Filter filter) {
		try {
			return Result.value(agencyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Agency.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<?> importCard() {
		try{
			//Config config = PbActivator.getAppConfig().getConfig("cardGroupName");
			String groupName = "服务伙伴";
			CardPubService cardPubService = PbActivator.getService(CardPubService.class);
			List<CardDto> cardDtoList = new ArrayList<CardDto>();
			
			List<Agency> agencyList = agencyDao.getList();
			for(Agency agency : agencyList){
				//负责人信息
				CardDto card = new CardDto();
				card.setGroupName(groupName);
				card.setName(agency.getCharger());
				card.setEmail(agency.getEmail());
				card.setHomeTel(agency.getPhone());
				card.setMobile(agency.getMobile());
				card.setPosition(agency.getPosition());
				card = populate(agency,card);
				cardDtoList.add(card);
				
				//联系人信息
				card = new CardDto();
				card.setGroupName(groupName);
				card.setName(agency.getContact());
				card.setHomeTel(agency.getContractPhone());
				card.setMobile(agency.getContractMobile());
				card.setPosition(agency.getCposition());
				card = populate(agency,card);
				cardDtoList.add(card);
			}
			cardPubService.ImportCards(cardDtoList);
			PbActivator.getOperationLogService().logOP("导入名片组【"+groupName+"】");
			return Result.success("导入成功");
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure("导入失败");
		}
	}
	
	private CardDto populate(Agency agency,CardDto card){
		card.setCateName("服务机构");
		card.setCompany(agency.getName());
		card.setCompanyAddr(agency.getAddress());
		card.setHomePage(agency.getHomePage());
		card.setZipCode(agency.getZipcode());
		card.setMemo(agency.getMemo());
		return card;
	}

	@Override
	public Result saveAccount(Long id, String username, String password,Long orgId) {
		try{
			Agency agency = agencyDao.getBeanById(id);
			User user = new User();
			user.setEmail(agency.getEmail());
			user.setPassword(Cipher.md5(password));
			user.setUsername(username);
			user.setRealName(agency.getName());
			Org org = new Org();
			org.setId(orgId);
			user.setOrg(org);
			user.setUserType(UserTypeEnum.OTHER);
			user.setRealName(agency.getName());
			OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
			Result<User> result = userService.createUser(user);
			if(result.isSuccess()){
				agency.setUserId(user.getId());
				agencyDao.update(agency);
				//判断类型分配角色
				if(agency.getAgencyType()!=null && agency.getAgencyType().equals(AgencyEnum.TZJG)){
					agencyDao.executeSQLUpdate("insert into "+ModulePrefixNamingStrategy.classToTableName(UserRoleRef.class)+"(user_id,role_id) values("+user.getId()+",4)");
				}
				return Result.success("账号新建成功");
			} else {
				return result;
			}
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure("账号新建失败");
		}
	}

	@Override
	public Result updateAccountPassword(Long id, String password) {
		try{
			OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
			return userService.updateUser(id, password);
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure("账号更新失败");
		}
	}
	
	/*private CardDto populate(Agency agency,String groupName){
		CardDto card = new CardDto();
		card.setGroupName(groupName);
		card.setCateName("服务机构");
		card.setName(agency.getName());
		card.setZipCode(agency.getZipcode());
		card.setEmail(agency.getEmail());
		card.setCompanyAddr(agency.getAddress());
		card.setHomePage(agency.getHomePage());
		card.setMemo(agency.getMemo());
		card.setMobile(agency.getMobile());
		card.setOfficeTel(agency.getPhone());
		return card;
	}*/
}
