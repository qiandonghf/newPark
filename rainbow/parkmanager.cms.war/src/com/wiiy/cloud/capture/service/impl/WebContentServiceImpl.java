package com.wiiy.cloud.capture.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cloud.capture.dao.WebContentDao;
import com.wiiy.cloud.capture.demo.NingBo;
import com.wiiy.cloud.capture.dto.WebDto;
import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.preferences.R;
import com.wiiy.cloud.capture.service.WebContentService;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class WebContentServiceImpl implements WebContentService{
	private WebContentDao webContentDao;
	public void setWebContentDao(WebContentDao webContentDao) {
		this.webContentDao = webContentDao;
	}

	@Override
	public Result<WebContent> save(WebContent t) {
		try{
			List<WebContent> list = getListByFilter(new Filter(WebContent.class).eq("title", t.getTitle())).getValue();
			if(list!=null && list.size()>0){
				return Result.failure("网站内容已存在");
			}
			t.setCreateTime(new Date());
			t.setModifyTime(t.getCreateTime());
			t.setEntityStatus(EntityStatus.NORMAL);
			webContentDao.save(t);
			return Result.success(R.WebContent.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebContent.class)));
		}catch (Exception e) {
			return Result.failure(R.WebContent.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WebContent> update(WebContent t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			webContentDao.update(t);
			return Result.success(R.WebContent.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebContent.class)));
		} catch (Exception e) {
			return Result.failure(R.WebContent.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<WebContent> delete(WebContent t) {
		try {
			webContentDao.delete(t);
			return Result.success(R.WebContent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebContent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContent> deleteById(Serializable id) {
		try {
			webContentDao.deleteById(id);
			return Result.success(R.WebContent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebContent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContent> deleteByIds(String ids) {
		try {
			webContentDao.deleteByIds(ids);
			return Result.success(R.WebContent.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebContent.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContent> getBeanByFilter(Filter filter) {
		try {
			return Result.value(webContentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebContent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WebContent> getBeanById(Serializable id) {
		try {
			return Result.value(webContentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WebContent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebContent>> getList() {
		try {
			return Result.value(webContentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WebContent.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebContent>> getListByFilter(Filter filter) {
		try {
			return Result.value(webContentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebContent.LOAD_FAILURE);
		}
	}

	@Override
	public WebInfo getWebInfoByName(String name) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webContentDao.openSession();
			WebContent webContent = new WebContent();
			tr = session.beginTransaction();
			List<Object> list = new ArrayList<Object>();
			String sql = "SELECT c.id,c.name,c.url,c.create_time,c.modify_time,c.params,c.begin_flag,c.end_flag,c.item_regex,c.id_regex,c.date_regex,c.date_pattern FROM "+ModulePrefixNamingStrategy.classToTableName(WebInfo.class)+
					" c WHERE c.name ='"+name+"' GROUP BY c.id,c.name,c.url,c.create_time,c.modify_time,c.params,c.begin_flag,c.end_flag,c.item_regex,c.id_regex,c.date_regex,c.date_pattern";
			list = webContentDao.getObjectListBySql(sql);
			WebInfo webInfo = new WebInfo();
			for(Object object : list){
				Object[] objects = (Object[])object;
				Long wId = Long.parseLong(String.valueOf(objects[0]));
				String wName = String.valueOf(objects[1]);
				String wUrl = String.valueOf(objects[2]);
				Date cTime = DateUtil.parse(String.valueOf(objects[3]));
				Date mTime = DateUtil.parse(String.valueOf(objects[4]));
				String params = String.valueOf(objects[5]);
				String begin_flag = String.valueOf(objects[6]);
				String end_flag = String.valueOf(objects[7]);
				String item_regex = String.valueOf(objects[8]);
				String id_regex = String.valueOf(objects[9]);
				String date_regex = String.valueOf(objects[10]);
				String date_pattern = String.valueOf(objects[11]);
				webInfo.setId(wId);
				webInfo.setName(wName);
				webInfo.setUrl(wUrl);
				webInfo.setCreateTime(cTime);
				webInfo.setModifyTime(mTime);
				webInfo.setParams(params);
				webInfo.setBeginFlag(begin_flag);
				webInfo.setEndFlag(end_flag);
				webInfo.setItemRegex(item_regex);
				webInfo.setIdRegex(id_regex);
				webInfo.setDateRegex(date_regex);
				webInfo.setDatePattern(date_pattern);
			}
			tr.commit();
			return webInfo;
		}catch (Exception e) {
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@Override
	public List<WebInfo> getWebInfoList() {
		Session session = null;
		Transaction tr = null;
		try{
			session = webContentDao.openSession();
			tr = session.beginTransaction();
			List<WebInfo> webInfoList = new ArrayList<WebInfo>();
			List<Object> list = new ArrayList<Object>();
			String sql = "SELECT c.id,c.name,c.url,c.create_time,c.modify_time,c.params,c.begin_flag,c.end_flag,c.item_regex,c.id_regex,c.date_regex,c.date_pattern,c.column_id,c.period FROM "+ModulePrefixNamingStrategy.classToTableName(WebInfo.class)+
					" c GROUP BY c.id,c.name,c.url,c.create_time,c.modify_time,c.params,c.begin_flag,c.end_flag,c.item_regex,c.id_regex,c.date_regex,c.date_pattern,c.column_id,c.period";
			list = webContentDao.getObjectListBySql(sql);
			for(Object object : list){
				WebInfo webInfo = new WebInfo();
				Object[] objects = (Object[])object;
				Long wId = Long.parseLong(String.valueOf(objects[0]));
				String wName = String.valueOf(objects[1]);
				String wUrl = String.valueOf(objects[2]);
				Date cTime = DateUtil.parse(String.valueOf(objects[3]));
				Date mTime = DateUtil.parse(String.valueOf(objects[4]));
				String params = String.valueOf(objects[5]);
				String begin_flag = String.valueOf(objects[6]);
				String end_flag = String.valueOf(objects[7]);
				String item_regex = String.valueOf(objects[8]);
				String id_regex = String.valueOf(objects[9]);
				String date_regex = String.valueOf(objects[10]);
				String date_pattern = String.valueOf(objects[11]);
				Long columnId = Long.parseLong(String.valueOf(objects[12]));
				if(!String.valueOf(objects[13]).equals("null")){
				 double period = Double.parseDouble(String.valueOf(objects[13]));
				 webInfo.setPeriod(period);
				}
				webInfo.setId(wId);
				webInfo.setName(wName);
				webInfo.setUrl(wUrl);
				webInfo.setCreateTime(cTime);
				webInfo.setModifyTime(mTime);
				webInfo.setParams(params);
				webInfo.setBeginFlag(begin_flag);
				webInfo.setEndFlag(end_flag);
				webInfo.setItemRegex(item_regex);
				webInfo.setIdRegex(id_regex);
				webInfo.setDateRegex(date_regex);
				webInfo.setDatePattern(date_pattern);
				webInfo.setColumnId(columnId);
				webInfoList.add(webInfo);
			}
			return webInfoList;
		}catch (Exception e) {
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@Override
	public void updateWebInfoTime(WebInfo webInfo) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webContentDao.openSession();
			tr = session.beginTransaction();			
			webInfo.setModifyTime(new Date());
			session.merge(webInfo);
			tr.commit();
		}catch (Exception e) {
			tr.rollback();
		}finally{
			session.close();
		}	
	}

	@Override
	public Result doBackUp() {
		//NingBo.parseContent("http://gjgxq.ningbo.gov.cn/doc/zwgk/gxdt/2010_8_23/71303.shtml","<td  height=\"100\" class=\"cmain\" id=\"zoom\">","<table width=\"96%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">","http://gjgxq.ningbo.gov.cn");
		try {
		List<WebInfo> webInfoList = getWebInfoList();
		loot:for(WebInfo webInfo : webInfoList){
		    updateWebInfoTime(webInfo);
			String url = webInfo.getUrl();
			Map<String,String> params = new HashMap<String, String>();
			if(webInfo.getParams()!=null && webInfo.getParams().length()>0){
				String p  = webInfo.getParams().trim();
				for (String itemParams : p.split(",")) {
					for (int i=0;i<itemParams.split(":").length;i++) {
						params.put(itemParams.split(":")[0], itemParams.split(":")[1]);
					}
				}
			}
			String beginFlag = webInfo.getBeginFlag();
			String endFlag = webInfo.getEndFlag();
			String basePath = NingBo.getBasePath(url);
			String baseUrl = basePath.replace("http://www.", "") ;
			String[] urls = baseUrl.split("/") ;
			String hadeUrl = "http://www."+urls[0] ;
			String itemRegex = webInfo.getItemRegex();
			String idRegex = webInfo.getIdRegex();
			String dateRegex = webInfo.getDateRegex();
			String datePattern = webInfo.getDatePattern();
			
			List<WebDto> list = NingBo.fetch(url, params, beginFlag, endFlag, basePath, itemRegex, idRegex, dateRegex, datePattern);
			loop:for (WebDto dto : list) {
				String title = dto.getTitle().substring(0, 4);	
				//有的文章是以图片的形式作为标题,如果遇到这种情况,则不抓取这条新闻
				if(title.equals("<img")){
					continue loop;
				}				
				WebContent webContent = new WebContent();
				webContent.setWebInfoId(webInfo.getId());
				webContent.setWebInfo(webInfo);
				webContent.setContentId(dto.getId());
				//判断当前的路径是否是完整的路径
				int position = dto.getUrl().indexOf("http://");
				//如果是,则不用操作
				if(position >=0 )
					 webContent.setUrl(dto.getUrl());
				else
				webContent.setUrl(hadeUrl+"/"+dto.getUrl()); //如果不是,则给它加上完整的路径				
				webContent.setTitle(dto.getTitle());
				webContent.setReleaseDate(dto.getDate());
				webContent.setHear("No");
				
				/* add by jonathan 2015-01-25
				  同一站点， 如果出现重复标题，则不需要抓取
				 */
				
				save(webContent);
			}
		}
			return Result.success("抓取成功");
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure("抓取失败");
		}
	}

	@Override
	public Result getRowCount(Filter filter) {
		try{
			Integer counts = webContentDao.getRowCount(filter);
			return Result.value(counts);
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure("查询记录数失败");
		}
	}
}
