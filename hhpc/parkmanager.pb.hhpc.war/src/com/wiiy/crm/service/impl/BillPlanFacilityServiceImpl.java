package com.wiiy.crm.service.impl;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.BillPlanFacilityDao;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.service.BillPlanFacilityService;
import com.wiiy.crm.service.BillService;
import com.wiiy.crm.service.BillTypeService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.preferences.enums.FacilityTypeEnum;
import com.wiiy.pb.service.FacilityOrderService;

public class BillPlanFacilityServiceImpl implements BillPlanFacilityService {
	private BillPlanFacilityDao billPlanFacilityDao;
	private BillTypeService billTypeService;
	private BillService billService;
	private FacilityOrderService facilityOrderService;
	
	public void setFacilityOrderService(FacilityOrderService facilityOrderService) {
		this.facilityOrderService = facilityOrderService;
	}


	public void setBillPlanFacilityDao(BillPlanFacilityDao billPlanFacilityDao) {
		this.billPlanFacilityDao = billPlanFacilityDao;
	}
	
	
	public void setBillTypeService(BillTypeService billTypeService) {
		this.billTypeService = billTypeService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}
	@Override
	public Result<BillPlanFacility> save(BillPlanFacility t) {
		try {
			if(t.getFacilityOrderId()!=null){
				FacilityOrder facilityOrder= facilityOrderService.getBeanById(t.getFacilityOrderId()).getValue();
				if(facilityOrder!=null){
					if(facilityOrder.getCustomerId()!=null){
						t.setCustomerId(facilityOrder.getCustomerId());
					}
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			billPlanFacilityDao.save(t);
			return Result.success(R.BillPlanFacility.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillPlanFacility.class)));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.SAVE_FAILURE);
		}
	}
	
	@Override
	public Result<BillPlanFacility> delete(BillPlanFacility t) {
		try {
			billPlanFacilityDao.delete(t);
			return Result.success(R.BillPlanFacility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanFacility> deleteById(Serializable id) {
		try {
			billPlanFacilityDao.deleteById(id);
			return Result.success(R.BillPlanFacility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanFacility> deleteByIds(String ids) {
		try {
			billPlanFacilityDao.deleteByIds(ids);
			return Result.success(R.BillPlanFacility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.DELETE_FAILURE);
		}
	}
	
	@Override
	public Result<BillPlanFacility> update(BillPlanFacility t) {
		try {
			if(null!=t.getFacilityOrder().getCustomer()){
				t.setCustomerId(t.getFacilityOrder().getCustomerId());
			}
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			billPlanFacilityDao.update(t);
			return Result.success(R.BillPlanFacility.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillPlanFacility.class)));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<BillPlanFacility> getBeanByFilter(Filter filter) {
		try {
			return Result.value(billPlanFacilityDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BillPlanFacility> getBeanById(Serializable id) {
		try {
			return Result.value(billPlanFacilityDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillPlanFacility>> getList() {
		try {
			return Result.value(billPlanFacilityDao.getList());
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillPlanFacility>> getListByFilter(Filter filter) {
		try {
			return Result.value(billPlanFacilityDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillPlanFacility.LOAD_FAILURE);
		}
	}

	@Override
	public Result checkoutById(Long id, BillPlanStatusEnum billPlanStatus) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanFacilityDao.openSession();
			tr = session.beginTransaction();
			BillPlanFacility billPlanFacility = (BillPlanFacility) session.get(BillPlanFacility.class,id);
			BillType topType = billTypeService.getBillType("公共设施").getValue();
			Map<FacilityTypeEnum,Long> typeMap = new HashMap<FacilityTypeEnum,Long>();
			for (FacilityTypeEnum facilityTypeEnum : FacilityTypeEnum.values()) {
				BillType billType = new BillType();
				billType.setTypeName(facilityTypeEnum.getTitle());
				billType.setParentId(topType.getId());
				billTypeService.checkBillType(billType);
				typeMap.put(facilityTypeEnum, billType.getId());
			}
			Bill bill = new Bill();
			bill.setUrged(BooleanEnum.NO);
			bill.setNumber(billService.generateNumber(session));
			bill.setInvoice(BooleanEnum.NO);
			bill.setBillTypeId(typeMap.get(billPlanFacility.getFacility().getType()));
			if(billPlanFacility.getContract()!=null){
				bill.setCustomerId(billPlanFacility.getContract().getCustomerId());
			}else{
				bill.setCustomerId(billPlanFacility.getFacilityOrder().getCustomerId());
			}
			bill.setDiscountRate(billPlanFacility.getRealFee());
			bill.setPlanPayTime(billPlanFacility.getPlanPayDate());
			switch (billPlanStatus) {
			case INCHECKED:
				bill.setInOut(BillInOutEnum.IN);
				break;
			case OUTCHECKED:
				bill.setInOut(BillInOutEnum.OUT);
				break;
			}
			bill.setTotalAmount(billPlanFacility.getRealFee());
			bill.setPenalty(0d);
			bill.setFactPayment(billPlanFacility.getRealFee());
			bill.setFeeEndTime(billPlanFacility.getEndDate());
			bill.setFeeStartTime(billPlanFacility.getStartDate());
			bill.setCheckoutTime(new Date());
			bill.setPrice(billPlanFacility.getPrice());
			bill.setAmount(billPlanFacility.getAmount());
			bill.setStatus(BillStatusEnum.UNPAID);
			bill.setBillPlanId(billPlanFacility.getId());
			bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(BillPlanFacility.class));
			if(billPlanFacility.getContract()!=null){
				bill.setContractNo(billPlanFacility.getContract().getContractNo());
			}
			setcreatemodify(bill);
			session.save(bill);
			billPlanFacility.setModifyTime(new Date());
			billPlanFacility.setModifier(PbActivator.getSessionUser().getRealName());
			billPlanFacility.setModifierId(PbActivator.getSessionUser().getId());
			billPlanFacility.setStatus(billPlanStatus);
			billPlanFacility.setEntityStatus(EntityStatus.NORMAL);
			billPlanFacility.setIntoAccountDate(new Date());
			session.save(billPlanFacility);
			tr.commit();
			return Result.success("出账成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("出账失败");
		} finally {
			session.close();
		}
	}
	public void setcreatemodify(BaseEntity t){
		t.setCreateTime(new Date());
		t.setCreator(PbActivator.getSessionUser().getRealName());
		t.setCreatorId(PbActivator.getSessionUser().getId());
		t.setModifyTime(t.getCreateTime());
		t.setModifier(t.getCreator());
		t.setModifierId(t.getCreatorId());
		t.setEntityStatus(EntityStatus.NORMAL);
	}

	@Override
	public Result batchCheckout(String ids, String[] types, boolean autoRemind) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanFacilityDao.openSession();
			tr = session.beginTransaction();
			List<BillPlanFacility> list = (List<BillPlanFacility>) session.createQuery("from BillPlanFacility where id in ("+ids+")").list();
			BillType topType = billTypeService.getBillType("公共设施").getValue();
			Map<FacilityTypeEnum,Long> typeMap = new HashMap<FacilityTypeEnum,Long>();
			for (FacilityTypeEnum facilityTypeEnum : FacilityTypeEnum.values()) {
				BillType billType = new BillType();
				billType.setTypeName(facilityTypeEnum.getTitle());
				billType.setParentId(topType.getId());
				billTypeService.checkBillType(billType);
				typeMap.put(facilityTypeEnum, billType.getId());
			}
			Map<Long,StatisticDto> countMap = new HashMap<Long, StatisticDto>();
			for (int i = 0; i < list.size(); i++) {
				BillPlanFacility billPlanFacility = list.get(i);
				if(!countMap.containsKey(billPlanFacility.getContract().getCustomerId())){
					Customer customer = billPlanFacility.getContract().getCustomer();
					StatisticDto dto = new StatisticDto();
					dto.setName(customer.getName());
					dto.setdValue(billPlanFacility.getRealFee());
					countMap.put(customer.getId(), dto);
				} else {
					StatisticDto dto = countMap.get(billPlanFacility.getContract().getCustomerId());
					dto.setdValue(dto.getdValue()+billPlanFacility.getRealFee());
				}
				Bill bill = new Bill();
				bill.setNumber(billService.generateNumber(session));
				bill.setInvoice(BooleanEnum.NO);
				bill.setBillTypeId(typeMap.get(billPlanFacility.getFacility().getType()));
				bill.setCustomerId(billPlanFacility.getContract().getCustomerId());
				bill.setDiscountRate(billPlanFacility.getRealFee());
				bill.setPlanPayTime(billPlanFacility.getPlanPayDate());
				if(billPlanFacility.getContract()!=null){
					bill.setContractNo(billPlanFacility.getContract().getContractNo());
				}
				if(types[i].equals("in")){
					bill.setInOut(BillInOutEnum.IN);
					billPlanFacility.setStatus(BillPlanStatusEnum.INCHECKED);
				} else {
					bill.setInOut(BillInOutEnum.OUT);
					billPlanFacility.setStatus(BillPlanStatusEnum.OUTCHECKED);
				}
				bill.setTotalAmount(billPlanFacility.getRealFee());
				bill.setPrice(billPlanFacility.getPrice());
				bill.setAmount(billPlanFacility.getAmount());
				bill.setPenalty(0d);
				bill.setFactPayment(billPlanFacility.getRealFee());
				bill.setFeeEndTime(billPlanFacility.getEndDate());
				bill.setFeeStartTime(billPlanFacility.getStartDate());
				bill.setCheckoutTime(new Date());
				bill.setStatus(BillStatusEnum.UNPAID);
				bill.setBillPlanId(billPlanFacility.getId());
				bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(BillPlanFacility.class));
				if(autoRemind) bill.setUrged(BooleanEnum.YES);
				else bill.setUrged(BooleanEnum.NO);
				setcreatemodify(bill);
				session.save(bill);
				session.update(billPlanFacility);
			}
			if(autoRemind){
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null){
					for (Entry<Long, StatisticDto> entry : countMap.entrySet()) {
						Contect contect = (Contect) session.createQuery("from Contect where customerId = "+entry.getKey()+" and main = '"+BooleanEnum.YES+"'").uniqueResult();
						if(contect==null) continue;
						SMSDto sms = new SMSDto();
						String mobile = contect.getMobile();
						String content = PbActivator.getAppConfig().getConfig("billCheckoutSms").getParameter("content");
						content = content.replace("${customerName}", contect.getCustomer().getName());
						content = content.replace("${total}", new DecimalFormat("#0.00").format(entry.getValue().getdValue())+"");
						sms.setContent(content);
						List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
						SMSReceiverDto receiver = new SMSReceiverDto();
						receiver.setPhone(mobile);
						receiver.setReceiverName(contect.getCustomer().getName());
						receiverList.add(receiver);
						sms.setReceiverList(receiverList);
						sms.setCreator(PbActivator.getSessionUser().getRealName());
						sms.setCreatorId(PbActivator.getSessionUser().getId());
						smsPubService.send(sms, session);
					}
				}
			}
			tr.commit();
			return Result.success("出账成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("出账失败");
		} finally {
			session.close();
		}
	}


	@Override
	public Integer getRowCount(Filter filter) {
		return billPlanFacilityDao.getRowCount(filter);
	}


}
