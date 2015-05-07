package com.wiiy.pb.service.impl;

import java.io.Serializable;
import java.util.List;

import com.wiiy.crm.dao.ParkLogDao;
import com.wiiy.crm.entity.ParkLog;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.service.ParkLogService;

public class ParkLogServiceImpl implements ParkLogService {
    private ParkLogDao parkLogDao ;
    public void setParkLogDao(ParkLogDao parkLogDao) {
		this.parkLogDao = parkLogDao;
	}
	@Override
	public Result<ParkLog> delete(ParkLog parkLog) {
		try {
			parkLogDao.delete(parkLog);
			return Result.success("删除成功");
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("删除失败");
		}
	}

	@Override
	public Result<ParkLog> deleteById(Serializable id) {
		try {
			parkLogDao.deleteById(id);
			return Result.success("删除成功");
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("删除失败");
		}
	}

	@Override
	public Result<ParkLog> deleteByIds(String ids) {
		try {
			parkLogDao.deleteByIds(ids);
			return Result.success("删除成功");
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("删除失败");
		}
	}

	@Override
	public Result<ParkLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(parkLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("获取对象失败");
		}
	}

	@Override
	public Result<ParkLog> getBeanById(Serializable id) {
		try {
			return Result.value(parkLogDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("获取对象失败");
		}
	}

	@Override
	public Result<List<ParkLog>> getList() {
		// TODO Auto-generated method stub
		return Result.value(parkLogDao.getList());
	}

	@Override
	public Result<List<ParkLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(parkLogDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("获取列表失败");
		}
	}

	@Override
	public Result<ParkLog> save(ParkLog parkLog) {
		try {
			parkLogDao.save(parkLog);
			return Result.success("保存成功");
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("添加失败");
		}
	}

	@Override
	public Result<ParkLog> update(ParkLog parkLog) {
		try {
			parkLogDao.update(parkLog);
			return Result.success("修改成功");
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("修改失败");
		}
	}

}
