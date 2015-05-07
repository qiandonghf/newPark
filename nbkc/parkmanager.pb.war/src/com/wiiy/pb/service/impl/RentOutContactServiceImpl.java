package com.wiiy.pb.service.impl;


import java.io.File;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

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
import com.wiiy.crm.dto.DirectorDto;
import com.wiiy.pb.dto.RentOutContactDto;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.pb.entity.RentOutContact;
import com.wiiy.pb.entity.Room;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.dao.RentOutContactDao;
import com.wiiy.pb.service.RentOutContactService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class RentOutContactServiceImpl extends ContactBaseServiceImpl<RentOutContact> implements RentOutContactService{
	
	private RentOutContactDao rentOutContactDao;
	
	public void setRentOutContactDao(RentOutContactDao rentOutContactDao) {
		this.rentOutContactDao = rentOutContactDao;
	}
	
	@Override
	protected ContactBaseDao<RentOutContact> getDao() {
		return rentOutContactDao;
	}
	

	@Override
	public Result<?> send(Long id, Long receiveId, String approvalType) {
		Session session = null;
		Transaction tr = null;
		try{
			session = rentOutContactDao.openSession();
			tr = session.beginTransaction();
			RentOutContact t = (RentOutContact) session.get(RentOutContact.class, id);
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
			}else if("opinion3".equals(approvalType)){
				if(t.getOpinion3Id()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion3Id(receiveId);
					t.setOpinionNow("opinion3");
				}
			}else if("opinion4".equals(approvalType)){
				if(t.getOpinion4Id()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion4Id(receiveId);
					t.setOpinionNow("opinion4");
				}
			}else if("opinion5".equals(approvalType)){
				if(t.getOpinion5Id()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion5Id(receiveId);
					t.setOpinionNow("opinion5");
				}
			}else if("opinion6".equals(approvalType)){
				if(t.getOpinion6Id()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion6Id(receiveId);
					t.setOpinionNow("opinion6");
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
			contactLog.setContactType(ContactTypeEnum.RENTOUTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.RentOutContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.RentOutContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = rentOutContactDao.openSession();
			tr = session.beginTransaction();
			RentOutContact t = (RentOutContact) session.get(RentOutContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("opinion1".equals(approvalType)){
				t.setOpinion1(opinion);
				contactLog.setContent("修改了管委会创业服务部初审意见");
			}else if("opinion2".equals(approvalType)){
				t.setOpinion2(opinion);
				contactLog.setContent("修改了管委（公司）领导批复意见");
			}else if("opinion3".equals(approvalType)){
				t.setOpinion3(opinion);
				contactLog.setContent("修改了管委会企业发展部注册变更审核意见");
			}else if("opinion4".equals(approvalType)){
				t.setOpinion4(opinion);
				contactLog.setContent("修改了管委会财务部审核意见");
			}else if("opinion5".equals(approvalType)){
				t.setOpinion5(opinion);
				contactLog.setContent("修改了南都物业服务中心验房审核意见");
			}else if("opinion6".equals(approvalType)){
				t.setOpinion6(opinion);
				contactLog.setContent("修改了南都物业服务中心（财务）审核意见");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getOpinion1Id()!=null && t.getOpinion1()!=null && t.getOpinion2Id()!=null && t.getOpinion2()!=null && t.getOpinion3Id()!=null && t.getOpinion3()!=null && t.getOpinion4Id()!=null && t.getOpinion4()!=null && t.getOpinion5Id()!=null && t.getOpinion5()!=null && t.getOpinion6Id()!=null && t.getOpinion6()!=null){
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
			contactLog.setContactType(ContactTypeEnum.RENTOUTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.RentOutContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.RentOutContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			RentOutContact rentOutContact = rentOutContactDao.getBeanById(id);
			RentOutContactDto rentOutContactDto = new RentOutContactDto();
			
			if(rentOutContact.getCreateTime()!=null){
				rentOutContactDto.setYear(DateUtil.format(rentOutContact.getCreateTime(), "yyyy"));
				rentOutContactDto.setMonth(DateUtil.format(rentOutContact.getCreateTime(), "MM"));
				rentOutContactDto.setDay(DateUtil.format(rentOutContact.getCreateTime(), "dd"));
			}
			if(rentOutContact.getCustomer()!=null){
				rentOutContactDto.setCustomer(rentOutContact.getCustomer());
			}
			if(rentOutContact.getRoom()!=null){
				Room room = rentOutContact.getRoom();
				rentOutContactDto.setRoom(room.getBuilding().getName()+" "+room.getName()+" "+room.getBuildingArea()+"平方米");
			}
			if(rentOutContact.getReason()!=null){
				rentOutContactDto.setReason(rentOutContact.getReason());
			}
			if(rentOutContact.getOpinion1()!=null){
				rentOutContactDto.setOpinion1(rentOutContact.getOpinion1());
			}
			if(rentOutContact.getOpinion2()!=null){
				rentOutContactDto.setOpinion2(rentOutContact.getOpinion2());
			}
			if(rentOutContact.getOpinion3()!=null){
				rentOutContactDto.setOpinion3(rentOutContact.getOpinion3());
			}
			if(rentOutContact.getOpinion4()!=null){
				rentOutContactDto.setOpinion4(rentOutContact.getOpinion4());
			}
			if(rentOutContact.getOpinion5()!=null){
				rentOutContactDto.setOpinion5(rentOutContact.getOpinion5());
			}
			if(rentOutContact.getOpinion6()!=null){
				rentOutContactDto.setOpinion6(rentOutContact.getOpinion6());
			}
			if(rentOutContact.getDescription()!=null){
				rentOutContactDto.setDescription(rentOutContact.getDescription());
			}
			session = rentOutContactDao.openSession();
			generateRentOutContactWord(rentOutContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.RentOutContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateRentOutContactWord(RentOutContactDto rentOutContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/rentOutContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] rentOutContactFields = RentOutContactDto.class.getDeclaredFields();
			for (Field field : rentOutContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = RentOutContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(rentOutContactDto);
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
