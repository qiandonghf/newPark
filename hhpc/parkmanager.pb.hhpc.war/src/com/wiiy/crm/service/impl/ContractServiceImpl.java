package com.wiiy.crm.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.IOUtil;
import com.wiiy.commons.util.MicrosoftWordUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.ContractDao;
import com.wiiy.crm.dao.ParkLogDao;
import com.wiiy.crm.dto.ContractRentPrintDto;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractAtt;
import com.wiiy.crm.entity.ContractMemo;
import com.wiiy.crm.entity.ContractModifyLog;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.Deposit;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.entity.SubjectNetwork;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.ContractRentStatusEnum;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.preferences.enums.ContractTypeEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.preferences.enums.DepositTypeEnum;
import com.wiiy.crm.preferences.enums.NetworkPriceUnitEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.BillPlanRentService;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomHistory;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class ContractServiceImpl implements ContractService{
	
	private ContractDao contractDao;
	private RoomService roomService;
	private BillPlanRentService billPlanRentService;
	private ParkLogDao parkLogDao ;
	private CustomerService customerService;
	private SubjectRentService subjectRentService;

	public void setSubjectRentService(SubjectRentService subjectRentService) {
		this.subjectRentService = subjectRentService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setParkLogDao(ParkLogDao parkLogDao) {
		this.parkLogDao = parkLogDao;
	}
	
	public void setContractDao(ContractDao contractDao) {
		this.contractDao = contractDao;
	}

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}

	public void setBillPlanRentService(BillPlanRentService billPlanRentService) {
		this.billPlanRentService = billPlanRentService;
	}

	@Override
	public Result<Contract> save(Contract t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractDao.save(t);
			return Result.success(R.Contract.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Contract.class)));
		} catch (Exception e) {
			return Result.failure(R.Contract.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Contract> delete(Contract t) {
		try {
			contractDao.delete(t);
			return Result.success(R.Contract.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Contract.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Contract> deleteById(Serializable id) {
		Session session=null;
		Transaction tr=null;
		try {
			session=contractDao.openSession();
			tr=session.beginTransaction();
			
			
			@SuppressWarnings("unchecked")
			List<BigInteger> contractExpireApprovalIds=session.createSQLQuery("select id from crm_contract_expire_approval where contract_id="+id).list();
			if(contractExpireApprovalIds!=null && contractExpireApprovalIds.size()>0){
				long contractExpireApprovalId =contractExpireApprovalIds.get(0).longValue();
			
				@SuppressWarnings("unchecked")
				List<BigInteger> countersignIds = session.createSQLQuery("select id from crm_countersign where countersignId = "+contractExpireApprovalId+" and countersign_type='"+CountersignTypeEnum.EXPIRE+"'").list();
				if(countersignIds!=null && countersignIds.size()>0){
					for(int i=0;i<countersignIds.size();i++){
						long countersignId = countersignIds.get(i).longValue();
						session.createSQLQuery("delete from crm_countersign where id="+countersignId).executeUpdate();
					}
				}
				@SuppressWarnings("unchecked")
				List<BigInteger> contractExpireApprovalAttIds = session.createSQLQuery("select id from crm_contract_expire_approval_att where contractExpireApproval_id="+contractExpireApprovalId).list();
				@SuppressWarnings("unchecked")
				List<String> newNames =session.createSQLQuery("select new_name from crm_contract_expire_approval_att where contractExpireApproval_id="+contractExpireApprovalId).list();
				if(contractExpireApprovalAttIds!=null && contractExpireApprovalAttIds.size()>0){
					for(int i=0;i<contractExpireApprovalAttIds.size();i++){
						long contractExpireApprovalAttId = contractExpireApprovalAttIds.get(i).longValue();
						String path = newNames.get(i);
						PbActivator.getResourcesService().delete(path);
						
						session.createSQLQuery("delete from crm_contract_expire_approval_att where id="+contractExpireApprovalAttId).executeUpdate();
					}
				}
				session.createSQLQuery("delete from crm_contract_expire_approval where id="+contractExpireApprovalId).executeUpdate();
				@SuppressWarnings("unchecked")
				List<BigInteger> approvalIds = session.createSQLQuery("select id from core_approval where group_id ="+contractExpireApprovalId+" and type='"+ApprovalTypeEnum.EXPIRE+"'").list();
				if(approvalIds!=null && approvalIds.size()>0){
					for(int i=0;i<approvalIds.size();i++){
						long approvalId = approvalIds.get(i).longValue();
						session.createSQLQuery("delete from core_approval where id="+approvalId).executeUpdate();
					}
				}
			}
			
			@SuppressWarnings("unchecked")
			List<BigInteger> contractReviewIds=session.createSQLQuery("select id from crm_contract_review where contract_id="+id).list();
			if(contractReviewIds!=null && contractReviewIds.size()>0){
				long contractReviewId =contractReviewIds.get(0).longValue();
			
				@SuppressWarnings("unchecked")
				List<BigInteger> countersignIds = session.createSQLQuery("select id from crm_countersign where countersignId = "+contractReviewId+" and countersign_type='"+CountersignTypeEnum.REVIEW+"'").list();
				if(countersignIds!=null && countersignIds.size()>0){
					for(int i=0;i<countersignIds.size();i++){
						long countersignId = countersignIds.get(i).longValue();
						session.createSQLQuery("delete from crm_countersign where id="+countersignId).executeUpdate();
					}
				}
				@SuppressWarnings("unchecked")
				List<BigInteger> contractReviewAttIds = session.createSQLQuery("select id from crm_contract_review_att where contractReview_id="+contractReviewId).list();
				@SuppressWarnings("unchecked")
				List<String> newNames =session.createSQLQuery("select new_name from crm_contract_review_att where contractReview_id="+contractReviewId).list();
				if(contractReviewAttIds!=null && contractReviewAttIds.size()>0){
					for(int i=0;i<contractReviewAttIds.size();i++){
						long contractReviewAttId = contractReviewAttIds.get(i).longValue();
						String path = newNames.get(i);
						PbActivator.getResourcesService().delete(path);
						
						session.createSQLQuery("delete from crm_contract_review_att where id="+contractReviewAttId).executeUpdate();
					}
				}
				session.createSQLQuery("delete from crm_contract_review where id="+contractReviewId).executeUpdate();
				@SuppressWarnings("unchecked")
				List<BigInteger> approvalIds = session.createSQLQuery("select id from core_approval where group_id ="+contractReviewId+" and type='"+ApprovalTypeEnum.REVIEW+"'").list();
				if(approvalIds!=null && approvalIds.size()>0){
					for(int i=0;i<approvalIds.size();i++){
						long approvalId = approvalIds.get(i).longValue();
						session.createSQLQuery("delete from core_approval where id="+approvalId).executeUpdate();
					}
				}
			}
			try {
				session.createSQLQuery("delete from crm_bill_plan_rent where contract_id = "+id).executeUpdate();
				session.createSQLQuery("delete from crm_deposit where contract_id = "+id).executeUpdate();
				session.createSQLQuery("delete from crm_contract where id = "+id).executeUpdate();
			}  catch (ConstraintViolationException e) {
				throw new FKConstraintException(e);
			}
			tr.commit();
			return Result.success(R.Contract.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Contract.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Contract> deleteByIds(String ids) {
		System.out.println(ids);
		Session session=null;
		Transaction tr=null;
		try {
			session=contractDao.openSession();
			tr=session.beginTransaction();
			
			
			@SuppressWarnings("unchecked")
			List<BigInteger> contractExpireApprovalIds = session.createSQLQuery("select id from crm_contract_expire_approval where contract_id in ("+ids+")").list();
			if(contractExpireApprovalIds!=null && contractExpireApprovalIds.size()>0){
				for(int i=0;i<contractExpireApprovalIds.size();i++){
					long contractExpireApprovalId=contractExpireApprovalIds.get(i).longValue();
					@SuppressWarnings("unchecked")
					List<BigInteger> countersignIds = session.createSQLQuery("select id from crm_countersign where countersignId = "+contractExpireApprovalId+" and countersign_type='"+CountersignTypeEnum.EXPIRE+"'").list();
					if(countersignIds!=null && countersignIds.size()>0){
						for(int j=0;j<countersignIds.size();j++){
							long countersignId = countersignIds.get(j).longValue();
							session.createSQLQuery("delete from crm_countersign where id="+countersignId).executeUpdate();
						}
					}
					@SuppressWarnings("unchecked")
					List<BigInteger> contractExpireApprovalAttIds=session.createSQLQuery("select id from crm_contract_expire_approval_att where contractExpireApproval_id="+contractExpireApprovalId).list();
					@SuppressWarnings("unchecked")
					List<String> newNames=session.createSQLQuery("select new_name from crm_contract_expire_approval_att where contractExpireApproval_id="+contractExpireApprovalId).list();
					if(contractExpireApprovalAttIds!=null && contractExpireApprovalAttIds.size()>0){
						for(int j=0;j<contractExpireApprovalAttIds.size();j++){
							long contractExpireApprovalAttId=contractExpireApprovalAttIds.get(j).longValue();
							String path = newNames.get(j);
							PbActivator.getResourcesService().delete(path);
							session.createSQLQuery("delete from crm_contract_expire_approval_att where id="+contractExpireApprovalAttId).executeUpdate();
						}
					}
					session.createSQLQuery("delete from crm_contract_expire_approval where id="+contractExpireApprovalId).executeUpdate();
					@SuppressWarnings("unchecked")
					List<BigInteger> approvalIds = session.createSQLQuery("select id from core_approval where group_id ="+contractExpireApprovalId+" and type='"+ApprovalTypeEnum.EXPIRE+"'").list();
					if(approvalIds!=null && approvalIds.size()>0){
						for(int j=0;j<approvalIds.size();j++){
							long approvalId = approvalIds.get(j).longValue();
							session.createSQLQuery("delete from core_approval where id="+approvalId).executeUpdate();
						}
					}
				}
			}
			
			
			
			@SuppressWarnings("unchecked")
			List<BigInteger> contractReviewIds = session.createSQLQuery("select id from crm_contract_review where contract_id in ("+ids+")").list();
			if(contractReviewIds!=null && contractReviewIds.size()>0){
				for(int i=0;i<contractReviewIds.size();i++){
					long contractReviewId=contractReviewIds.get(i).longValue();
					@SuppressWarnings("unchecked")
					List<BigInteger> countersignIds = session.createSQLQuery("select id from crm_countersign where countersignId = "+contractReviewId+" and countersign_type='"+CountersignTypeEnum.REVIEW+"'").list();
					if(countersignIds!=null && countersignIds.size()>0){
						for(int j=0;j<countersignIds.size();j++){
							long countersignId=countersignIds.get(j).longValue();
							session.createSQLQuery("delete from crm_countersign where id="+countersignId).executeUpdate();
						}
					}
					@SuppressWarnings("unchecked")
					List<BigInteger> contractReviewAttIds=session.createSQLQuery("select id from crm_contract_review_att where contractReview_id="+contractReviewId).list();
					@SuppressWarnings("unchecked")
					List<String> newNames=session.createSQLQuery("select new_name from crm_contract_review_att where contractReview_id="+contractReviewId).list();
					if(contractReviewAttIds!=null && contractReviewAttIds.size()>0){
						for(int j=0;j<contractReviewAttIds.size();j++){
							long contractReviewAttId=contractReviewAttIds.get(j).longValue();
							String path = newNames.get(j);
							PbActivator.getResourcesService().delete(path);
							session.createSQLQuery("delete from crm_contract_review_att where id="+contractReviewAttId).executeUpdate();
						}
					}
					session.createSQLQuery("delete from crm_contract_review where id="+contractReviewId).executeUpdate();
					@SuppressWarnings("unchecked")
					List<BigInteger> approvalIds = session.createSQLQuery("select id from core_approval where group_id ="+contractReviewId+" and type='"+ApprovalTypeEnum.REVIEW+"'").list();
					if(approvalIds!=null && approvalIds.size()>0){
						for(int j=0;j<approvalIds.size();j++){
							long approvalId = approvalIds.get(j).longValue();
							session.createSQLQuery("delete from core_approval where id="+approvalId).executeUpdate();
						}
					}
				}
			}
			try {
				session.createSQLQuery("delete from crm_bill_plan_rent where contract_id in ("+ids+")").executeUpdate();
				session.createSQLQuery("delete from crm_deposit where contract_id in ("+ids+")").executeUpdate();
				session.createSQLQuery("delete from crm_contract where id in ("+ids+")").executeUpdate();
			}  catch (ConstraintViolationException e) {
				throw new FKConstraintException(e);
			}
			tr.commit();
			return Result.success(R.Contract.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Contract.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Contract> update(Contract t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractDao.update(t);
			return Result.success(R.Contract.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Contract.class)));
		} catch (Exception e) {
			return Result.failure(R.Contract.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Contract> getBeanById(Serializable id) {
		try {
			return Result.value(contractDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Contract.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Contract> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Contract.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Contract>> getList() {
		try {
			return Result.value(contractDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Contract.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Contract>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Contract.LOAD_FAILURE);
		}
	}

	@Override
	public Result<String> generateCode(String contractModel) {
		if(contractModel == null){
			contractModel = "Z";
		}
		String mouth =String.valueOf(CalendarUtil.now().get(Calendar.MONTH)+1);
		if(CalendarUtil.now().get(Calendar.MONTH)<10){
			mouth = "0"+mouth;
		}		
		String code = "浙大科园甬司["+CalendarUtil.now().get(Calendar.YEAR)+"]"+contractModel+mouth;
		
		
		Contract contract = contractDao.getBeanByFilter(new Filter(Contract.class).ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)).orderBy("id", Filter.DESC).maxResults(1));
		int count = contractDao.getRowCount(new Filter(Contract.class).ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)));
		try {
			String oldCode = contract.getContractNo();
			count = Integer.parseInt(oldCode.replace("浙大科园甬司"+CalendarUtil.now().get(Calendar.YEAR), ""));
		} catch (Exception e) {
		}
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumIntegerDigits(6);
		code = code + nf.format(count+1);
		return Result.value(code);
	}

	@Override
	public Result save(Contract t, List<SubjectRent> sessionSubjectRentList) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(sessionSubjectRentList!=null)
			for (SubjectRent subjectRent : sessionSubjectRentList) {
				subjectRent.setContractId(t.getId());
				subjectRent.setCreateTime(new Date());
				subjectRent.setCreator(PbActivator.getSessionUser().getRealName());
				subjectRent.setCreatorId(PbActivator.getSessionUser().getId());
				subjectRent.setModifyTime(t.getCreateTime());
				subjectRent.setModifier(t.getCreator());
				subjectRent.setModifierId(t.getCreatorId());
				subjectRent.setEntityStatus(EntityStatus.NORMAL);
				session.save(subjectRent);
			}
			tr.commit();
			return Result.success(R.Contract.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Contract.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Contract.SAVE_FAILURE);
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
	public Result submitApproval(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			Contract contract = (Contract) session.get(Contract.class, id);
//			contract.setState(ContractStatusEnum.COMFIRM);
			SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
			if(smsPubService!=null){
				SMSDto dto = new SMSDto();
				Long userId = Long.parseLong(PbActivator.getAppConfig().getConfig("rentContractAuthor").getParameter("author"));
				User user = PbActivator.getService(OsgiUserService.class).getById(userId);
				String mobile = user.getMobile();
				dto.setContent("您好，有一份编号为"+contract.getContractNo()+"的合同需要您审批");
				List<SMSReceiverDto> receiverList = new ArrayList<SMSReceiverDto>();
				SMSReceiverDto receiver = new SMSReceiverDto();
				receiver.setPhone(mobile);
				receiver.setReceiverName(user.getRealName());
				receiverList.add(receiver);
				dto.setReceiverList(receiverList);
				dto.setCreator(PbActivator.getSessionUser().getRealName());
				dto.setCreatorId(PbActivator.getSessionUser().getId());
				smsPubService.send(dto, session);
			}
			session.update(contract);
			tr.commit();
			return Result.success(R.Contract.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Contract.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Contract.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	

	@Override
	public Result print(Long id) {
		try {
			Session session = contractDao.openSession();
			Object dto = generatePrintDto(session,id);
			return Result.value(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}
	
	public Object generatePrintDto(Session session, Long id){
		Contract contract = contractDao.getBeanById(id);
		List<SubjectRent> list = session.createQuery("from SubjectRent where contractId = "+id).list();
		List<BillPlanRent> billPlanList = session.createQuery("from BillPlanRent where contractId = "+id).list();
		List<Deposit> depositList = session.createQuery("from Deposit where contractId = "+id).list();
		ContractRentPrintDto dto = new ContractRentPrintDto();
		dto.setContractParty(contract.getContractParty().getDataValue());
		dto.setCustomerName(contract.getCustomerName());
		dto.setStartDate(contract.getStartDate());
		dto.setEndDate(contract.getEndDate());
		
		if(null!=contract.getPropertyName()){dto.setPropertyName(contract.getPropertyName());}
		if(null!=contract.getPropertyNo()){dto.setPropertyNo(contract.getPropertyNo());}
		if(null!=contract.getRoomType()){dto.setRoomType(contract.getRoomType().getDataValue());}
		if(null!=contract.getPropertyUnit()){dto.setPropertyUnit(contract.getPropertyUnit().toString());}
		if(0!=list.size()){
			dto.setAreaTotal(0d);
			String roomName = "";
			for (SubjectRent subjectRent : list) {
				dto.setAreaTotal(dto.getAreaTotal()+subjectRent.getRoomArea());
				if(null!=subjectRent.getRoomName()){
					roomName+=subjectRent.getRoom().getName()+",";
				}
			}
			dto.setContractItemList(roomName.substring(0, roomName.length()-1));
		}
		if (0!=billPlanList.size()) {
			double planFee = 0;
			for (BillPlanRent billPlanRent : billPlanList) {
				if ((RentBillPlanFeeEnum.MANAGE).equals(billPlanRent
						.getFeeType())) {
					planFee += billPlanRent.getPlanFee();
				}
			}
			dto.setAnnuity(planFee);
		}
		if(null!=contract.getOverallFloorage()){dto.setOverallFloorage((contract.getOverallFloorage().toString()));}
		if(null!=contract.getPurpose()){dto.setPurpose(contract.getPurpose());}
		if(null!=contract.getPayType()){dto.setPayType(contract.getPayType().getTitle());}
		if(null!=contract.getRentAmount()){
			System.out.println(contract.getRentAmount());
			dto.setRentAmount(contract.getRentAmount());
		}
		if(null!=contract.getAddress()){dto.setAddress(contract.getAddress());}
		double amount = 0d;
		if(0!=depositList.size()){
			for(Deposit deposit:depositList){
				amount+=deposit.getAmount();
			}
			dto.setAmount(amount);
		}
		return dto;
	}
	
	@Override
	public Result print(Long id, File template,OutputStream out) {
		try {
			Session session = contractDao.openSession();
			Object dto = generatePrintDto(session, id);
			generateWord(dto, template, out);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}
	
	private void generateWord(Object contract,File template,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			IOUtil.copyInputStreamToFile(new FileInputStream(template), temp);
			mwu.openDocument(temp.getAbsolutePath());
			if(contract instanceof ContractRentPrintDto) {
				Field[] fields = ContractRentPrintDto.class.getDeclaredFields();
				for (Field field : fields) {
					if(!Collection.class.isAssignableFrom(field.getType())){
						String fieldName = field.getName();
						try {
							Object value = ContractRentPrintDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(contract);
							String replaceText = "";
							if(value instanceof Number){
								replaceText = new DecimalFormat("#.##").format(value);
							} else if(value instanceof Date){
								replaceText = DateUtil.format((Date)value,"yyyy年MM月dd日");
							} else if(value!=null){
								replaceText = value.toString();
							}
							String toFindText = "#"+fieldName;
							mwu.moveStart();
							mwu.replaceAllText(toFindText, replaceText);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
			mwu.closeDocument();
			IOUtil.copyFileToOutputStream(temp, out);
			temp.deleteOnExit();
		} catch (Exception e) {
			e.printStackTrace();
			mwu.close();
		}
	}

	@Override
	public Result submitSubtract(Long contractId, Long subjectRentId, Date executeTime,Double checkoutMoney,Boolean checkoutNow, String memo) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			Contract contract = (Contract) session.get(Contract.class, contractId);
			SubjectRent subjectRent =  (SubjectRent) session.get(SubjectRent.class, subjectRentId);
			BillPlanRent billPlanRent = new BillPlanRent();
			billPlanRent.setAutoCheck(BooleanEnum.NO);
			billPlanRent.setContractId(contractId);
			billPlanRent.setEndDate(executeTime);
			billPlanRent.setFeeType(RentBillPlanFeeEnum.RENT);
			billPlanRent.setMemo(memo);
			billPlanRent.setRoomId(subjectRent.getRoomId());
			billPlanRent.setRoomName(subjectRent.getRoomName());
			billPlanRent.setPlanFee(checkoutMoney);
			billPlanRent.setPlanPayDate(executeTime);
			billPlanRent.setRealFee(checkoutMoney);
			billPlanRent.setStartDate(contract.getStartDate());
			billPlanRent.setSubjectId(subjectRentId);
			setcreatemodify(billPlanRent);
			if(checkoutNow) billPlanRent.setStatus(BillPlanStatusEnum.OUTCHECKED);
			else billPlanRent.setStatus(BillPlanStatusEnum.UNCHECK);
			session.save(billPlanRent);
			if(checkoutNow) billPlanRentService.checkoutById(billPlanRent.getId(), BillPlanStatusEnum.OUTCHECKED, session);
			surrender(subjectRent,executeTime,session,billPlanRent.getId());
			ContractMemo contractMemo = new ContractMemo();
			contractMemo.setMemo(memo);
			contractMemo.setContractId(contractId);
			setcreatemodify(contractMemo);
			session.save(contractMemo);
			ContractModifyLog log = new ContractModifyLog();
			setcreatemodify(log);
			log.setOperation("合同减租");
			log.setMemo("合同标的"+subjectRent.getRoomName()+"减租 执行时间为"+DateUtil.format(executeTime));
			log.setContractId(contractId);
			setcreatemodify(log);
			session.save(log);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setCreator("合同减租");
			parkLog.setContent("合同标的"+subjectRent.getRoomName()+"减租 执行时间为"+DateUtil.format(executeTime));
			parkLog.setParkLogType(ParkLogTypeEnums.CONTRACT);
			parkLog.setCreateTime(new Date());
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			session.save(parkLog);
			tr.commit();
			return Result.success("减租成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("减租失败");
		} finally {
			session.close();
		}
	}
	
	private void surrender(SubjectRent subjectRent,Date executeTime,Session session){
		subjectRent.setEndDate(executeTime);
		session.update(subjectRent);
		session.createQuery("delete from BillPlanRent where contractId = "+subjectRent.getContractId()+" and status = '"+BillPlanStatusEnum.UNCHECK+"'").executeUpdate();
	}
	
	private void surrender(SubjectRent subjectRent,Date executeTime,Session session,Long except){
		subjectRent.setEndDate(executeTime);
		session.update(subjectRent);
		session.createQuery("delete from BillPlanRent where contractId = "+subjectRent.getContractId()+" and status = '"+BillPlanStatusEnum.UNCHECK+"' and id != "+except).executeUpdate();
	}

	@Override
	public Result submitSurrender(Long contractId, Date executeTime,List<Double> checkoutMoneys,Boolean checkoutNow, String memo) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			Contract contract = (Contract) session.get(Contract.class, contractId);
			contract.setEndDate(executeTime);
//			contract.setState(ContractStatusEnum.CLOSED);
			contract.setRentState(ContractRentStatusEnum.RENTOFF);
			List<SubjectRent> subjectRentList = session.createQuery("from SubjectRent where contractId = "+contractId).list();
			for (int i = 0; i < subjectRentList.size(); i++) {
				SubjectRent subjectRent = subjectRentList.get(i);
				surrender(subjectRent,executeTime,session);
				BillPlanRent billPlanRent = new BillPlanRent();
				billPlanRent.setAutoCheck(BooleanEnum.NO);
				billPlanRent.setContractId(contractId);
				billPlanRent.setEndDate(executeTime);
				billPlanRent.setFeeType(RentBillPlanFeeEnum.RENT);
				billPlanRent.setRoomId(subjectRent.getRoomId());
				billPlanRent.setRoomName(subjectRent.getRoomName());
				billPlanRent.setMemo(memo);
				billPlanRent.setPlanFee(checkoutMoneys.get(i));
				billPlanRent.setPlanPayDate(executeTime);
				billPlanRent.setRealFee(checkoutMoneys.get(i));
				billPlanRent.setStartDate(contract.getStartDate());
				billPlanRent.setSubjectId(subjectRent.getId());
				setcreatemodify(billPlanRent);
				if(checkoutNow) billPlanRent.setStatus(BillPlanStatusEnum.OUTCHECKED);
				else billPlanRent.setStatus(BillPlanStatusEnum.UNCHECK);
				session.save(billPlanRent);
				if(checkoutNow) billPlanRentService.checkoutById(billPlanRent.getId(), BillPlanStatusEnum.OUTCHECKED, session);
			}
			ContractMemo contractMemo = new ContractMemo();
			contractMemo.setMemo(memo);
			contractMemo.setContractId(contractId);
			setcreatemodify(contractMemo);
			session.save(contractMemo);
			ContractModifyLog log = new ContractModifyLog();
			setcreatemodify(log);
			log.setOperation("合同退租");
			log.setMemo("退租 执行时间为"+DateUtil.format(executeTime));
			log.setContractId(contractId);
			setcreatemodify(log);
			session.save(log);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setCreator("合同退租");
			parkLog.setContent("退租 执行时间为"+DateUtil.format(executeTime));
			parkLog.setParkLogType(ParkLogTypeEnums.CONTRACT);
			parkLog.setCreateTime(new Date());
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			session.save(parkLog);
			tr.commit();
			return Result.success("退租成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("退租失败");
		} finally {
			session.close();
		}
	}

	@Override
	public Result approval(Long contractId,Long approvalUserId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			if(session.createQuery("from Approval where type = '"+ApprovalTypeEnum.CONTRACT+"' and groupId = "+contractId+" and userId = "+approvalUserId).list().size()>0){
				return Result.failure("审批人已存在");
			} else {
				tr = session.beginTransaction();
				Contract contract = (Contract) session.get(Contract.class, contractId);
				Approval approval = new Approval();
				approval.setUserId(approvalUserId);
				approval.setUserName(PbActivator.getService(OsgiUserService.class).getById(approvalUserId).getRealName());
				approval.setGroupId(contractId);
				approval.setStatus(ApprovalStatusEnum.UNDETERMINED);
				approval.setType(ApprovalTypeEnum.CONTRACT);
				approval.setTitle(contract.getName());
				approval.setWidth(765);
				approval.setHeight(467);
				approval.setUrl("parkmanager.pb/contract!view.action?id="+contractId+"&type=approval");
				setcreatemodify(approval);
				session.save(approval);
				sendMsg(session,contractId);
				tr.commit();
				return Result.success("送审成功");
			}
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("送审失败");
		} finally {
			session.close();
		}
	}
	
	private void sendMsg(Session session, Long contractId){
		Contract contract = (Contract) session.get(Contract.class, contractId);
		String author = PbActivator.getAppConfig().getConfig("rentContractAuthor").getParameter("author");
		OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
		User user = userService.getById(Long.valueOf(author));
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		if(smsPubService!=null && smsActive()){
			String receiverMobile = user.getMobile();
			String receiverName = user.getRealName();
			String content = PbActivator.getAppConfig().getConfig("contractRemind").getParameter("smsModule");
			content = content.replace("${companyName}", contract.getCustomerName());
			smsPubService.send(receiverMobile, content, receiverName);
		}
		
		SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
		if(sysEmailSenderPubService!=null && emailActive()){
			String content = "";
			StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
			content = data.toString();
			String subject = "合同审批提醒";
			content = content.replace("${subject}", contract.getCustomerName());
			content = content.replace("${msgType}", "合同审批提醒");
			content = content.replace("${url}", basePath()+"parkmanager.pb/contract!view.action?id="+contract.getId());
			content = content.replace("${receiver}", user.getRealName());
			content = content.replace("${customerName}", user.getRealName());
			content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
			content = content.replace("${content}", "");
			content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
			sysEmailSenderPubService.send(user.getEmail(),content,subject);
		}
	}
	
	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private StringBuffer parseHTML(String str){
		URL url = PbActivator.getURL(str);
		InputStreamReader Inputreader;
		StringBuffer data = new StringBuffer();
		try {
			Inputreader = new InputStreamReader(url.openStream(),"utf-8");
			BufferedReader br = new BufferedReader(Inputreader);
			String temp=br.readLine();
			while( temp!=null){
				data.append(temp+"\n");
				temp=br.readLine(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	private String basePath(){
		return ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
	}
	
	@Override
	public Result closeContract(Long contractId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			Contract contract = (Contract) session.get(Contract.class, contractId);
			contract.setState(ContractStatusEnum.CLOSED);
			session.update(contract);
			List<SubjectRent> subjectRentList = session.createQuery("from SubjectRent where contractId="+contractId).list();
			for (SubjectRent subjectRent : subjectRentList) {
				roomService.updateRoomCustomer(session, subjectRent.getRoomId(), contract,subjectRent);
			}
			ContractModifyLog log = new ContractModifyLog();
			setcreatemodify(log);
			log.setOperation("合同关闭");
			log.setMemo("合同关闭");
			log.setContractId(contractId);
			session.save(log);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setCreator("合同关闭");
			parkLog.setContent("合同关闭:"+contract.getName()+"【"+contract.getCustomerName()+"】");
			parkLog.setParkLogType(ParkLogTypeEnums.CONTRACT);
			parkLog.setCreateTime(new Date());
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			session.save(parkLog);
			tr.commit();
			return Result.success("合同关闭成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("合同关闭失败");
		} finally {
			session.close();
		}
	}
	@Override
	public Result executeContract(Long contractId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			Contract contract = (Contract) session.get(Contract.class, contractId);
			contract.setState(ContractStatusEnum.EXECUTE);
			session.update(contract);
			List<SubjectRent> subjectRentList = session.createQuery("from SubjectRent where contractId="+contractId).list();
			for (SubjectRent subjectRent : subjectRentList) {
				roomService.updateRoomCustomer(session, subjectRent.getRoomId(), contract,subjectRent);
			}
			ContractModifyLog log = new ContractModifyLog();
			setcreatemodify(log);
			log.setOperation("合同执行");
			log.setMemo("合同执行:"+contract.getName() +"["+contract.getCustomerName()+"]");
			log.setContractId(contractId);
			session.save(log);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setCreator("合同执行");
			parkLog.setContent("合同执行" +contract.getName() +"【"+contract.getCustomerName()+"】");
			parkLog.setParkLogType(ParkLogTypeEnums.CONTRACT);
			parkLog.setCreateTime(new Date());
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
			session.save(parkLog);
			
			List<SubjectRent> srList = subjectRentService.getListByFilter(new Filter(SubjectRent.class).eq("contractId", contractId)).getValue();
			if(srList!=null&&srList.size()>0){
				for(SubjectRent sr : srList){
					RoomHistory rh = new RoomHistory();
					rh.setContractId(contractId);
					rh.setCustomerId(contract.getCustomerId());
					Customer c = customerService.getBeanByFilter(new Filter(Customer.class).eq("id",contract.getCustomerId())).getValue();
					CustomerInfo cif = c.getCustomerInfo();
					if(c!=null&&cif!=null&&cif.getCellphone()!=null){
						rh.setPhone(cif.getCellphone());
					}
					rh.setRoomId(sr.getRoomId());
					rh.setManagerId(contract.getManagerId());
					rh.setRentDate(new SimpleDateFormat("yyyy-MM-dd").format(sr.getStartDate())+"-"+new SimpleDateFormat("yyyy-MM-dd").format(sr.getEndDate()));
					setcreatemodify(rh);
					session.save(rh);
				}
			}
			tr.commit();
			return Result.success("合同执行成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("合同执行失败");
		} finally {
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Result submitRelet(Contract t) {
		Long oldId = t.getId();
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			tr = session.beginTransaction();
			User user = PbActivator.getSessionUser();
			Contract old = (Contract) session.get(Contract.class, oldId);
			Date startDate = t.getStartDate();
			Date endDate = t.getEndDate();
			Date receiveDate = t.getReceiveDate();
			BeanUtil.copyProperties(old, t);
			t.setId(null);
			t.setStartDate(startDate);
			t.setEndDate(endDate);
			t.setReceiveDate(receiveDate);
			t.setName(old.getName()+"(续租)");
			t.setState(ContractStatusEnum.NEW);
			t.setContractNo(generateCode(null).getValue());
			t.setCreateTime(new Date());
			t.setCreator(user.getRealName());
			t.setCreatorId(user.getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setRentState(ContractRentStatusEnum.RELET);
			session.save(t);
			List<SubjectRent> subjectRentList = session.createQuery("from SubjectRent where contractId="+oldId).list();
			for (SubjectRent oldSubjectRent : subjectRentList) {
				SubjectRent subjectRent = new SubjectRent();
				BeanUtil.copyProperties(oldSubjectRent, subjectRent);
				subjectRent.setId(null);
				subjectRent.setContractId(t.getId());
				setcreatemodify(subjectRent);
				session.save(subjectRent);
			}
			List<ContractAtt> attList = session.createQuery("from ContractAtt where contractId="+oldId).list();
			for (ContractAtt contractAtt : attList) {
				ContractAtt att = new ContractAtt();
				BeanUtil.copyProperties(contractAtt, att);
				setcreatemodify(att);
				att.setId(null);
				att.setContractId(t.getId());
				session.save(att);
			}
			ContractModifyLog log = new ContractModifyLog();
			setcreatemodify(log);
			log.setOperation("续租");
			log.setMemo("合同续租 续租产生的新合同为"+t.getName()+"("+t.getContractNo()+")");
			log.setContractId(oldId);
			session.save(log);
			ParkLog parkLog = new ParkLog() ;
			parkLog.setCreator("续租");
			parkLog.setContent("合同续租 续租产生的新合同为"+t.getName()+"【"+t.getContractNo()+"】");
			parkLog.setParkLogType(ParkLogTypeEnums.CONTRACT);
			parkLog.setCreateTime(new Date());
			parkLog.setHandlePersonnel(PbActivator.getSessionUser().getUsername());
			session.save(parkLog);
			tr.commit();
			return Result.success("合同续租成功");
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Contract.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("合同续租成功");
		} finally {
			session.close();
		}
	}

	@Override
	public Result saveRentContract1(Contract contract,Map<String,String[]> roomRent,Map<String,String[]> billPlanRent,Map<String,String[]> deposit) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			/*if(contract.getContractNo()!=null){
				int count = session.createCriteria(Contract.class).add(Restrictions.eq("contractNo", contract.getContractNo())).list().size();
				if(count>0){
					return Result.failure("合同编号已经存在 ，保存失败");
				}
			}*/
			tr = session.beginTransaction();
			contract.setState(ContractStatusEnum.NEW);
			contract.setType(ContractTypeEnum.RentContract);
			contract.setName(contract.getCustomerName());
//			contract.setName(contract.getCustomerName()+DateUtil.format(new Date(),"yyyyMMddHHmm"));
			if(contract.getRoomTypeId()!=null && contract.getRoomTypeId().equals("")){
				contract.setRoomTypeId(null);
			}
			setcreatemodify(contract);
			session.save(contract);
			Map<Long,SubjectRent> subjectMap = new HashMap<Long, SubjectRent>();
			if(roomRent.get("roomIds")!=null){
				for (int i = 0; i < roomRent.get("roomIds").length; i++) {
					SubjectRent rent = new SubjectRent();
					rent.setContractId(contract.getId());
					rent.setStartDate(DateUtil.parse(roomRent.get("startDate")[i]));
					rent.setEndDate(DateUtil.parse(roomRent.get("endDate")[i]));
					/*rent.setManagePrice(Double.valueOf(roomRent.get("managePrice")[i]));
					rent.setManagePriceUnit(PriceUnitEnum.valueOf(roomRent.get("managePriceUnit")[i]));*/
					rent.setRentPrice(Double.valueOf(roomRent.get("rentPrices")[i]));
					rent.setRentPriceUnit(PriceUnitEnum.valueOf(roomRent.get("rentPriceUnit")[i]));
					rent.setRoomArea(Double.valueOf(roomRent.get("roomAreas")[i]));
					rent.setRoomId(Long.valueOf(roomRent.get("roomIds")[i]));
					rent.setRoomName(roomRent.get("roomNames")[i]);
					if(!("").equals(roomRent.get("rebateRuleId")[i])){
						rent.setRebateRuleId(roomRent.get("rebateRuleId")[i]);
					}else{
						rent.setRebateRuleId(null);
					}
					if(roomRent.get("rebate")!=null && roomRent.get("rebate")[i]!=null){
						rent.setRebate(BooleanEnum.valueOf(roomRent.get("rebate")[i]));
					}
					if(roomRent.get("memo")!=null && roomRent.get("memo")[i]!=null){
						rent.setMemo(roomRent.get("memo")[i]);
					}
					/*RoomHistory rh = new RoomHistory();
					rh.setContract(contract);
					rh.setContractId(contract.getId());
					Customer c = customerService.getBeanByFilter(new Filter(Customer.class).eq("id",contract.getCustomerId())).getValue();
					rh.setCustomerId(contract.getCustomerId());
					CustomerInfo cif = c.getCustomerInfo();
					if(c!=null&&cif!=null&&cif.getCellphone()!=null){
						rh.setPhone(cif.getCellphone());
					}
					rh.setRoomId(Long.valueOf(roomRent.get("roomIds")[i]));
					rh.setManagerId(contract.getManagerId());
					rh.setRentDate(roomRent.get("startDate")[i]+"——"+roomRent.get("endDate")[i]);
					setcreatemodify(rh);
					session.save(rh);*/
					setcreatemodify(rent);
					session.save(rent);
					subjectMap.put(rent.getRoomId(), rent);
				}
			}
			if(billPlanRent.get("feeTypes")!=null){
				for (int i = 0; i < billPlanRent.get("feeTypes").length; i++) {
					BillPlanRent plan = new BillPlanRent();
					plan.setContractId(contract.getId());
					plan.setFeeType(RentBillPlanFeeEnum.valueOf(billPlanRent.get("feeTypes")[i]));
					plan.setPlanFee(Double.valueOf(billPlanRent.get("planFees")[i]));
					plan.setRealFee(Double.valueOf(billPlanRent.get("realFees")[i]));
					plan.setPlanPayDate(DateUtil.parse(billPlanRent.get("planPayDates")[i]));
					plan.setStartDate(DateUtil.parse(billPlanRent.get("planStartDates")[i]));
					plan.setEndDate(DateUtil.parse(billPlanRent.get("planEndDates")[i]));
					if(billPlanRent.get("planStatus")!=null && billPlanRent.get("planStatus")[i]!=null && billPlanRent.get("planStatus")[i]!=""){
						plan.setStatus(BillPlanStatusEnum.valueOf(billPlanRent.get("planStatus")[i]));
					}else{
						plan.setStatus(BillPlanStatusEnum.UNCHECK);
					}
					if(billPlanRent.get("planMemos")!=null && billPlanRent.get("planMemos")[i]!=null){
						plan.setMemo(billPlanRent.get("planMemos")[i]);
					}
					if(billPlanRent.get("planRoomIds") !=null && subjectMap.get(billPlanRent.get("planRoomIds")[i])!=null){
						plan.setSubjectId(subjectMap.get(billPlanRent.get("planRoomIds")[i]).getId());
					}
					if(billPlanRent.get("planRoomIds")!=null && !("").equals(billPlanRent.get("planRoomIds")[i])){
						plan.setRoomName(billPlanRent.get("planRoomNames")[i]);
						plan.setRoomId(Long.valueOf(billPlanRent.get("planRoomIds")[i]));
					}
					plan.setAutoCheck(BooleanEnum.NO);
					setcreatemodify(plan);
					session.save(plan);
				}
			}	
			
			if(deposit.get("depositTypes")!=null){
				for (int i = 0; i < deposit.get("depositTypes").length; i++) {
					Deposit d = new Deposit();
					d.setAmount(Double.valueOf(deposit.get("depositAmounts")[i]));
					d.setType(DepositTypeEnum.valueOf(deposit.get("depositTypes")[i]));
					if(deposit.get("depositMemos")!=null && !("").equals(deposit.get("depositMemos")[i]) ){
						d.setMemo(deposit.get("depositMemos")[i]);
					}
					d.setContractId(contract.getId());
					d.setCustomerId(contract.getCustomerId());
					d.setStatus(BillPlanStatusEnum.UNCHECK);
					setcreatemodify(d);
					session.save(d);
				}
			}
			tr.commit();
			return Result.success("保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure("保存失败");
		} finally {
			session.close();
		}
		
	}

	@Override
	public Result saveNetContract1(Contract contract, String[] netIds, String[] prices,
			String[] ips, String[] ports, String[] ipPubs,
			String[] netStartDates, String[] netEndDates, String[] feeTypes,
			String[] moneys, String[] playPayDates, String[] planStartDates,
			String[] planEndDates, String autocheck) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractDao.openSession();
			/*if(contract.getContractNo()!=null){
				int count = session.createCriteria(Contract.class).add(Restrictions.eq("contractNo", contract.getContractNo())).list().size();
				if(count>0){
					return Result.failure("合同编号已经存在 ，保存失败");
				}
			}*/
			tr = session.beginTransaction();
			contract.setState(ContractStatusEnum.NEW);
			contract.setType(ContractTypeEnum.NetWorkContract);
			contract.setName(contract.getCustomerName());
			contract.setContractNo(generateCode(null).getValue());
			setcreatemodify(contract);
			session.save(contract);
			SubjectNetwork tempSubject = null;
			for (int i = 0; i < netIds.length; i++) {
				SubjectNetwork net = new SubjectNetwork();
				net.setContractId(contract.getId());
				net.setPrice(Double.parseDouble(prices[i]));
				net.setCustomerId(contract.getCustomerId());
				net.setStartDate(DateUtil.parse(netStartDates[i]));
				net.setEndDate(DateUtil.parse(netEndDates[i]));
				net.setIp(Integer.valueOf(ips[i]));
				net.setPriceUnit(NetworkPriceUnitEnum.MONTH);
				net.setPublicIP(Integer.valueOf(ipPubs[i]));
				net.setPort(Integer.valueOf(ports[i]));
				net.setFacilityId(Long.valueOf(netIds[i]));
				setcreatemodify(net);
				session.save(net);
				tempSubject = net;
			}
			if(moneys!=null)
			for (int i = 0; i < moneys.length; i++) {
				BillPlanFacility plan = new BillPlanFacility();
				if(autocheck!=null && autocheck.equals("yes")){
					plan.setAutoCheck(BooleanEnum.YES);
				}
				plan.setContractId(contract.getId());
				plan.setPlanFee(Double.valueOf(moneys[i]));
				plan.setRealFee(Double.valueOf(moneys[i]));
				plan.setPlanPayDate(DateUtil.parse(playPayDates[i]));
				plan.setStartDate(DateUtil.parse(planStartDates[i]));
				plan.setEndDate(DateUtil.parse(planEndDates[i]));
				plan.setStatus(BillPlanStatusEnum.UNCHECK);
				if(netIds.length==1){
					plan.setSubjectId(tempSubject.getId());
					plan.setFacilityId(tempSubject.getFacilityId());
				}
				setcreatemodify(plan);
				session.save(plan);
			}
			
			String deposit = ServletActionContext.getRequest().getParameter("deposit");
			if(deposit!=null){
				Double depositValue = Double.parseDouble(deposit);
				Deposit d = new Deposit();
				d.setAmount(depositValue);
				d.setContractId(contract.getId());
				d.setCustomerId(contract.getCustomerId());
				d.setType(DepositTypeEnum.ROOM);
				d.setStatus(BillPlanStatusEnum.UNCHECK);
				setcreatemodify(d);
				session.save(d);
			}
			
			
			tr.commit();
			return Result.success("保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure("保存失败");
		} finally {
			session.close();
		}
		
	}

	@Override
	public Result<List<Contract>> getListByHql(String Hql) {
		try {
			return Result.value(contractDao.getListByHql(Hql));
		} catch (Exception e) {
			return Result.failure(R.Contract.LOAD_FAILURE);
		}
	}
}
