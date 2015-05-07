package com.wiiy.pb.service.impl;


import java.io.File;
import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.IOUtil;
import com.wiiy.commons.util.MicrosoftWordUtil;
import com.wiiy.core.dao.ContactBaseDao;
import com.wiiy.core.entity.ContactLog;
import com.wiiy.core.entity.User;
import com.wiiy.core.preferences.enums.ContactTypeEnum;
import com.wiiy.core.service.impl.ContactBaseServiceImpl;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.CarportOutContact;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.dao.CarportOutContactDao;
import com.wiiy.pb.dto.CarportOutContactDto;
import com.wiiy.pb.service.CarportOutContactService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CarportOutContactServiceImpl extends ContactBaseServiceImpl<CarportOutContact> implements CarportOutContactService{
	
	private CarportOutContactDao carportOutContactDao;
	
	public void setCarportOutContactDao(CarportOutContactDao carportOutContactDao) {
		this.carportOutContactDao = carportOutContactDao;
	}
	
	@Override
	protected ContactBaseDao<CarportOutContact> getDao() {
		return carportOutContactDao;
	}

	@Override
	public Result<?> send(Long id, Long receiveId, String approvalType) {
		Session session = null;
		Transaction tr = null;
		try{
			session = carportOutContactDao.openSession();
			tr = session.beginTransaction();
			CarportOutContact t = (CarportOutContact) session.get(CarportOutContact.class, id);
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
			contactLog.setContactType(ContactTypeEnum.CARPORTOUTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.CarportOutContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.CarportOutContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = carportOutContactDao.openSession();
			tr = session.beginTransaction();
			CarportOutContact t = (CarportOutContact) session.get(CarportOutContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("opinion1".equals(approvalType)){
				t.setOpinion1(opinion);
				contactLog.setContent("修改了创业服务中心核实意见");
			}else if("opinion2".equals(approvalType)){
				t.setOpinion2(opinion);
				contactLog.setContent("修改了科技园发展有限公财务部审核");
			}else if("opinion3".equals(approvalType)){
				t.setOpinion3(opinion);
				contactLog.setContent("修改了南都物业物管中心财务审核");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getOpinion1Id()!=null && t.getOpinion1()!=null && t.getOpinion2Id()!=null && t.getOpinion2()!=null && t.getOpinion3Id()!=null && t.getOpinion3()!=null){
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
			contactLog.setContactType(ContactTypeEnum.CARPORTOUTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.CarportOutContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.CarportOutContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			CarportOutContact carportOutContact = carportOutContactDao.getBeanById(id);
			CarportOutContactDto carportOutContactDto = new CarportOutContactDto();
			
			if(carportOutContact.getCreateTime()!=null){
				carportOutContactDto.setYear(DateUtil.format(carportOutContact.getCreateTime(), "yyyy"));
				carportOutContactDto.setMonth(DateUtil.format(carportOutContact.getCreateTime(), "MM"));
				carportOutContactDto.setDay(DateUtil.format(carportOutContact.getCreateTime(), "dd"));
			}
			if(carportOutContact.getCustomer()!=null){
				carportOutContactDto.setCustomer(carportOutContact.getCustomer());
			}
			if(carportOutContact.getReason()!=null){
				carportOutContactDto.setReason(carportOutContact.getReason());
			}
			if(carportOutContact.getResponsible()!=null){
				carportOutContactDto.setResponsible(carportOutContact.getResponsible().getRealName());
			}
			if(carportOutContact.getResponsible()!=null && carportOutContact.getResponsible().getTelephone()!=null){
				carportOutContactDto.setPhone(carportOutContact.getResponsible().getTelephone());
			}
			if(carportOutContact.getCarport()!=null){
				carportOutContactDto.setCarport(carportOutContact.getCarport());
			}
			if(carportOutContact.getNumber()!=null){
				carportOutContactDto.setNumber(carportOutContact.getNumber());
			}
			if(carportOutContact.getRentStart()!=null){
				carportOutContactDto.setRentStart(carportOutContact.getRentStart());
			}
			if(carportOutContact.getRentEnd()!=null){
				carportOutContactDto.setRentEnd(carportOutContact.getRentEnd());
			}
			if(carportOutContact.getRentOutStart()!=null){
				carportOutContactDto.setRentOutStart(carportOutContact.getRentOutStart());
			}
			if(carportOutContact.getRentOutEnd()!=null){
				carportOutContactDto.setRentOutEnd(carportOutContact.getRentOutEnd());
			}
			if(carportOutContact.getMoney()!=null){
				carportOutContactDto.setMoney(carportOutContact.getMoney());
			}
			if(carportOutContact.getOpinion1()!=null){
				carportOutContactDto.setOpinion1(carportOutContact.getOpinion1());
			}
			if(carportOutContact.getOpinion2()!=null){
				carportOutContactDto.setOpinion2(carportOutContact.getOpinion2());
			}
			if(carportOutContact.getOpinion3()!=null){
				carportOutContactDto.setOpinion3(carportOutContact.getOpinion3());
			}
			session = carportOutContactDao.openSession();
			generateCarportOutContactWord(carportOutContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.CarportOutContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateCarportOutContactWord(CarportOutContactDto carportOutContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/carportOutContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] carportOutContactFields = CarportOutContactDto.class.getDeclaredFields();
			for (Field field : carportOutContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = CarportOutContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(carportOutContactDto);
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
