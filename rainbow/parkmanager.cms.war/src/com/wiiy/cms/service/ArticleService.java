package com.wiiy.cms.service;

import java.util.List;

import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public interface ArticleService extends IService<Article>{
	//文章还原
	public Result restoreById(Long id);
	public Result restoreByIds(String ids);
	
	
	//文章放入回收站
	public Result recycleById(Long id);
	public Result recycleByIds(String ids);

	public Result view(Long id);
	
	List<Object> loadByTypeId(long typeId);
	
	Result<Article> save(Article t,List<ArticleAtt> att);
	Result<Article> update(Article t,List<ArticleAtt> att);
	
	void deleteAttById(long id);
	
	Result getRowCount(Filter filter);
}
