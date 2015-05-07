package com.wiiy.cms.action;

import java.io.UnsupportedEncodingException;


import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.entity.FloatingWindow;
import com.wiiy.cms.entity.Links;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.Resource;
import com.wiiy.cms.entity.WaterMark;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.cms.service.ContactInfoService;
import com.wiiy.cms.service.FloatingWindowService;
import com.wiiy.cms.service.LinksService;
import com.wiiy.cms.service.ParamService;
import com.wiiy.cms.service.ResourceService;
import com.wiiy.cms.service.WaterMarkService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ParamAction extends JqGridBaseAction<Param>{
	private ParamService paramService;
	private WaterMarkService waterMarkService;
	private ContactInfoService contactInfoService;
	private ArticleTypeService articleTypeService;
	private ArticleKindEnum articleKind;
	private LinksService linksService;
	private ResourceService resourceService;
	private FloatingWindowService floatingWindowService;
	private Param param;
	private WaterMark waterMark;
	private ContactInfo contactInfo;
	private Resource resource;
	private FloatingWindow floatingWindow;
	private Links links;
	private Long id;
	private String ids;
	private List<DataDict> templetes;
	@SuppressWarnings("rawtypes")
	private Result result;
	private String memo;
	
	public String list(){
		Filter filter = new Filter(Param.class);
		User user = CmsActivator.getSessionUser();
		if (user.getAdmin() == BooleanEnum.NO) {
			filter.like("managerIds", ","+user.getId()+"");
			return refresh(filter);
		}else {
			return refresh(filter);
		}
	}
	
	public String add() {
		templetes = CmsActivator.getDataDictInitService().getDataDictsByDataName("TEMPLETE");
		return "add";
	}
	
	public String listArticle() {
		User user = CmsActivator.getSessionUser();
		refresh(new Filter(Param.class));
		List<Param> list = new ArrayList<Param>(root.size());
		if (user.getAdmin() == BooleanEnum.NO) {
			String uid = ","+user.getId()+",";
			for (Param param : root) {
				ids = param.getManagerIds();
				if (ids != null && ids.indexOf(uid) != -1) {
					list.add(param);
					continue;
				}else {
					Filter filter = new Filter(ArticleType.class);
					filter.eq("paramId", param.getId()).eq("kind", articleKind).like("managerIds", uid);
					List<ArticleType> articleTypeList = 
							articleTypeService.getListByFilter(filter).getValue();
					if (articleTypeList.size() > 0) {
						list.add(param);
						continue;
					}
				}
			}
			root = list;
		}
		return JSON;
	}
	
	
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
	
	public String webListResource(){
		webList();
		return "resource";
	}
	//浮窗方法
	public String webListFloatingWindow(){
		webList();
		return "floatingWindow";
	}
	
	public String show() {
		List<Param> list = paramService.getList().getValue();
		if (list != null && list.size() > 0) {
			result = Result.value(list.get(0));
		}
		return "show";
	}
	
	public String save(){
		if ("".equals(param.getTempleteId())) {
			param.setTempleteId(null);
		}
		result = paramService.save(param);
		return JSON;
	}
	
	public String saveOrUpdate(){
		result = paramService.saveOrUpdate(param,waterMark,contactInfo);
		return JSON;
	}
	
	public String view(){
		result = paramService.getBeanById(id);
		param = (Param) result.getValue();
		if (param.getTempleteId() != null) {
			param.setTemplete(CmsActivator.
					getDataDictInitService().getDataDictById(param.getTempleteId()));
		}
		if (param != null) {
			Long paramId = param.getId();
			waterMark = waterMarkService.getBeanByFilter(
					new Filter(WaterMark.class).eq("paramId", paramId)).getValue();
			contactInfo = contactInfoService.getBeanByFilter(
					new Filter(ContactInfo.class).eq("paramId", paramId)).getValue();
		}
		return VIEW;
	}
	
	public String edit(){
		result = paramService.getBeanById(id);
		param = (Param) result.getValue();
		if (param != null) {
			Long paramId = param.getId();
			waterMark = waterMarkService.getBeanByFilter(
					new Filter(WaterMark.class).eq("paramId", paramId)).getValue();
			contactInfo = contactInfoService.getBeanByFilter(
					new Filter(ContactInfo.class).eq("paramId", paramId)).getValue();
		}
		templetes = CmsActivator.getDataDictInitService().getDataDictsByDataName("TEMPLETE");
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			resourceService.deleteByParamId(id);
			linksService.deleteByParamId(id);
			waterMarkService.deleteByParamId(id);
			contactInfoService.deleteByParamId(id);
			result = paramService.deleteById(id);
		}else if(ids!=null){
			result = paramService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		Param dbBean = paramService.getBeanById(param.getId()).getValue();
		BeanUtil.copyProperties(param, dbBean);
		/*ContactInfo info = contactInfoService.getBeanByFilter(
				new Filter(ContactInfo.class).eq("paramId", dbBean.getId())).getValue();
		contactInfo.setId(info.getId());*/
		contactInfo.setParamId(param.getId());
		waterMark.setParamId(param.getId());
		contactInfoService.update(contactInfo);
		waterMarkService.update(waterMark);
		result = paramService.update(dbBean);
		return JSON;
	}
	
	/**
	 * 设置网站管理员
	 * @return
	 */
	public String setManager() {
		try {
			memo = URLDecoder.decode(memo, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		param = paramService.getBeanById(id).getValue();
		if (ids.length() > 1) {
			param.setManagerIds(ids);
			memo = memo.substring(1, memo.length()-1);
			param.setManagerNames(memo);
		}else {
			param.setManagerIds(null);
			param.setManagerNames(null);
		}
		result = paramService.update(param);
		return JSON;
	}
	
	@Override
	protected List<Param> getListByFilter(Filter fitler) {
		return paramService.getListByFilter(fitler).getValue();
	}
	
	public Param getParam() {
		return param;
	}
	public void setParam(Param param) {
		this.param = param;
	}
	public WaterMark getWaterMark() {
		return waterMark;
	}

	public void setWaterMark(WaterMark waterMark) {
		this.waterMark = waterMark;
	}

	public ContactInfo getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(ContactInfo contactInfo) {
		this.contactInfo = contactInfo;
	}

	public Resource getResource() {
		return resource;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
	}

	public Links getLinks() {
		return links;
	}

	public void setLinks(Links links) {
		this.links = links;
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
	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}
	
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	public void setWaterMarkService(WaterMarkService waterMarkService) {
		this.waterMarkService = waterMarkService;
	}

	public void setContactInfoService(ContactInfoService contactInfoService) {
		this.contactInfoService = contactInfoService;
	}

	public void setLinksService(LinksService linksService) {
		this.linksService = linksService;
	}

	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
//添加浮窗set
	public void setFloatingWindowService(FloatingWindowService floatingWindowService) {
		this.floatingWindowService = floatingWindowService;
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

	public void setArticleTypeService(ArticleTypeService articleTypeService) {
		this.articleTypeService = articleTypeService;
	}

	public List<DataDict> getTempletes() {
		return templetes;
	}

	public void setTempletes(List<DataDict> templetes) {
		this.templetes = templetes;
	}


}
