package com.wiiy.crm.service.impl;


import java.io.File;
import java.io.OutputStream;
import java.lang.reflect.Field;
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
import com.wiiy.crm.dto.BusinessCenterContactDto;
import com.wiiy.pb.entity.Room;
import com.wiiy.crm.entity.BusinessCenterContact;
import com.wiiy.crm.dao.BusinessCenterContactDao;
import com.wiiy.crm.service.BusinessCenterContactService;
import com.wiiy.crm.preferences.R;

/**
 * @author my
 */
public class BusinessCenterContactServiceImpl extends ContactBaseServiceImpl<BusinessCenterContact> implements BusinessCenterContactService{
	
	private BusinessCenterContactDao businessCenterContactDao;
	
	public void setBusinessCenterContactDao(BusinessCenterContactDao businessCenterContactDao) {
		this.businessCenterContactDao = businessCenterContactDao;
	}

	@Override
	protected ContactBaseDao<BusinessCenterContact> getDao() {
		return businessCenterContactDao;
	}
	
	@Override
	public Result<?> send(Long id, Long receiveId, String approvalType) {
		Session session = null;
		Transaction tr = null;
		try{
			session = businessCenterContactDao.openSession();
			tr = session.beginTransaction();
			BusinessCenterContact t = (BusinessCenterContact) session.get(BusinessCenterContact.class, id);
			if("opinion1".equals(approvalType)){
				if(t.getOpinion1Id()!=null){//id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion1Id(receiveId);
					t.setOpinionNow("opinion1");
				}
				
			}else if("opinion2".equals(approvalType)){
				if(t.getOpinion2Id()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion2Id(receiveId);
					t.setOpinionNow("opinion2");
				}
			}
			
			User nowUser = PbActivator.getSessionUser();
			if(t.getReceiveId()!=null){//如果是空的话，说明是该联系单创建人第一次发送审批。
				t.setUsedIds((t.getUsedIds()==null?",":t.getUsedIds())+nowUser.getId()+",");
			}
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
			contactLog.setContactType(ContactTypeEnum.BUSINESSCENTERCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.BusinessCenterContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.BusinessCenterContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = businessCenterContactDao.openSession();
			tr = session.beginTransaction();
			BusinessCenterContact t = (BusinessCenterContact) session.get(BusinessCenterContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("opinion1".equals(approvalType)){
				t.setOpinion1(opinion);
				contactLog.setContent("修改了处理意见");
			}else if("opinion2".equals(approvalType)){
				t.setOpinion2(opinion);
				contactLog.setContent("修改了被联系单位 或部门意见");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getOpinion1Id()!=null && t.getOpinion1()!=null && t.getOpinion2Id()!=null){
				t.setUsedIds((t.getUsedIds()==null?",":t.getUsedIds())+nowUser.getId()+",");
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
			contactLog.setContactType(ContactTypeEnum.BUSINESSCENTERCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.BusinessCenterContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.BusinessCenterContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			BusinessCenterContact businessCenterContact = businessCenterContactDao.getBeanById(id);
			BusinessCenterContactDto businessCenterContactDto = new BusinessCenterContactDto();
			
			if(businessCenterContact.getCreateTime()!=null){
				businessCenterContactDto.setYear(DateUtil.format(businessCenterContact.getCreateTime(), "yyyy"));
				businessCenterContactDto.setMonth(DateUtil.format(businessCenterContact.getCreateTime(), "MM"));
				businessCenterContactDto.setDay(DateUtil.format(businessCenterContact.getCreateTime(), "dd"));
			}
			if(businessCenterContact.getOrg()!=null){
				businessCenterContactDto.setOrg(businessCenterContact.getOrg());
			}
			if(businessCenterContact.getContent()!=null){
				businessCenterContactDto.setContent(businessCenterContact.getContent());
			}
			if(businessCenterContact.getOpinion1()!=null){
				businessCenterContactDto.setOpinion1(businessCenterContact.getOpinion1());
			}
			if(businessCenterContact.getOpinion2()!=null){
				businessCenterContactDto.setOpinion2(businessCenterContact.getOpinion2());
			}
			session = businessCenterContactDao.openSession();
			generateBusinessCenterContactWord(businessCenterContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.BusinessCenterContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateBusinessCenterContactWord(BusinessCenterContactDto businessCenterContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/businessCenterContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] businessCenterContactFields = BusinessCenterContactDto.class.getDeclaredFields();
			for (Field field : businessCenterContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = BusinessCenterContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(businessCenterContactDto);
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
