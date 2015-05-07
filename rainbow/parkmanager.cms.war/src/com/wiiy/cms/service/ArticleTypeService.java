package com.wiiy.cms.service;

import java.util.List;

import com.wiiy.cms.entity.ArticleType;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;

public interface ArticleTypeService extends IService<ArticleType>{
	Result<ArticleType> AddManageIdsAndNames(
			String ids,String managerIds,String managerNames);
	
	@SuppressWarnings("rawtypes")
	Result updateFieldById(String field,Long value,Long id);
	
	
	void executeSQLUpdate(String sql);
	
	@SuppressWarnings("rawtypes")
	List createSqlQuery(String sql);
}
