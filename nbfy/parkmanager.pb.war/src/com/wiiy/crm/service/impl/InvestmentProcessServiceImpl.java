package com.wiiy.crm.service.impl;


import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.IOUtil;
import com.wiiy.commons.util.MicrosoftWordUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.InvestmentProcessDao;

import com.wiiy.crm.dto.InvestmentProcessDto;

import com.wiiy.core.entity.Countersign;
import com.wiiy.crm.entity.InvestmentProcess;
import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.crm.preferences.R;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.crm.service.InvestmentProcessService;
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
public class InvestmentProcessServiceImpl implements InvestmentProcessService{
	
	private InvestmentProcessDao investmentProcessDao;
	
	public void setInvestmentProcessDao(InvestmentProcessDao investmentProcessDao) {
		this.investmentProcessDao = investmentProcessDao;
	}

	@Override
	public Result<InvestmentProcess> save(InvestmentProcess t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setCountersignStatus(CountersignOpenEnum.UNDONE);
			investmentProcessDao.save(t);
			return Result.success(R.InvestmentProcess.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentProcess.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.SAVE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcess> delete(InvestmentProcess t) {
		try {
			investmentProcessDao.delete(t);
			return Result.success(R.InvestmentProcess.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcess> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session=investmentProcessDao.openSession();
			tr=session.beginTransaction();
			
			InvestmentProcess investmentProcess = (InvestmentProcess)session.createQuery("from InvestmentProcess where id ="+id).uniqueResult();
			@SuppressWarnings("unchecked")
			List<InvestmentProcessAtt> investmentProcessAtts=session.createQuery("from InvestmentProcessAtt where investmentId="+investmentProcess.getInvestmentId()).list();
			if(investmentProcessAtts!=null){
				for(InvestmentProcessAtt investmentProcessAtt:investmentProcessAtts){
					String path = investmentProcessAtt.getNewName();
					PbActivator.getResourcesService().delete(path);
					session.delete(investmentProcessAtt);
				}
			}
			
			
			@SuppressWarnings("unchecked")
			List<Countersign> countersigns = session.createQuery("from Countersign where countersignId = "+id+"and countersignType='"+CountersignTypeEnum.PROCESS+"'").list();
			if(countersigns!=null){
				for(Countersign countersign:countersigns){
					session.delete(countersign);
				}
			}
			
			session.delete(investmentProcess);
			
			@SuppressWarnings("unchecked")
			List<Approval> approvals = session.createQuery("from Approval where groupId ="+id+"and type='"+ApprovalTypeEnum.PROCESS+"'").list();
			if(approvals!=null){
				for(Approval approval:approvals){
					session.delete(approval);
				}
			}
						
			tr.commit();
			return Result.success(R.InvestmentProcess.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.InvestmentProcess.DELETE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<InvestmentProcess> deleteByIds(String ids) {
		try {
			investmentProcessDao.deleteByIds(ids);
			return Result.success(R.InvestmentProcess.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcess> update(InvestmentProcess t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			investmentProcessDao.update(t);
			return Result.success(R.InvestmentProcess.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentProcess.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcess> getBeanById(Serializable id) {
		try {
			return Result.value(investmentProcessDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.LOAD_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcess> getBeanByFilter(Filter filter) {
		try {
			return Result.value(investmentProcessDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentProcess>> getList() {
		try {
			return Result.value(investmentProcessDao.getList());
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentProcess>> getListByFilter(Filter filter) {
		try {
			return Result.value(investmentProcessDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcess.LOAD_FAILURE);
		}
	}

	@Override
	public Result approval(Long id,Long userId,String approvalType) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentProcessDao.openSession();
			InvestmentProcess investmentProcess = (InvestmentProcess) session.get(InvestmentProcess.class, id);
			if(investmentProcess.getCwbApprovalId()==null && approvalType.equals("cwb") || investmentProcess.getGcbApprovalId()==null && approvalType.equals("gcb") || investmentProcess.getRzqyApprovalId()==null && approvalType.equals("rzqy")){
				tr = session.beginTransaction();
//				Long approvalId = Long.valueOf(PbActivator.getAppConfig().getConfig("investmentApprovalUser").getParameter(approvalType));
				Long approvalId = userId;
				User approvalUser = PbActivator.getService(OsgiUserService.class).getById(approvalId);
				SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
				if(sysEmailSenderPubService!=null && emailActive()&&approvalUser!=null){
					String content = "";
					StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
					content = data.toString();
					String subject = "入驻企业流程联系单审批提醒";
					content = content.replace("${subject}", investmentProcess.getName());
					content = content.replace("${msgType}", "入驻企业流程联系单审批");
					content = content.replace("${url}", basePath()+"parkmanager.pb/countersign!view.action?id="+id+"type="+CountersignTypeEnum.PROCESS);
					content = content.replace("${receiver}", approvalUser.getRealName());
					content = content.replace("${customerName}", approvalUser.getRealName());
					content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
					content = content.replace("${content}", investmentProcess.getOther());
					content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
					if(approvalUser.getEmail()!=null&&!approvalUser.getEmail().equals("")){
						sysEmailSenderPubService.send(approvalUser.getEmail(), content, subject);
					}
				}
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive() && approvalUser!=null){
					String receiverMobile = approvalUser.getMobile();
					String receiverName = approvalUser.getRealName();
					String content = PbActivator.getAppConfig().getConfig("investmentProcessRemind").getParameter("smsModule");
					content = content.replace("${investmentProcess}", investmentProcess.getName());
					smsPubService.send(receiverMobile, content, receiverName);
				}
				Approval approval = new Approval();
				approval.setTitle(investmentProcess.getName());
				approval.setStatus(ApprovalStatusEnum.UNDETERMINED);
				approval.setType(ApprovalTypeEnum.PROCESS);
				approval.setGroupId(investmentProcess.getId());
				approval.setUserId(approvalId);
				approval.setUserName(PbActivator.getService(OsgiUserService.class).getById(approvalId).getRealName());
				approval.setUrl("parkmanager.pb/investmentProcess!approvalView.action?id="+id);
				approval.setWidth(600);
				approval.setHeight(400);
				session.save(approval);
				if(approvalType.equals("cwb")){
					investmentProcess.setCwbApprovalId(approval.getId());
				} else if(approvalType.equals("gcb")){
					investmentProcess.setGcbApprovalId(approval.getId());
				} else if(approvalType.equals("rzqy")){
					investmentProcess.setRzqyApprovalId(approval.getId());
				}
				session.update(investmentProcess);
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
		String msgSet =  PbActivator.getAppConfig().getConfig("investmentProcessRemind").getParameter("email");
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
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("investmentProcessRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	@Override
	public Result<InvestmentProcess> print(Long id,OutputStream out) {
		try {
			InvestmentProcess investmentProcess = investmentProcessDao.getBeanById(id);
				
			
			InvestmentProcessDto investmentProcessDto = new InvestmentProcessDto();
			
			investmentProcessDto.setName(investmentProcess.getName());		
			if(investmentProcess.getBusinessmanSuggestion()!=null&&investmentProcess.getBusinessmanSuggestion().length()>0){
				investmentProcessDto.setBusinessmanSuggestion(investmentProcess.getBusinessmanSuggestion());
			}
			if(investmentProcess.getCwbApproval()!=null){
				investmentProcessDto.setCwbSuggesstion(investmentProcess.getCwbApproval().getSuggestion());
			}
			if(investmentProcess.getGcb()!=null){
				investmentProcessDto.setGcbSuggesstion(investmentProcess.getGcb().getSuggestion());
			}
			if(investmentProcess.getRzqy()!=null){
				investmentProcessDto.setRzqySuggesstion(investmentProcess.getRzqy().getSuggestion());
			}
			if(investmentProcess.getProjectMemo()!=null){
				investmentProcessDto.setProjectMemo(investmentProcess.getProjectMemo());
			}
			
			investmentProcessDto.setDay(DateUtil.format(investmentProcess.getModifyTime(),"dd"));
			investmentProcessDto.setMonth(DateUtil.format(investmentProcess.getModifyTime(),"MM"));
			investmentProcessDto.setYear(DateUtil.format(investmentProcess.getModifyTime(),"yyyy"));
	
			investmentProcessDto.setName(investmentProcess.getName());
			investmentProcessDto.setContect(investmentProcess.getContect());
			investmentProcessDto.setPhone(investmentProcess.getPhone());
			investmentProcessDto.setOther(investmentProcess.getOther());
			
			generateInvestmentProcessWord(investmentProcessDto, out);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.InvestmentProcess.LOAD_FAILURE);
		}
	}
	private void generateInvestmentProcessWord(InvestmentProcessDto investmentProcessDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/investmentProcess.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			Field[] investmentProcessFields = InvestmentProcessDto.class.getDeclaredFields();
			for (Field field : investmentProcessFields) {
				if(!Collection.class.isAssignableFrom(field.getClass())){
					String fieldName = field.getName();
					try {
						Object value = InvestmentProcessDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(investmentProcessDto);
						String replaceText = "";
						if(value instanceof Number){
							replaceText = new DecimalFormat("#.##").format(value);
						} else if(value!=null){
							replaceText = value.toString();
						}
						String toFindText = "#"+fieldName;
						mwu.moveStart();
						mwu.replaceText(toFindText, replaceText);
					} catch (Exception e) {
						e.printStackTrace();
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
}
