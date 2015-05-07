package com.wiiy.cloud.capture.service.impl;

import java.io.Serializable;
import java.util.List;


import com.wiiy.cloud.capture.dao.WebParamDao;
import com.wiiy.cloud.capture.entity.WebParam;
import com.wiiy.cloud.capture.service.WebParamService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class WebParamServiceImpl implements WebParamService{
	private WebParamDao webParamDao;
	public void setWebParamDao(WebParamDao webParamDao) {
		this.webParamDao = webParamDao;
	}
	
	@Override
	public Result<WebParam> save(WebParam t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<WebParam> update(WebParam t) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Result<WebParam> delete(WebParam t) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<WebParam> deleteById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<WebParam> deleteByIds(String ids) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<WebParam> getBeanByFilter(Filter filter) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<WebParam> getBeanById(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<List<WebParam>> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Result<List<WebParam>> getListByFilter(Filter filter) {
		// TODO Auto-generated method stub
		return null;
	}


}
