package com.wiiy.core.service.impl;

import java.io.Serializable;
import java.util.List;

import com.wiiy.core.dao.NewsParamDao;
import com.wiiy.core.entity.NewsParam;
import com.wiiy.core.service.NewsParamService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class NewsParamServiceImpl implements NewsParamService {
    private NewsParamDao newsParamDao ;
	public void setNewsParamDao(NewsParamDao newsParamDao) {
		this.newsParamDao = newsParamDao;
	}

	@Override
	public Result<NewsParam> delete(NewsParam arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<NewsParam> deleteById(Serializable arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<NewsParam> deleteByIds(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<NewsParam> getBeanByFilter(Filter arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<NewsParam> getBeanById(Serializable arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<List<NewsParam>> getList() {
		if(newsParamDao.getList().size()==0){
			return null ;
		}
		return Result.value(newsParamDao.getList());
	}

	@Override
	public Result<List<NewsParam>> getListByFilter(Filter arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<NewsParam> save(NewsParam newsParam) {
		try {
			newsParamDao.save(newsParam);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("���ʧ��");
		}
		return Result.success("��ӳɹ�");
	}

	@Override
	public Result<NewsParam> update(NewsParam newsParam) {
		try {
			newsParamDao.update(newsParam);
		} catch (Exception e) {
			e.printStackTrace() ;
			return Result.failure("����ʧ��");
		}
		
		return Result.success();
	}

}
