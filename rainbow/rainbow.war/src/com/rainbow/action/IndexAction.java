package com.rainbow.action;

import java.util.List;

import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Document;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.DocumentService;
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

	private Result result;
	private Long id;
	private Article article;
	private ArticleType articleType;
	public ArticleType getArticleType() {
		return articleType;
	}


	public void setArticleType(ArticleType articleType) {
		this.articleType = articleType;
	}

	private String categoryName;
	private List<ArticleType> articleTypeList;
	private String url;
	private Pager pager;
	private List<Article> articleList;
	private DocumentService documentService;
	private List<Document> documentList;
	private int page;

	public int getPage() {
		return page;
	}


	public void setPage(int page) {
		this.page = page;
	}


	public List<Document> getDocumentList() {
		return documentList;
	}


	public void setDocumentList(List<Document> documentList) {
		this.documentList = documentList;
	}


	public List<Article> getArticleList() {
		return articleList;
	}


	public void setDocumentService(DocumentService documentService) {
		this.documentService = documentService;
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


	public String getCategoryName() {
		return categoryName;
	}


	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	
	public Result getResult() {
		return result;
	}


	public void setResult(Result result) {
		this.result = result;
	}
	

	//首页
	public String index(){
		
		if(null != categoryName ){
			categoryName = StringUtil.ISOToUTF8(categoryName);			
		}
		
		Filter filter = new Filter(Article.class);
		filter.eq("typeId", 11L);
		filter.eq("pubed", BooleanEnum.YES);
		filter.eq("kind", ArticleKindEnum.LIST);

		pager = new Pager(1,10);
		filter.orderBy("pubTime", "DESC");
		filter.pager(pager);
		articleList = articleService.getListByFilter(filter).getValue();
		
		return "success";
				
	}
	
	//查看文章
	public String content(){
		leftMenu();
		article = articleService.getBeanById(article.getId()).getValue();
		
		articleType = articleTypeService.getBeanById(article.getTypeId()).getValue();
		
		return "success";
		
	}
	
	public String list(){
		leftMenu();
		
		Filter filter = new Filter(Article.class);
		filter.eq("typeId", article.getTypeId());
		filter.eq("pubed", BooleanEnum.YES);
		filter.eq("kind", ArticleKindEnum.LIST);

		if (page <= 0 ){
			page=1;
		}
		pager = new Pager(page,10);
		filter.orderBy("pubTime", "DESC");
		filter.pager(pager);
		articleList = articleService.getListByFilter(filter).getValue();
		
		articleType = articleTypeService.getBeanById(article.getTypeId()).getValue();
		
		
		return "success";
	}
	
	public String listdoc(){
		leftMenu();
		Filter filter = new Filter(Document.class);
		filter.eq("isFolder", BooleanEnum.NO);
		if (page <= 0 ){
			page=1;
		}
		pager = new Pager(page,10);
		filter.orderBy("createTime", Filter.DESC);
		filter.pager(pager);
		
		documentList = documentService.getListByFilter(filter).getValue();
		
		return "success";
		
		
	}
	
	public String listcase(){
		leftMenu();
		return "success";
	}
	
	public String urlPackage( Long id ){
		
		ArticleType at = articleTypeService.getBeanById(id).getValue();
		if( null == at){
			return "false";
		}
		
		Filter filter = new Filter(Article.class).eq("typeId", id);
		if (at.getKind() == ArticleKindEnum.SINGLE){
			List<Article> aList = articleService.getListByFilter(filter).getValue();
			if( null != aList && aList.size() !=0){
				Article atc = (Article)aList.get(0);
				url = "content.action?article.id="+atc.getId().toString();
				url += "&categoryName="+categoryName;
			}
		}
		else if ( at.getKind() == ArticleKindEnum.LIST){
			url = "list.action?article.typeId="+id.toString();
			url += "&categoryName="+categoryName;
			
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
	
	public void leftMenu(){
		// 应用对象关联信息进行查询时，必须创建别名
		Filter filter = new Filter(ArticleType.class).createAlias("parentType", "parentType");
		categoryName = StringUtil.ISOToUTF8(categoryName);
		filter.match("parentType.typeName", categoryName, "eq");
		filter.match("display", BooleanEnum.YES, "eq");
		articleTypeList = articleTypeService.getListByFilter(filter).getValue();
	}
	
	
	


}
