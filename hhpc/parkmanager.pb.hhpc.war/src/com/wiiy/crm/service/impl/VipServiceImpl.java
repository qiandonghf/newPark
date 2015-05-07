package com.wiiy.crm.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.VipDao;
import com.wiiy.crm.entity.Vip;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.VipService;
import com.wiiy.crm.util.Cipher;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.dto.CardDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

public class VipServiceImpl implements VipService{
	private VipDao vipDao;
	public void setVipDao(VipDao vipDao) {
		this.vipDao = vipDao;
	}
	
	@Override
	public Result<Vip> save(Vip t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			vipDao.save(t);
			PbActivator.getOperationLogService().logOP("添加专家【"+t.getName()+"】");
			return Result.success(R.Vip.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), Vip.class)));
		}catch(Exception e){
			return Result.failure(R.Vip.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Vip> delete(Vip t) {
		try{
			vipDao.delete(t);
			PbActivator.getOperationLogService().logOP("删除专家【"+t.getName()+"】");
			return Result.success(R.Vip.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(PbActivator.getFKMessage(e.getFK()));			
		}catch(Exception e){
			return Result.failure(R.Vip.DELETE_FAILURE);
		}
	}


	@Override
	public Result<Vip> deleteById(Serializable id) {
		try {
			vipDao.deleteById(id);
			PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的专家");
			return Result.success(R.Vip.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Vip.DELETE_FAILURE);
		}
	}


	@Override
	public Result<Vip> deleteByIds(String ids) {
		try {
			vipDao.deleteByIds(ids);
			for (String id : ids.split(",")) {
				PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的专家");
			}		
			return Result.success(R.Vip.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Vip.DELETE_FAILURE);
		}
	}


	@Override
	public Result<Vip> update(Vip t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			vipDao.update(t);
			PbActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的专家信息");
			return Result.success(R.Vip.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Vip.class)));
		} catch (Exception e) {
			return Result.failure(R.Vip.UPDATE_FAILURE);
		}
	}


	@Override
	public Result<Vip> getBeanById(Serializable id) {
		try {
			return Result.value(vipDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Vip.LOAD_FAILURE);
		}
	}


	@Override
	public Result<Vip> getBeanByFilter(Filter filter) {
		try {
			return Result.value(vipDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Vip.LOAD_FAILURE);
		}
	}


	@Override
	public Result<List<Vip>> getList() {
		try {
			return Result.value(vipDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Vip.LOAD_FAILURE);
		}
	}


	@Override
	public Result<List<Vip>> getListByFilter(Filter filter) {
		try {
			return Result.value(vipDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Vip.LOAD_FAILURE);
		}
	}
	
	@Override
	public Result<?> importCard() {
		try{
			/*Config config = PbActivator.getAppConfig().getConfig("cardGroupName");*/
			String groupName="专家";
			CardPubService cardPubService = PbActivator.getService(CardPubService.class);
			List<CardDto> cardDtoList = new ArrayList<CardDto>();
			
			List<Vip> vipList = vipDao.getList();
			for(Vip vip : vipList){
				cardDtoList.add(populate(vip, groupName));
			}
			cardPubService.ImportCards(cardDtoList);
			PbActivator.getOperationLogService().logOP("导入名片组【"+groupName+"】");
			return Result.success("导入成功");
		}catch(Exception e){
			return Result.failure("导入失败");
		}
	}
	
	private CardDto populate(Vip vip,String groupName){
		CardDto card = new CardDto();
		card.setGroupName(groupName);
		card.setCateName("专家");
		
		card.setName(vip.getName());
		card.setGender(vip.getGender());
		card.setMobile(vip.getMobile());
		card.setPosition(vip.getPosition());
		card.setMemo(vip.getMemo());
		card.setEmail(vip.getEmail());
		return card;
	}
	
	
	@Override
	public Result saveAccount(Long id, String username, String password,Long orgId) {
		try{
			Vip vip = vipDao.getBeanById(id);
			User user = new User();
			user.setEmail(vip.getEmail());
			user.setPassword(Cipher.md5(password));
			user.setUsername(username);
			user.setRealName(vip.getName());
			Org org = new Org();
			org.setId(orgId);
			user.setOrg(org);
			user.setUserType(UserTypeEnum.OTHER);
			OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
			Result<User> result = userService.createUser(user);
			if(result.isSuccess()){
				vip.setUserId(user.getId());
				vipDao.update(vip);
				//配置专家角色
				vipDao.executeSQLUpdate("insert into "+ModulePrefixNamingStrategy.classToTableName(UserRoleRef.class)+"(user_id,role_id) values("+user.getId()+",3)");
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
}
