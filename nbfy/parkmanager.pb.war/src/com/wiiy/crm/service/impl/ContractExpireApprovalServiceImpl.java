package com.wiiy.crm.service.impl;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.ContractExpireApprovalDao;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractExpireApproval;
import com.wiiy.crm.entity.ContractExpireApprovalAtt;
import com.wiiy.core.entity.Countersign;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.R;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.service.ContractExpireApprovalService;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractExpireApprovalServiceImpl implements ContractExpireApprovalService{
	
	private ContractExpireApprovalDao contractExpireApprovalDao;
	private SubjectRentService subjectRentService;
	
	public void setContractExpireApprovalDao(ContractExpireApprovalDao contractExpireApprovalDao) {
		this.contractExpireApprovalDao = contractExpireApprovalDao;
	}

	
	
	public void setSubjectRentService(SubjectRentService subjectRentService) {
		this.subjectRentService = subjectRentService;
	}



	@Override
	public Result<ContractExpireApproval> save(ContractExpireApproval t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractExpireApprovalDao.save(t);
			return Result.success(R.ContractExpireApproval.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractExpireApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApproval> delete(ContractExpireApproval t) {
		try {
			contractExpireApprovalDao.delete(t);
			return Result.success(R.ContractExpireApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApproval> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session=contractExpireApprovalDao.openSession();
			tr=session.beginTransaction();
			
			
			@SuppressWarnings("unchecked")
			List<ContractExpireApprovalAtt> contractExpireApprovalAtts=session.createQuery("from ContractExpireApprovalAtt where contractExpireApprovalId="+id).list();
			if(contractExpireApprovalAtts!=null){
				for(ContractExpireApprovalAtt contractExpireApprovalAtt:contractExpireApprovalAtts){
					String path = contractExpireApprovalAtt.getNewName();
					PbActivator.getResourcesService().delete(path);
					session.delete(contractExpireApprovalAtt);
				}
			}
			
			
			@SuppressWarnings("unchecked")
			List<Countersign> countersigns=session.createQuery("from Countersign where countersignId="+id+"and countersignType='"+CountersignTypeEnum.EXPIRE+"'").list();
			if(countersigns!=null){
				for(Countersign countersign:countersigns){
					session.delete(countersign);
				}
			}
			
			ContractExpireApproval contractExpireApproval = (ContractExpireApproval)session.createQuery("from ContractExpireApproval where id ="+id).list().get(0);
			session.delete(contractExpireApproval);
			
			@SuppressWarnings("unchecked")
			List<Approval> approvals = session.createQuery("from Approval where groupId ="+id+"and type='"+ApprovalTypeEnum.EXPIRE+"'").list();
			if(approvals!=null){
				for(Approval approval:approvals){
					session.delete(approval);
				}
			}
						
			tr.commit();
			return Result.success(R.ContractExpireApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractExpireApproval.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<ContractExpireApproval> deleteByIds(String ids) {
		try {
			contractExpireApprovalDao.deleteByIds(ids);
			return Result.success(R.ContractExpireApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApproval> update(ContractExpireApproval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractExpireApprovalDao.update(t);
			return Result.success(R.ContractExpireApproval.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractExpireApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApproval> getBeanById(Serializable id) {
		try {
			return Result.value(contractExpireApprovalDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApproval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractExpireApprovalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractExpireApproval>> getList() {
		try {
			return Result.value(contractExpireApprovalDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractExpireApproval>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractExpireApprovalDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result approval(Long id,Long userId,String approvalType) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractExpireApprovalDao.openSession();
			ContractExpireApproval contractExpireApproval = (ContractExpireApproval) session.get(ContractExpireApproval.class, id);
			if(contractExpireApproval.getCwzjApprovalId()==null && approvalType.equals("cwzj")||contractExpireApproval.getGcbApprovalId()==null && approvalType.equals("gcb")||contractExpireApproval.getZjlApprovalId()==null && approvalType.equals("zjl")||contractExpireApproval.getCwbApprovalId()==null && approvalType.equals("cwb")||contractExpireApproval.getKhApprovalId()==null && approvalType.equals("kh") ){
				tr = session.beginTransaction();
//				Long approvalId = Long.valueOf(PbActivator.getAppConfig().getConfig("contractExpireApprovalApprovalUser").getParameter(approvalType));
				Long approvalId = userId;
				User approvalUser = PbActivator.getService(OsgiUserService.class).getById(approvalId);
				SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
				if(sysEmailSenderPubService!=null && emailActive()&&approvalUser!=null){
					String content = "";
					StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
					content = data.toString();
					String subject = "合同到期审批提醒";
					content = content.replace("${subject}", contractExpireApproval.getContract().getName());
					content = content.replace("${msgType}", "合同到期审批");
					content = content.replace("${url}", basePath()+"parkmanager.pb/countersign!view.action?id="+id+"type="+CountersignTypeEnum.EXPIRE);
					content = content.replace("${receiver}", approvalUser.getRealName());
					content = content.replace("${customerName}", approvalUser.getRealName());
					content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
					content = content.replace("${content}", "");
					content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
					if(approvalUser.getEmail()!=null&&!approvalUser.getEmail().equals("")){
						sysEmailSenderPubService.send(approvalUser.getEmail(), content, subject);
					}
				}
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive() && approvalUser!=null){
					String receiverMobile = approvalUser.getMobile();
					String receiverName = approvalUser.getRealName();
					String content = PbActivator.getAppConfig().getConfig("contractExpireApprovalRemind").getParameter("smsModule");
					content = content.replace("${contractExpireApproval}", contractExpireApproval.getContract().getName());
					smsPubService.send(receiverMobile, content, receiverName);
				}
				Approval approval = new Approval();
				approval.setTitle(contractExpireApproval.getContract().getName());
				approval.setStatus(ApprovalStatusEnum.UNDETERMINED);
				approval.setType(ApprovalTypeEnum.EXPIRE);
				approval.setGroupId(contractExpireApproval.getId());
				approval.setUserId(approvalId);
				approval.setUserName(PbActivator.getService(OsgiUserService.class).getById(approvalId).getRealName());
				approval.setUrl("parkmanager.pb/contractExpireApproval!view.action?id="+id);
				approval.setWidth(600);
				approval.setHeight(400);
				session.save(approval);
				if(approvalType.equals("cwb")){
					contractExpireApproval.setCwbApprovalId(approval.getId());
				} else if(approvalType.equals("gcb")){
					contractExpireApproval.setGcbApprovalId(approval.getId());
				} else if(approvalType.equals("cwzj")){
					contractExpireApproval.setCwzjApprovalId(approval.getId());
				}else if(approvalType.equals("zjl")){
					contractExpireApproval.setZjlApprovalId(approval.getId());
				}else if(approvalType.equals("kh")){
					contractExpireApproval.setKhApprovalId(approval.getId());
			    }
				session.update(contractExpireApproval);
				tr.commit();
				return Result.success("送审成功");
			} else {
				return Result.failure("已经送审");
			}
		} catch (Exception e) { 
			tr.rollback();
			e.printStackTrace();
			return Result.failure("送审失败");
		} finally {
			session.close();
		}
	}

	@Override
	public String setBusinessmanSuggestion(Contract contract) {
		String businessmanSuggestion=PbActivator.getAppConfig().getConfig("businessmanSuggestion").getParameter("content");
		SubjectRent subjectRent=subjectRentService.getBeanByFilter(new Filter(SubjectRent.class).eq("contractId", contract.getId())).getValue();
		if(subjectRent!=null){
			businessmanSuggestion=businessmanSuggestion.replace("${contract.name}",contract.getCustomerName());
			businessmanSuggestion=businessmanSuggestion.replace("${roomName}",subjectRent.getRoomName());
			businessmanSuggestion=businessmanSuggestion.replace("${area}",subjectRent.getRoomArea().toString());
			String startDate=DateUtil.format(subjectRent.getStartDate(), "yyyy年MM月dd日");
			businessmanSuggestion=businessmanSuggestion.replace("${startDate}",startDate);
			String endDate=DateUtil.format(subjectRent.getEndDate(), "yyyy年MM月dd日");
			businessmanSuggestion=businessmanSuggestion.replace("${endDate}",endDate);
			Long mi=subjectRent.getEndDate().getTime()-subjectRent.getStartDate().getTime();
//		    NumberFormat   nf=new  DecimalFormat( "0.0 "); 
//		    double y=mi*10.0/1000/60/60/24/365.0;
//			    if(y<1){
//			    	Double month = Double.parseDouble( nf.format(Math.round(mi*1.0/1000/60/60/24/30)));
//			    	businessmanSuggestion=businessmanSuggestion.replace("${year}", month.toString()+"月");
//			    }else{
//		        Double year = Double.parseDouble(nf.format(Math.round(mi*1.0/1000/60/60/24/365.0)));
//			    businessmanSuggestion=businessmanSuggestion.replace("${year}", year.toString()+"年");
//			    }
			businessmanSuggestion=businessmanSuggestion.replace("${year}", "");
		}else{
			businessmanSuggestion=businessmanSuggestion.replace("${contract.name}",contract.getCustomerName());
			businessmanSuggestion=businessmanSuggestion.replace("${roomName}","xx幢xx室");
			businessmanSuggestion=businessmanSuggestion.replace("${area}","xx平方米");
			String startDate=DateUtil.format(contract.getStartDate(), "yyyy年MM月dd日");
			businessmanSuggestion=businessmanSuggestion.replace("${startDate}",startDate);
			String endDate=DateUtil.format(contract.getEndDate(), "yyyy年MM月dd日");
			businessmanSuggestion=businessmanSuggestion.replace("${endDate}",endDate);
			Long mi=contract.getEndDate().getTime()-contract.getStartDate().getTime();
//			  NumberFormat   nf=new  DecimalFormat( "0.0 "); 
//			  double y=mi*10.0/1000/60/60/24/365.0;
//			    if(y<1){
//			    	Double month = Double.parseDouble( nf.format(Math.round(mi*1.0/1000/60/60/24/30)));
//			    	businessmanSuggestion=businessmanSuggestion.replace("${year}", month.toString()+"月");
//			    }else{
//		        Double year = Double.parseDouble(nf.format(Math.round(mi*1.0/1000/60/60/24/365.0)));
//			    businessmanSuggestion=businessmanSuggestion.replace("${year}", year.toString()+"年");
//			    }
			businessmanSuggestion=businessmanSuggestion.replace("${year}", "");
		}
		return businessmanSuggestion;
	}
	
	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractExpireApprovalRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractExpireApprovalRemind").getParameter("sms");
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
}
