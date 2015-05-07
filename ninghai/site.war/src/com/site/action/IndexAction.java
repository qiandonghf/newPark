package com.site.action;

import java.util.List;

import org.apache.http.HttpRequest;

import com.site.Activator;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.commons.action.BaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;



public class IndexAction {
	
	
	

	private ArticleService articleService;
	private ArticleTypeService articleTypeService;


	public void setArticleTypeService(ArticleTypeService articleTypeService) {
		this.articleTypeService = articleTypeService;
	}

	private Long id;

	private Article article;

	private ArticleType articleType;
	private ArticleType articleTypeSub;
	public ArticleType getArticleTypeSub() {
		return articleTypeSub;
	}


	public void setArticleTypeSub(ArticleType articleTypeSub) {
		this.articleTypeSub = articleTypeSub;
	}


	public ArticleType getArticleType() {
		return articleType;
	}


	public void setArticleType(ArticleType articleType) {
		this.articleType = articleType;
	}

	String tag;
	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}

	private List<ArticleType> articleTypeList;
	
	
	List<ArticleType> articleTypeListAboutUs;
	List<ArticleType> articleTypeListBase;
	List<ArticleType> articleTypeListInfo;
	List<ArticleType> articleTypeListPolicy;
	List<ArticleType> articleTypeListServ;
	
	public List<ArticleType> getArticleTypeListAboutUs() {
		return articleTypeListAboutUs;
	}


	public void setArticleTypeListAboutUs(List<ArticleType> articleTypeListAboutUs) {
		this.articleTypeListAboutUs = articleTypeListAboutUs;
	}


	public List<ArticleType> getArticleTypeListBase() {
		return articleTypeListBase;
	}


	public void setArticleTypeListBase(List<ArticleType> articleTypeListBase) {
		this.articleTypeListBase = articleTypeListBase;
	}


	public List<ArticleType> getArticleTypeListInfo() {
		return articleTypeListInfo;
	}


	public void setArticleTypeListInfo(List<ArticleType> articleTypeListInfo) {
		this.articleTypeListInfo = articleTypeListInfo;
	}


	public List<ArticleType> getArticleTypeListPolicy() {
		return articleTypeListPolicy;
	}


	public void setArticleTypeListPolicy(List<ArticleType> articleTypeListPolicy) {
		this.articleTypeListPolicy = articleTypeListPolicy;
	}


	public List<ArticleType> getArticleTypeListServ() {
		return articleTypeListServ;
	}


	public void setArticleTypeListServ(List<ArticleType> articleTypeListServ) {
		this.articleTypeListServ = articleTypeListServ;
	}


	
	
	private String url;
	private Pager pager;
	private List<Article> articleList;
	private int page;

	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
	}


	public List<Article> getArticleList() {
		return articleList;
	}


	public void setArticleList(List<Article> articleList) {
		this.articleList = articleList;
	}


	public Pager getPager() {
		return pager;
	}


	public void setPager(Pager pager) {
		this.pager = pager;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public List<ArticleType> getArticleTypeList() {
		return articleTypeList;
	}


	public void setArticleTypeList(List<ArticleType> articleTypeList) {
		this.articleTypeList = articleTypeList;
	}




	public Article getArticle() {
		return article;
	}


	public void setArticle(Article article) {
		this.article = article;
	}




	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
	

	

	//首页
	public String index(){

		genMainMenu();
		
		// 获取
		Long lTypeId  =  Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.info"));	
		Filter filter = new Filter(ArticleType.class);
		filter.like("parentIds", ","+lTypeId+",");
		List<ArticleType> atList = articleTypeService.getListByFilter(filter).getValue();
		
		Filter afilter = new Filter(Article.class);
		afilter.in("typeId", createArrayFromList(atList));
		afilter.eq("pubed", BooleanEnum.YES);
		afilter.eq("kind", ArticleKindEnum.LIST);
		afilter.eq("deleted",BooleanEnum.NO);
		pager = new Pager(1,3);
		afilter.orderBy("pubTime", "DESC");
		afilter.pager(pager);
		articleList = articleService.getListByFilter(afilter).getValue();
		return "success";
				
	}
	
	private Object[] createArrayFromList(List<ArticleType> list){
		Object[] obj = null;
		if (list != null) {
			obj = new Object[list.size()];
			for (int i = 0; i < obj.length; i++) {
				obj[i] = list.get(i).getId();
			}
		}
		return obj;
	}
	
	
	public String  view(){
		
		 genMainMenu();

		//另，当创业服务有两个字菜单时，显示得view页面样式会和其他的VIEW不一样，太奇怪，未解决
		article = articleService.getBeanById(article.getId()).getValue();
		
		// 根据tag生成右侧菜单
		if( tag.length() > 0 ){			
			Long lTypeId  =  Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter(tag));	
			// 获取栏目信息
			articleType = articleTypeService.getBeanById(lTypeId).getValue();
			// 获取子栏目信息
			Filter filter = new Filter(ArticleType.class);
			filter.match("parentId", lTypeId, "eq");
			filter.match("display", BooleanEnum.YES, "eq");
			articleTypeList = articleTypeService.getListByFilter(filter).getValue();
		}
		return "success";
	}
	
	
	public String list(){
		
		genMainMenu();
		
		
		Filter filter = new Filter(Article.class);
		filter.eq("typeId", article.getTypeId());
		filter.eq("pubed", BooleanEnum.YES);
		filter.eq("kind", ArticleKindEnum.LIST);
		filter.eq("deleted",BooleanEnum.NO);
		if (page <= 0 ){
			page=1;
		}
		pager = new Pager(page,5);
		filter.orderBy("pubTime", "DESC");
		filter.pager(pager);
		articleList = articleService.getListByFilter(filter).getValue();
				
		// 根据tag生成右侧菜单
		if( tag.length() > 0 ){			
			Long lTypeId  =  Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter(tag));	
			// 获取栏目信息
			articleType = articleTypeService.getBeanById(lTypeId).getValue();
			articleTypeSub = articleTypeService.getBeanById(article.getTypeId()).getValue();
			// 获取子栏目信息
			Filter afilter = new Filter(ArticleType.class);
			afilter.match("parentId", lTypeId, "eq");
			afilter.match("display", BooleanEnum.YES, "eq");
			articleTypeList = articleTypeService.getListByFilter(afilter).getValue();
		}
		
		return "success";
	}
	
	

	public String urlPackage( Long id, String stag){
		
		ArticleType at = articleTypeService.getBeanById(id).getValue();
		if( null == at){
			return "false";
		}
		
		Filter filter = new Filter(Article.class).eq("typeId", id);
		if (at.getKind() == ArticleKindEnum.SINGLE){
			List<Article> aList = articleService.getListByFilter(filter).getValue();
			if( null != aList && aList.size() !=0){
				Article atc = (Article)aList.get(0);
				url = "view.action?article.id="+atc.getId().toString();
				url += "&tag="+stag;
			}
		}
		else if ( at.getKind() == ArticleKindEnum.LIST){
			url = "list.action?article.typeId="+id.toString();
			url += "&tag="+stag;
			
		}
		else if  (at.getKind() == ArticleKindEnum.CUSTOM){
			url= "#";
			
		}
		else if(at.getKind() == ArticleKindEnum.TOPIC){
			url= "#";
		}
		else{
			url = "undefined";
		}
		
		return url;
		
		
	}
	
	
	public void genMainMenu(){
		
		// aboutus		
		Filter filter = new Filter(ArticleType.class);
		filter.match("parentId", Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.aboutus")), "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeListAboutUs = articleTypeService.getListByFilter(filter).getValue();
		
		// base
		filter.clear();
		filter.match("parentId", Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.base")), "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeListBase = articleTypeService.getListByFilter(filter).getValue();
		
		// policy
		filter.clear();
		filter.match("parentId", Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.policy")), "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeListPolicy = articleTypeService.getListByFilter(filter).getValue();
		
		// services
		filter.clear();
		filter.match("parentId", Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.serv")), "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeListServ = articleTypeService.getListByFilter(filter).getValue();
		
		// info
		filter.clear();
		filter.match("parentId", Long.parseLong(Activator.getAppConfig().getConfig("menu").getParameter("menu.info")), "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeListInfo = articleTypeService.getListByFilter(filter).getValue();


	}
	
	
	


}
