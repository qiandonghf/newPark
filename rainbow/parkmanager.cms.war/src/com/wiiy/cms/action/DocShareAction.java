package com.wiiy.cms.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.entity.Document;
import com.wiiy.cms.preferences.enums.DocTypeEnum;
import com.wiiy.cms.service.DocShareService;

public class DocShareAction extends JqGridBaseAction<Document>{
	private DocShareService docShareService;
	private List<Document> documentList;

	private Long id;
	private Long parentDocId;
	private String ids;
	private Document docShare;
	private Result result;
	private String type;
	
	public String move(){
		result = docShareService.getListByFilter(new Filter(Document.class).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.SHARED).ne("id", id).not(Filter.Like("parentIds", ","+id+",")));
		return "move";
	}
	
	public String moveDoc(){
		result = docShareService.moveTo(id,Long.valueOf(ids));
		return JSON;
	}
	
	public String save(){
		result = docShareService.save(docShare);
		return JSON;
	}
	public String shareDel(){
		Boolean b=CmsActivator.getSessionUser().getAdmin().equals(BooleanEnum.YES);
		Boolean b2=id==CmsActivator.getSessionUser().getId();
		if(b || b2){
			result=docShareService.shareDel(id,parentDocId);
			if(result.isSuccess()){
				result = Result.success("文档取消共享成功");
			}else{
				result = Result.failure("文档取消共享失败");
			}
		}else{
			result = Result.failure("无权限取消");
		}
		return JSON;
	}
	public String addFolder(){
		result = docShareService.getBeanById(id);
		return "addFolder";
	}
	
	public String loadDocByParentId(){
		Filter filter = new Filter(Document.class);
		if(id!=null){
			filter.or(Filter.Eq("parentId",id),Filter.Like("shareToIds", ","+id+","));
			filter.orderBy("isFolder", Filter.DESC);
		}else{
			if(type!=null){
				if("business".equals(type)){//招商
					filter.eq("parentId", 1L);
				}else if("sale".equals(type)){//销售
					filter.eq("parentId", 2L);
				}else if("engineering".equals(type)){//工程
					filter.eq("parentId", 3L);
				}else if("synthesis".equals(type)){//办公
					filter.eq("parentId", 4L);
				}else if("bill".equals(type)){//财务
					filter.eq("parentId", 5L);
				}
			}else{
				filter.isNull("parentId");
			}
			filter.eq("docType", DocTypeEnum.SHARED).orderBy("isFolder", Filter.DESC);
		}
		return refresh(filter);
	}
	
	public String list(){
		documentList = docShareService.getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.SHARED).eq("isFolder",BooleanEnum.YES)).getValue();
		for (Document document : documentList) {
			document.setText(document.getName());
			document.setState(TreeEntity.STATE_CLOSED);
		}
		documentList = TreeUtil.generateTree(documentList);
		TreeUtil.printTree(documentList);
		
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = docShareService.deleteById(id);
		} else if(ids!=null){
			result = docShareService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = docShareService.getBeanById(id);
		return "editFolder";
	}
	
	public String update(){
		Document dbBean = docShareService.getBeanById(docShare.getId()).getValue();
		BeanUtil.copyProperties(docShare, dbBean);
		result = docShareService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<Document> getListByFilter(Filter fitler) {
		return docShareService.getListByFilter(fitler).getValue();
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
	public Document getDocShare() {
		return docShare;
	}

	public void setDocShare(Document docShare) {
		this.docShare = docShare;
	}

	public void setDocShareService(DocShareService docShareService) {
		this.docShareService = docShareService;
	}
	
	public List<Document> getDocumentList() {
		return documentList;
	}

	public Long getParentDocId() {
		return parentDocId;
	}

	public void setParentDocId(Long parentDocId) {
		this.parentDocId = parentDocId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
