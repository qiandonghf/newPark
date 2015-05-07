package com.wiiy.crm.service.impl;


import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.hibernate.SQLQuery;
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
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.Countersign;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.dao.InvestmentDao;
import com.wiiy.crm.dao.InvestmentDirectorDao;
import com.wiiy.crm.dao.InvestmentInvestorDao;
import com.wiiy.crm.dto.DirectorDto;
import com.wiiy.crm.dto.InvestmentDto;
import com.wiiy.crm.dto.InvestorDto;
import com.wiiy.crm.entity.BusinessPlan;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.CustomerQualification;
import com.wiiy.crm.entity.CustomerVentureType;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.entity.InvestmentInvestor;
import com.wiiy.crm.entity.InvestmentProcess;
import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.crm.entity.InvestmentRegInfo;
import com.wiiy.crm.entity.InvestmentVentureType;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.InvestmentStatusEnum;
import com.wiiy.crm.preferences.enums.ParkStatusEnum;
import com.wiiy.crm.service.InvestmentProcessService;
import com.wiiy.crm.service.InvestmentService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class InvestmentServiceImpl implements InvestmentService{
	
	private InvestmentDao investmentDao;
	private InvestmentInvestorDao investmentInvestorDao;
	private InvestmentDirectorDao investmentDirectorDao;
	private InvestmentProcessService investmentProcessService;
	
	
	
	public void setInvestmentProcessService(
			InvestmentProcessService investmentProcessService) {
		this.investmentProcessService = investmentProcessService;
	}

	public void setInvestmentDirectorDao(InvestmentDirectorDao investmentDirectorDao) {
		this.investmentDirectorDao = investmentDirectorDao;
	}

	public void setInvestmentInvestorDao(InvestmentInvestorDao investmentInvestorDao) {
		this.investmentInvestorDao = investmentInvestorDao;
	}

	public void setInvestmentDao(InvestmentDao investmentDao) {
		this.investmentDao = investmentDao;
	}

	@Override
	public Result<Investment> save(Investment t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			investmentDao.save(t);
			return Result.success(R.Investment.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Investment.class)));
		} catch (Exception e) {
			return Result.failure(R.Investment.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Investment> delete(Investment t) {
		try {
			investmentDao.delete(t);
			return Result.success(R.Investment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Investment.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Investment> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentDao.openSession();
			tr = session.beginTransaction();
			session.createQuery("update Customer set investmentId = null where investmentId = "+id).executeUpdate();
			session.createQuery("delete BusinessPlanAtt where planId="+id).executeUpdate();
			session.createQuery("delete InvestmentInvestor where investmentId="+id).executeUpdate();
			session.createQuery("delete BusinessPlan where id="+id).executeUpdate();
			session.createQuery("delete InvestmentDirector where investmentId="+id).executeUpdate();
			session.createQuery("delete InvestmentRegInfo where id="+id).executeUpdate();
			session.createQuery("delete InvestmentVentureType where investmentId="+id).executeUpdate();
			session.createQuery("delete InvestmentLog where investmentId="+id).executeUpdate();
			session.createQuery("delete Investment where id="+id).executeUpdate();
			session.createQuery("delete Approval where groupId="+id+"and type='"+ApprovalTypeEnum.INVESTMENT+"'").executeUpdate();
			
			InvestmentProcess investmentProcess = (InvestmentProcess) session.createQuery("from InvestmentProcess where investmentId="+id).uniqueResult();
			if(investmentProcess!=null){
			@SuppressWarnings("unchecked")
			List<Countersign> countersigns = session.createQuery("from Countersign where countersignId = "+investmentProcess.getId()+"and countersignType='"+CountersignTypeEnum.PROCESS+"'").list();
			if(countersigns!=null){
				for(Countersign countersign:countersigns){
					session.delete(countersign);
				}
			}
			
			@SuppressWarnings("unchecked")
			List<InvestmentProcessAtt> investmentProcessAtts=session.createQuery("from InvestmentProcessAtt where investmentId="+id).list();
			if(investmentProcessAtts!=null){
				for(InvestmentProcessAtt investmentProcessAtt:investmentProcessAtts){
					String path = investmentProcessAtt.getNewName();
					PbActivator.getResourcesService().delete(path);
					session.delete(investmentProcessAtt);
				}
			}
			
			
			
			session.delete(investmentProcess);
			
			@SuppressWarnings("unchecked")
			List<Approval> approvals = session.createQuery("from Approval where groupId ="+investmentProcess.getId()+"and type='"+ApprovalTypeEnum.PROCESS+"'").list();
			if(approvals!=null){
				for(Approval approval:approvals){
					session.delete(approval);
				}
			}
			}
			tr.commit();
			return Result.success(R.Investment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Investment.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Investment> deleteByIds(String ids) {
		try {
			investmentDao.deleteByIds(ids);
			return Result.success(R.Investment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Investment.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Investment> update(Investment t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			investmentDao.update(t);
			return Result.success(R.Investment.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Investment.class)));
		} catch (Exception e) {
			return Result.failure(R.Investment.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Investment> getBeanById(Serializable id) {
		try {
			return Result.value(investmentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Investment> getBeanByFilter(Filter filter) {
		try {
			return Result.value(investmentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Investment>> getList() {
		try {
			return Result.value(investmentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Investment>> getListByFilter(Filter filter) {
		try {
			return Result.value(investmentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Investment> saveOrUpdate(Investment investment, InvestmentRegInfo investmentRegInfo, String[] enterpriseTypeIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentDao.openSession();
			tr = session.beginTransaction();
			setCreatorModifier(investment);
			setCreatorModifier(investmentRegInfo);
			boolean newSave = false;
			BusinessPlan businessPlan = null;
			if(newSave = investment.getId()==null) {
				businessPlan = new BusinessPlan();
				setCreatorModifier(businessPlan);
				businessPlan.setInvestment(investment);
			}
			session.saveOrUpdate(investment);
			investmentRegInfo.setInvestment(investment);
			session.saveOrUpdate(investmentRegInfo);
			if(newSave) session.saveOrUpdate(businessPlan);
			
			String sql = "DELETE FROM "+ModulePrefixNamingStrategy.classToTableName(InvestmentVentureType.class)+
					" WHERE investment_id = "+investment.getId()+" ";
					session.createSQLQuery(sql).executeUpdate();
			if(enterpriseTypeIds!=null){	
				for(String enterpriseTypeId : enterpriseTypeIds){
					InvestmentVentureType it = new InvestmentVentureType();
					it.setModifyTime(new Date());
					it.setInvestment(investment);
					it.setInvestmentId(investment.getId());
					it.setVentureTypeId(enterpriseTypeId);
					session.save(it);
				}
			}
			tr.commit();
			return Result.success(R.Investment.SAVE_SUCCESS,investment);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Investment.class)));
		} catch (ConstraintViolationException e){
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(new UKConstraintException(e).getUK(),Investment.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Investment.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	private void setCreatorModifier(BaseEntity entity){
		entity.setCreateTime(new Date());
		entity.setCreatorId(PbActivator.getSessionUser().getId());
		entity.setCreator(PbActivator.getSessionUser().getRealName());
		entity.setModifyTime(entity.getCreateTime());
		entity.setModifier(entity.getCreator());
		entity.setModifierId(entity.getCreatorId());
		entity.setEntityStatus(EntityStatus.NORMAL);
	}
	
	private void setModifier(BaseEntity entity){
		entity.setModifyTime(entity.getCreateTime());
		entity.setModifier(entity.getCreator());
		entity.setModifierId(entity.getCreatorId());
	}

	@Override
	public Result<String> generateCode() {
		String code = "万创"+CalendarUtil.now().get(Calendar.YEAR);
		Investment investment = investmentDao.getBeanByFilter(new Filter(Investment.class).ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)).orderBy("id", Filter.DESC).maxResults(1));
		int count = investmentDao.getRowCount(new Filter(Investment.class).ge("createTime", CalendarUtil.getEarliest(Calendar.YEAR)));
		try {
			String oldCode = investment.getCode();
			count = Integer.parseInt(oldCode.replace("万创"+CalendarUtil.now().get(Calendar.YEAR), ""));
		} catch (Exception e) {
		}
		NumberFormat nf = NumberFormat.getInstance();
		nf.setGroupingUsed(false);
		nf.setMinimumIntegerDigits(6);
		code = code + nf.format(count+1);
		return Result.value(code);
	}

	@Override
	public Result<Investment> update(Investment investment, InvestmentRegInfo investmentRegInfo, String[] enterpriseTypeIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentDao.openSession();
			tr = session.beginTransaction();
			if(investmentRegInfo.getOrganizationNumber()!=null && investmentRegInfo.getOrganizationNumber().length()>0){
				Object o = session.createQuery("from InvestmentRegInfo where organizationNumber = '"+investmentRegInfo.getOrganizationNumber()+"' and id != "+investmentRegInfo.getId()).uniqueResult();
				if(o!=null){
					return Result.failure("组织机构代码已存在");
				}
			}
			Investment dbInvestment = (Investment) session.get(Investment.class,investment.getId());
			BeanUtil.copyProperties(investment, dbInvestment);
			if(investment.getOfficeArea()==null){
				dbInvestment.setOfficeArea(null);
			}
			/*InvestmentDirector dbInvestmentDirector = (InvestmentDirector) session.get(InvestmentDirector.class,investmentDirector.getId());*/
			/*BeanUtil.copyProperties(investmentDirector, dbInvestmentDirector);*/
			InvestmentRegInfo dbInvestmentRegInfo = (InvestmentRegInfo) session.get(InvestmentRegInfo.class,investmentRegInfo.getId());
			BeanUtil.copyProperties(investmentRegInfo, dbInvestmentRegInfo);
			if(investment.getCurrencyId().equals(""))dbInvestment.setCurrencyId(null);
			/*if(investmentDirector.getDegreeId().equals(""))dbInvestmentDirector.setDegreeId(null);*/
			if(investmentRegInfo.getCurrencyTypeId().equals(""))dbInvestmentRegInfo.setCurrencyTypeId(null);
			if(investmentRegInfo.getDocumentTypeId().equals(""))dbInvestmentRegInfo.setDocumentTypeId(null);
			if(investmentRegInfo.getRegTypeId().equals(""))dbInvestmentRegInfo.setRegTypeId(null);
			setModifier(dbInvestment);
			/*setModifier(dbInvestmentDirector);*/
			setModifier(dbInvestmentRegInfo);
			session.update(dbInvestment);
			session.update(dbInvestmentRegInfo);
			
			String sql = "DELETE FROM "+ModulePrefixNamingStrategy.classToTableName(InvestmentVentureType.class)+
					" WHERE investment_id = "+investment.getId()+" ";
					session.createSQLQuery(sql).executeUpdate();
			if(enterpriseTypeIds!=null){		
				for(String enterpriseTypeId : enterpriseTypeIds){
					InvestmentVentureType it = new InvestmentVentureType();
					it.setModifyTime(new Date());
					it.setInvestment(investment);
					it.setInvestmentId(investment.getId());
					it.setVentureTypeId(enterpriseTypeId);
					session.save(it);
				}
			}
			
			tr.commit();
			return Result.success(R.Investment.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Investment.class)));
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.Investment.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Investment> print(Long id,OutputStream out) {
		try {
			Investment investment = investmentDao.getBeanById(id);
			List<InvestmentInvestor> investorList = investmentInvestorDao.getListByFilter(new Filter(InvestmentInvestor.class).eq("investmentId",id));	
			List<InvestmentDirector> directorList = investmentDirectorDao.getListByFilter(new Filter(InvestmentDirector.class).eq("investmentId",id));
			InvestmentDto investmentDto = new InvestmentDto();
			if(investment.getBusinessmanSuggestion()!=null){//招商人员意见
				investmentDto.setBusinessmanView(investment.getBusinessmanSuggestion());
			}
			if(investment.getManagerApproval()!=null){//创投部经理审批意见
				investmentDto.setManagerView(investment.getManagerApproval().getSuggestion());
			}
			if(investment.getOfficeApproval()!=null){//领导审批意见
				investmentDto.setOfficeView(investment.getOfficeApproval().getSuggestion());
			}
			Session session = investmentDao.openSession();
			List<InvestmentVentureType> typeList = (List<InvestmentVentureType>) session.createQuery("from InvestmentVentureType where investmentId = "+investment.getId()).list();
			if(typeList!=null){
				String types = "";
				for (InvestmentVentureType investmentVentureType : typeList) {
					types += investmentVentureType.getVentureType().getDataValue()+",";
				}
				types = StringUtil.trim(types, ",");
				investmentDto.setEnterpriseTypes(types);
			}
			session.close();
			if(investment.getBusinessScope()!=null){
			investmentDto.setBusinessScope(investment.getBusinessScope());
			}
			if(investment.getTechnic()!=null && investment.getTechnic().getDataValue()!=null){
			investmentDto.setTechnic(investment.getTechnic().getDataValue());
			}
			if(investment.getCode()!=null){
			investmentDto.setCode(investment.getCode());
			}
			if(investment.getAddress()!=null){
			investmentDto.setAddress(investment.getAddress());
			}
			if(investment.getModifyTime()!=null){
			investmentDto.setDay(DateUtil.format(investment.getModifyTime(),"dd"));
			investmentDto.setMonth(DateUtil.format(investment.getModifyTime(),"MM"));
			investmentDto.setYear(DateUtil.format(investment.getModifyTime(),"yyyy"));
			}
			if(investment.getProjectMemo()!=null){
				investmentDto.setProjectMemo(investment.getProjectMemo());
			}
			if(investment.getInvestCapital()!=null){
			investmentDto.setInvestCapital(investment.getInvestCapital());
			}
			if(investment.getMemo()!=null){
			investmentDto.setMemo(investment.getMemo());
			}
			if(investment.getName()!=null){
			investmentDto.setName(investment.getName());
			}
			if(investment.getOfficeArea()!=null){
			investmentDto.setOfficeArea(investment.getOfficeArea());
			}
			if(investment.getOutputValue()!=null){
			investmentDto.setOutputValue(investment.getOutputValue());
			}
			if(investment.getRegCapital()!=null){
			investmentDto.setRegCapital(investment.getRegCapital());
			}
			if(investment.getStaff()!=null){
			investmentDto.setStaff(investment.getStaff());
			}
			if(investment.getAddress()!=null){
			investmentDto.setAddress(investment.getAddress());
			}
			if(investment.getBusinessScope()!=null){
			investmentDto.setBusinessScope(investment.getBusinessScope());
			}
			List<InvestorDto> dtoList = new ArrayList<InvestorDto>();
			for (InvestmentInvestor investor : investorList) {
				InvestorDto dto = new InvestorDto();
				if(investor.getBirthDay()!=null){
					dto.setBirthDay(DateUtil.format(investor.getBirthDay(),"yyyy-MM"));
				}
				if(investor.getCapital()!=null){
					dto.setCapital(investor.getCapital().getDataValue());
				}
				if(investor.getDegree()!=null){
					dto.setDegree(investor.getDegree().getDataValue());
				}
				if(investor.getGraduateYear()!=null){
				dto.setGraduateYear(investor.getGraduateYear());
				}
				if(investor.getName()!=null){
				dto.setName(investor.getName());
				}
				if(investor.getProfession()!=null){
				dto.setProfession(investor.getProfession());
				}
				if(investor.getRate()!=null){
					dto.setRate((new java.text.DecimalFormat("#.00").format(investor.getRate()))+"%");
				}
				if(investor.getSchool()!=null){
				dto.setSchool(investor.getSchool());
				}
				dtoList.add(dto);
			}
			List<DirectorDto> directorDtoList = new ArrayList<DirectorDto>();
			for (InvestmentDirector director: directorList) {
				DirectorDto directorDto = new DirectorDto();
				
				if(director.getDegree()!=null){
					directorDto.setDegree(director.getDegree().getDataValue());
				}
				directorDto.setName(director.getName());
				directorDto.setProfession(director.getProfession());
				directorDto.setSpecialty(director.getSpecialty());
				directorDto.setPhone(director.getPhone());
				directorDto.setMobile(director.getMobile());
				directorDtoList.add(directorDto);
			}

			investmentDto.setDirectorList(directorDtoList);
			investmentDto.setList(dtoList);
			generateInvestmentWord(investmentDto, out);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Investment.LOAD_FAILURE);
		}
	}
	
	private void generateInvestmentWord(InvestmentDto investmentDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/investment.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] investmentFields = InvestmentDto.class.getDeclaredFields();
			for (Field field : investmentFields) {
				if(!Collection.class.isAssignableFrom(field.getClass())){
					String fieldName = field.getName();
					try {
						Object value = InvestmentDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(investmentDto);
						String replaceText = "";
						if(value instanceof Number){
							replaceText = new DecimalFormat("#.##").format(value);
						} else if(value!=null){
							replaceText = value.toString();
						}
						String toFindText = "#"+fieldName;
						mwu.moveStart();
						mwu.replaceText(toFindText, replaceText);
						if(investmentDto.getEnterpriseTypes().contains("大学生")){
							mwu.replaceText("#title","大学生创业园区入驻申请表");
						}else{
							mwu.replaceText("#title","企业入驻申请表");
						}
						if(investmentDto.getOfficeArea()==null){
							mwu.replaceText("m2","");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
			List<DirectorDto> directorList = investmentDto.getDirectorList();
			int directorAddLine = directorList.size()-1;
			int dirStartIndex = 7;
			int dirColcount = 6; 
			for (int i = 0; i < directorAddLine; i++) {
				for (int j = 0; j < dirColcount; j++) {
					mwu.splitCell(1, dirStartIndex, j+1, 2, 1);
				}
			}
			for (int i = 0; i < directorList.size(); i++) {
				int colIndex = 1;
				DirectorDto dirDto = directorList.get(i);
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getName());
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getDegree());
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getSpecialty());
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getProfession());
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getMobile());
				mwu.writeCell(1, dirStartIndex+i, colIndex++, dirDto.getPhone());
			}
			
			List<InvestorDto> list = investmentDto.getList();
			int addLine = list.size()-1;
			int rowStartIndex = 8+directorList.size();
			int colCount = 8;
			for (int i = 0; i < addLine; i++) {
				for (int j = 0; j < colCount; j++) {
					mwu.splitCell(1, rowStartIndex, j+1, 2, 1);
				}
			}
			for (int i = 0; i < list.size(); i++) {
				int colIndex = 1;
				InvestorDto dto = list.get(i);
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getName());
				//如果去掉下面的判断，若是Rate为空，则打印出的申请表会显示null
				if(dto.getRate()==null){
					mwu.writeCell(1, rowStartIndex+i, colIndex++, "");
				}else{
					mwu.writeCell(1, rowStartIndex+i, colIndex++, String.valueOf(dto.getRate()));
				}
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getCapital());
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getBirthDay());
				//如果去掉下面的判断，若是GraduateYear为空，则打印出的申请表会显示null
				if(dto.getGraduateYear()==null){
					mwu.writeCell(1, rowStartIndex+i, colIndex++,"");
				}else{
					mwu.writeCell(1, rowStartIndex+i, colIndex++, String.valueOf(dto.getGraduateYear()));
				}
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getDegree());
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getProfession());
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getSchool());
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
	public Result submitSettled(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
 			session = investmentDao.openSession();
			tr = session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Object> obj = session.createSQLQuery("SELECT id FROM crm_customer WHERE investment_id="+id).list();
			if (obj.size() > 0) {
				return Result.failure("该招商项目已经提交入驻 或 已存在同名企业");
			}
			Investment investment = (Investment) session.get(Investment.class, id);
			session.createQuery("update InvestmentRegInfo set businessScope = '"+investment.getBusinessScope()+"' where investment.id = "+id).executeUpdate();
			Customer customer = new Customer();
			customer.setTechnicId(investment.getTechnicId());
			customer.setInvestmentId(id);
			customer.setName(investment.getName());
			//customer.setCode(investment.getCode());
			customer.setCode((new Date()).getTime()+"");
			customer.setParkStatus(ParkStatusEnum.INPARK);
			customer.setHostName(investment.getHostName());
			customer.setHostId(investment.getHostId());
			customer.setImportId(investment.getImportId());
			customer.setImportName(investment.getImportName());
			customer.setTime(new Date());
			customer.setCreateTime(new Date());
			customer.setCreator(PbActivator.getSessionUser().getRealName());
			customer.setCreatorId(PbActivator.getSessionUser().getId());
			customer.setModifyTime(new Date());
			customer.setModifier(PbActivator.getSessionUser().getRealName());
			customer.setModifierId(PbActivator.getSessionUser().getId());
			if(investment.getAccount()!=null){
				customer.setShortName(investment.getAccount());
			}
			customer.setMessageSend(EntityStatus.NORMAL);
			CustomerInfo info = new CustomerInfo();
			if(investment.getRegInfo()!=null){
				BeanUtil.copyProperties(investment.getRegInfo(), info);
				/*User user = new User();
				user.setUsername(investment.getAccount());
				user.setPassword(Cipher.md5("123456"));
				user.setUserType(UserTypeEnum.Customer);
				user.setRealName(investment.getName());
				Org org = new Org();
				org.setId(2l);
				user.setOrg(org);
				session.save(user);
				session.createSQLQuery("insert into "+ModulePrefixNamingStrategy.classToTableName(UserRoleRef.class)+"(user_id,role_id) values("+user.getId()+",2)").executeUpdate();
				customer.setUserId(user.getId());*/
			}
			info.setId(null);
			info.setBusinessScope(investment.getBusinessScope());
			IncubationInfo incubationInfo = new IncubationInfo();
			incubationInfo.setCustomer(customer);
			info.setCustomer(customer);
			investment.setInvestmentStatus(InvestmentStatusEnum.PARK);
			
			session.save(incubationInfo);
			session.save(customer);
			session.save(info);
			session.update(investment);
			
			//创建主要联系人
			List<InvestmentInvestor> investorList = investmentInvestorDao.getListByFilter(new Filter(InvestmentInvestor.class).eq("investmentId", id));
			for (InvestmentInvestor investmentInvestor : investorList) {
				Staffer staffer = new Staffer();
				staffer.setCustomerId(customer.getId());
				staffer.setName(investmentInvestor.getName());
				staffer.setDegreeId(investmentInvestor.getDegreeId());
				staffer.setStudySchool(investmentInvestor.getSchool());
				staffer.setStockHolder(BooleanEnum.YES);
				staffer.setManager(BooleanEnum.NO);
				staffer.setStudyAbroad(BooleanEnum.NO);
				staffer.setLegal(BooleanEnum.NO);
				staffer.setPub(BooleanEnum.NO);
				session.save(staffer);
			}
			
			
			//项目创业类型导入对应企业创业类型
			List<Object> list = investmentDao.getObjectListBySql("SELECT ventureType_id  FROM "+ModulePrefixNamingStrategy.classToTableName(InvestmentVentureType.class)+" WHERE investment_id = "+id+" GROUP BY ventureType_id;");
			if(list!=null && list.size()>0){
				for(Object object : list){
					CustomerVentureType cvt = new CustomerVentureType();
					cvt.setVentureTypeId(String.valueOf(object));
					cvt.setCustomer(customer);
					cvt.setCustomerId(customer.getId());
					cvt.setCreateTime(new Date());
					cvt.setCreator(PbActivator.getSessionUser().getRealName());
					cvt.setCreatorId(PbActivator.getSessionUser().getId());
					cvt.setModifyTime(cvt.getCreateTime());
					cvt.setModifier(cvt.getCreator());
					cvt.setModifierId(cvt.getCreatorId());
					cvt.setEntityStatus(EntityStatus.NORMAL);
					session.save(cvt);
				}
			}
			
			DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
			if(dataDictInitService!=null){
				//入驻项目,自动生成孵化信息
				List<DataDict> incubationRouteList = dataDictInitService.getDataDictByParentId("crm.0025");
				for(DataDict d : incubationRouteList){
					IncubationRoute ibr = new IncubationRoute();
					ibr.setId(null);
					ibr.setCustomer(customer);
					ibr.setCustomerId(customer.getId());
					ibr.setRouteId(d.getId());
					ibr.setRoute(d);
					ibr.setCreateTime(new Date());
					ibr.setCreator(PbActivator.getSessionUser().getRealName());
					ibr.setCreatorId(PbActivator.getSessionUser().getId());
					ibr.setModifyTime(ibr.getCreateTime());
					ibr.setModifier(ibr.getCreator());
					ibr.setModifierId(ibr.getCreatorId());
					ibr.setEntityStatus(EntityStatus.NORMAL);
					session.save(ibr);
				}
				
				//入驻项目,自动生成企业资质
				List<DataDict> customerQualificationList = dataDictInitService.getDataDictByParentId("crm.0027");
				for(DataDict d : customerQualificationList){
					CustomerQualification cqf = new CustomerQualification();
					cqf.setId(null);
					cqf.setCustomer(customer);
					cqf.setCustomerId(customer.getId());
					cqf.setQualificationId(d.getId());
					cqf.setQualification(d);
					cqf.setCreateTime(new Date());
					cqf.setCreator(PbActivator.getSessionUser().getRealName());
					cqf.setCreatorId(PbActivator.getSessionUser().getId());
					cqf.setModifyTime(cqf.getCreateTime());
					cqf.setModifier(cqf.getCreator());
					cqf.setModifierId(cqf.getCreatorId());
					cqf.setEntityStatus(EntityStatus.NORMAL);
					session.save(cqf);
				}
			}
			
			SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
			List<InvestmentDirector> directorList = (List<InvestmentDirector>) investmentDirectorDao.getListByHql("from InvestmentDirector where investmentId = "+id);
			String[] receiverEmail = new String[]{};
			String[] content = new String[]{};
			int i = 0;
			if(directorList!=null && directorList.size()>0&&sysEmailSenderPubService!=null && emailActive()){
				receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
				content = Arrays.copyOf(content, content.length+1);
				String subject = "招商项目提交入住提醒";
				StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
				content[i] = data.toString();
				content[i] = content[i].replace("${subject}", investment.getName());
				content[i] = content[i].replace("${msgType}", "入驻提醒");
				content[i] = content[i].replace("${url}", basePath()+"parkmanager.pb/investment!view.action?id="+investment.getId());
				content[i] = content[i].replace("${sender}", PbActivator.getSessionUser().getRealName());
				content[i] = content[i].replace("${content}", investment.getMemo());
				content[i] = content[i].replace("${receiver}", "");
				content[i] = content[i].replace("${customerName}","");
				for (InvestmentDirector director : directorList) {
					if(director.getName()!=null){
						if(director.getEmail()!=null){
							receiverEmail[i] = director.getEmail();
						}else{
							receiverEmail[i] = "";
						}
						content[i] = content[i].replace("${receiver}", director.getName());
						content[i] = content[i].replace("${customerName}", director.getName());
						content = Arrays.copyOf(content, content.length+1);
						receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
						content[i+1] = content[i];
						i++;
					}
				}
				sysEmailSenderPubService.send(receiverEmail,content,subject);
			}
			SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
			if(directorList!=null && directorList.size()>0&&smsPubService!=null && smsActive()){
				i = 0;
				String[] receiverMobile = new String[]{};
				String[] receiverName = new String[]{};
				content = new String[]{};
				content = Arrays.copyOf(content, content.length+1);
				content[i] = PbActivator.getAppConfig().getConfig("investmentSubmitSettledRemind").getParameter("smsModule");
				content[i] = content[i].replace("${investment}", investment.getName());
				for (InvestmentDirector director : directorList) {
					if(director.getMobile()!=null){
						receiverMobile[i] = director.getMobile();
					}else{
						receiverMobile[i] = "";
					}
					if(director.getName()!=null){
						receiverName[i] = director.getName();
					}
					receiverName = Arrays.copyOf(content, content.length+1);
					receiverMobile = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
					content = Arrays.copyOf(content, content.length+1);
					content[i+1] = content[i];
					i++;
				}
				smsPubService.send(receiverMobile, content, receiverName);
			}
			tr.commit();
			return Result.success("提交成功");
		} catch (ConstraintViolationException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("该招商项目已经提交入驻 或 已存在同名企业");
		} catch (Exception e) { 
			tr.rollback();
			e.printStackTrace();
			return Result.failure("提交失败");
		} finally {
			session.close();
		}
	}

	@Override
	public Result updateApproval(Approval approval) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentDao.openSession();
			tr = session.beginTransaction();
			session.update(approval);
			tr.commit();
			return Result.success("审批成功");
		} catch (Exception e) { 
			tr.rollback();
			e.printStackTrace();
			return Result.failure("审批失败");
		} finally {
			session.close();
		}
	}

	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("investmentApplyRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("investmentApplyRemind").getParameter("sms");
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
	public Result approval(Long id,Long userId,String approvalType) {
		Session session = null;
		Transaction tr = null;
		try {
			session = investmentDao.openSession();
			Investment investment = (Investment) session.get(Investment.class, id);
			if(investment.getDepartmentApprovalId()==null && approvalType.equals("department") || investment.getChiefApprovalId()==null && approvalType.equals("chief") || investment.getOfficeApprovalId()==null && approvalType.equals("office")||investment.getManagerApprovalId()==null&&approvalType.equals("manager")){
				tr = session.beginTransaction();
//				Long approvalId = Long.valueOf(PbActivator.getAppConfig().getConfig("investmentApprovalUser").getParameter(approvalType));
				Long approvalId = userId;
				User approvalUser = PbActivator.getService(OsgiUserService.class).getById(approvalId);
				SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
				if(sysEmailSenderPubService!=null && emailActive()&&approvalUser!=null){
					String content = "";
					StringBuffer data = parseHTML("web/msgRemindModule/msgRemindModule.html");
					content = data.toString();
					String subject = "招商报送审批提醒";
					content = content.replace("${subject}", investment.getName());
					content = content.replace("${msgType}", "项目审批");
					content = content.replace("${url}", basePath()+"parkmanager.pb/investment!approvalView.action?id="+id);
					content = content.replace("${receiver}", approvalUser.getRealName());
					content = content.replace("${customerName}", approvalUser.getRealName());
					content = content.replace("${sender}", PbActivator.getSessionUser().getRealName());
					content = content.replace("${content}", investment.getMemo());
					content = content.replace("${msgLink}",PbActivator.getRemindEmailService().getRemindEmailLink());
					if(approvalUser.getEmail()!=null&&!approvalUser.getEmail().equals("")){
						sysEmailSenderPubService.send(approvalUser.getEmail(), content, subject);
					}
				}
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive() && approvalUser!=null){
					String receiverMobile = approvalUser.getMobile();
					String receiverName = approvalUser.getRealName();
					String content = PbActivator.getAppConfig().getConfig("investmentApplyRemind").getParameter("smsModule");
					content = content.replace("${investment}", investment.getName());
					smsPubService.send(receiverMobile, content, receiverName);
				}
				Approval approval = new Approval();
				approval.setTitle(investment.getName());
				approval.setStatus(ApprovalStatusEnum.UNDETERMINED);
				approval.setType(ApprovalTypeEnum.INVESTMENT);
				approval.setGroupId(investment.getId());
				approval.setUserId(approvalId);
				approval.setUserName(PbActivator.getService(OsgiUserService.class).getById(approvalId).getRealName());
				approval.setUrl("parkmanager.pb/investment!approvalView.action?id="+id);
				approval.setWidth(600);
				approval.setHeight(400);
				session.save(approval);
				if(approvalType.equals("department")){
					investment.setDepartmentApprovalId(approval.getId());
				} else if(approvalType.equals("chief")){
					investment.setChiefApprovalId(approval.getId());
				} else if(approvalType.equals("office")){
					investment.setOfficeApprovalId(approval.getId());
				}else if(approvalType.equals("manager")){
					investment.setManagerApprovalId(approval.getId());
				}
				investment.setInvestmentStatus(InvestmentStatusEnum.APPROVAL);
				session.update(investment);
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
	public Result<List<Object>> getListByLimitNum(int i) {
		try{
		Session session = investmentDao.openSession();
		Transaction tr = session.beginTransaction();
		String sql = "select id,name,create_time from crm_investment where investment_status <> 'PARK' order by create_time desc limit 0,"+i;
		//String sql = "from Investment where investmentStatus <> '"+InvestmentStatusEnum.PARK+"' order by createTime desc limit 0,"+i;
	
		@SuppressWarnings("unchecked")
		List<Object> list = session.createSQLQuery(sql).list();
		Result<List<Object>> result = Result.success("加载成功",list);
		tr.commit();
		session.close();
		return result;
		}catch(Exception e){
			e.printStackTrace();
			
		}
		return Result.failure("加载失败");
	}

	@Override
	public Result getApprovalList() {
		try{
			Filter filter = new Filter(Investment.class);
			
			filter.sqlRestriction("this_.id in (select group_id from core_approval a where a.type='INVESTMENT' ");
//			String hql = "select new Investment(i.*) from Investment i join Approval a on i.id = a.groupId where a.type = '"+ApprovalTypeEnum.INVESTMENT+"' and a.userId = '"+PbActivator.getSessionUser().getId()+"' and i.investmentStatus = '"+InvestmentStatusEnum.APPROVAL+"'";
//			Query query = session.createQuery(hql);
//			List<Investment> list = session.createQuery(hql).list();
			List<Investment> list = investmentDao.getListByFilter(filter);
			return Result.value(list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Result getMyApprovalList() {
		try{
			Filter filter = new Filter(Investment.class);
			
			filter.sqlRestriction("this_.id in (select group_id from core_approval a where a.type='INVESTMENT' and a.user_id="+PbActivator.getSessionUser().getId()+")");
//			String hql = "select new Investment(i.*) from Investment i join Approval a on i.id = a.groupId where a.type = '"+ApprovalTypeEnum.INVESTMENT+"' and a.userId = '"+PbActivator.getSessionUser().getId()+"' and i.investmentStatus = '"+InvestmentStatusEnum.APPROVAL+"'";
//			Query query = session.createQuery(hql);
//			List<Investment> list = session.createQuery(hql).list();
			filter.eq("investmentStatus",InvestmentStatusEnum.APPROVAL);
			List<Investment> list = investmentDao.getListByFilter(filter);
			return Result.value(list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
}
