package com.wiiy.crm.service.impl;


import java.io.File;
import java.io.OutputStream;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.IOUtil;
import com.wiiy.commons.util.MicrosoftWordUtil;
import com.wiiy.crm.dao.CustomerServiceDao;
import com.wiiy.crm.dao.CustomerServiceTrackDao;
import com.wiiy.crm.dto.CustomerServiceDto;
import com.wiiy.crm.dto.CustomerServiceTrackDto;
import com.wiiy.crm.entity.CustomerService;
import com.wiiy.crm.entity.CustomerServiceTrack;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.CustomerServiceService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerServiceServiceImpl implements CustomerServiceService{
	
	private CustomerServiceDao customerServiceDao;
	private CustomerServiceTrackDao customerServiceTrackDao;
	
	public void setCustomerServiceTrackDao(
			CustomerServiceTrackDao customerServiceTrackDao) {
		this.customerServiceTrackDao = customerServiceTrackDao;
	}
	public void setCustomerServiceDao(CustomerServiceDao customerServiceDao) {
		this.customerServiceDao = customerServiceDao;
	}

	@Override
	public Result<CustomerService> save(CustomerService t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerServiceDao.save(t);
			return Result.success(R.CustomerService.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerService.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> delete(CustomerService t) {
		try {
			customerServiceDao.delete(t);
			return Result.success(R.CustomerService.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> deleteById(Serializable id) {
		try {
			customerServiceDao.deleteById(id);
			return Result.success(R.CustomerService.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> deleteByIds(String ids) {
		try {
			customerServiceDao.deleteByIds(ids);
			return Result.success(R.CustomerService.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> update(CustomerService t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerServiceDao.update(t);
			return Result.success(R.CustomerService.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerService.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> getBeanById(Serializable id) {
		try {
			return Result.value(customerServiceDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerServiceDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerService>> getList() {
		try {
			return Result.value(customerServiceDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerService.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerService>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerServiceDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerService.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerService> print(Long id, OutputStream out) {
		try {
			CustomerService customerService = customerServiceDao.getBeanById(id);
			List<CustomerServiceTrack> list = customerServiceTrackDao.getListByFilter(new Filter(CustomerServiceTrack.class).eq("serviceId", id));
			CustomerServiceDto customerServiceDto = new CustomerServiceDto();
			customerServiceDto.setCreatedDate(DateUtil.format(new Date()));
			customerServiceDto.setCustomerName(customerService.getCustomer().getName());
			customerServiceDto.setType(customerService.getType().getDataValue());
			customerServiceDto.setContectName(customerService.getContect());
			customerServiceDto.setStartDate(DateUtil.format(customerService.getStartDate()));
			customerServiceDto.setDescription(customerService.getDescription());
			customerServiceDto.setUserName(customerService.getUser().getUsername());
			customerServiceDto.setStatus(customerService.getStatus().getTitle());
			customerServiceDto.setServiceResult(customerService.getResult().getTitle());
			if(customerService.getSuggest()!=null){
				customerServiceDto.setSuggest(customerService.getSuggest());
			}
			customerServiceDto.setPhone(customerService.getPhone());
			List<CustomerServiceTrackDto> trackList = new ArrayList<CustomerServiceTrackDto>();
			for (CustomerServiceTrack customerServiceTrack : list) {
				CustomerServiceTrackDto customerServiceTrackDto = new CustomerServiceTrackDto();
				customerServiceTrackDto.setName(customerServiceTrack.getUser().getUsername());
				customerServiceTrackDto.setDate(DateUtil.format(customerServiceTrack.getHandleTime()));
				if(customerServiceTrack.getContent()!=null){
					customerServiceTrackDto.setContent(customerServiceTrack.getContent());
				}
				trackList.add(customerServiceTrackDto);
			}
			customerServiceDto.setList(trackList);
			generateInvestmentWord(customerServiceDto, out);
			return Result.success();
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerService.LOAD_FAILURE);
		}
	}
	
	private void generateInvestmentWord(CustomerServiceDto customerServiceDto,
			OutputStream out) {
		MicrosoftWordUtil mwu = new MicrosoftWordUtil();
		try {
			String printDoc = "d:\\printDoc";
			File f = new File(printDoc);
			f.mkdir();
			File temp = new File("d:\\printDoc\\temp.doc");
			URL url = PbActivator.getURL("doc/customerService.doc");
			IOUtil.copyInputStreamToFile(url.openStream(), temp);
			mwu.openDocument(temp.getAbsolutePath());
			Field[] customerServiceFields = CustomerServiceDto.class.getDeclaredFields();
			for (Field field : customerServiceFields) {
				if(!Collection.class.isAssignableFrom(field.getClass())){
					String fieldName = field.getName();
					try {
						Object value = CustomerServiceDto.class.getMethod("get"+fieldName.substring(0,1).toUpperCase()+fieldName.substring(1)).invoke(customerServiceDto);
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
			List<CustomerServiceTrackDto> list = customerServiceDto.getList();
			int addLine = list.size()-3;
			int rowStartIndex = 8;
			int colCount = 3;
			for (int i = 0; i < addLine; i++) {
				for (int j = 0; j < colCount; j++) {
					mwu.splitCell(1, rowStartIndex, j+1, 2, 1);
				}
			}
			for (int i = 0; i < list.size(); i++) {
				int colIndex = 1;
				CustomerServiceTrackDto dto = list.get(i);
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getName());
				mwu.writeCell(1, rowStartIndex+i, colIndex++, String.valueOf(dto.getDate()));
				mwu.writeCell(1, rowStartIndex+i, colIndex++, dto.getContent());
			}
			mwu.closeDocument();
			IOUtil.copyFileToOutputStream(temp, out);
			temp.deleteOnExit();
		} catch (Exception e) {
			e.printStackTrace();
			mwu.close();
		}
	}
	public int countYetCustomer() {
		try{
		Session session = customerServiceDao.openSession();
		String sql = "select count(*) from crm_customer_service where status <> 'CLOSE'";
		int num =((BigInteger) session.createSQLQuery(sql).uniqueResult()).intValue();
		session.close();
		return num;
		}catch(Exception e){
			e.printStackTrace();
		}
		return 0;
	}
}
