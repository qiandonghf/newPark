package com.wiiy.crm.service.impl;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.URL;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.ContractReviewDao;
import com.wiiy.crm.entity.ContractReview;
import com.wiiy.crm.entity.ContractReviewAtt;
import com.wiiy.core.entity.Countersign;
import com.wiiy.crm.preferences.R;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.service.ContractReviewService;
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
public class ContractReviewServiceImpl implements ContractReviewService{
	
	private ContractReviewDao contractReviewDao;
	
	public void setContractReviewDao(ContractReviewDao contractReviewDao) {
		this.contractReviewDao = contractReviewDao;
	}

	@Override
	public Result<ContractReview> save(ContractReview t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractReviewDao.save(t);
			return Result.success(R.ContractReview.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractReview.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractReview> delete(ContractReview t) {
		try {
			contractReviewDao.delete(t);
			return Result.success(R.ContractReview.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractReview> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session=contractReviewDao.openSession();
			tr=session.beginTransaction();
			
			
			@SuppressWarnings("unchecked")
			List<ContractReviewAtt> contractReviewAtts=session.createQuery("from ContractReviewAtt where contractReviewId="+id).list();
			if(contractReviewAtts!=null){
				for(ContractReviewAtt contractReviewAtt:contractReviewAtts){
					String path = contractReviewAtt.getNewName();
					PbActivator.getResourcesService().delete(path);
					session.delete(contractReviewAtt);
				}
			}
			
			
			@SuppressWarnings("unchecked")
			List<Countersign> countersigns=session.createQuery("from Countersign where countersignId="+id+"and countersignType='"+CountersignTypeEnum.EXPIRE+"'").list();
			if(countersigns!=null){
				for(Countersign countersign:countersigns){
					session.delete(countersign);
				}
			}
			
			ContractReview contractReview = (ContractReview)session.createQuery("from ContractReview where id ="+id).list().get(0);
			session.delete(contractReview);
			
			@SuppressWarnings("unchecked")
			List<Approval> approvals = session.createQuery("from Approval where groupId ="+id+"and type='"+ApprovalTypeEnum.REVIEW+"'").list();
			if(approvals!=null){
				for(Approval approval:approvals){
					session.delete(approval);
				}
			}
						
			tr.commit();
			return Result.success(R.ContractReview.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractReview.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<ContractReview> deleteByIds(String ids) {
		try {
			contractReviewDao.deleteByIds(ids);
			return Result.success(R.ContractReview.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractReview> update(ContractReview t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractReviewDao.update(t);
			return Result.success(R.ContractReview.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractReview.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractReview> getBeanById(Serializable id) {
		try {
			return Result.value(contractReviewDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractReview> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractReviewDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractReview>> getList() {
		try {
			return Result.value(contractReviewDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractReview.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractReview>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractReviewDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractReview.LOAD_FAILURE);
		}
	}

	@Override
	public Result approval(Long id,Long userId,String approvalType) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractReviewDao.openSession();
			ContractReview contractReview = (ContractReview) session.get(ContractReview.class, id);
			if(contractReview.getJbId()==null && approvalType.equals("jb") || contractReview.getHqId()==null && approvalType.equals("hq") || contractReview.getShId()==null && approvalType.equals("sh")|| contractReview.getSpId()==null && approvalType.equals("sp")){
				tr = session.beginTransaction();
//				Long approvalId = Long.valueOf(PbActivator.getAppConfig().getConfig("contractReviewApprovalUser").getParameter(approvalType));
				Long approvalId = userId;
				User approvalUser = PbActivator.getService(OsgiUserService.class).getById(approvalId);
				SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
				if(sysEmailSenderPubService!=null && emailActive()&&approvalUser!=null){
					String content = "";
					StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
					content = data.toString();
					String subject = "合同会签审核提醒";
					content = content.replace("${subject}", contractReview.getContract().getName());
					content = content.replace("${msgType}", "合同会签审核");
					content = content.replace("${url}", basePath()+"parkmanager.pb/countersign!view.action?id="+id+"type="+CountersignTypeEnum.REVIEW);
					content = content.replace("${receiver}", approvalUser.getRealName());
					content = content.replace("${customerName}", approvalUser.getRealName());
					content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
					content = content.replace("${content}","");
					content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
					if(approvalUser.getEmail()!=null&&!approvalUser.getEmail().equals("")){
						sysEmailSenderPubService.send(approvalUser.getEmail(), content, subject);
					}
				}
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive() && approvalUser!=null){
					String receiverMobile = approvalUser.getMobile();
					String receiverName = approvalUser.getRealName();
					String content = PbActivator.getAppConfig().getConfig("contractReviewRemind").getParameter("smsModule");
					content = content.replace("${contractReview}", contractReview.getContract().getName());
					smsPubService.send(receiverMobile, content, receiverName);
				}
				Approval approval = new Approval();
				approval.setTitle(contractReview.getContract().getName());
				approval.setStatus(ApprovalStatusEnum.UNDETERMINED);
				approval.setType(ApprovalTypeEnum.REVIEW);
				approval.setGroupId(contractReview.getId());
				approval.setUserId(approvalId);
				approval.setUserName(PbActivator.getService(OsgiUserService.class).getById(approvalId).getRealName());
				approval.setUrl("parkmanager.pb/contractReview!view.action?id="+id);
				approval.setWidth(600);
				approval.setHeight(400);
				session.save(approval);
				if(approvalType.equals("jb")){
					contractReview.setJbId(approval.getId());
				} else if(approvalType.equals("hq")){
					contractReview.setHqId(approval.getId());
				} else if(approvalType.equals("sh")){
					contractReview.setShId(approval.getId());
				}else if(approvalType.equals("sp")){
					contractReview.setSpId(approval.getId());
				}
				session.update(contractReview);
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
	
	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractReviewRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractReviewRemind").getParameter("sms");
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
