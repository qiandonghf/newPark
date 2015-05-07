package com.wiiy.cms.action;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dto.WebInfoDto;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.WebInfoConfig;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.preferences.enums.NewsTypeEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.ParamService;
import com.wiiy.cms.service.WebInfoConfigService;
import com.wiiy.cms.util.CmsUtil;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.core.service.export.Page;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

public class ArticleAction extends JqGridBaseAction<Article>{
	private ArticleService articleService;
	private ArticleTypeService articleTypeService;
	private WebInfoConfigService webInfoConfigService;
	private ParamService paramService;
	private Article article;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Long id;
	private Long typeId;
	private String ids;
	private String rootPath;
	private ArticleKindEnum kind;
	private String filePath;
	private String attsPath;
	private String fileName;
	private InputStream inputStream;
	private List<ArticleType> articleTypeList;
	private ArticleAtt articleAtt;
	private Long paramId;
	private Param param;
	private String searchContent;
	
	private Integer articleCounts;
	private Pager pager;
	private Integer showRows = 5;
	
	private Article photoArticle;
	

	public ArticleAtt getArticleAtt() {
		return articleAtt;
	}

	public void setArticleAtt(ArticleAtt articleAtt) {
		this.articleAtt = articleAtt;
	}

	private List<Article> articleList;
	
	public ArticleAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
		
	}
	
	/**
	 * 加载当前用户能访问的网站
	 * @return
	 */
	public String webList() {
		Filter f = new Filter(Param.class);
		User user = CmsActivator.getSessionUser();
		if (user.getAdmin() != BooleanEnum.YES) {
			f.like("managerIds", ","+user.getId()+",");
		}
		List<Param> params = paramService.getListByFilter(f).getValue();
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("params", params);
		return "web";
	}
	
	//工作台通知公告总页数
	public String insideWebArticleCounts(){
		Filter filter = new Filter(Article.class).eq("paramId", 2L).eq("typeId", 2L).eq("pubed", BooleanEnum.YES).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO);
		result = articleService.getRowCount(filter);
		if(result.isSuccess()){
			articleCounts = (Integer)result.getValue();
		}else{
			articleCounts = 0;
		}
		if(page!=0){
			pager = new Pager(page,showRows);
		} else {
			pager = new Pager(1,showRows);
		}
		pager.setRecords(articleCounts);
		return JSON;
	}
	
	//工作台通知公告
	public String insideWebArticleList(){
		Filter filter = new Filter(Article.class).eq("paramId", 2L).eq("typeId", 2L).eq("pubed", BooleanEnum.YES).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO);
		if(page!=0){
			pager = new Pager(page,showRows);
		} else {
			pager = new Pager(1,showRows);
		}
		filter.pager(pager);
		articleList = articleService.getListByFilter(filter).getValue();
		return JSON;
	}
	
	//工作台园区资讯总页数
	public String parkInformationPages(){
		Filter filter = new Filter(Article.class).eq("paramId", 1L).eq("typeId", 3L).eq("pubed", BooleanEnum.YES).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO);
		result = articleService.getRowCount(filter);
		if(result.isSuccess()){
			articleCounts = (Integer)result.getValue();
		}else{
			articleCounts = 0;
		}
		if(page!=0){
			pager = new Pager(page,6);
		} else {
			pager = new Pager(1,6);
		}
		pager.setRecords(articleCounts);
		return JSON;
	}
	
	//工作台园区资讯
	public String parkInformations(){
		Filter filter = new Filter(Article.class).eq("paramId", 1L).eq("typeId", 3L).eq("pubed", BooleanEnum.YES).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO);
		if(page!=0){
			pager = new Pager(page,6);
		} else {
			pager = new Pager(1,6);
		}
		filter.pager(pager);
		String[] names = {"id","title","newsType","photo","pubed","pubTime","source","toped"};
		filter.include(names);
		articleList = articleService.getListByFilter(filter).getValue();
		filter = new Filter(Article.class).eq("paramId", 1L).eq("typeId", 3L).eq("newsType", NewsTypeEnum.PHOTO).eq("pubed", BooleanEnum.YES).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO);
		filter.include(names);
		filter.maxResults(1);
		List<Article> list = articleService.getListByFilter(filter).getValue();
		if(list!=null && list.size()>0){
			photoArticle = list.get(0);
		}
		return JSON;
	}
	
	//工作台内部公告
	public String insideArticleList(){
		articleList = articleService.getListByFilter(new Filter(Article.class).maxResults(6).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO)).getValue();
		return "insideArticleList";
	}
	
	public String listByNormal(){
		//查询所有网站
		User user = CmsActivator.getSessionUser();
		Filter filter = new Filter(ArticleType.class);
		if(BooleanEnum.NO == user.getAdmin()){
			Filter f = new Filter(Param.class);
			f.eq("id", paramId);
			f.like("managerIds", ","+user.getId()+",");
			param = paramService.getBeanByFilter(f).getValue();
			/**
			 * 当前登录帐号的用户没有网站管理的权限
			 * 取出该账号有管理权限的所有栏目
			 */
			if (param == null) {
				filter.like("managerIds", ","+user.getId()+",");
			}
		}
		if (paramId != null) {
			filter.eq("paramId", paramId);
		}
		articleTypeList = articleTypeService.getListByFilter(filter).getValue();
		filter = new Filter(Article.class);
		filter.eq("deleted",BooleanEnum.NO);
		filter.like("contentText", searchContent);
		filter.in("typeId", createArrayFromList(articleTypeList));
		filter.orderBy("pubTime", Filter.DESC);
		filter.orderBy("createTime", Filter.DESC);
		if (kind != null) {
			filter.eq("kind", kind);
		}
		filter.createAlias("articleType", "articleType");
		String[] names={"id","articleType.typeName","typeId","paramId","title","hits","pubTime","pubed","editor","modifyTime","record"};
		filter.include(names);
		return refresh(filter);
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
	
	/**
	 * 根据文章类型的id来加载数据
	 * @return
	 */
	public String loadByTypeId() {
		User user = CmsActivator.getSessionUser();
		String userId = ","+user.getId()+",";
		Filter f = new Filter(ArticleType.class);
		if(BooleanEnum.NO == user.getAdmin()){
			f.eq("id", typeId);
			f.like("managerIds", userId);
			//f.like("parentIds", ","+typeId+",");
			ArticleType type = articleTypeService.getBeanByFilter(f).getValue();
			if (type == null) {
				type = articleTypeService.getBeanById(typeId).getValue();
				param = paramService.getBeanById(type.getParamId()).getValue();
				if (param.getManagerIds().indexOf(userId) == -1) {
					return JSON;
				}
			}
		}
		f = new Filter(ArticleType.class);
		f.or(Filter.Eq("id", typeId),Filter.Like("parentIds", ","+typeId+","));
		if (kind != null) {
			f.eq("kind", kind);
		}
		articleTypeList = new ArrayList<ArticleType>();
		articleTypeList.addAll(articleTypeService.getListByFilter(f).getValue());
		
		Filter filter = new Filter(Article.class);
		filter.eq("deleted",BooleanEnum.NO);
		filter.in("typeId", createArrayFromList(articleTypeList));
		if (kind != null) {
			filter.eq("kind", kind);
		}
		filter.createAlias("articleType", "articleType");
		String[] names={"id","articleType.typeName","typeId","paramId","title","hits","pubTime","pubed","editor","modifyTime","record"};
		filter.include(names);
		return refresh(filter);
	}
	
	/**
	 * 获取专题列表
	 * @return
	 */
	public String listByTopic(){
		Filter filter = new Filter(Article.class);
		filter.eq("kind", ArticleKindEnum.TOPIC).eq("deleted",BooleanEnum.NO);
		filter.createAlias("articleType", "articleType");
		String[] names={"id","articleType.typeName","typeId","paramId","title","hits","pubTime","pubed","editor","modifyTime","record"};
		filter.include(names);
		refresh(filter);
		String userId = ","+CmsActivator.getSessionUser().getId()+",";
		if (root != null && root.size() > 0) {
			for (int i = 0; i < root.size(); i++){
				ArticleType type = root.get(i).getArticleType();
				if(type.getManagerIds() != null){
					int index = type.getManagerIds().indexOf(userId);
					if(index < 0){
						root.remove(i);
						total -= 1;
					}
				}else{
					root.remove(i);
					total -= 1;
				}
			}
		}
		return JSON;
	}
	
	/**
	 * 文章发布操作
	 * @return
	 */
	public String publish() {
		article = articleService.getBeanById(id).getValue();
		article.setPubed(BooleanEnum.YES);
		if (article.getPubTime() == null) {
			article.setPubTime(new Date());
		}
		article.setEditor(CmsActivator.getSessionUser().getRealName());
		result = articleService.update(article);
		if(result.isSuccess()){
			result = Result.success("发布成功");
		}else{
			result = Result.failure("发布失败");
		}
		return JSON;
	}
	
	/**
	 * 文章撤回操作
	 * @return
	 */
	public String back() {
		article = articleService.getBeanById(id).getValue();
		article.setPubed(BooleanEnum.NO);
		article.setEditor(null);
		result = articleService.update(article);
		if(result.isSuccess()){
			result = Result.success("撤回成功");
		}else{
			result = Result.failure("撤回失败");
		}
		return JSON;
	}
	
	/**
	 * 文章回收站
	 * @return
	 */
	public String recycler(){
		if(id != null){
			Filter filter = new Filter(Article.class);
			filter.eq("paramId", id);
			filter.eq("deleted",BooleanEnum.YES);
			filter.createAlias("articleType", "articleType");
			String[] names={"id","articleType.typeName","typeId","paramId","title","hits","pubTime","pubed","editor","modifyTime","record"};
			filter.include(names);
			refresh(filter);
		}
		return JSON;
	}
	
	/**
	 * 根据文件路径删除上传时的文件
	 * @return
	 */
	public String deleteByFilePath(){
		if(filePath!=null){
			File file = new File(rootPath + filePath);
			if (file.exists()) {
				file.delete();
			}
			result = Result.success("文件删除成功");
		}
		return JSON;
	}
	
	/**
	 * 根据文件名导出文件
	 * @return
	 */
	public String export() {
		filePath = rootPath + filePath;
		File file = new File(filePath);
		if (file.exists()) {
			byte buffer[] = new byte[(int) file.length()];
			try {
				BufferedInputStream input = new BufferedInputStream(
						new FileInputStream(filePath));
				input.read(buffer, 0, buffer.length);
				input.close();
				System.out.println("Info:文件读取成功!");
				inputStream = new ByteArrayInputStream(buffer);
			} catch (FileNotFoundException e) {
				System.out.println("Info: 文件不存在!");
				e.printStackTrace();
			} catch (IOException e) {
				System.out.println("Info: 文件读取失败!");
				e.printStackTrace();
			}
		}
		return "export";
	}
	
	/**
	 * 保存专题
	 * @return
	 */
	public String topicSave() {
		List<ArticleAtt> attList = backListFromJSON(filePath);
		if(article.getToped()==null)article.setToped(BooleanEnum.NO);
		if(article.getRecommend()==null)article.setRecommend(BooleanEnum.NO);
		if(article.getBold()==null)article.setBold(BooleanEnum.NO);
		if(article.getPubed() == null)article.setPubed(BooleanEnum.NO);
		if(article.getTypeId()!=null){
			ArticleType articleType = articleTypeService.getBeanById(article.getTypeId()).getValue();
			article.setArticleType(articleType);
		}
		article.setHits(0);
		result = articleService.save(article,attList);
		return JSON;
	}
	
	/**
	 * 解析从js中发回的JSON格式的数据
	 * @param json
	 * @return
	 */
	private List<ArticleAtt> backListFromJSON(Object json) {
		JSONArray jsonArray = JSONArray.fromObject(json);
		List<ArticleAtt> att = new ArrayList<ArticleAtt>();
		if (jsonArray.size() > 0) {
			for (int i = 0; i <jsonArray.size(); i++) {
				JSONObject o = jsonArray.getJSONObject(i);
				String oldName = o.getString("fileName");
				try {
					oldName = URLDecoder.decode(oldName, "utf-8");
					oldName = URLDecoder.decode(oldName, "utf-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				ArticleAtt a = new ArticleAtt();
				a.setOldName(oldName);
				a.setNewName(o.getString("filePath"));
				att.add(a);
			}
		}
		return att;
	}
	
	@SuppressWarnings("unchecked")
	public String treeList(){
		articleTypeList = articleTypeService.getListByFilter(new Filter(ArticleType.class)).getValue();
		for(ArticleType at : articleTypeList){
			at.setState(TreeEntity.STATE_CLOSED);
			at.setText(at.getTypeName());
		}
		articleTypeList = TreeUtil.generateTree(articleTypeList);
		return JSON;
	}
	
	public String save(){
		List<ArticleAtt> attList = backListFromJSON(attsPath);
		if(article.getToped()==null)article.setToped(BooleanEnum.NO);
		if(article.getRecommend()==null)article.setRecommend(BooleanEnum.NO);
		if(article.getBold()==null)article.setBold(BooleanEnum.NO);
		if(article.getPubed() == null)article.setPubed(BooleanEnum.NO);
		article.setParam(param);
		article.setParamId(param.getId());
		article.setHits(0);
		if (article.getNewsType() == NewsTypeEnum.WORDS) {
			article.setNewsType(null);
		}
		if (filePath != null && !"".equals(filePath.trim())) {
			article.setPhoto(filePath);
		}else {
			article.setPhoto(null);
		}
		if(article.getTypeId()!=null){
			ArticleType articleType = articleTypeService.getBeanById(article.getTypeId()).getValue();
			article.setArticleType(articleType);
			article.setKind(articleType.getKind());
		}
		result = articleService.save(article,attList);
		if(result.isSuccess()){
			//CmsActivator.getService(LuceneService.class).createIndex("article"+article.getId(), article.getTitle(), article.getContentText(), "parkmanager.cms/article!view.action?id="+article.getId());
			SysEmailSenderPubService sysEmailSenderPubService = CmsActivator.getService(SysEmailSenderPubService.class);
			if(sysEmailSenderPubService!=null){
				UserPubService userPubService=CmsActivator.getService(UserPubService.class);
				List<User> centerUserList = userPubService.getCenterUserList();
				int i=0,j=0;
				String[] receiverEmail = new String[]{};
				String[] content = new String[]{};
				String subject = "新文章发布提醒";
				for (User user : centerUserList) {
					if(!user.getUsername().equals(CmsActivator.getSessionUser().getUsername())){
						receiverEmail = Arrays.copyOf(receiverEmail, receiverEmail.length+1);
						content = Arrays.copyOf(content, content.length+1);
						receiverEmail[i++] = user.getEmail();
						String docContent = CmsActivator.getAppConfig().getConfig("articleReleaseRemind").getParameter("email");
						docContent = docContent.replace("${customerName}",CmsActivator.getSessionUser().getRealName());
						String path = ServletActionContext.getRequest().getScheme()+"://"+ServletActionContext.getRequest().getServerName()+":"+ServletActionContext.getRequest().getServerPort()+"/";
						String url = path+"parkmanager.cms/article!view.action?id="+article.getId();
						docContent.replace("${url}", url);
						content[j++] = docContent.replace("${articleTitle}",article.getTitle());
					}
				}
				sendMail(sysEmailSenderPubService,receiverEmail,content,subject);
			}
		}
		return JSON;
	}
	
	public void sendMail(SysEmailSenderPubService sysEmailSenderPubService,String[] receiverEmail,String[] content,String subject){
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}
	
	public String recycle(){
		if(id!=null){
			result = articleService.recycleById(id);
		}
		if(ids!=null){
			result = articleService.recycleByIds(ids);
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = articleService.deleteById(id);
		}
		if(ids!=null){
			result = articleService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		article = articleService.getBeanById(id).getValue();
		id = article.getParamId();
		if (id != null) {
			param = paramService.getBeanById(id).getValue();
			article.setParam(param);
		}
		result = Result.value(article);
		return EDIT;
	}
	
	/**
	 * 专题编辑
	 */
	public String topicEdit() {
		result = articleService.getBeanById(id);
		article = (Article) result.getValue();
		param = paramService.getBeanById(article.getParamId()).getValue();
		article.setParam(param);
		Set<ArticleAtt> set = article.getArticleAtts();
		Iterator<ArticleAtt> it = set.iterator();
		if (it.hasNext()) {
			articleAtt = it.next();
		}
		return "topicEdit";
	}
	
	public String update(){
		List<ArticleAtt> attList = backListFromJSON(attsPath);
		Article dbean = articleService.getBeanById(article.getId()).getValue();
		BeanUtil.copyProperties(article,dbean);
		if(article.getPubed() == null)article.setPubed(BooleanEnum.NO);
		if(dbean.getTypeId()!=null){
			ArticleType articleType = articleTypeService.getBeanById(dbean.getTypeId()).getValue();
			dbean.setArticleType(articleType);
			dbean.setKind(articleType.getKind());
			if(article.getToped()==null)dbean.setToped(BooleanEnum.NO);
			if(article.getRecommend()==null)dbean.setRecommend(BooleanEnum.NO);
			if(article.getBold()==null)dbean.setBold(BooleanEnum.NO);
		}
		if (param != null && param.getId() != null) {
			dbean.setParamId(param.getId());
		}
		if (article.getNewsType() == NewsTypeEnum.WORDS) {
			dbean.setNewsType(null);
		}
		if (filePath != null && !"".equals(filePath.trim())) {
			dbean.setPhoto(filePath);
		}else {
			dbean.setPhoto(null);
		}
		result = articleService.update(dbean,attList);
		//CmsActivator.getService(LuceneService.class).updateIndex("article"+dbean.getId(), dbean.getTitle(), dbean.getContentText(), "parkmanager.cms/article!view.action?id="+dbean.getId());
		return JSON;
	}
	
	/**
	 * 专题更新
	 * @return
	 */
	public String topicUpdate(){
		Article dbean = articleService.getBeanById(article.getId()).getValue();
		BeanUtil.copyProperties(article,dbean);
		if(dbean.getTypeId()!=null){
			ArticleType articleType = articleTypeService.getBeanById(dbean.getTypeId()).getValue();
			dbean.setArticleType(articleType);
			dbean.setKind(articleType.getKind());
		}
		if (filePath.trim().length() > 0 && filePath.endsWith("-d")) {
			//删除
			filePath = filePath.substring(0, filePath.length()-3);
			deleteByFilePath();
			if (result.isSuccess()) {
				articleService.deleteAttById(articleAtt.getId());
				dbean.setArticleAtts(null);
			}
		}else {
			dbean.getArticleAtts().clear();
			articleAtt.setCreateTime(new Date());
			articleAtt.setCreator(CmsActivator.getSessionUser().getRealName());
			articleAtt.setCreatorId(CmsActivator.getSessionUser().getId());
			articleAtt.setModifyTime(new Date());
			articleAtt.setModifier(CmsActivator.getSessionUser().getRealName());
			articleAtt.setModifierId(CmsActivator.getSessionUser().getId());
			dbean.getArticleAtts().add(articleAtt);
		}
		result = articleService.update(dbean);
		return JSON;
	}
	
	//查看文章,并增加点击次数
	public String view(){
		article = articleService.getBeanById(id).getValue();
		paramId = article.getParamId();
		if (paramId != null) {
			param = paramService.getBeanById(paramId).getValue();
			article.setParam(param);
		}
		result = Result.value(article);
		return VIEW;
	}
	
	public String topicView() {
		result = articleService.view(id);
		return "topicView";
	}
	
	//文章还原
	public String restore(){
		if(id!=null){
			result = articleService.restoreById(id);
		}
		if(ids!=null){
			result = articleService.restoreByIds(ids);
		}
		return JSON;
	}
	
	public String listAll(){
		articleList = articleService.getListByFilter(new Filter(Article.class).maxResults(20).orderBy("modifyTime", Filter.DESC).eq("deleted", BooleanEnum.NO)).getValue();
		//WebContentPubService webContentPubService =CmsActivator.getService(WebContentPubService.class);
		//webContent = webContentPubService.getImageNews();
		
		WebInfoConfig wf = webInfoConfigService.getBeanByFilter(new Filter(WebInfoConfig.class).eq("userId", CmsActivator.getSessionUser().getId()).notNull("webInfoIds")).getValue();
		if(wf!=null){
			String ids = wf.getWebInfoIds();
			List<WebInfoDto> list = new ArrayList<WebInfoDto>();
			Config config = CmsActivator.getAppConfig().getConfig("newsURL");
			String newsURL = config.getParameter("name");
			if(ids.split(",").length>1){
				for(String sid : ids.split(",")){
					Long id = Long.parseLong(sid);
					WebInfoDto wi = CmsUtil.getInfoByURL(newsURL+id);
					list.add(wi);
				}
			}else if(ids.split(",").length==1){
				Long id = Long.parseLong(ids);
				WebInfoDto wi = CmsUtil.getInfoByURL(newsURL+id);
				list.add(wi);
			}
			ServletActionContext.getRequest().setAttribute("list", list);
		}
		return "listAll";
	}
	
	public String deskTopView(){
		result = articleService.view(id);;
		return "deskTopView";
	}
	
	@Override
	protected List<Article> getListByFilter(Filter filter) {
		return articleService.getListByFilter(filter).getValue();
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

	public Long getTypeId() {
		return typeId;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setTypeId(Long typeId) {
		this.typeId = typeId;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}

	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}

	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	public ArticleKindEnum getKind() {
		return kind;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public void setKind(ArticleKindEnum kind) {
		this.kind = kind;
	}

	public void setArticleTypeService(ArticleTypeService articleTypeService) {
		this.articleTypeService = articleTypeService;
	}

	public List<ArticleType> getArticleTypeList() {
		return articleTypeList;
	}

	public void setArticleTypeList(List<ArticleType> articleTypeList) {
		this.articleTypeList = articleTypeList;
	}

	public List<Article> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<Article> articleList) {
		this.articleList = articleList;
	}

	public void setWebInfoConfigService(WebInfoConfigService webInfoConfigService) {
		this.webInfoConfigService = webInfoConfigService;
	}

	public Long getParamId() {
		return paramId;
	}

	public void setParamId(Long paramId) {
		this.paramId = paramId;
	}

	public Param getParam() {
		return param;
	}

	public void setParam(Param param) {
		this.param = param;
	}

	public String getAttsPath() {
		return attsPath;
	}

	public void setAttsPath(String attsPath) {
		this.attsPath = attsPath;
	}

	public String getSearchContent() {
		return searchContent;
	}

	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}
	public Integer getArticleCounts() {
		return articleCounts;
	}

	public void setArticleCounts(Integer articleCounts) {
		this.articleCounts = articleCounts;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public Article getPhotoArticle() {
		return photoArticle;
	}

	public void setPhotoArticle(Article photoArticle) {
		this.photoArticle = photoArticle;
	}
}
