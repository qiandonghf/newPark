package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SupplyApplyDao;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyApply;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.CarApplyStatusEnum;
import com.wiiy.oa.service.SupplyApplyService;
import com.wiiy.oa.util.RemindUtil;

public class SupplyApplyServiceImpl implements SupplyApplyService{
	private SupplyApplyDao supplyApplyDao;
	@Override
	public Result<SupplyApply> save(SupplyApply t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = supplyApplyDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			
			Supply supply = (Supply)session.get(Supply.class, t.getSupplyId());
			Double stockNum = supply.getStock();
			Double applyNum = t.getAmount();
			if(applyNum<=stockNum){
				supply.setStock(stockNum-applyNum);
				session.update(supply);
				tr.commit();
				return Result.success(R.SupplyApply.SAVE_SUCCESS, t);
			}else if(applyNum>stockNum)
				tr.commit();
				return Result.success("库存数不足");
		}catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SupplyApply.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}


	@Override
	public Result<SupplyApply> delete(SupplyApply t) {
		try {
			OaActivator.getOperationLogService().logOP("删除办公用品申请单,id为【"+t.getId()+"】");
			supplyApplyDao.delete(t);
			return Result.success(R.SupplyApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除办公用品申请单,id为【"+id+"】");
			supplyApplyDao.deleteById(id);
			return Result.success(R.SupplyApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除办公用品申请单,id为【"+id+"】");
			}
			supplyApplyDao.deleteByIds(ids);
			return Result.success(R.SupplyApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> update(SupplyApply t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			supplyApplyDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的办公用品申请单");
			return Result.success(R.SupplyApply.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyApply.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> getBeanById(Serializable id) {
		try {
			return Result.value(supplyApplyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(supplyApplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyApply>> getList() {
		try {
			return Result.value(supplyApplyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyApply>> getListByFilter(Filter filter) {
		try {
			return Result.value(supplyApplyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.LOAD_FAILURE);
		}
	}

	public SupplyApplyDao getSupplyApplyDao() {
		return supplyApplyDao;
	}

	public void setSupplyApplyDao(SupplyApplyDao supplyApplyDao) {
		this.supplyApplyDao = supplyApplyDao;
	}

	@Override
	public Result<SupplyApply> approve(Long id, Long approverId,String approverl) {
		try {
			SupplyApply t = supplyApplyDao.getBeanById(id);
			t.setApproverId(approverId);
			t.setApprover(approverl);
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			supplyApplyDao.update(t);
			//发送邮件
			User user = OaActivator.getUserById(approverId);
			SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
			if(sysEmailSenderPubService!=null ){
				String content = "";
				StringBuffer data = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html");
				content = data.toString();
				String subject = "办公用品申请审批提醒";
				content = content.replace("${subject}", t.getSupply().getName());
				content = content.replace("${msgType}", "办公用品申请审批提醒");
				content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.oa/supplyApply!view.action?id="+t.getId());
				content = content.replace("${receiver}",  user.getRealName());
				content = content.replace("${customerName}", user.getRealName());
				content = content.replace("${sender}",t.getApplyer());
				content = content.replace("${content}", t.getMemo());
				content = content.replace("${msgLink}", OaActivator.getHttpSessionService().getRemindEmailLink());
				RemindUtil.sendMail( user.getRealName(), user.getEmail(),subject,content,sysEmailSenderPubService);
			}
			return Result.success(R.SupplyApply.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyApply.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SupplyApply> approveApply(SupplyApply t, String applyCheck) {
		Session session = null;
		Transaction tr = null;
		try {
			session = supplyApplyDao.openSession();
			tr = session.beginTransaction();
			if(applyCheck.equals("1")){
				t.setStatus(CarApplyStatusEnum.AGREE);
			}else{
				t.setStatus(CarApplyStatusEnum.REFUSE);
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			session.update(t);
			
			/*//发送邮件提醒
			SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
			User applyPerson = OaActivator.getUserById(t.getCreatorId());
			String content = OaActivator.getAppConfig().getConfig("supplyApprovalRemind").getParameter("email");
			content = content.replace("${applicant}",applyPerson.getRealName());
			String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
			String url = path+"parkmanager.oa/web/chiefadmin/Vehicle_maintenance_list.jsp";
			content = content.replace("${url}", url);
			String subject = "办公用品审批完成提醒";
			if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(applyPerson.getEmail(), content,subject);
			OaActivator.getOperationLogService().logOP("审批id为【"+t.getId()+"】的办公用品申请单");*/
			
			Supply supply = (Supply)session.get(Supply.class, t.getSupplyId());
			Double stockNum = supply.getStock();
			Double applyNum = t.getAmount();
			if(t.getStatus().equals(CarApplyStatusEnum.AGREE) && applyNum<=stockNum){
				supply.setStock(stockNum-applyNum);
				session.update(supply);
				tr.commit();
				return Result.success(R.SupplyApply.UPDATE_SUCCESS);
			}else if(t.getStatus().equals(CarApplyStatusEnum.AGREE) && applyNum>stockNum)
				tr.commit();
				return Result.success("库存数不足");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SupplyApply.UPDATE_FAILURE);
		} finally{
			session.close();
		}
	}	
	@Override
	public Result updateSupply(SupplyApply t, Double count) {
		Session session = null;
		Transaction tr = null;
		try {
			session = supplyApplyDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			session.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的办公用品申请单");
			
			Supply supply = (Supply)session.get(Supply.class, t.getSupplyId());
			supply.setStock(supply.getStock()-t.getAmount()+count);
			session.update(supply);
			
			tr.commit();
			return Result.success(R.SupplyApply.UPDATE_SUCCESS,t);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.SupplyApply.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}

}
