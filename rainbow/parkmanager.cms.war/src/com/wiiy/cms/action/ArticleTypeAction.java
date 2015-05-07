package com.wiiy.cms.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dto.CatalogDto;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.ParamService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ArticleTypeAction extends JqGridBaseAction<ArticleType>{
	private ArticleTypeService articleTypeService;
	private ParamService paramService;
	private ArticleService articleService;
	
	private List<Param> params;
	private ArticleType articleType;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Long paramId;
	private Param param;
	
	private Long id;
	private String ids;
	private List<ArticleType> articleTypeList;
	private String memo = "";
	private ArticleKindEnum articleKind;
	private List<CatalogDto> catalogDtoList;
	private List<DataDict> displayPositions;

	
	
	public String add() {
		displayPositions = new ArrayList<DataDict>();
		if (paramId != null) {
			param = paramService.getBeanById(paramId).getValue();
			String tempId = param.getTempleteId();
			if (tempId != null) {
				List<DataDict> list = CmsActivator.
						getDataDictInitService().getDataDictByParentId(tempId);
				displayPositions = new ArrayList<DataDict>();
				for (DataDict dataDict : list) {
					if ("ARTICLE".equals(dataDict.getDataName())){ 
						displayPositions.add(dataDict);
					}
				}
			}
		}
		return "add";
	}
	
	
	
	@SuppressWarnings("unchecked")
	public String treeList(){
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
		filter.eq("paramId", paramId);
		if (articleKind != null) {
			if ("article".equals(memo)) {
				filter.eq("kind", articleKind);
			}else {
				filter.ne("kind", ArticleKindEnum.SINGLE);
			}
		}
		articleTypeList = articleTypeService.getListByFilter(filter).getValue();
		for(ArticleType at : articleTypeList){
			at.setState(TreeEntity.STATE_CLOSED);
			at.setText(at.getTypeName());
			at.setLevel(at.getLevel());
		}
		articleTypeList = TreeUtil.generateTree(articleTypeList);
		mySort(articleTypeList);
		return JSON;
	}
	
	
	@SuppressWarnings("unchecked")
	public void mySort(List<ArticleType> list) {
		if (list == null) {
			return;
		}
		Collections.sort(list, new Comparator<ArticleType>(){
			@Override
			public int compare(ArticleType o1, ArticleType o2) {
				if(o1.getDisplayOrder()==null)return -1;
				if(o2.getDisplayOrder()==null)return 1;
				return o1.getDisplayOrder()-o2.getDisplayOrder();
			}
		});
		
		for (ArticleType articleType : list) {
			List<ArticleType> types = articleType.getChildren();
			if (types != null && types.size() > 0) {
				Collections.sort(types, new Comparator<ArticleType>(){
					@Override
					public int compare(ArticleType o1, ArticleType o2) {
						if(o1.getDisplayOrder()==null)return -1;
						if(o2.getDisplayOrder()==null)return 1;
						return o1.getDisplayOrder()-o2.getDisplayOrder();
					}
				});
			}
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public String contentTreeList() {
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
		filter.eq("paramId", paramId);
		if (articleKind != null) {
			filter.eq("kind", articleKind);
		}
		articleTypeList = articleTypeService.getListByFilter(filter).getValue();
		for(ArticleType at : articleTypeList){
			at.setState(TreeEntity.STATE_CLOSED);
			at.setText(at.getTypeName());
			at.setLevel(at.getLevel());
		}
		articleTypeList = TreeUtil.generateTree(articleTypeList);
		mySort(articleTypeList);
		return JSON;
	}
	
	@SuppressWarnings("unchecked")
	public String singleTreeList() {
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
		filter.eq("paramId", paramId);
		if (articleKind != null) {
			filter.eq("kind", articleKind);
		}
		articleTypeList = articleTypeService.getListByFilter(filter).getValue();
		StringBuilder builder = new StringBuilder();
		for(ArticleType at : articleTypeList){
			String pIds = at.getParentIds();
			if (pIds != null && !(",".equals(pIds))) {
				pIds = pIds.substring(0,pIds.length()-1);
				builder.append(pIds);
			}
		}
		builder.append(",");
		if (!",".equals(builder.toString())) {
			Long[] pids = returnParentIds(builder.toString());
			Set<Long> idSet = new HashSet<Long>();
			for (int i = 0; i < pids.length; i++) {
				idSet.add(pids[i]);
			}
			filter = new Filter(ArticleType.class);
			filter.in("id", idSet.toArray());
			List<ArticleType> list = articleTypeService.getListByFilter(filter).getValue();
			articleTypeList.addAll(list);
		}
		for(ArticleType at : articleTypeList){
			at.setState(TreeEntity.STATE_CLOSED);
			at.setText(at.getTypeName());
			at.setLevel(at.getLevel());
		}
		articleTypeList = TreeUtil.generateTree(articleTypeList);
		mySort(articleTypeList);
		return JSON;
	}
	
	public String listArticle() {
		if (articleKind == null) {
			articleKind = ArticleKindEnum.LIST;
		}
		Filter f = new Filter(Param.class);
		User user = CmsActivator.getSessionUser();
		params = paramService.getListByFilter(f).getValue();
		List<Param> list = new ArrayList<Param>(params.size());
		if (user.getAdmin() == BooleanEnum.NO) {
			String uid = ","+user.getId()+",";
			for (Param param : params) {
				ids = param.getManagerIds();
				if (ids != null && ids.indexOf(uid) != -1) {
					list.add(param);
					continue;
				}else {
					Filter filter = new Filter(ArticleType.class);
					filter.eq("paramId", param.getId()).eq("kind", articleKind).like("managerIds", uid);
					articleTypeList = articleTypeService.getListByFilter(filter).getValue();
					if (articleTypeList.size() > 0) {
						list.add(param);
						continue;
					}
				}
			}
		}else {
			list = params;
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("params", list);
		return "listArticle";
	}
	
	public String listTopic() {
		articleKind = ArticleKindEnum.TOPIC;
		listArticle();
		return "listTopic";
	}
	
	public String listSingle() {
		articleKind = ArticleKindEnum.SINGLE;
		listArticle();
		return "listSingle";
	}
	
	/**
	 * 由网站Id获取所有栏目
	 * @return
	 */
	public String listAll(){
		if (paramId == null) {
			return JSON;
		}
		User user = CmsActivator.getSessionUser();
		Filter filter = new Filter(ArticleType.class);
		if(user!=null){
			if(BooleanEnum.NO == user.getAdmin()){
				param = paramService.getBeanByFilter(
						new Filter(Param.class).
						eq("id", paramId).
						like("managerIds", ","+user.getId()+",")).getValue();
			}
		}
		else{
			//return "login";
		}
		filter.eq("paramId", paramId);
		HttpServletRequest request = ServletActionContext.getRequest();
		String nodeId = request.getParameter("nodeid");
		if(nodeId!=null && !("".equals(nodeId.trim()))){
			filter.eq("parentId", Long.parseLong(nodeId.trim()));
		} else {
			filter.isNull("parentId");
		}
		filter.orderBy("level", Filter.ASC);
		refresh(filter);
		if (root !=null && root.size() > 0) {
			mySort(root);
		}
		return JSON;
	}
	
	
	public String webList() {
		Filter f = new Filter(Param.class);
		User user = CmsActivator.getSessionUser();
		if (user.getAdmin() != BooleanEnum.YES) {
			f.like("managerIds", ","+user.getId()+",");
		}
		params = paramService.getListByFilter(f).getValue();
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("params", params);
		return "web";
	}
	
	public String loadById(){
		Filter filter = new Filter(ArticleType.class).eq("parentId", id);
		refresh(filter);
		for (ArticleType type : root) {
			Filter f = new Filter(ArticleType.class);
			f.like("parentIds", ","+type.getId()+",");
			List<ArticleType> list = articleTypeService.getListByFilter(f).getValue();
			if (list == null) {
				type.setLevel(0);
			}else {
				type.setLevel(list.size());
			}
		}
		return JSON;
	}
	
	/**
	 * 保存,若是单页,生成对应栏目名称的一篇文章
	 * @return
	 */
	public String save(){
		if ("".equals(articleType.getDisplayPositionId())) {
			articleType.setDisplayPositionId(null);
		}
		ArticleType parent = null;
		if (articleType.getParentId() != null) {
			parent = articleTypeService.getBeanById(articleType.getParentId()).getValue();
			articleType.setLevel(parent.getLevel()+1);
		}else {
			articleType.setLevel(0);
		}
		result = articleTypeService.save(articleType);
		if (result.isSuccess() && 
				articleType.getKind() == ArticleKindEnum.SINGLE) {
			createArticle(articleType);
		}
		return JSON;
	}
	
	/**
	 * 创建文章
	 * @param type 文章所属的栏目
	 */
	private void createArticle(ArticleType type){
		Article article = new Article();
		article.setParamId(articleType.getParamId());
		article.setKind(articleType.getKind());
		article.setTypeId(articleType.getId());
		article.setTitle(articleType.getTypeName());
		article.setPubed(BooleanEnum.NO);
		article.setDeleted(BooleanEnum.NO);
		article.setEditor(CmsActivator.getSessionUser().getRealName());
		article.setRecommend(BooleanEnum.NO);
		article.setBold(BooleanEnum.NO);
		article.setToped(BooleanEnum.NO);
		article.setHits(0);
		articleService.save(article);
	}
	
	public String delete(){
		if(id!=null){
			result = articleTypeService.deleteById(id);
		}
		if(ids!= null){
			result = articleTypeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	/**
	 * 栏目编辑
	 * @return
	 */
	public String edit(){
		displayPositions = new ArrayList<DataDict>();
		articleType = articleTypeService.getBeanById(id).getValue();
		if (articleType != null) {
			if (articleType.getParentId() != null) {
				articleType.setText(articleType.getParentType().getTypeName());
			}
			if (articleType.getParam() != null) {
				String tempId = articleType.getParam().getTempleteId();
				if (tempId != null) {
					List<DataDict> list = CmsActivator.
							getDataDictInitService().getDataDictByParentId(tempId);
					displayPositions = new ArrayList<DataDict>();
					for (DataDict dataDict : list) {
						if ("ARTICLE".equals(dataDict.getDataName())){ 
							displayPositions.add(dataDict);
						}
					}
				}
			}
		}
		result = Result.value(articleType);
		return EDIT;
	}
	
	/**
	 * 栏目更新
	 * @return
	 */
	public String update(){
		ArticleType dbean = articleTypeService.
				getBeanById(articleType.getId()).getValue();
		Long parentId = articleType.getParentId();
		id = articleType.getId();
		if (parentId != null && dbean.getParentId() != parentId) {
			//type:当前目录,新上级目录
			ArticleType type = articleTypeService.getBeanById(parentId).getValue();
			String idStr = ","+id+",";
			if (type.getParentIds().indexOf(idStr) != -1) {
				result = Result.failure("更新失败,不能将此栏目放置其子栏目中");
				return JSON;
			}else {
				articleType.setLevel(type.getLevel()+1);
				articleType.setParamId(param.getId());
				String sql = "";
				//更新所有子栏目
				sql = "UPDATE cms_article_type SET LEVEL="+(type.getLevel()+2);
				sql += ",parent_ids='"+type.getParentIds()+type.getId()+","+id+",'";
				sql += ",param_id="+param.getId();
				sql += " WHERE parent_ids LIKE '%,"+id+",%'";
				articleTypeService.executeSQLUpdate(sql);
			}
		}else if (parentId == null && 
				dbean.getParentId() != null) {
			//清空上级栏目,即将当前栏目作为顶级栏目
			articleType.setParentIds(null);
			articleType.setLevel(0);
			dbean.setParentId(null);
			dbean.setParentIds(null);
			//再更新所有子栏目
			String sql = "UPDATE cms_article_type SET LEVEL=1";
			sql += ",parent_ids=',"+id+",'";
			sql += ",param_id="+param.getId();
			sql += " WHERE parent_ids LIKE '%,"+id+",%'";
			articleTypeService.executeSQLUpdate(sql);
		}
		BeanUtil.copyProperties(articleType, dbean);
		if ("".equals(articleType.getDisplayPositionId())) {
			dbean.setDisplayPositionId(null);
		}
		result = articleTypeService.update(dbean);
		return JSON;
	}
	
	public String view(){
		articleType = articleTypeService.getBeanById(id).getValue();
		if (articleType.getDisplayPositionId() != null) {
			DataDict dataDict = CmsActivator.getDataDictInitService().
					getDataDictById(articleType.getDisplayPositionId());
			articleType.setDisplayPosition(dataDict);
		}
		result = Result.value(articleType);
		return VIEW;
	}
	
	/**
	 * 设置栏目管理员
	 * @return
	 */
	public String set() {
		try {
			memo = URLDecoder.decode(memo, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		articleType = articleTypeService.getBeanById(id).getValue();//当前栏目
		String parentId = articleType.getParentIds();//父类id
		
		String oldIds = articleType.getManagerIds();
		if(",".equals(ids) && oldIds == null){
			//未发生更改,未发生任何改变
			result = Result.failure("更新失败,未发生任何改变");
			return JSON;
		}else if(",".equals(ids) && !ids.equals(oldIds)){
			//清空
			String sql = "UPDATE cms_article_type set manager_ids="+null+",manager_names="+null;
			sql += " WHERE id="+id+" OR parent_ids LIKE '%,"+id+",%'";
			articleTypeService.executeSQLUpdate(sql);
		}else if(!ids.equals(oldIds)){
			//发生改变,当前栏目及其子栏目更新为当前选择的用户
			String names = memo.substring(1,memo.length()-1);
			String sql = "UPDATE cms_article_type set manager_ids='"+ids+"',";
			sql += "manager_names='"+names+"'";
			sql += " WHERE id="+id+" OR parent_ids LIKE '%,"+id+",%'";
			articleTypeService.executeSQLUpdate(sql);
		}
		if(",".equals(parentId)){
			//顶级操作
			result = Result.success("更新栏目管理员成功");
		}else{
			/*当前栏目非顶级栏目,有上级栏目
			 *需要获取到所有上级栏目,比对当前
			 */
			Filter f = new Filter(ArticleType.class);
			f.like("parentIds", ","+articleType.getId()+",");
			f = new Filter(ArticleType.class);
			Object[] parentIds = returnParentIds(parentId);
			f.in("id", parentIds);
			List<ArticleType> parents = articleTypeService.getListByFilter(f).getValue();
			List<ArticleType> afterSort = sortList(parents);
			for (ArticleType type : afterSort) {
				f = new Filter(ArticleType.class);
				f.like("parentIds", ","+type.getId()+",");
				f.and(Filter.NotNull("managerIds"), Filter.NotNull("managerNames"));
				List<ArticleType> children = articleTypeService.getListByFilter(f).getValue();
				Set<String> idSet = new HashSet<String>();
				Set<String> nameSet = new HashSet<String>();
				
				for (ArticleType child : children) {
					String[] childIds = returnManageIds(child.getManagerIds());
					String[] childNames = returnManageNames(child.getManagerNames());
					for (int i = 0; i < childIds.length; i++) {
						idSet.add(childIds[i]);
						nameSet.add(childNames[i]);
					}
				}
				String lastIds = null;
				String lastNames = null;
				if (children.size() != 0) {
					StringBuilder builder = returnStringBySet(idSet);
					lastIds = builder.insert(0, ",").toString();
					builder = returnStringBySet(nameSet);
					lastNames = builder.deleteCharAt(builder.length()-1).toString();
				}
				type.setManagerIds(lastIds);
				type.setManagerNames(lastNames);
				result = articleTypeService.update(type);
				if (!result.isSuccess()) {
					break;
				}
			}			
		}
		return JSON;
	}
	
	private List<ArticleType> sortList(List<ArticleType> oldList) {
		List<ArticleType> newList = new ArrayList<ArticleType>();
		for (int i = 0; i < oldList.size(); i++) {
			Long cId = null;
			Long pId = null;
			for (int j = 0; j <oldList.size(); j++) {
				if (i== 0) {
					cId = articleType.getParentId();
				}else {
					cId = newList.get(i-1).getParentId();
				}
				pId = oldList.get(j).getId();
				if (cId.equals(pId)) {
					newList.add(oldList.get(j));
					break;
				}
			}
		}
		return newList;
	}
	
	private StringBuilder returnStringBySet(Set<String> oldSet) {
		StringBuilder builder = new StringBuilder();
		for (String any : oldSet) {
			builder.append(any);
			builder.append(",");
		}
		return builder;
	}
	
	private String[] returnManageIds(String idsString){
		return idsString.substring(1).split(",");
	}
	
	private Long[] returnParentIds(String idsString){
		String[] s = returnManageIds(idsString);
		Long[] l = new Long[s.length];
		for (int i = 0; i < s.length; i++) {
			l[i] = Long.parseLong(s[i]);
		}
		return l;
	}
	
	private String[] returnManageNames(String namesString){
		return namesString.split(",");
	}
	
	private String returnIdsByFilter(Filter filter){
		List<ArticleType> children = articleTypeService.getListByFilter(filter).getValue();
		StringBuilder builder = new StringBuilder();
		for (ArticleType child : children) {
			builder.append(child.getId());
			builder.append(",");
		}
		builder.append(articleType.getId());
		builder.append(",");
		return builder.deleteCharAt(builder.length()-1).toString();
	}
	
	@Override
	protected List<ArticleType> getListByFilter(Filter filter) {
		return articleTypeService.getListByFilter(filter).getValue();
	}
	public ArticleType getArticleType() {
		return articleType;
	}
	public void setArticleType(ArticleType articleType) {
		this.articleType = articleType;
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
	public Result<ArticleType> getResult() {
		return result;
	}
	
	public void setArticleTypeService(ArticleTypeService articleTypeService) {
		this.articleTypeService = articleTypeService;
	}
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	public List<ArticleType> getArticleTypeList() {
		return articleTypeList;
	}
	public void setArticleTypeList(List<ArticleType> articleTypeList) {
		this.articleTypeList = articleTypeList;
	}

	public List<CatalogDto> getCatalogDtoList() {
		return catalogDtoList;
	}


	public void setCatalogDtoList(List<CatalogDto> catalogDtoList) {
		this.catalogDtoList = catalogDtoList;
	}


	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public ArticleKindEnum getArticleKind() {
		return articleKind;
	}

	public void setArticleKind(ArticleKindEnum articleKind) {
		this.articleKind = articleKind;
	}


	public List<Param> getParams() {
		return params;
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



	public List<DataDict> getDisplayPositions() {
		return displayPositions;
	}



	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}

}
