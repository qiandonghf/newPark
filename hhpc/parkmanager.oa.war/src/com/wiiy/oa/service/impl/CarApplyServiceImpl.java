package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.CarApplyDao;
import com.wiiy.oa.entity.CarApply;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.CarApplyStatusEnum;
import com.wiiy.oa.service.CarApplyService;

public class CarApplyServiceImpl implements CarApplyService{
	private CarApplyDao carApplyDao;
	public void setCarApplyDao(CarApplyDao carApplyDao) {
		this.carApplyDao = carApplyDao;
	}

	@Override
	public Result<CarApply> save(CarApply t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			carApplyDao.save(t);
			OaActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的车辆申请单");
			return Result.success(R.CarApply.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarApply.class)));
		} catch (Exception e) {
			return Result.failure(R.CarApply.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> delete(CarApply t) {
		try {
			carApplyDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的车辆申请单");
			return Result.success(R.CarApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆申请单");
			carApplyDao.deleteById(id);
			return Result.success(R.CarApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆申请单");
			}
			carApplyDao.deleteByIds(ids);
			return Result.success(R.CarApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> update(CarApply t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			carApplyDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的车辆申请单");
			return Result.success(R.CarApply.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarApply.class)));
		} catch (Exception e) {
			return Result.failure(R.CarApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> getBeanById(Serializable id) {
		try {
			return Result.value(carApplyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CarApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CarApply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(carApplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CarApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CarApply>> getList() {
		try {
			return Result.value(carApplyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CarApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CarApply>> getListByFilter(Filter filter) {
		try {
			return Result.value(carApplyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CarApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CarApply> approve(Long id, Long approverId, String approverl) {
		try {
			CarApply t = carApplyDao.getBeanById(id);
			t.setApproverId(approverId);
			t.setApprover(approverl);
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			carApplyDao.update(t);
			
			SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
			User user = OaActivator.getUserById(approverId);
			String content = OaActivator.getAppConfig().getConfig("carApplyRemind").getParameter("email");
			content = content.replace("${approver}", user.getRealName());
			content = content.replace("${applicant}",OaActivator.getSessionUser().getRealName());
			String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
			String url = path+"parkmanager.oa/web/chiefadmin/Vehicle_applications_list.jsp";
			content = content.replace("${url}", url);
			String subject = "车辆审批提醒";
			if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(user.getEmail(), content,subject);
			OaActivator.getOperationLogService().logOP("将id为【"+t.getId()+"】的车辆申请单提交审批");
			return Result.success(R.CarApply.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarApply.class)));
		} catch (Exception e) {
			return Result.failure(R.CarApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CarApply> approveCarApply(Long id, String applyCheck) {
		try {
			CarApply t = carApplyDao.getBeanById(id);
			if(applyCheck.equals("1")){
				t.setStatus(CarApplyStatusEnum.AGREE);
			}else{
				t.setStatus(CarApplyStatusEnum.REFUSE);
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			carApplyDao.update(t);
			SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
			User applyPerson = OaActivator.getUserById(t.getCreatorId());
			String content = OaActivator.getAppConfig().getConfig("carApprovalRemind").getParameter("email");
			content = content.replace("${applicant}",applyPerson.getRealName());
			String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
			String url = path+"parkmanager.oa/web/chiefadmin/Vehicle_applications_list.jsp";
			content = content.replace("${url}", url);
			String subject = "车辆审批完成提醒";
			if(sysEmailSenderPubService!=null) sysEmailSenderPubService.send(applyPerson.getEmail(), content,subject);
			OaActivator.getOperationLogService().logOP("审批id为【"+t.getId()+"】的车辆申请单");
			return Result.success(R.CarApply.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarApply.class)));
		} catch (Exception e) {
			return Result.failure(R.CarApply.UPDATE_FAILURE);
		}
	}

}
