package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Document;
import com.wiiy.oa.preferences.enums.DocTypeEnum;
import com.wiiy.oa.service.DocPublicService;

public class DocPublicAction extends JqGridBaseAction<Document>{
	private DocPublicService docPublicService;
	private List<Document> documentList;

	private Long id;
	private Long parentDocId;
	private String ids;
	private Document docPublic;
	private Result result;
	
	private int size;

	public String publicDel(){
		Boolean b=OaActivator.getSessionUser().getAdmin().equals(BooleanEnum.YES);
		Boolean b2=id==OaActivator.getSessionUser().getId();
		if(b || b2){
			result=docPublicService.publicDel(id,parentDocId);
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
	public String LoadServiceListByFolderId(){
		documentList = new ArrayList<Document>();
		listByParentId(documentList,id);
		size = documentList.size()-1;
		return "LoadServiceListByFolderId";
	}
	
	public List<Document> listByParentId(List<Document> documentList,Long id){
		Document document = docPublicService.getBeanById(id).getValue();
		if(document.getParentId()==null){
			documentList.add(document);
		}else{
			listByParentId(documentList,document.getParentId());
			documentList.add(document);
		}
		return documentList;
	}
	
	public String move(){
		result = docPublicService.getListByFilter(new Filter(Document.class).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.PUBLIC).not(Filter.Like("parentIds", ","+id+",")).ne("id", id));
		return "move";
	}
	
	public String moveDoc(){
		result = docPublicService.moveTo(id,Long.valueOf(ids));
		return JSON;
	}
	
	public String save(){
		docPublic.setPubed(BooleanEnum.NO);
		result = docPublicService.save(docPublic);
		return JSON;
	}
	
	public String addFolder(){
		result = docPublicService.getBeanById(id);
		return "addFolder";
	}
	
	public String list(){
		documentList = docPublicService.getListByFilter(new Filter(Document.class).eq("docType", DocTypeEnum.PUBLIC).eq("isFolder",BooleanEnum.YES)).getValue();
		for (Document document : documentList) {
			document.setText(document.getName());
			document.setState(TreeEntity.STATE_CLOSED);
		}
		documentList = TreeUtil.generateTree(documentList);
		TreeUtil.printTree(documentList);
		return JSON;
	}
	
	public String loadDocByParentId(){
		Filter filter = new Filter(Document.class);
		if(id!=null){
			filter.or(Filter.Eq("parentId",id),Filter.Like("shareToIds", ","+id+","));
			filter.orderBy("isFolder", Filter.DESC);
		}else{
			filter.isNull("parentId").eq("docType", DocTypeEnum.PUBLIC).orderBy("isFolder", Filter.DESC);
		}
		return refresh(filter);
	}
	
	public String delete(){
		if(id!=null){
			result = docPublicService.deleteById(id);
		} else if(ids!=null){
			result = docPublicService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = docPublicService.getBeanById(id);
		return "editFolder";
	}
	
	public String update(){
		Document dbBean = docPublicService.getBeanById(docPublic.getId()).getValue();
		BeanUtil.copyProperties(docPublic, dbBean);
		result = docPublicService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<Document> getListByFilter(Filter fitler) {
		return docPublicService.getListByFilter(fitler).getValue();
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

	public void setdocPublicService(DocPublicService docPublicService) {
		this.docPublicService = docPublicService;
	}
	
	public List<Document> getDocumentList() {
		return documentList;
	}
	public Document getDocPublic() {
		return docPublic;
	}

	public void setDocPublic(Document docPublic) {
		this.docPublic = docPublic;
	}
	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public Long getParentDocId() {
		return parentDocId;
	}

	public void setParentDocId(Long parentDocId) {
		this.parentDocId = parentDocId;
	}
	
}
