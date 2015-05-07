package com.wiiy.core.action;

import java.io.UnsupportedEncodingException;

import com.wiiy.core.entity.NewsParam;
import com.wiiy.core.newsWebService.NewService;
import com.wiiy.core.newsWebService.NewsWebServiceImplService;
import com.wiiy.core.service.NewsParamService;
import com.wiiy.hibernate.Result;

public class NewsParamAction {
	private NewsParamService newsParamService;
	private String columnIds;
	private String webInfoIds;
	private NewsParam newsParam ;
	private String message ;
    private String news_str ;
	public String getNews_str() {
		return news_str;
	}

	public void setNews_str(String news_str) {
		this.news_str = news_str;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public NewsParam getNewsParam() {
		return newsParam;
	}

	public void setNewsParam(NewsParam newsParam) {
		this.newsParam = newsParam;
	}

	public String getColumnIds() {
		return columnIds;
	}

	public void setColumnIds(String columnIds) {
		this.columnIds = columnIds;
	}

	public String getWebInfoIds() {
		return webInfoIds;
	}

	public void setWebInfoIds(String webInfoIds) {
		this.webInfoIds = webInfoIds;
	}

	public void setNewsParamService(NewsParamService newsParamService) {
		this.newsParamService = newsParamService;
	}
	public String savaParmas(){
		//newsParam.setColumnId(columnIds);
		//newsParam.setWebInfoId(webInfoIds);
		Result result = null ;
		NewsParam newsParamDB = null ;
		if (newsParamService.getList()!= null) {
			newsParamDB = newsParamService.getList().getValue().get(0);
			newsParamDB.setColumnId(newsParam.getColumnId());
			newsParamDB.setWebInfoId(newsParam.getWebInfoId());
			result =newsParamService.update(newsParamDB);
		}else {
			result = newsParamService.save(newsParam);
		}
		if (result.isSuccess()) {
			message = "配置成功" ;
		}
		else 
			 message = "配置失败" ;
		return  "json" ;
	}
	public String newsList(){
		try {
			NewService service = new NewsWebServiceImplService().getNewsWebServiceImplPort();
			news_str = service.getNewList("0");
			System.out.println(news_str);
			//news_str = new String(news_str.getBytes(), "utf-8") ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		//NewsParam newsParamDB = newsParamService.getList().getValue().get(0);
		
		return "json" ;
	}
}
