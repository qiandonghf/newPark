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
import com.wiiy.crm.dao.BillPlanRentDao;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.preferences.enums.BillingMethodEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.BillPlanRentService;
import com.wiiy.crm.service.BillService;
import com.wiiy.crm.service.BillTypeService;
import com.wiiy.crm.util.BillPlanGenerateUtil;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class BillPlanRentServiceImpl implements BillPlanRentService{
	
	private BillPlanRentDao billPlanRentDao;
	private BillTypeService billTypeService;
	private BillService billService;
	public void setBillPlanRentDao(BillPlanRentDao billPlanRentDao) {
		this.billPlanRentDao = billPlanRentDao;
	}

	public void setBillTypeService(BillTypeService billTypeService) {
		this.billTypeService = billTypeService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}

	@Override
	public Result<BillPlanRent> save(BillPlanRent t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			billPlanRentDao.save(t);
			return Result.success(R.BillPlanRent.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillPlanRent.class)));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.SAVE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> delete(BillPlanRent t) {
		try {
			billPlanRentDao.delete(t);
			return Result.success(R.BillPlanRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> deleteById(Serializable id) {
		try {
			billPlanRentDao.deleteById(id);
			return Result.success(R.BillPlanRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> deleteByIds(String ids) {
		try {
			billPlanRentDao.deleteByIds(ids);
			return Result.success(R.BillPlanRent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> update(BillPlanRent t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			billPlanRentDao.update(t);
			return Result.success(R.BillPlanRent.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BillPlanRent.class)));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> getBeanById(Serializable id) {
		try {
			return Result.value(billPlanRentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BillPlanRent> getBeanByFilter(Filter filter) {
		try {
			return Result.value(billPlanRentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillPlanRent>> getList() {
		try {
			return Result.value(billPlanRentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillPlanRent>> getListByFilter(Filter filter) {
		try {
			return Result.value(billPlanRentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BillPlanRent>> autoGenerate(RentBillPlanFeeEnum feeType,
			RentBillPlanEnum rentBillPlan, BillingMethodEnum billingMethod,
			Date startDate, Date endDate, Double roomArea, Double price,
			PriceUnitEnum priceUnit) {
		Result<List<BillPlanRent>> result = BillPlanGenerateUtil.generate(rentBillPlan, billingMethod, startDate, endDate, roomArea, price, priceUnit);
		if(result.isSuccess())
		for (BillPlanRent billPlanRent : result.getValue()) {
			billPlanRent.setFeeType(feeType);
			billPlanRent.setAmount(roomArea);
			billPlanRent.setPrice(price+priceUnit.getTitle()+"("+rentBillPlan.getTitle()+")");
			billPlanRent.setPlanPayDate(billPlanRent.getEndDate());
		}
		return result;
	}

	@Override
	public Result save(List<BillPlanRent> billPlanRentList) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanRentDao.openSession();
			tr = session.beginTransaction();
			for (BillPlanRent billPlanRent : billPlanRentList) {
				billPlanRent.setCreateTime(new Date());
				billPlanRent.setCreator(PbActivator.getSessionUser().getRealName());
				billPlanRent.setCreatorId(PbActivator.getSessionUser().getId());
				billPlanRent.setModifyTime(billPlanRent.getCreateTime());
				billPlanRent.setModifier(billPlanRent.getCreator());
				billPlanRent.setModifierId(billPlanRent.getCreatorId());
				billPlanRent.setEntityStatus(EntityStatus.NORMAL);
				session.save(billPlanRent);
			}
			tr.commit();
			return Result.failure(R.BillPlanRent.SAVE_SUCCESS);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.BillPlanRent.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result checkoutById(Long id,BillPlanStatusEnum billPlanStatus) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanRentDao.openSession();
			tr = session.beginTransaction();
			checkoutById(id, billPlanStatus, session);
			tr.commit();
			return Result.failure("出账成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("出账失败");
		} finally {
			session.close();
		}
	}
	@Override
	public Result checkoutById(Long id,BillPlanStatusEnum billPlanStatus,Session session) {
		BillPlanRent billPlanRent = (BillPlanRent) session.get(BillPlanRent.class,id);
		Contract contract = (Contract) session.get(Contract.class, billPlanRent.getContractId());
		BillType topType = billTypeService.getBillType("物业").getValue();
		Map<RentBillPlanFeeEnum,Long> typeMap = new HashMap<RentBillPlanFeeEnum,Long>();
		for (RentBillPlanFeeEnum rentBillPlanFeeEnum : RentBillPlanFeeEnum.values()) {
			BillType billType = new BillType();
			billType.setTypeName(rentBillPlanFeeEnum.getTitle());
			billType.setParentId(topType.getId());
			billTypeService.checkBillType(billType);
			typeMap.put(rentBillPlanFeeEnum, billType.getId());
		}
		Bill bill = new Bill();
		bill.setUrged(BooleanEnum.NO);
		bill.setNumber(billService.generateNumber(session));
		bill.setBillTypeId(typeMap.get(billPlanRent.getFeeType()));
		bill.setCustomerId(contract.getCustomerId());
		bill.setDiscountRate(billPlanRent.getRealFee());
		bill.setPlanPayTime(billPlanRent.getPlanPayDate());
		switch (billPlanStatus) {
		case INCHECKED:
			bill.setInOut(BillInOutEnum.IN);
			break;
		case OUTCHECKED:
			bill.setInOut(BillInOutEnum.OUT);
			break;
		}
		bill.setTotalAmount(billPlanRent.getRealFee());
		bill.setInvoice(BooleanEnum.NO);
		bill.setPenalty(0d);
		bill.setFactPayment(billPlanRent.getRealFee());
		bill.setFeeEndTime(billPlanRent.getEndDate());
		bill.setFeeStartTime(billPlanRent.getStartDate());
		bill.setCheckoutTime(new Date());
		bill.setRoomId(billPlanRent.getRoomId());
		bill.setContractNo(contract.getContractNo());
		bill.setStatus(BillStatusEnum.UNPAID);
		bill.setPrice(billPlanRent.getPrice());
		bill.setAmount(billPlanRent.getAmount());
		bill.setBillPlanId(billPlanRent.getId());
		bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(BillPlanRent.class));
		setcreatemodify(bill);
		session.save(bill);
		billPlanRent.setModifyTime(new Date());
		billPlanRent.setModifier(PbActivator.getSessionUser().getRealName());
		billPlanRent.setModifierId(PbActivator.getSessionUser().getId());
		billPlanRent.setStatus(billPlanStatus);
		session.update(billPlanRent);
		return Result.failure("出账成功");
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
	public Result checkout(List<BillPlanRent> list) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanRentDao.openSession();
			tr = session.beginTransaction();
			BillType topType = billTypeService.getBillType("物业").getValue();
			Map<RentBillPlanFeeEnum,Long> typeMap = new HashMap<RentBillPlanFeeEnum,Long>();
			for (RentBillPlanFeeEnum rentBillPlanFeeEnum : RentBillPlanFeeEnum.values()) {
				BillType billType = new BillType();
				billType.setTypeName(rentBillPlanFeeEnum.getTitle());
				billType.setParentId(topType.getId());
				billTypeService.checkBillType(billType);
				typeMap.put(rentBillPlanFeeEnum, billType.getId());
			}
			for (BillPlanRent billPlanRent : list) {
				Bill bill = new Bill();
				bill.setUrged(BooleanEnum.NO);
				bill.setNumber(billService.generateNumber(session));
				bill.setInvoice(BooleanEnum.NO);
				bill.setBillTypeId(typeMap.get(billPlanRent.getFeeType()));
				bill.setCustomerId(billPlanRent.getContract().getCustomerId());
				bill.setDiscountRate(billPlanRent.getRealFee());
				bill.setPlanPayTime(billPlanRent.getPlanPayDate());
				bill.setInOut(BillInOutEnum.IN);
				bill.setTotalAmount(billPlanRent.getRealFee());
				bill.setPenalty(0d);
				bill.setPrice(billPlanRent.getPrice());
				bill.setAmount(billPlanRent.getAmount());
				bill.setFactPayment(billPlanRent.getRealFee());
				bill.setFeeEndTime(billPlanRent.getEndDate());
				bill.setFeeStartTime(billPlanRent.getStartDate());
				bill.setCheckoutTime(new Date());
				bill.setRoomId(billPlanRent.getRoomId());
				bill.setContractNo(billPlanRent.getContract().getContractNo());
				bill.setStatus(BillStatusEnum.UNPAID);
				bill.setBillPlanId(billPlanRent.getId());
				bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(BillPlanRent.class));
				setcreatemodify(bill);
				session.save(bill);
				billPlanRent.setStatus(BillPlanStatusEnum.INCHECKED);
				session.save(billPlanRent);
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
	public Result batchCheckout(String ids, String[] types, boolean autoRemind) {
		Session session = null;
		Transaction tr = null;
		try {
			session = billPlanRentDao.openSession();
			tr = session.beginTransaction();
			List<BillPlanRent> list = (List<BillPlanRent>) session.createQuery("from BillPlanRent where id in ("+ids+")").list();
			BillType topType = billTypeService.getBillType("物业").getValue();
			Map<RentBillPlanFeeEnum,Long> typeMap = new HashMap<RentBillPlanFeeEnum,Long>();
			for (RentBillPlanFeeEnum rentBillPlanFeeEnum : RentBillPlanFeeEnum.values()) {
				BillType billType = new BillType();
				billType.setTypeName(rentBillPlanFeeEnum.getTitle());
				billType.setParentId(topType.getId());
				billTypeService.checkBillType(billType);
				typeMap.put(rentBillPlanFeeEnum, billType.getId());
			}
			Map<Long,StatisticDto> countMap = new HashMap<Long, StatisticDto>();
			for (int i = 0; i < list.size(); i++) {
				BillPlanRent billPlanRent = list.get(i);
				if(!countMap.containsKey(billPlanRent.getContract().getCustomerId())){
					Customer customer = billPlanRent.getContract().getCustomer();
					StatisticDto dto = new StatisticDto();
					dto.setName(customer.getName());
					dto.setdValue(billPlanRent.getRealFee());
					if(dto.getdValue()==null) dto.setdValue(0d);
					countMap.put(customer.getId(), dto);
				} else {
					StatisticDto dto = countMap.get(billPlanRent.getContract().getCustomerId());
					dto.setdValue(dto.getdValue()+billPlanRent.getRealFee());
				}
				Bill bill = new Bill();
				bill.setNumber(billService.generateNumber(session));
				bill.setInvoice(BooleanEnum.NO);
				bill.setBillTypeId(typeMap.get(billPlanRent.getFeeType()));
				bill.setCustomerId(billPlanRent.getContract().getCustomerId());
				bill.setDiscountRate(billPlanRent.getRealFee());
				bill.setPlanPayTime(billPlanRent.getPlanPayDate());
				bill.setCheckoutTime(new Date());
				if(types[i].equals("in")){
					bill.setInOut(BillInOutEnum.IN);
					billPlanRent.setStatus(BillPlanStatusEnum.INCHECKED);
				}else{
					bill.setInOut(BillInOutEnum.OUT);
					billPlanRent.setStatus(BillPlanStatusEnum.OUTCHECKED);
				}
				bill.setTotalAmount(billPlanRent.getRealFee());
				bill.setPenalty(0d);
				bill.setPrice(billPlanRent.getPrice());
				bill.setAmount(billPlanRent.getAmount());
				bill.setTotalAmount(billPlanRent.getPlanFee());
				bill.setFactPayment(billPlanRent.getRealFee());
				bill.setFeeEndTime(billPlanRent.getEndDate());
				bill.setFeeStartTime(billPlanRent.getStartDate());
				bill.setRoomId(billPlanRent.getRoomId());
				bill.setContractNo(billPlanRent.getContract().getContractNo());
				bill.setStatus(BillStatusEnum.UNPAID);
				bill.setBillPlanId(billPlanRent.getId());
				bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(BillPlanRent.class));
				if(autoRemind) bill.setUrged(BooleanEnum.YES);
				else bill.setUrged(BooleanEnum.NO);
				setcreatemodify(bill);
				session.save(bill);
				session.update(billPlanRent);
			}
			if(autoRemind) {
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null){
					for (Entry<Long, StatisticDto> entry : countMap.entrySet()) {
/*						List<Contect> contectList = (List<Contect>) session.createQuery("from Contect where customerId = "+entry.getKey()).list();
						if(contectList!=null && contectList.size()>0){
							String[] receiverMobile = new String[contectList.size()];
							String[] content = new String[contectList.size()];
							String[] receiverName = new String[contectList.size()];
							int i = 0;
							for (Contect contect : contectList) {
								SMSDto sms = new SMSDto();
								receiverMobile[i] = contect.getMobile();
								content[i] = PbActivator.getAppConfig().getConfig("billCheckoutSms").getParameter("content");
								content[i] = content[i].replace("${customerName}", contect.getCustomer().getName());
								content[i] = content[i].replace("${total}", new DecimalFormat("#0.00").format(entry.getValue().getdValue())+"");
								receiverName[i] = contect.getCustomer().getName();
							}
							smsPubService.send(receiverMobile, content, receiverName);
						}*/
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
		return billPlanRentDao.getRowCount(filter);
	}
	
	@Override
	public Result<List<BillPlanRent>> getListHql(String hql) {
		try {
			return Result.value(billPlanRentDao.getListByHql(hql));
		} catch (Exception e) {
			return Result.failure(R.BillPlanRent.LOAD_FAILURE);
		}
	}
}
