package com.wiiy.crm.service.impl;


import java.io.File;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Collection;
import java.util.Date;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.IOUtil;
import com.wiiy.commons.util.MicrosoftWordUtil;
import com.wiiy.core.dao.ContactBaseDao;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.service.impl.ContactBaseServiceImpl;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.dto.CustomerServiceContactDto;
import com.wiiy.crm.dto.CustomerServiceContactDto;
import com.wiiy.crm.entity.CustomerServiceContact;
import com.wiiy.crm.entity.CustomerServiceContact;
import com.wiiy.crm.dao.CustomerServiceContactDao;
import com.wiiy.crm.service.CustomerServiceContactService;
import com.wiiy.crm.preferences.R;

/**
 * @author my
 */
public class CustomerServiceContactServiceImpl extends ContactBaseServiceImpl<CustomerServiceContact> implements CustomerServiceContactService{
	
	private CustomerServiceContactDao customerServiceContactDao;
	
	public void setCustomerServiceContactDao(CustomerServiceContactDao customerServiceContactDao) {
		this.customerServiceContactDao = customerServiceContactDao;
	}

	@Override
	protected ContactBaseDao<CustomerServiceContact> getDao() {
		return customerServiceContactDao;
	}
	
	@Override
	public Result<?> send(Long id, Long receiveId) {
		Session session = null;
		Transaction tr = null;
		try{
			session = customerServiceContactDao.openSession();
			tr = session.beginTransaction();
			CustomerServiceContact t = (CustomerServiceContact) session.get(CustomerServiceContact.class, id);
				if(t.getOpinion1Id()!=null || t.getOpinion1()!=null){
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion1Id(receiveId);
					t.setReceiveId(receiveId);
					t.setOpinionNow("opinion1");
				}
			User nowUser = PbActivator.getSessionUser();
			t.setModifier(nowUser.getRealName());
			t.setModifierId(nowUser.getId());
			t.setModifyTime(new Date());
			t.setReceiveId(receiveId);
			session.update(t);
			ContactLog contactLog = new ContactLog();
			contactLog.setContactId(id);
			contactLog.setCreateTime(t.getModifyTime());
			contactLog.setCreatorId(nowUser.getId());
			contactLog.setCreator(nowUser.getRealName());
			contactLog.setModifier(nowUser.getRealName());
			contactLog.setModifierId(nowUser.getId());
			contactLog.setModifyTime(contactLog.getCreateTime());
			String sqlForReceiveName = "select real_name from core_user where id = " + receiveId;
			String receiveName = session.createSQLQuery(sqlForReceiveName).uniqueResult().toString();
			contactLog.setContent("将联系单发送给" + receiveName);
			contactLog.setContactType(ContactTypeEnum.CUSTOMERSERVICECONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.CustomerServiceContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.CustomerServiceContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = customerServiceContactDao.openSession();
			tr = session.beginTransaction();
			CustomerServiceContact t = (CustomerServiceContact) session.get(CustomerServiceContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("opinion1".equals(approvalType)){
				t.setOpinion1(opinion);
				contactLog.setContent("修改了处理意见");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getOpinion1Id()!=null && t.getOpinion1()!=null){
				t.setUsedIds(","+nowUser.getId()+",");
				t.setReceiveId(null);
			}
			session.update(t);
			
			contactLog.setContactId(id);
			contactLog.setCreateTime(new Date());
			contactLog.setCreatorId(nowUser.getId());
			contactLog.setCreator(nowUser.getRealName());
			contactLog.setModifier(nowUser.getRealName());
			contactLog.setModifierId(nowUser.getId());
			contactLog.setModifyTime(contactLog.getCreateTime());
			contactLog.setContactType(ContactTypeEnum.CUSTOMERSERVICECONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.CustomerServiceContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.CustomerServiceContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			CustomerServiceContact customerServiceContact = customerServiceContactDao.getBeanById(id);
			CustomerServiceContactDto customerServiceContactDto = new CustomerServiceContactDto();
			
			if(customerServiceContact.getCreateTime()!=null){
				customerServiceContactDto.setYear(DateUtil.format(customerServiceContact.getCreateTime(), "yyyy"));
				customerServiceContactDto.setMonth(DateUtil.format(customerServiceContact.getCreateTime(), "MM"));
				customerServiceContactDto.setDay(DateUtil.format(customerServiceContact.getCreateTime(), "dd"));
			}
			if(customerServiceContact.getCustomer()!=null){
				customerServiceContactDto.setCustomer(customerServiceContact.getCustomer().getName());
			}
			if(customerServiceContact.getOrg()!=null){
				customerServiceContactDto.setOrg(customerServiceContact.getOrg().getName());
			}
			if(customerServiceContact.getTypeId()!=null){
				customerServiceContactDto.setType(PbActivator.getDataDictInitService().getDataDictById(customerServiceContact.getTypeId()).getDataName());
			}
			if(customerServiceContact.getResult()!=null){
				customerServiceContactDto.setResult(customerServiceContact.getResult().getTitle());
			}
			if(customerServiceContact.getSuggest()!=null){
				customerServiceContactDto.setSuggest(customerServiceContact.getSuggest());
			}
			if(customerServiceContact.getLinkman()!=null){
				customerServiceContactDto.setContectName(customerServiceContact.getLinkman());
			}
			if(customerServiceContact.getStartDate()!=null){
				customerServiceContactDto.setStartDate(DateUtil.format(customerServiceContact.getStartDate()));
			}
			if(customerServiceContact.getTelephone()!=null){
				customerServiceContactDto.setPhone(customerServiceContact.getTelephone());
			}
			customerServiceContactDto.setUserName(customerServiceContact.getCreator());
			if(customerServiceContact.getStatus()!=null){
				customerServiceContactDto.setStatus(customerServiceContact.getStatus().getTitle());
			}
			if(customerServiceContact.getOpinion1()!=null){
				customerServiceContactDto.setOpinion1(customerServiceContact.getOpinion1());
			}
			if(customerServiceContact.getDescription()!=null){
				customerServiceContactDto.setDescription(customerServiceContact.getDescription());
			}
			session = customerServiceContactDao.openSession();
			generateCustomerServiceContactWord(customerServiceContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.CustomerServiceContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateCustomerServiceContactWord(CustomerServiceContactDto customerServiceContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/customerServiceContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] customerServiceContactFields = CustomerServiceContactDto.class.getDeclaredFields();
			for (Field field : customerServiceContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = CustomerServiceContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(customerServiceContactDto);
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
