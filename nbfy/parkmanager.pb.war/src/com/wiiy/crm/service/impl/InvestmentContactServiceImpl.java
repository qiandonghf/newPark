package com.wiiy.crm.service.impl;

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
import com.wiiy.crm.entity.InvestmentContact;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.InvestmentContactService;
import com.wiiy.crm.dao.InvestmentContactDao;
import com.wiiy.crm.dao.InvestmentDirectorDao;
import com.wiiy.crm.dto.DirectorDto;
import com.wiiy.crm.dto.InvestmentContactDto;
import com.wiiy.crm.dto.InvestmentDto;
import com.wiiy.crm.dto.InvestorDto;
import com.wiiy.hibernate.BaseDao;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class InvestmentContactServiceImpl extends ContactBaseServiceImpl<InvestmentContact> implements InvestmentContactService {

	private InvestmentContactDao investmentContactDao;
	private InvestmentDirectorDao investmentDirectorDao;

	public void setInvestmentContactDao(InvestmentContactDao investmentContactDao) {
		this.investmentContactDao = investmentContactDao;
	}

	public void setInvestmentDirectorDao(InvestmentDirectorDao investmentDirectorDao) {
		this.investmentDirectorDao = investmentDirectorDao;
	}

	@Override
	protected ContactBaseDao<InvestmentContact> getDao() {
		return investmentContactDao;
	}

	@Override
	public Result<?> send(Long id, Long receiveId, String approvalType) {
		Session session = null;
		Transaction tr = null;
		try{
			session = investmentContactDao.openSession();
			tr = session.beginTransaction();
			InvestmentContact t = (InvestmentContact) session.get(InvestmentContact.class, id);
			if(t.getCreatorId().longValue() == PbActivator.getSessionUser().getId() && (t.getDepartmentOpinionId()!=null || t.getHeadOpinionId()!=null)){
				return Result.failure("您已经报送过审批,不能再次报送！");
			}
			if("departmentOpinion".equals(approvalType)){
				if(t.getDepartmentOpinionId()!=null){//投资促进部审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setDepartmentOpinionId(receiveId);
					t.setOpinionNow("departmentOpinion");
				}
				
			}else if("headOpinion".equals(approvalType)){
				if(t.getHeadOpinionId()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setHeadOpinionId(receiveId);
					t.setOpinionNow("headOpinion");
				}
			}else if("attractOpinion".equals(approvalType)){
				if(t.getAttractOpinionId()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setAttractOpinionId(receiveId);
					t.setOpinionNow("attractOpinion");
				}
			}else if("handleOpinion".equals(approvalType)){
				if(t.getHandleOpinionId()!=null){//审批者id不为空，说明已经有这个人了， 不能再报送审批
					return Result.failure("已经发送过该审批！！！");
				}else{
					t.setHandleOpinionId(receiveId);
					t.setOpinionNow("handleOpinion");
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
			contactLog.setContactType(ContactTypeEnum.INVESTMENTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.InvestmentContact.SEND_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.success(R.InvestmentContact.SEND_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> approval(String approvalType, Long id,String opinion) {
		Session session = null;
		Transaction tr = null;
		try{
			session = investmentContactDao.openSession();
			tr = session.beginTransaction();
			InvestmentContact t = (InvestmentContact) session.get(InvestmentContact.class, id);
			ContactLog contactLog = new ContactLog();
			if("departmentOpinion".equals(approvalType)){
				t.setDepartmentOpinion(opinion);
				contactLog.setContent("修改了投资促进部意见");
			}else if("headOpinion".equals(approvalType)){
				t.setHeadOpinion(opinion);
				contactLog.setContent("修改了主任办公室意见");
			}else if("attractOpinion".equals(approvalType)){
				t.setAttractOpinion(opinion);
				contactLog.setContent("修改了招商人员意见");
			}else if("handleOpinion".equals(approvalType)){
				t.setHandleOpinion(opinion);
				contactLog.setContent("修改了经办人员意见");
			}
			User nowUser = PbActivator.getSessionUser();
			if(t.getDepartmentOpinionId()!=null && t.getDepartmentOpinion()!=null && t.getHeadOpinionId()!=null && t.getHeadOpinion()!=null && t.getAttractOpinionId()!=null && t.getAttractOpinion()!=null && t.getHandleOpinionId()!=null && t.getHandleOpinion()!=null){
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
			contactLog.setContactType(ContactTypeEnum.INVESTMENTCONTACT);
			session.save(contactLog);
			tr.commit();
			return Result.success(R.InvestmentContact.SAVE_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.InvestmentContact.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<?> print(Long id, OutputStream out) {
		Session session = null;
		try{
			InvestmentContact investmentContact = investmentContactDao.getBeanById(id);
			InvestmentContactDto investmentContactDto = new InvestmentContactDto();
			
			if(investmentContact.getCreateTime()!=null){
				investmentContactDto.setYear(DateUtil.format(investmentContact.getCreateTime(), "yyyy"));
				investmentContactDto.setMonth(DateUtil.format(investmentContact.getCreateTime(), "MM"));
				investmentContactDto.setDay(DateUtil.format(investmentContact.getCreateTime(), "dd"));
			}
			if(investmentContact.getInvestmentName()!=null){
				investmentContactDto.setInvestmentName(investmentContact.getInvestmentName());
			}
			if(investmentContact.getBusinessScope()!=null){
				investmentContactDto.setBusinessScope(investmentContact.getBusinessScope());
			}
			if(investmentContact.getRegCapital()!=null){
				investmentContactDto.setRegCapital(investmentContact.getRegCapital());
			}
			if(investmentContact.getStaff()!=null){
				investmentContactDto.setStaff(investmentContact.getStaff());
			}
			if(investmentContact.getOfficeArea()!=null){
				investmentContactDto.setOfficeArea(investmentContact.getOfficeArea());
			}
			if(investmentContact.getInvestCapital()!=null){
				investmentContactDto.setInvestCapital(investmentContact.getInvestCapital());
			}
			if(investmentContact.getOutputValue()!=null){
				investmentContactDto.setOutputValue(investmentContact.getOutputValue());
			}
			if(investmentContact.getDepartmentOpinion()!=null){
				investmentContactDto.setDepartmentOpinion(investmentContact.getDepartmentOpinion());
			}
			if(investmentContact.getHeadOpinion()!=null){
				investmentContactDto.setHeadOpinion(investmentContact.getHeadOpinion());
			}
			if(investmentContact.getAttractOpinion()!=null){
				investmentContactDto.setAttractOpinion(investmentContact.getAttractOpinion());
			}
			if(investmentContact.getHandleOpinion()!=null){
				investmentContactDto.setHandleOpinion(investmentContact.getHandleOpinion());
			}
			if(investmentContact.getDescription()!=null){
				investmentContactDto.setDescription(investmentContact.getDescription());
			}
			session = investmentContactDao.openSession();
			if(investmentContact.getLinkmanId()!=null){
				investmentContactDto.setLinkman((User) session.get(User.class, investmentContact.getLinkmanId()));
			}
			List<InvestmentDirector> directorList = investmentDirectorDao.getListByFilter(new Filter(InvestmentDirector.class).eq("investmentId",investmentContact.getInvestmentId()));
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
			investmentContactDto.setDirectorList(directorDtoList);
			generateInvestmentContactWord(investmentContactDto,out);
			return Result.success();
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.InvestmentContact.LOAD_FAILURE);
		}finally{
			session.close();
		}
	}
	private void generateInvestmentContactWord(InvestmentContactDto investmentContactDto,OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/investmentContact.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			
			Field[] investmentContactFields = InvestmentContactDto.class.getDeclaredFields();
			for (Field field : investmentContactFields) {
				if(!Collection.class.isAssignableFrom(field.getType()) && !User.class.isAssignableFrom(field.getType())){
					String fieldName = field.getName();
					try {
						Object value = InvestmentContactDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(investmentContactDto);
						String replaceText = "";
						if(value instanceof Number){
							replaceText = new DecimalFormat("#.##").format(value);
						} else if(value!=null){
							replaceText = value.toString();
						}
						String toFindText = "#"+fieldName;
						mwu.moveStart();
						mwu.replaceText(toFindText, replaceText);
						if(investmentContactDto.getOfficeArea()==null){
							mwu.replaceText("m2","");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
			List<DirectorDto> directorList = investmentContactDto.getDirectorList();
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
			User linkman = investmentContactDto.getLinkman();
			if(linkman!=null){
				mwu.writeCell(1, 5, 1,linkman.getRealName());
				mwu.writeCell(1, 5, 2,linkman.getGender().getTitle());
				mwu.writeCell(1, 5, 3,linkman.getMobile());
				mwu.writeCell(1, 5, 4,linkman.getTelephone());
				mwu.writeCell(1, 5, 5,new SimpleDateFormat("yyyy-MM-dd").format(linkman.getBirthday()));
				mwu.writeCell(1, 5, 6,linkman.getEmail());
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
