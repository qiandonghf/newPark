package com.wiiy.cloud.capture.service.impl;

import java.io.Serializable;
import java.util.List;

import com.wiiy.cloud.capture.dao.ColumnDao;
import com.wiiy.cloud.capture.entity.Column;
import com.wiiy.cloud.capture.service.ColumnService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ColumnServiceImpl implements ColumnService {
    private ColumnDao columnDao ;
	public ColumnDao getColumnDao() {
		return columnDao;
	}

	public void setColumnDao(ColumnDao columnDao) {
		this.columnDao = columnDao;
	}

	@Override
	public Result<Column> save(Column t) {
		try {
			columnDao.save(t);
			return Result.success("保存成功");
		     
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("保存失败");
		}
		
	}

	@Override
	public Result<Column> delete(Column t) {
		try {
			columnDao.delete(t);
		 return	Result.success("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
		return	Result.failure("删除失败");
		}
	}

	@Override
	public Result<Column> deleteById(Serializable id) {
		try {
			columnDao.deleteById(id);
			return Result.success("删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("删除失败");
		}
	}

	@Override
	public Result<Column> deleteByIds(String ids) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<Column> update(Column t) {
		try {
			columnDao.update(t);
			return Result.success("更新成功");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("更新失败");
		}
	}

	@Override
	public Result<Column> getBeanById(Serializable id) {
		try {
			return Result.value(columnDao.getBeanById(id));
		} catch (Exception e) {
			Result.failure("获取内容失败");
		}
		return null;
	}

	@Override
	public Result<Column> getBeanByFilter(Filter filter) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<List<Column>> getList() {
		try {
			System.out.println(columnDao.getList().size());
		  return Result.value(columnDao.getList());
		} catch (Exception e) {
			return Result.failure("获取栏目列表失败");
		}
	}

	@Override
	public Result<List<Column>> getListByFilter(Filter filter) {
		return Result.value(columnDao.getListByFilter(filter));
	}

}
