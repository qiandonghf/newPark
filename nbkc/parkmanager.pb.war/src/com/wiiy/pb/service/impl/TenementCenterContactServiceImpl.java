package com.wiiy.pb.service.impl;


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
import com.wiiy.pb.dto.TenementCenterContactDto;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.TenementCenterContact;
import com.wiiy.pb.dao.TenementCenterContactDao;
import com.wiiy.pb.service.TenementCenterContactService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class TenementCenterContactServiceImpl extends ContactBaseServiceImpl<TenementCenterContact> implements TenementCenterContactService{
	
	private TenementCenterContactDao tenementCenterContactDao;
	
	public void setTenementCenterContactDao(TenementCenterContactDao tenementCenterContactDao) {
		this.tenementCenterContactDao = tenementCenterContactDao;
	}

	@Override
	protected ContactBaseDao<TenementCenterContact> getDao() {
		return tenementCenterContactDao;
	}
	
	@Override
	public Result<?> send(Long id, Long receiveId, String approvalType) {
		Session session = null;
		Transaction tr = null;
		try{
			session = tenementCenterContactDao.openSession();
			tr = session.beginTransaction();
			TenementCenterContact t = (TenementCenterContact) session.get(TenementCenterContact.class, id);
			if("opinion1".equals(approvalType)){
				if(t.getOpinion1Id()!=null){//id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setOpinion1Id(receiveId);
					t.setOpinionNow("opinion1");
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
			contactLog.setContactType(ContactTypeEnum.TENEMENTCENTERCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.TenementCenterContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.TenementCenterContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = tenementCenterContactDao.openSession();
			tr = session.beginTransaction();
			TenementCenterContact t = (TenementCenterContact) session.get(TenementCenterContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("opinion1".equals(approvalType)){
				t.setOpinion1(opinion);
				contactLog.setContent("修改了物业部门意见");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getOpinion1Id()!=null && t.getOpinion1()!=null){
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
			contactLog.setContactType(ContactTypeEnum.TENEMENTCENTERCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.TenementCenterContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.TenementCenterContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			TenementCenterContact tenementCenterContact = tenementCenterContactDao.getBeanById(id);
			TenementCenterContactDto tenementCenterContactDto = new TenementCenterContactDto();
			
			if(tenementCenterContact.getCreateTime()!=null){
				tenementCenterContactDto.setYear(DateUtil.format(tenementCenterContact.getCreateTime(), "yyyy"));
				tenementCenterContactDto.setMonth(DateUtil.format(tenementCenterContact.getCreateTime(), "MM"));
				tenementCenterContactDto.setDay(DateUtil.format(tenementCenterContact.getCreateTime(), "dd"));
			}
			if(tenementCenterContact.getCustomer()!=null){
				tenementCenterContactDto.setCustomer(tenementCenterContact.getCustomer());
			}
			if(tenementCenterContact.getContent()!=null){
				tenementCenterContactDto.setContent(tenementCenterContact.getContent());
			}
			if(tenementCenterContact.getRoom()!=null){
				Room room = tenementCenterContact.getRoom();
				tenementCenterContactDto.setRoom(room.getBuilding().getName()+" "+room.getName()+" "+room.getBuildingArea()+"平方米");
			}
			if(tenementCenterContact.getOpinion1()!=null){
				tenementCenterContactDto.setOpinion1(tenementCenterContact.getOpinion1());
			}
			session = tenementCenterContactDao.openSession();
			generateTenementCenterContactWord(tenementCenterContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.TenementCenterContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateTenementCenterContactWord(TenementCenterContactDto tenementCenterContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/tenementCenterContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] tenementCenterContactFields = TenementCenterContactDto.class.getDeclaredFields();
			for (Field field : tenementCenterContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = TenementCenterContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(tenementCenterContactDto);
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
