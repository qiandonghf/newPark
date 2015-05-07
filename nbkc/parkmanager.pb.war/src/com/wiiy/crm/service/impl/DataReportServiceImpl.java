package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.crm.dao.DataReportDao;
import com.wiiy.crm.dao.ParkLogDao;
import com.wiiy.crm.dto.AnalyseDto;
import com.wiiy.crm.dto.DataReportPropertyDto;
import com.wiiy.crm.dto.DataStatisticDto;
import com.wiiy.crm.dto.ParkLogDto;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReport;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.entity.InvestmentLog;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.crm.preferences.enums.DataTypeEnum;
import com.wiiy.crm.preferences.enums.ReportStatusEnum;
import com.wiiy.crm.service.CustomerModifyLogService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.DataReportService;
import com.wiiy.crm.service.DataReportToCustomerService;
import com.wiiy.crm.service.InvestmentLogService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.preferences.enums.ParkLogTypeEnums;

/**
 * @author my
 */
public class DataReportServiceImpl implements DataReportService{
	
	private DataReportDao dataReportDao;
	private InvestmentLogService investmentLogService;
	private CustomerModifyLogService customerModifyLogService;
	private DataReportToCustomerService dataReportToCustomerService;
	private CustomerService customerService;
	private ParkLogDao parkLogDao ;
	
	public void setParkLogDao(ParkLogDao parkLogDao) {
		this.parkLogDao = parkLogDao;
	}
	
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setDataReportToCustomerService(
			DataReportToCustomerService dataReportToCustomerService) {
		this.dataReportToCustomerService = dataReportToCustomerService;
	}

	public void setCustomerModifyLogService(
			CustomerModifyLogService customerModifyLogService) {
		this.customerModifyLogService = customerModifyLogService;
	}

	public void setInvestmentLogService(InvestmentLogService investmentLogService) {
		this.investmentLogService = investmentLogService;
	}

	public void setDataReportDao(DataReportDao dataReportDao) {
		this.dataReportDao = dataReportDao;
	}

	@Override
	public Result<DataReport> save(DataReport t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataReportDao.save(t);
			return Result.success(R.DataReport.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReport.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReport.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataReport> delete(DataReport t) {
		try {
			dataReportDao.delete(t);
			return Result.success(R.DataReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReport> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			//delete from CRM_data_report_def_property where group_id in (select g.id from CRM_data_report_def_group g where g.report_id = 15)
			@SuppressWarnings("unchecked")
			List<DataReportProperty> propertyList = session.createQuery("from DataReportProperty where reportId = "+id+" order by level desc").list();
			for (DataReportProperty dataReportProperty : propertyList) {
				session.createQuery("delete from DataReportProperty where id = "+dataReportProperty.getId()).executeUpdate();
			}
			session.createQuery("delete from DataReport where id = "+id).executeUpdate();
			tr.commit();
			return Result.success(R.DataReportToCustomer.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (ConstraintViolationException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(new FKConstraintException(e).getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DataReport.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<DataReport> deleteByIds(String ids) {
		try {
			dataReportDao.deleteByIds(ids);
			return Result.success(R.DataReport.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReport.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReport> update(DataReport t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			dataReportDao.update(t);
			return Result.success(R.DataReport.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReport.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReport.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataReport> getBeanById(Serializable id) {
		try {
			return Result.value(dataReportDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataReport> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataReportDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReport>> getList() {
		try {
			return Result.value(dataReportDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReport>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataReportDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReport.LOAD_FAILURE);
		}
	}

	@Override
	public Result save(DataReport t, String customerIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			if(customerIds!=null){
				String[] ids = customerIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					Long id = Long.valueOf(ids[i].trim());
					DataReportToCustomer dc = new DataReportToCustomer();
					dc.setCustomerId(id);
					dc.setStatus(CustomerReportStatusEnum.UNPUB);
					dc.setReportId(t.getId());
					dc.setFinished(BooleanEnum.NO);
					dc.setCreateTime(t.getCreateTime());
					dc.setCreator(PbActivator.getSessionUser().getRealName());
					dc.setCreatorId(PbActivator.getSessionUser().getId());
					dc.setModifyTime(t.getCreateTime());
					dc.setModifier(t.getCreator());
					dc.setModifierId(t.getCreatorId());
					dc.setEntityStatus(EntityStatus.NORMAL);
					session.save(dc);
				    
				}
			}
			ParkLog parkLog = new ParkLog() ;
		    parkLog.setContent("添加了["+customerIds+"]数据填报信息");
		    parkLog.setCreateTime(new Date());
		    parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
		    parkLog.setParkLogType(ParkLogTypeEnums.DATAREPORT);
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.DataReport.SAVE_SUCCESS);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataReport.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result update(DataReport t, String customerIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.update(t);
			session.createQuery("delete from DataReportToCustomer dc where dc.reportId = "+t.getId()).executeUpdate();
			if(customerIds!=null){
				String[] ids = customerIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					Long id = Long.valueOf(ids[i].trim());
					DataReportToCustomer dc = new DataReportToCustomer();
					dc.setCustomerId(id);
					dc.setReportId(t.getId());
					dc.setFinished(BooleanEnum.NO);
					dc.setCreateTime(t.getCreateTime());
					dc.setCreator(PbActivator.getSessionUser().getRealName());
					dc.setCreatorId(PbActivator.getSessionUser().getId());
					dc.setModifyTime(t.getCreateTime());
					dc.setModifier(t.getCreator());
					dc.setModifierId(t.getCreatorId());
					dc.setEntityStatus(EntityStatus.NORMAL);
					session.save(dc);
				}
			}
			ParkLog parkLog = new ParkLog() ;
		    parkLog.setContent("修改了["+customerIds+"]数据填报信息");
		    parkLog.setCreateTime(new Date());
		    parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
		    parkLog.setParkLogType(ParkLogTypeEnums.DATAREPORT);
		    session.save(parkLog);
			tr.commit();
			return Result.success(R.DataReport.SAVE_SUCCESS);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataReport.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("dataReportRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Result publish(Long id, String customerIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			DataReport t = (DataReport) session.get(DataReport.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setStatus(ReportStatusEnum.PUBED);
			session.update(t);
			session.createQuery("delete from DataReportToCustomer dc where dc.reportId = "+t.getId()+" and dc.customerId in ("+customerIds+")").executeUpdate();
			List<Object> customers = (List<Object>)session.createQuery("select id,name from Customer").list();
			Map<Long,Customer> customerMap = new HashMap<Long, Customer>();
			for (Object object : customers) {
				Object[] obj = (Object[])object;
				Customer customer = new Customer();
				customer.setId(Long.valueOf(obj[0].toString()));
				customer.setName(obj[1].toString());
				customerMap.put(customer.getId(), customer);
			}
			List<Object> cList = (List<Object>) session.createQuery("select name,customerId,phone,mobile from Contect").list();
			Map<Long,List<Contect>> contectMap = new HashMap<Long, List<Contect>>();
			for (Object object : cList) {
				Object[] obj = (Object[])object;
				Contect contect = new Contect();
				contect.setName(obj[0].toString());
				contect.setCustomerId(Long.valueOf(obj[1].toString()));
				if(obj[2]!=null){
					contect.setPhone(obj[2].toString());
				}
				if(obj[3]!=null){
					contect.setMobile(obj[3].toString());
				}
				if(contectMap.get(contect.getCustomerId())!=null){
					contectMap.get(contect.getCustomerId()).add(contect);
				}else{
					List<Contect> list = new ArrayList<Contect>();
					list.add(contect);
					contectMap.put(contect.getCustomerId(), list);
				}
			}
			if(customerIds!=null){
				String[] ids = customerIds.split(",");
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				String customerNames = "";
				int k = 0;
				for (int i = 0; i < ids.length; i++) {
					k++;
					Long customerId = Long.valueOf(ids[i].trim());
					Customer c = customerMap.get(customerId);
					customerNames+=c.getName()+",";
					if(smsPubService!=null && smsActive()){
						String[] receiverMobiles = new String[]{};
						String[] receiverNames = new String[]{};
						String[] content = new String[]{};
						//Contect contect = (Contect) session.createQuery("from Contect where customerId = "+customerId+" and main = '"+BooleanEnum.YES+"'").uniqueResult();
						List<Contect> contectList = contectMap.get(customerId);
						if(contectList!=null && contectList.size()>0){
							for (Contect contect : contectList) {
								receiverMobiles = Arrays.copyOf(receiverMobiles, receiverMobiles.length+1);
								receiverNames = Arrays.copyOf(receiverNames, receiverNames.length+1);
								content = Arrays.copyOf(content, content.length+1);
								int index = receiverMobiles.length-1;
								String dataReportcontent = PbActivator.getAppConfig().getConfig("dataReportRemind").getParameter("smsModule");
								dataReportcontent = dataReportcontent.replace("${companyName}", c.getName());
								dataReportcontent = dataReportcontent.replace("${dataReportName}", t.getName());
								content[index] = dataReportcontent;
								if(contect.getMobile()!=null){
									receiverMobiles[index] = contect.getMobile();
								}else if(contect.getPhone()!=null){
									receiverMobiles[index] = contect.getPhone();
								}else{
									receiverMobiles[index] = "";
								}
								receiverNames[index] = contect.getName();
							}
							smsPubService.send(receiverMobiles, content, receiverNames, session);
						}
						/*if(contect!=null){
							receiverMobiles = Arrays.copyOf(receiverMobiles, receiverMobiles.length+1);
							receiverNames = Arrays.copyOf(receiverNames, receiverNames.length+1);
							content = Arrays.copyOf(content, content.length+1);
							int index = receiverMobiles.length-1;
							String dataReportcontent = PbActivator.getAppConfig().getConfig("dataReportRemind").getParameter("smsModule");
							dataReportcontent = dataReportcontent.replace("${companyName}", contect.getCustomer().getName());
							dataReportcontent = dataReportcontent.replace("${dataReportName}", t.getName());
							content[index] = dataReportcontent;
							if(contect.getMobile()!=null){
								receiverMobiles[index] = contect.getMobile();
							}else if(contect.getPhone()!=null){
								receiverMobiles[index] = contect.getPhone();
							}else{
								receiverMobiles[index] = "";
							}
							receiverNames[index] = contect.getName();
						}*/
					}
					DataReportToCustomer dc = new DataReportToCustomer();
					dc.setStatus(CustomerReportStatusEnum.UNPUB);
					dc.setCustomerId(customerId);
					dc.setReportId(t.getId());
					dc.setFinished(BooleanEnum.NO);
					dc.setCreateTime(t.getCreateTime());
					dc.setCreator(PbActivator.getSessionUser().getRealName());
					dc.setCreatorId(PbActivator.getSessionUser().getId());
					dc.setModifyTime(t.getCreateTime());
					dc.setModifier(t.getCreator());
					dc.setModifierId(t.getCreatorId());
					dc.setEntityStatus(EntityStatus.NORMAL);
					session.save(dc);
				}
				try{
					ParkLog parkLog = new ParkLog() ;
				    parkLog.setContent("发布了["+customerNames.substring(0, customerNames.length()-1)+"]数据填报信息");
				    parkLog.setCreateTime(new Date());
				    parkLog.setHandlePersonnel(PbActivator.getSessionUser().getRealName());
				    parkLog.setParkLogType(ParkLogTypeEnums.DATAREPORT);
				    session.save(parkLog);
				}catch(Exception e){
					System.err.println("=============园区日志创建失败，content内容过长=================");
				}
			}
			DataTemplate template = t.getTemplate();
			List<DataTemplatePropertyConfig> tcList = session.createQuery("from DataTemplatePropertyConfig where templateId="+template.getId()).list();
			List<DataProperty> propertyList = new ArrayList<DataProperty>();
			for (DataTemplatePropertyConfig tc : tcList) {
				propertyList.add(tc.getProperty());
			}
			propertyList = TreeUtil.generateTree(propertyList);
			int j = 0;
			for (DataProperty dataProperty : propertyList) {
				copyProperty(session, t.getId(), dataProperty, null, "");
			}
			tr.commit();
			return Result.success(R.DataReport.PUBLISH_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.DataReport.PUBLISH_FAILURE);
		} finally {
			session.close();
		}
	}
	
	private void copyProperty(Session session, Long reportId, DataProperty dataProperty,Long parentId,String parentIds) {
		DataReportProperty rp = new DataReportProperty();
		BeanUtil.copyProperties(dataProperty, rp);
		rp.setReportId(reportId);
		rp.setId(null);
		rp.setPropertyId(dataProperty.getId());
		if(parentId!=null){
			rp.setParentIds(parentIds+parentId+",");
		} else {
			rp.setParentIds(",");
		}
		rp.setParentId(parentId);
		setCreatorModifier(rp);
		session.save(rp);
		if(dataProperty.getChildren()!=null)
		for (Object o : dataProperty.getChildren()) {
			DataProperty property = (DataProperty)o;
			copyProperty(session, reportId, property, rp.getId(), rp.getParentIds());
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

	@Override
	public Result close(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			DataReport t = (DataReport) session.get(DataReport.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setStatus(ReportStatusEnum.CLOSE);
			session.update(t);
			tr.commit();
			return Result.success(R.DataReport.CLOSE_SUCCESS);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataReport.CLOSE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result open(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			DataReport t = (DataReport) session.get(DataReport.class, id);
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			t.setStatus(ReportStatusEnum.PUBED);
			session.update(t);
			tr.commit();
			return Result.success(R.DataReport.PUBLISH_SUCCESS);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DataReport.PUBLISH_FAILURE);
		} finally {
			session.close();
		}
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	// 此方法需重新整理
	public Result<List<DataReportPropertyDto>> count(Long id) {
		DataReport report = dataReportDao.getBeanById(id);
		Long templateId = report.getTemplateId();
		Session session = dataReportDao.openSession();
		List<DataReportProperty> dataReportPropertyList = session.createQuery("From DataReportProperty where reportId = "+id).list();
		Map<Long,DataReportPropertyDto> propertyDtoMap = new HashMap<Long,DataReportPropertyDto>();
		for (DataReportProperty property : dataReportPropertyList) {
			DataReportPropertyDto propertyDto = new DataReportPropertyDto();
			propertyDto.setId(property.getId());
			propertyDto.setName(property.getName());
			propertyDto.setProperty(property);
			if(property.getDataType()!=null && property.getDataType().equals(DataTypeEnum.SELECT)){
				propertyDto.setIcount(0);
				String[] values = property.getDataTypeExt().split("\\|");
				for (String string : values) {
					if(string.length()>0 && !string.equals("\\|")){
						DataReportPropertyDto dto = new DataReportPropertyDto();
						dto.setName(string);
						propertyDto.getPropertyList().add(dto);
					}
				}
			}
			propertyDtoMap.put(property.getId(),propertyDto);
		}
		session.close();
		//SELECT v.property_id,SUM(v.double_val),SUM(v.int_val) FROM crm_data_report_value v LEFT JOIN crm_data_report_to_customer c ON v.report_customer_id = c.id WHERE c.report_id = 7 GROUP BY v.property_id;
		String sumSql = "SELECT v.property_id,SUM(v.double_val),SUM(v.int_val)" +
				" FROM "+table(DataReportValue.class)+" v" +
				" LEFT JOIN "+table(DataReportToCustomer.class)+" c ON v.report_customer_id = c.id" +
				" WHERE c.report_id = " + id +
				" GROUP BY v.property_id";
		List<Object> sumList = dataReportDao.getObjectListBySql(sumSql);
		for (Object object : sumList) {
			Object[] os = (Object[])object;
			Long propertyId = BigInteger.class.cast(os[0]).longValue();
			DataReportPropertyDto dto = propertyDtoMap.get(propertyId);
			if(dto!=null){
				if(dto.getProperty().getDataType().equals(DataTypeEnum.DOUBLE) && os[1] != null){
					if(os[1]!=null){
						dto.setDcount(Double.class.cast(os[1]));
					}
				}
				if(dto.getProperty().getDataType().equals(DataTypeEnum.INT) && os[2] != null){
					if(os[2]!=null){
						dto.setIcount(Integer.valueOf(os[2].toString()));
					}
				}
			}
		}
		//SELECT v.property_id,v.sel_val,COUNT(v.sel_val) FROM crm_data_report_value v LEFT JOIN crm_data_report_to_customer c ON v.report_customer_id = c.id WHERE c.report_id = 2 GROUP BY v.property_id,v.sel_val;
		String countSql = "SELECT v.propertyId,v.selVal,COUNT(v.selVal)" +
				" FROM DataReportValue v" +
				" WHERE v.reportCustomer.reportId = " + id +
				" GROUP BY v.propertyId,v.selVal ";
		List<Object> countList = dataReportDao.getObjectListByHql(countSql);
		for (Object object : countList) {
			Object[] os = (Object[])object;
			if(os[1]==null || os[2]==null) continue;
			Long propertyId = Long.class.cast(os[0]);
			DataReportPropertyDto pDto = propertyDtoMap.get(propertyId);
			for (DataReportPropertyDto p : pDto.getPropertyList()) {
				if(p.getName().equals(String.valueOf(os[1]))){
					p.setIcount(Long.class.cast(os[2]).intValue());
					pDto.setIcount(pDto.getIcount()+p.getIcount());
				}
			}
		}
		//propertyDtoMap.values()
		List<DataReportPropertyDto> propertyList = new ArrayList<DataReportPropertyDto>();
		dataReportPropertyList = TreeUtil.generateTree(dataReportPropertyList);
		for (DataReportProperty dataReportProperty : dataReportPropertyList) {
			if(dataReportProperty.getDataType()!=null && dataReportProperty.getDataType() == DataTypeEnum.DATETIME) continue;
			DataReportPropertyDto dto = propertyDtoMap.get(dataReportProperty.getId());
			propertyList.add(dto);
			copyTree(dataReportProperty.getChildren(),dto,propertyDtoMap);
		}
		return Result.value(propertyList);
	}
	@SuppressWarnings("rawtypes")
	private void copyTree(List list, DataReportPropertyDto dto, Map<Long, DataReportPropertyDto> propertyDtoMap) {
		if(list!=null){
			for (Object object : list) {
				DataReportProperty dataReportProperty = (DataReportProperty) object;
				if(dataReportProperty.getDataType()!=null && dataReportProperty.getDataType() == DataTypeEnum.DATETIME) continue;
				DataReportPropertyDto d = propertyDtoMap.get(dataReportProperty.getId());
				if(d!=null){
					dto.getPropertyList().add(d);
					copyTree(dataReportProperty.getChildren(), dto, propertyDtoMap);
				}
			}
		}
	}

	private String table(Class<?> clazz){
		return ModulePrefixNamingStrategy.classToTableName(clazz);
	}

	@Override
	public List<DataStatisticDto> getCountDto(AnalyseDto dto){
		String sTime = dto.getsYear() + "-"+dto.getsMonth();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
		Date sDate = null;
		Date eDate = null;
		try {
			sDate = fmt.parse(sTime);
			String eTime = dto.geteYear() + "-"+dto.geteMonth();
			eDate = fmt.parse(eTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
			
		String sqlForId="SELECT p.id FROM "+table(DataReportProperty.class)+" P WHERE p.property_id=" + dto.getPropertyId() + " AND p.report_id in ("+dto.getIds()+")";
		List<Object> dataReportPropertyIds = dataReportDao.getObjectListBySql(sqlForId);
		String allId = "(";
			for(int i=0;i<dataReportPropertyIds.size();i++){
				String id = dataReportPropertyIds.get(i).toString();
				id = ","+id+",";
				String idsSql = "SELECT p.id FROM "+table(DataReportProperty.class)+" P WHERE p.id=" + dataReportPropertyIds.get(i) + " OR p.parent_ids like ('%"+id+"%')";
				List<Object> ids = dataReportDao.getObjectListBySql(idsSql);
				for(int j=0;j<ids.size();j++){
					allId = allId + ids.get(j).toString()+",";
				}
				
			}
			allId = allId.substring(0,allId.length()-1)+")";
		String sql = "SELECT p.report_id,p.create_time,r.name ,SUM(v.double_val),SUM(v.int_val)" +
				" FROM "+table(DataReportProperty.class)+" p " +
				" LEFT JOIN "+table(DataReportValue.class)+" v ON p.id=v.property_id " +
				" LEFT JOIN "+table(DataReport.class)+" r ON r.id=p.report_id " +
				" WHERE p.id in " + allId + " AND p.report_id in ("+dto.getIds()+") AND " +
				" r.data_time BETWEEN '"+DateUtil.format(sDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(eDate,"yyyy-MM-dd HH:mm:ss")+"' "+
				" GROUP BY p.report_id";
		String sql2 = "SELECT p.report_id,p.create_time,r.name ,v.double_val,v.int_val " +
				" FROM "+table(DataReportProperty.class)+" p " +
				" LEFT JOIN "+table(DataReportValue.class)+" v ON p.id=v.property_id " +
				" LEFT JOIN "+table(DataReport.class)+" r ON r.id=p.report_id " +
				" WHERE p.property_id=" + dto.getPropertyId() + " AND p.report_id in ("+dto.getIds()+") AND " +
				" p.create_time BETWEEN '"+DateUtil.format(sDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(eDate,"yyyy-MM-dd HH:mm:ss")+"' "+
				" GROUP BY p.report_id,p.create_time,r.name ,v.double_val,v.int_val ";
		List<Object> list = dataReportDao.getObjectListBySql(sql);
		List<DataStatisticDto> dtoList = new ArrayList<DataStatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long reportId =  Long.parseLong(String.valueOf(objects[0]));
			Date date = DateUtil.parse(String.valueOf(objects[1]));
			String reportName = String.valueOf(objects[2]);
			Double dVal = null;
			String s = String.valueOf(objects[3]);
			if(!String.valueOf(objects[3]).equals("null")){
				dVal = Double.parseDouble(String.valueOf(objects[3]));
			}
			Integer iVal = null;
			if(!String.valueOf(objects[4]).equals("null")){
				iVal = Integer.parseInt(String.valueOf(objects[4]));
			}
			DataStatisticDto d = new DataStatisticDto();
			d.setId(reportId);
			d.setDate(date);
			d.setName(reportName);
			d.setdValue(dVal);
			d.setiValue(iVal);
			dtoList.add(d);
		}
		return dtoList;
	}
	public List<DataStatisticDto> getCountDto2(AnalyseDto dto,Long id){
		String sTime = dto.getsYear() + "-"+dto.getsMonth();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
		Date sDate = null;
		Date eDate = null;
		try {
			sDate = fmt.parse(sTime);
			String eTime = dto.geteYear() + "-"+dto.geteMonth();
		    eDate = fmt.parse(eTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		String sqlForId="SELECT p.id FROM "+table(DataReportProperty.class)+" P WHERE p.property_id=" + dto.getPropertyId();
		List<Object> dataReportPropertyIds = dataReportDao.getObjectListBySql(sqlForId);
		String allId = "(";
			for(int i=0;i<dataReportPropertyIds.size();i++){
				String id1 = dataReportPropertyIds.get(i).toString();
				id1 = ","+id1+",";
				String idsSql = "SELECT p.id FROM "+table(DataReportProperty.class)+" P WHERE p.id=" + dataReportPropertyIds.get(i) + " OR p.parent_ids like ('%"+id1+"%')";
				List<Object> ids = dataReportDao.getObjectListBySql(idsSql);
				for(int j=0;j<ids.size();j++){
					allId = allId + ids.get(j).toString()+",";
				}
				
			}
			allId = allId.substring(0,allId.length()-1)+")";
		String sql = "SELECT p.report_id,p.create_time,r.name ,SUM(v.double_val),SUM(v.int_val)" +
				" FROM "+table(DataReportProperty.class)+" p " +
				" LEFT JOIN "+table(DataReportValue.class)+" v ON p.id=v.property_id " +
				" LEFT JOIN "+table(DataReport.class)+" r ON r.id=p.report_id " +
				" LEFT JOIN "+table(DataReportToCustomer.class)+" dtc ON dtc.id=v.report_customer_id " +
				" WHERE p.id in" +allId + " AND dtc.customer_id="+id+" AND  "+
				" r.data_time BETWEEN '"+DateUtil.format(sDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(eDate,"yyyy-MM-dd HH:mm:ss")+"' "+
				" GROUP BY p.report_id,r.name ";
		List<Object> list = dataReportDao.getObjectListBySql(sql);
		List<DataStatisticDto> dtoList = new ArrayList<DataStatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long reportId =  Long.parseLong(String.valueOf(objects[0]));
			Date date = DateUtil.parse(String.valueOf(objects[1]));
			String reportName = String.valueOf(objects[2]);
			Double dVal = null;
			String s = String.valueOf(objects[3]);
			if(!String.valueOf(objects[3]).equals("null")){
				dVal = Double.parseDouble(String.valueOf(objects[3]));
			}
			Integer iVal = null;
			if(!String.valueOf(objects[4]).equals("null")){
				iVal = Integer.parseInt(String.valueOf(objects[4]));
			}
			DataStatisticDto d = new DataStatisticDto();
			d.setId(reportId);
			d.setDate(date);
			d.setName(reportName);
			d.setdValue(dVal);
			d.setiValue(iVal);
			dtoList.add(d);
		}
		return dtoList;
	}
	
	@Override
	public Result<DataReport> addCustomer(Long id, String customerIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = dataReportDao.openSession();
			tr = session.beginTransaction();
			DataReport t = (DataReport) session.get(DataReport.class, id);
			if (customerIds != null) {
				String[] ids = customerIds.split(",");
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				String[] receiverMobiles = new String[] {};
				String[] receiverNames = new String[] {};
				String[] content = new String[] {};
				List<Object> customers = (List<Object>)session.createQuery("select id,name from Customer").list();
				Map<Long,Customer> customerMap = new HashMap<Long, Customer>();
				for (Object object : customers) {
					Object[] obj = (Object[])object;
					Customer customer = new Customer();
					customer.setId(Long.valueOf(obj[0].toString()));
					customer.setName(obj[1].toString());
					customerMap.put(customer.getId(), customer);
				}
				List<Object> cList = (List<Object>) session.createQuery("select name,customerId,phone,mobile from Contect").list();
				Map<Long,List<Contect>> contectMap = new HashMap<Long, List<Contect>>();
				for (Object object : cList) {
					Object[] obj = (Object[])object;
					Contect contect = new Contect();
					contect.setName(obj[0].toString());
					contect.setCustomerId(Long.valueOf(obj[1].toString()));
					if(obj[2]!=null){
						contect.setPhone(obj[2].toString());
					}
					if(obj[3]!=null){
						contect.setMobile(obj[3].toString());
					}
					if(contectMap.get(contect.getCustomerId())!=null){
						contectMap.get(contect.getCustomerId()).add(contect);
					}else{
						List<Contect> list = new ArrayList<Contect>();
						list.add(contect);
						contectMap.put(contect.getCustomerId(), list);
					}
				}
				for (int i = 0; i < ids.length; i++) {
					Long customerId = Long.valueOf(ids[i].trim());
					DataReportToCustomer drtc = (DataReportToCustomer) session.createQuery("from DataReportToCustomer where customerId = "+customerId+" and reportId = "+id).uniqueResult();
					if(drtc!=null) continue;
					if (smsPubService != null && smsActive()) {
						List<Contect> contectList = contectMap.get(customerId);
						if(contectList!=null && contectList.size()>0){
							for (Contect contect : contectList) {
								receiverMobiles = Arrays.copyOf(receiverMobiles, receiverMobiles.length+1);
								receiverNames = Arrays.copyOf(receiverNames, receiverNames.length+1);
								content = Arrays.copyOf(content, content.length+1);
								int index = receiverMobiles.length-1;
								String dataReportcontent = PbActivator.getAppConfig().getConfig("dataReportRemind").getParameter("smsModule");
								dataReportcontent = dataReportcontent.replace("${companyName}", customerMap.get(customerId).getName());
								dataReportcontent = dataReportcontent.replace("${dataReportName}", t.getName());
								content[index] = dataReportcontent;
								if(contect.getMobile()!=null){
									receiverMobiles[index] = contect.getMobile();
								}else if(contect.getPhone()!=null){
									receiverMobiles[index] = contect.getPhone();
								}else{
									receiverMobiles[index] = "";
								}
								receiverNames[index] = contect.getName();
							}
						}
						/*Contect contect = (Contect) session.createQuery("from Contect where customerId = " + customerId + " and main = '" + BooleanEnum.YES + "'").uniqueResult();
						if (contect != null) {
							receiverMobiles = Arrays.copyOf(receiverMobiles, receiverMobiles.length + 1);
							receiverNames = Arrays.copyOf(receiverNames, receiverNames.length + 1);
							content = Arrays.copyOf(content, content.length + 1);
							int index = receiverMobiles.length - 1;
							String dataReportcontent = PbActivator.getAppConfig().getConfig("dataReportRemind").getParameter("smsModule");
							dataReportcontent = dataReportcontent.replace("${companyName}", contect.getCustomer().getName());
							dataReportcontent = dataReportcontent.replace("${dataReportName}", t.getName());
							content[index] = dataReportcontent;
							if (contect.getMobile() != null) {
								receiverMobiles[index] = contect.getMobile();
							} else if (contect.getPhone() != null) {
								receiverMobiles[index] = contect.getPhone();
							} else {
								receiverMobiles[index] = "";
							}
							receiverNames[index] = contect.getName();
						}*/
					}
					DataReportToCustomer dc = new DataReportToCustomer();
					dc.setCustomerId(customerId);
					dc.setStatus(CustomerReportStatusEnum.UNPUB);
					dc.setReportId(t.getId());
					dc.setFinished(BooleanEnum.NO);
					dc.setCreateTime(t.getCreateTime());
					dc.setCreator(PbActivator.getSessionUser().getRealName());
					dc.setCreatorId(PbActivator.getSessionUser().getId());
					dc.setModifyTime(t.getCreateTime());
					dc.setModifier(t.getCreator());
					dc.setModifierId(t.getCreatorId());
					dc.setEntityStatus(EntityStatus.NORMAL);
					session.save(dc);
				}
				if (smsPubService != null && smsActive()) {
					smsPubService.send(receiverMobiles, content, receiverNames, session);
				}
			}
			tr.commit();
			return Result.success("添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.DataReport.PUBLISH_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public List<ParkLogDto> getParkLog() {
		List<ParkLogDto> parkLogDtoList = new ArrayList<ParkLogDto>();
		Calendar remindTime = Calendar.getInstance();
		remindTime.setTime(new Date());
		remindTime.set(Calendar.DATE, remindTime.get(Calendar.DATE) - 30);
		Date remindDate = remindTime.getTime();
		List<DataReport> dataReportList =  dataReportDao.getListByFilter(new Filter(DataReport.class).ge("createTime", remindDate));
		if(null!=dataReportList){
			for(DataReport dataReport:dataReportList){
				List<DataReportToCustomer> dataReportToCustomerList =  dataReportToCustomerService.getListByFilter(new Filter(DataReportToCustomer.class).eq("reportId", dataReport.getId())).getValue();
				for(DataReportToCustomer dataReportToCustomer:dataReportToCustomerList){
					Customer c = customerService.getBeanById(dataReportToCustomer.getCustomerId()).getValue();
					ParkLogDto parkLogDto = new ParkLogDto();
					parkLogDto.setLogType("数据填报");
					parkLogDto.setId(dataReportToCustomer.getId());
					parkLogDto.setLogData(dataReport.getName());
					parkLogDto.setLogCustormer(c.getName());
					parkLogDto.setLogTime(dataReport.getCreateTime());
					parkLogDtoList.add(parkLogDto);
				}
			}
		}
		
		List<InvestmentLog> investmentLogList = investmentLogService.getListByFilter(new Filter(InvestmentLog.class).ge("linkTime", remindDate)).getValue();
		if(null!=investmentLogList){
			for(InvestmentLog investmentLog:investmentLogList){
				ParkLogDto parkLogDto = new ParkLogDto();
				parkLogDto.setLogType("招商跟进");
				parkLogDto.setId(investmentLog.getId());
				parkLogDto.setLogData(investmentLog.getInvestment().getName()+"(负责人:"+investmentLog.getLinkMan()+")");
				parkLogDto.setLogTime(investmentLog.getCreateTime());
				parkLogDtoList.add(parkLogDto);
			}
		}
		
		List<CustomerModifyLog> customerModifyLogList = customerModifyLogService.getListByFilter(new Filter(CustomerModifyLog.class).ge("modifyLogTime", remindDate)).getValue();
		if(null!=customerModifyLogList){
			for(CustomerModifyLog customerModifyLog:customerModifyLogList){
				Customer c = customerService.getBeanById(customerModifyLog.getCustomerId()).getValue();
				ParkLogDto parkLogDto = new ParkLogDto();
				parkLogDto.setLogType("客户信息更新变化");
				parkLogDto.setId(customerModifyLog.getId());
				parkLogDto.setLogData(customerModifyLog.getContent());
				parkLogDto.setLogTime(customerModifyLog.getModifyLogTime());
				parkLogDto.setLogCustormer(c.getName());
				parkLogDtoList.add(parkLogDto);
			}
		}
		
		return parkLogDtoList;
	}

	@Override
	public Result getParkLogPage(int page) {
		
		return Result.value(null);
	}
}
