package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.crm.dao.StafferDao;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.entity.ProjectApply;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.StafferService;
import com.wiiy.external.service.CardPubService;
import com.wiiy.external.service.dto.CardDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class StafferServiceImpl implements StafferService{
	
	private StafferDao stafferDao;
	
	public void setStafferDao(StafferDao stafferDao) {
		this.stafferDao = stafferDao;
	}

	@Override
	public Result<Staffer> save(Staffer t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = stafferDao.openSession();
			tr = session.beginTransaction();
			if (t.getDegreeId().equals("")) {
				t.setDegreeId(null);
			}
			if (t.getPositionId().equals("")) {
				t.setPositionId(null);
			}
			if(t.getPoliticalId().equals("")){
				t.setPoliticalId(null);
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			
			if(t.getManager() == BooleanEnum.YES || t.getLegal() == BooleanEnum.YES){
				List<Staffer> staffers = getListByFilter(new Filter(Staffer.class).eq("customerId",t.getCustomerId()).or(Filter.Eq("manager", BooleanEnum.YES),Filter.Eq("legal", BooleanEnum.YES))).getValue();
				for (Staffer staffer : staffers) {
					if(staffer.getManager() == BooleanEnum.YES && t.getManager() == BooleanEnum.YES){
						staffer.setManager(BooleanEnum.NO);
					}else if(staffer.getLegal() == BooleanEnum.YES && t.getLegal() == BooleanEnum.YES){
						staffer.setLegal(BooleanEnum.NO);
					}
					session.update(staffer);
				}
			}
			session.save(t);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("添加主要人员【"+t.getName()+"】");
			customerModifyLog.setCustomer(customer);
			customerModifyLog.setCustomerId(t.getCustomerId());
			customerModifyLog.setCreateTime(new Date());
			customerModifyLog.setCreator(PbActivator.getSessionUser().getRealName());
			customerModifyLog.setCreatorId(PbActivator.getSessionUser().getId());
			customerModifyLog.setModifyTime(new Date());
			customerModifyLog.setModifier(t.getCreator());
			customerModifyLog.setModifierId(t.getCreatorId());
			customerModifyLog.setModifyLogTime(t.getCreateTime());
			customerModifyLog.setEntityStatus(EntityStatus.NORMAL);
			session.save(customerModifyLog);	
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("添加主要人员【"+t.getName()+"】    "+customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.Staffer.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Staffer.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Staffer.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Staffer> delete(Staffer t) {
		try {
			stafferDao.delete(t);
			return Result.success(R.Staffer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Staffer.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Staffer> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = stafferDao.openSession();
			tr = session.beginTransaction();
			Staffer t = (Staffer)session.get(Staffer.class, id);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("删除主要人员【"+t.getName()+"】");
			customerModifyLog.setCustomer(customer);
			customerModifyLog.setCustomerId(t.getCustomerId());
			customerModifyLog.setCreateTime(new Date());
			customerModifyLog.setCreator(PbActivator.getSessionUser().getRealName());
			customerModifyLog.setCreatorId(PbActivator.getSessionUser().getId());
			customerModifyLog.setModifyTime(new Date());
			customerModifyLog.setModifier(t.getCreator());
			customerModifyLog.setModifierId(t.getCreatorId());
			customerModifyLog.setModifyLogTime(t.getCreateTime());
			customerModifyLog.setEntityStatus(EntityStatus.NORMAL);
			session.save(customerModifyLog);
			session.delete(t);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("删除主要人员【"+t.getName()+"】    "+customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.Staffer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Staffer.DELETE_FAILURE);
		} finally{
			session.close();
		}
	}

	@Override
	public Result<Staffer> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = stafferDao.openSession();
			tr = session.beginTransaction();
			List<Staffer> list = session.createQuery("from Staffer where id in ("+ids+")").list();
			String str = "" ;
			for (Staffer t : list) {
				Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
				CustomerModifyLog customerModifyLog = new CustomerModifyLog();
				customerModifyLog.setContent("删除主要人员【"+t.getName()+"】");
				customerModifyLog.setCustomer(customer);
				customerModifyLog.setCustomerId(t.getCustomerId());
				customerModifyLog.setCreateTime(new Date());
				customerModifyLog.setCreator(PbActivator.getSessionUser().getRealName());
				customerModifyLog.setCreatorId(PbActivator.getSessionUser().getId());
				customerModifyLog.setModifyTime(new Date());
				customerModifyLog.setModifier(t.getCreator());
				customerModifyLog.setModifierId(t.getCreatorId());
				customerModifyLog.setModifyLogTime(t.getCreateTime());
				customerModifyLog.setEntityStatus(EntityStatus.NORMAL);
				session.save(customerModifyLog);
				session.delete(t);
				str = str  +"删除主要人员【"+t.getName()+"】    "+customer.getName()+";";
			}
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent(str);
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.Staffer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Staffer.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Staffer> update(Staffer t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = stafferDao.openSession();
			tr = session.beginTransaction();
			if (t.getDegreeId().equals("")) {
				t.setDegreeId(null);
			}
			if (t.getPositionId().equals("")) {
				t.setPositionId(null);
			}
			if(t.getPoliticalId().equals("")){
				t.setPoliticalId(null);
			}
			
			if(t.getManager() == BooleanEnum.YES || t.getLegal() == BooleanEnum.YES){
				List<Staffer> staffers = getListByFilter(new Filter(Staffer.class).ne("id", t.getId()).eq("customerId",t.getCustomerId()).or(Filter.Eq("manager", BooleanEnum.YES),Filter.Eq("legal", BooleanEnum.YES))).getValue();
				for (Staffer staffer : staffers) {
					if(staffer.getManager() == BooleanEnum.YES && t.getManager() == BooleanEnum.YES){
						staffer.setManager(BooleanEnum.NO);
					}else if(staffer.getLegal() == BooleanEnum.YES && t.getLegal() == BooleanEnum.YES){
						staffer.setLegal(BooleanEnum.NO);
					}
					session.update(staffer);
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			Customer customer = (Customer)session.get(Customer.class,t.getCustomerId());
			CustomerModifyLog customerModifyLog = new CustomerModifyLog();
			customerModifyLog.setContent("更新主要人员【"+t.getName()+"】");
			customerModifyLog.setCustomer(customer);
			customerModifyLog.setCustomerId(t.getCustomerId());
			customerModifyLog.setCreateTime(new Date());
			customerModifyLog.setCreator(PbActivator.getSessionUser().getRealName());
			customerModifyLog.setCreatorId(PbActivator.getSessionUser().getId());
			customerModifyLog.setModifyTime(new Date());
			customerModifyLog.setModifier(t.getCreator());
			customerModifyLog.setModifierId(t.getCreatorId());
			customerModifyLog.setModifyLogTime(t.getCreateTime());
			customerModifyLog.setEntityStatus(EntityStatus.NORMAL);
			session.save(customerModifyLog);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setContent("更新主要人员【"+t.getName()+"】    "+customer.getName());
			parkLog.setParkLogType(ParkLogTypeEnums.CUSTOMERMODIFY);
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			parkLog.setCreateTime(new Date());
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.Staffer.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Staffer.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Staffer.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Staffer> getBeanById(Serializable id) {
		try {
			return Result.value(stafferDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Staffer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Staffer> getBeanByFilter(Filter filter) {
		try {
			return Result.value(stafferDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Staffer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Staffer>> getList() {
		try {
			return Result.value(stafferDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Staffer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Staffer>> getListByFilter(Filter filter) {
		try {
			return Result.value(stafferDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Staffer.LOAD_FAILURE);
		}
	}

	@Override
	public Result<?> importCard(String ids) {
		try{
			Config config = PbActivator.getAppConfig().getConfig("cardGroupName");
			String groupName=config.getParameter("name");
			//String groupName = PbActivator.getAppParamService().loadCardGroupName();
			CardPubService cardPubService = PbActivator.getService(CardPubService.class);
			List<CardDto> cardDtoList = new ArrayList<CardDto>();
			Filter filter = new Filter(Staffer.class);
			if(!ids.equals("")){
				String [] idss = ids.split(",");
				Long[] idsl = new Long[idss.length];
				int index=0;
				for(String s : idss){
					idsl[index++] = Long.parseLong(idss[index-1]);
				}
				filter.in("id", idsl);
			}
			List<Staffer> stafferList = stafferDao.getListByFilter(filter);
			for(Staffer staffer : stafferList){
				cardDtoList.add(populate(staffer, groupName));
			}
			cardPubService.ImportCards(cardDtoList);
			PbActivator.getOperationLogService().logOP("导入名片组【"+groupName+"】");
			return Result.success("导入成功");
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure("导入失败");
		}
	}

	private CardDto populate(Staffer staffer, String groupName) {
		CardDto card = new CardDto();
		card.setGroupName(groupName);
		card.setCateName("主要人员");
		if(staffer.getPhone()==null){
			staffer.setPhone("");
		}
		card.setName(staffer.getName());
		card.setEmail(staffer.getEmail());
		card.setMobile(staffer.getPhone());
		card.setOfficeTel("");
		if(staffer.getPosition()!=null){
			card.setPosition(staffer.getPosition().getDataValue());
		}
		return card;
	}
	
}
