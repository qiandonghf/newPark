package com.wiiy.oa.action;

import java.util.Date;
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
import com.wiiy.oa.service.CardCategoryService;
import com.wiiy.oa.service.CardService;
import com.wiiy.oa.service.DocPublicService;
import com.wiiy.oa.service.DocShareService;
import com.wiiy.oa.service.DocumentService;

public class DocumentAction extends JqGridBaseAction<Document>{
	private DocumentService documentService;
	private DocShareService docShareService;
	private DocPublicService docPublicService;
	private CardCategoryService cardCategoryService;
	private CardService cardService;
	
	private List<Document> documentList;
	private Long id;
	private String ids;
	private Document document;
	private Result result;
	private String name;

	public String shareDoc(){
		documentList = documentService.getListByFilter(new Filter(Document.class).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.SHARED)).getValue();
		String shareToIds = documentService.getBeanById(id).getValue().getShareToIds();
		if(shareToIds!=null){
			for (Document document : documentList) {
				document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				document.setState(TreeEntity.STATE_CLOSED);
				if(shareToIds.contains(","+document.getId()+",")){
					document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' checked='checked' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				}
			}
		}else{
			for (Document document : documentList) {
				document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				document.setState(TreeEntity.STATE_CLOSED);
			}
		}
		documentList = TreeUtil.generateTree(documentList);
		return JSON;
	}
	
	public String publicDoc(){
		documentList = documentService.getListByFilter(new Filter(Document.class).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.PUBLIC)).getValue();
		String shareToIds = documentService.getBeanById(id).getValue().getShareToIds();
		if(shareToIds!=null){
			for (Document document : documentList) {
				document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				document.setState(TreeEntity.STATE_CLOSED);
				if(shareToIds.contains(","+document.getId()+",")){
					document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' checked='checked' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				}
			}
		}else{
			for (Document document : documentList) {
				document.setText("<input type='checkbox' class='documentChecked' value='"+document.getId()+"' style='display: inline-block;height: 18px; vertical-align: middle; width: 16px;'/>"+document.getName());
				document.setState(TreeEntity.STATE_CLOSED);
			}
		}
		documentList = TreeUtil.generateTree(documentList);
		return JSON;
	}
	
	public String shareIn(){
		Document document = documentService.getBeanById(id).getValue();
		if(document.getIsFolder().equals(BooleanEnum.YES)){
			List<Document> documents = documentService.getListByFilter(new Filter(Document.class).like("parentIds",","+id+",").eq("isFolder", BooleanEnum.NO)).getValue();
			if (documents.size() == 0) {
				result = Result.success("该文件夹下没有文档");
				return JSON;
			}
			for(Document doc : documents){
				if(document.getShareToIds()!=null){
					document.setShareToIds(document.getShareToIds()+ids);
				}else{
					document.setShareToIds(","+ids);
				}
				result = docShareService.share(doc);
			}
		}else{
			if(document.getShareToIds()!=null){
				document.setShareToIds(document.getShareToIds()+ids);
			}else{
				document.setShareToIds(","+ids);
			}
			result = docShareService.share(document);
		}
		/*if(result.isSuccess()){
			String[] receiverEmail = new String[]{};
			String[] content = new String[]{};
			UserPubService userPubService=OaActivator.getService(UserPubService.class);
			List<User> centerUserList = userPubService.getCenterUserList();
			int i=0,j=0;
			String subject = "鍐呴儴鍏变韩鎻愰啋";
			for (User user : centerUserList) {
				if(!user.getUsername().equals(OaActivator.getSessionUser().getUsername())){
					receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
					content = Arrays.copyOf(content, content.length+1);
					receiverEmail[i++] = user.getEmail();
					String docContent = OaActivator.getAppConfig().getConfig("docShareRemind").getParameter("in");
					docContent = docContent.replace("${customerName}",OaActivator.getSessionUser().getRealName());
					String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
					docContent = docContent.replace("${url}",path+"parkmanager.oa/web/document/document_index.jsp");
					content[j++] = docContent.replace("${document}",document.getName());
				}
			}
			sendMail(receiverEmail,content,subject);
		}*/
		return JSON;
	}

/*	public void sendMail(String[] receiverEmail,String[] content,String subject){
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}
	*/
	public String shareOut(){
		Document document = documentService.getBeanById(id).getValue();
		if(document.getIsFolder().equals(BooleanEnum.YES)){
			List<Document> documents = documentService.getListByFilter(new Filter(Document.class).like("parentIds",","+id+",").eq("isFolder", BooleanEnum.NO)).getValue();
			if (documents.size() == 0) {
				result = Result.success("该文件夹下没有文档");
				return JSON;
			}
			for(Document doc : documents){
				if(document.getShareToIds()!=null){
					document.setShareToIds(document.getShareToIds()+ids);
				}else{
					document.setShareToIds(","+ids);
				}
				result = docPublicService.share(doc);
			}
		}else{
			if(document.getShareToIds()!=null){
				document.setShareToIds(document.getShareToIds()+ids);
			}else{
				document.setShareToIds(","+ids);
			}
			result = docPublicService.share(document);
		}
		/*CardCategory cardCategory = cardCategoryService.getBeanByFilter(new Filter(CardCategory.class).eq("name", "瀹㈡埛")).getValue();
		if(cardCategory!=null){
			String[] receiverEmail = new String[]{};
			String[] content = new String[]{};
			List<CardCategory> cardCategorys = cardCategoryService.getListByFilter(new Filter(CardCategory.class).eq("parentId", cardCategory.getId())).getValue();
			for (CardCategory cardCategory2 : cardCategorys) {
				List<Card>  cards = cardService.getListByFilter(new Filter(Card.class).eq("categoryId", cardCategory2.getId())).getValue();
				for (Card card : cards) {
					if(card.getEmail()!=null && !card.getEmail().equals("")){
						if(receiverEmail.length==0 || receiverEmail[receiverEmail.length-1]!=null){
							receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
							content = Arrays.copyOf(content, content.length+1);
						}
						for(int j=0;j<receiverEmail.length;j++){
							if(receiverEmail[0] == null || !receiverEmail[receiverEmail.length-2].equals(card.getEmail())){
								receiverEmail[j] = card.getEmail();
								String docContent = OaActivator.getAppConfig().getConfig("docShareRemind").getParameter("out");
								docContent =  docContent.replace("${customerName}", OaActivator.getSessionUser().getRealName());
								docContent =  docContent.replace("${document}", document.getName());
								String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
								docContent = docContent.replace("${url}",path+"parkmanager.oa/web/document/public_document_index.jsp");
								content[j] = docContent;
							}
						}
					}
				}
			}
			String subject = "澶栭儴鍏变韩鎻愰啋";
			sendMail(receiverEmail,content,subject);
		}*/
		return JSON;
	}
	
	public String move(){
		result = documentService.getListByFilter(new Filter(Document.class).eq("ownerId", OaActivator.getSessionUser().getId()).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.PRIVATE).ne("id", id).not(Filter.Like("parentIds", ","+id+",")));
		return "move";
	}
	
	public String moveDoc(){
		result = documentService.moveTo(id,Long.valueOf(ids));
		return JSON;
	}
	
	public String addFolder(){
		result = documentService.getBeanById(id);
		return "addFolder";
	}
	
	public String save(){
		document.setPubed(BooleanEnum.NO);
		result = documentService.save(document);
		return JSON;
	}
	
	/**
	 * 发布操作
	 * @return
	 */
	public String publish() {
		document = documentService.getBeanById(id).getValue();
		result = documentService.publish(id, document.getIsFolder());
		return JSON;
	}
	
	/**
	 * 撤回操作
	 * @return
	 */
	public String back() {
		document = documentService.getBeanById(id).getValue();
		result = documentService.back(id, document.getIsFolder());
		return JSON;
	}
	
	
	public String saveFolder(){
		document.setPubed(BooleanEnum.NO);
		result = documentService.saveFolder(document);
		return JSON;
	}
	
	
	public String delete(){
		if(id!=null){
			result = documentService.deleteById(id);
		} else if(ids!=null){
			result = documentService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		document = documentService.getBeanById(id).getValue();
		if(document.getFileName()!=null&&document.getIsFolder().equals(BooleanEnum.NO)){
			name = document.getName().substring(0, document.getName().lastIndexOf("."));
			return EDIT;
		}
		return "editFolder";
	}
	
	public String update(){
		Document dbBean = documentService.getBeanById(document.getId()).getValue();
		document.setName(document.getName()+"."+dbBean.getFileExt());
		BeanUtil.copyProperties(document, dbBean);
		result = documentService.update(dbBean);
		return JSON;
	}
	
	public String updateFolder(){
		Document dbBean = documentService.getBeanById(document.getId()).getValue();
		BeanUtil.copyProperties(document, dbBean);
		result = documentService.updateFolder(dbBean);
		return JSON;
	}
	
	public String list(){
		documentList = documentService.getListByFilter(new Filter(Document.class).eq("ownerId", OaActivator.getSessionUser().getId()).eq("isFolder",BooleanEnum.YES).eq("docType", DocTypeEnum.PRIVATE)).getValue();
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
			filter.eq("parentId",id).orderBy("isFolder", Filter.DESC);
		}else{
			filter.eq("ownerId", OaActivator.getSessionUser().getId()).isNull("parentId").eq("docType", DocTypeEnum.PRIVATE).orderBy("isFolder", Filter.DESC);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<Document> getListByFilter(Filter fitler) {
		return documentService.getListByFilter(fitler).getValue();
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

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public void setDocumentService(DocumentService documentService) {
		this.documentService = documentService;
	}
	public void setDocShareService(DocShareService docShareService) {
		this.docShareService = docShareService;
	}
	
	public List<Document> getDocumentList() {
		return documentList;
	}
	public void setDocPublicService(DocPublicService docPublicService) {
		this.docPublicService = docPublicService;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public void setCardService(CardService cardService) {
		this.cardService = cardService;
	}
	public void setCardCategoryService(CardCategoryService cardCategoryService) {
		this.cardCategoryService = cardCategoryService;
	}
}
