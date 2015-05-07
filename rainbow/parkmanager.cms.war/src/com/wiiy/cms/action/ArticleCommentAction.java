package com.wiiy.cms.action;

import java.util.List;
import com.wiiy.cms.entity.ArticleComment;
import com.wiiy.cms.service.ArticleCommentService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ArticleCommentAction extends JqGridBaseAction<ArticleComment>{
	private ArticleCommentService articleCommentService;
	private ArticleComment articleComment;
	private Long id;
	private String ids;
	private Result result;
	
	public String list(){
		Filter filter = new Filter(ArticleComment.class);		
		return refresh(filter);
	}
	
	public String save(){
		result = articleCommentService.save(articleComment);
		return JSON;
	}
	
	public String edit(){
		result = articleCommentService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = articleCommentService.deleteById(id);
		}else if(ids!=null){
			result = articleCommentService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		ArticleComment dbBean = articleCommentService.getBeanById(articleComment.getId()).getValue();
		BeanUtil.copyProperties(articleComment, dbBean);
		result = articleCommentService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<ArticleComment> getListByFilter(Filter fitler) {
		return articleCommentService.getListByFilter(fitler).getValue();
	}

	public ArticleComment getArticleComment() {
		return articleComment;
	}
	public void setArticleComment(ArticleComment articleComment) {
		this.articleComment = articleComment;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public void setArticleCommentService(ArticleCommentService articleCommentService) {
		this.articleCommentService = articleCommentService;
	}

}
