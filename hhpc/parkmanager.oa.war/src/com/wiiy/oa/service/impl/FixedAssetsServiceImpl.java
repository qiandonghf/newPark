package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.AssetsDepreciationDao;
import com.wiiy.oa.dao.FixedAssetsDao;
import com.wiiy.oa.entity.AssetsDepreciation;
import com.wiiy.oa.entity.FixedAssets;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.FixedAssetsService;

public class FixedAssetsServiceImpl implements FixedAssetsService{
	private FixedAssetsDao fixedAssetsDao;
	private AssetsDepreciationDao assetsDepreciationDao;
	public void setAssetsDepreciationDao(AssetsDepreciationDao assetsDepreciationDao) {
		this.assetsDepreciationDao = assetsDepreciationDao;
	}	
	public void setFixedAssetsDao(FixedAssetsDao fixedAssetsDao) {
		this.fixedAssetsDao = fixedAssetsDao;
	}

	@Override
	public Result<FixedAssets> save(FixedAssets t) {
		Session session = null;
		Transaction tr = null;
			//将新建的资源名称进行处理，方便与表中的对应字段进行比较
			String fixedAssetsName = t.getName().trim();
		try{
			session = fixedAssetsDao.openSession();
			tr = session.beginTransaction();
			//将数据取出判断是否重名，因为资产名称有唯一性约束
			List<FixedAssets> fixedAssetsList = new ArrayList<FixedAssets>();
			fixedAssetsList = session.createQuery("from FixedAssets").list();
			for (FixedAssets fixedAssets : fixedAssetsList) {
				if(fixedAssetsName.equals(fixedAssets.getName())){
					return Result.failure("资产名称已存在，请换个名称");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			fixedAssetsDao.save(t);
			tr.commit();
			OaActivator.getOperationLogService().logOP("添加固定资产【"+t.getName()+"】");
			return Result.success(R.FixedAssets.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), FixedAssets.class)));
		}catch(Exception e){
			return Result.failure(R.FixedAssets.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<FixedAssets> delete(FixedAssets t) {
		try{
			fixedAssetsDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除固定资产【"+t.getName()+"】");
			return Result.success(R.FixedAssets.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));			
		}catch(Exception e){
			return Result.failure(R.FixedAssets.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FixedAssets> deleteById(Serializable id) {
		try {
			fixedAssetsDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的固定资产");
			return Result.success(R.FixedAssets.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FixedAssets> deleteByIds(String ids) {
		try {
			fixedAssetsDao.deleteByIds(ids);
			for (String id : ids.split(",")) {
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的固定资产");
			}	
			return Result.success(R.FixedAssets.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FixedAssets> update(FixedAssets t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			fixedAssetsDao.update(t);
			OaActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的固定资产信息");
			return Result.success(R.FixedAssets.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FixedAssets.class)));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<FixedAssets> getBeanById(Serializable id) {
		try {
			return Result.value(fixedAssetsDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.LOAD_FAILURE);
		}
	}

	@Override
	public Result<FixedAssets> getBeanByFilter(Filter filter) {
		try {
			return Result.value(fixedAssetsDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FixedAssets>> getList() {
		try {
			return Result.value(fixedAssetsDao.getList());
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FixedAssets>> getListByFilter(Filter filter) {
		try {
			return Result.value(fixedAssetsDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FixedAssets.LOAD_FAILURE);
		}	
	}
	
	/**
	 * 进行资产折算
	 * 年折旧率=（1－预计净利残值率）/预计使用年限×100% 　　
	 * 月折旧率=年折旧率÷12 　　
	 * 月折旧额=固定资产原价×月折旧率 
	 * 年折旧额=固定资产原价×年折旧率
	 */
	
	@Override
	public Result convert(Long id) {
		try {
			FixedAssets fixedAssets = fixedAssetsDao.getBeanById(id);			
			/**
			 * 折旧信息
			 */
			String depreciation = fixedAssets.getDepreciation().getTitle();
			String cycle = fixedAssets.getCycle().getTitle();	
			double originalValue = fixedAssets.getOriginalValue();						
			double residualValueRate = fixedAssets.getResidualValueRate();					
			double cycleAmount = fixedAssets.getCycleAmount();			
			double lifeTime = fixedAssets.getLifeTime();
			
			if(depreciation!=null && cycle!=null
					&& originalValue!=0&& residualValueRate!=0 
					&& cycleAmount!=0 && lifeTime!=0){				
				fixedAssets.setModifyTime(new Date());
				fixedAssets.setModifier(OaActivator.getSessionUser().getRealName());
				fixedAssets.setModifierId(OaActivator.getSessionUser().getId());
				AssetsDepreciation assetsDepreciation = gainAssetsDepreciation(fixedAssets);									
					//保留两位小数位处理
				java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
					//平均折算法
				if(cycle.equals("年")){					
					//年折旧率（根据残值率、使用年限计算）
					double residualRatePerYear = (1-residualValueRate/100)/lifeTime;
					int usedTime = getYearSpace(assetsDepreciation.getStartDate(), new Date());
						if(usedTime<=0){
							return Result.failure("开始折旧日期距离当前日期太短，不能进行折旧计算");
						}
						deleteRecordByFixedAssetsId(fixedAssets.getId());
						if(usedTime<=fixedAssets.getCycleAmount()){
							//将每年的折旧值存入折旧记录表中
							for (int i = 1; i <= usedTime; i++) {
								double newValue = originalValue - (originalValue*residualRatePerYear*i);
								//折旧结束时间的处理
								Calendar startTime = Calendar.getInstance();	
								startTime.setTime(assetsDepreciation.getStartDate());
								startTime.add(Calendar.YEAR,i);//日期加i年							
								Date dt=startTime.getTime();
								assetsDepreciation.setEndDate(dt);													
								assetsDepreciation.setNewValue(Double.parseDouble(df.format(newValue)));												
								assetsDepreciationDao.save(assetsDepreciation);
							}
							fixedAssets.setNewValue(Double.parseDouble(df.format(originalValue - (originalValue*residualRatePerYear*usedTime))));

						}else{
							//将每年的折旧值存入折旧记录表中
							for (int i = 1; i <= fixedAssets.getCycleAmount(); i++) {
								double newValue = originalValue - (originalValue*residualRatePerYear*i);
								//折旧结束时间的处理
								Calendar startTime = Calendar.getInstance();	
								startTime.setTime(assetsDepreciation.getStartDate());
								startTime.add(Calendar.YEAR,i);//日期加i年							
								Date dt=startTime.getTime();
								assetsDepreciation.setEndDate(dt);													
								assetsDepreciation.setNewValue(Double.parseDouble(df.format(newValue)));												
								assetsDepreciationDao.save(assetsDepreciation);
								}
							fixedAssets.setNewValue(Double.parseDouble(df.format(originalValue - (originalValue*residualRatePerYear*fixedAssets.getCycleAmount()))));
							}
						//将最终的折旧值存入固定资产表中
						fixedAssetsDao.update(fixedAssets);														
				}else if(cycle.equals("月")){
					//月折旧率（根据残值率、使用年限计算）
					double residualRatePerMonth = ((1-residualValueRate/100)/lifeTime)/12;
					int usedTime = getMonthSpace(assetsDepreciation.getStartDate(), new Date());
						if(usedTime<=0){
							return Result.failure("开始折旧日期距离当前日期太短，不能进行折旧计算");
						}
						deleteRecordByFixedAssetsId(fixedAssets.getId());
						if(usedTime<=fixedAssets.getCycleAmount()){
							//将每月的折旧值存入折旧记录表中
							for (int i = 1; i <= usedTime; i++) {
								double newValue = originalValue - (originalValue*residualRatePerMonth*i);
								//折旧结束时间的处理
								Calendar startTime = Calendar.getInstance();	
								startTime.setTime(assetsDepreciation.getStartDate());
								startTime.add(Calendar.MONTH,i);//日期加i个月
								Date dt=startTime.getTime();
								assetsDepreciation.setEndDate(dt);	
								assetsDepreciation.setNewValue(Double.parseDouble(df.format(newValue)));			
								assetsDepreciationDao.save(assetsDepreciation);
							}
							fixedAssets.setNewValue(Double.parseDouble(df.format(originalValue - (originalValue*residualRatePerMonth*usedTime))));
						}else{
							//将每月的折旧值存入折旧记录表中
							for (int i = 1; i <= fixedAssets.getCycleAmount(); i++) {
								double newValue = originalValue - (originalValue*residualRatePerMonth*i);
								//折旧结束时间的处理
								Calendar startTime = Calendar.getInstance();	
								startTime.setTime(assetsDepreciation.getStartDate());
								startTime.add(Calendar.MONTH,i);//日期加i个月
								Date dt=startTime.getTime();
								assetsDepreciation.setEndDate(dt);	
								assetsDepreciation.setNewValue(Double.parseDouble(df.format(newValue)));			
								assetsDepreciationDao.save(assetsDepreciation);
							}
							fixedAssets.setNewValue(Double.parseDouble(df.format(originalValue - (originalValue*residualRatePerMonth*fixedAssets.getCycleAmount()))));
						}						
						//将最终的折旧值存入固定资产表中
						fixedAssetsDao.update(fixedAssets);
					}																						
				OaActivator.getOperationLogService().logOP("折算名称为【"+fixedAssets.getName()+"】的固定资产");
				return Result.success("固定资产折算成功");
			}
			return Result.failure("固定资产折旧信息未填写完整，不能进行折旧计算");						
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FixedAssets.class)));
		} catch (Exception e) {
			return Result.failure("固定资产折旧信息未填写完整，不能进行折旧计算");
		}
	}
	/**
	 * 根据传入的fixedAssets的返回对应的折旧记录对象
	 * @param fixedAssets
	 * @return assetsDepreciation
	 */
	public AssetsDepreciation gainAssetsDepreciation(FixedAssets fixedAssets){
		AssetsDepreciation assetsDepreciation = new AssetsDepreciation();
		//资产类型外键
		assetsDepreciation.setFixedAssetsId(fixedAssets.getId());
		//折旧类型
		assetsDepreciation.setDepreciation(fixedAssets.getDepreciation().getTitle());
		//折旧开始日期
		assetsDepreciation.setStartDate(fixedAssets.getStartDate());		
		//原资产值
		assetsDepreciation.setLastValue(fixedAssets.getOriginalValue());
		return assetsDepreciation;
	}
	
	/**
	 * 先删除折旧记录表中的重复记录
	 */	
	public void deleteRecordByFixedAssetsId(Long fixedAssetsId){
		Session session = null;
		Transaction tr = null;
		try{
			session = assetsDepreciationDao.openSession();
			tr = session.beginTransaction();
			org.hibernate.Query query = session.createQuery("delete from AssetsDepreciation where fixedAssetsId = ?");
			query.setLong(0, fixedAssetsId);
			query.executeUpdate();
			System.out.println("折旧记录表中的重复记录已经删除");
			tr.commit();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("折旧记录表中的重复记录删除失败");
			tr.rollback();
		}finally{
			session.close();
		}		
	}
	
	/**
	 * 计算两个日期之间的相差的月份
	 */
	public static int getMonthSpace(Date startDate, Date nowDate){
		int result = 0;
		int monthCount=0;
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(startDate);
		c2.setTime(nowDate);
		result = c2.get(Calendar.MONTH) - c1.get(Calendar.MONTH);
		if(result<0){
			result*=-1;
			monthCount = (getYearSpace(startDate, nowDate)*12)-result;
			System.out.println("相差月份："+monthCount);
			return monthCount;
		}
		monthCount = result+(getYearSpace(startDate, nowDate)*12);
		System.out.println("相差月份："+monthCount);
		return monthCount;
	}
	
	/**
	 * 计算两个日期之间的相差的年份
	 */
	public static int getYearSpace(Date startDate, Date nowDate){
		int result = 0;
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(startDate);
		c2.setTime(nowDate);
		result = c2.get(Calendar.YEAR) - c1.get(Calendar.YEAR);
		System.out.println("相差年份："+result);
		return result;
	}
}
