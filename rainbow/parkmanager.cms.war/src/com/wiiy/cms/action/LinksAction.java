package com.wiiy.cms.action;

import java.util.Date;
import java.util.List;

import com.wiiy.cms.entity.Links;
import com.wiiy.cms.service.LinksService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class LinksAction extends JqGridBaseAction<Links>{
	private LinksService linksService;
	private Links links;
	private Result<Links> result;
	private Long id;
	private String ids;
	private List<Links> linksList;
	
	public String list(){
		return refresh(new Filter(Links.class).eq("paramId", id));
	}
	
	/**
	 * 显示链接列表
	 * @return
	 */
	public String show() {
		return "show";
	}
	
	
	/**
	 * 保存新增的链接
	 * @return
	 */
	public String save() {
		if (links.getPhoto() != null && "".equals(links.getPhoto())) {
			links.setPhoto(null);
		}
		if (links.getOldName() != null && "".equals(links.getOldName())) {
			links.setOldName(null);
		}
		result = linksService.save(links);
		return JSON;
	}
	
	/**
	 * 根据id查找实体
	 * @return
	 */
	public String view() {
		result = linksService.getBeanById(id);
		return VIEW;
	}
	
	/**
	 * 根据id修改实体
	 * @return
	 */
	public String edit() {
		result = linksService.getBeanById(id);
		return EDIT;
	}
	
	/**
	 * 根据id删除实体
	 * @return
	 */
	public String delete() {
		if(id!=null){
			result = linksService.deleteById(id);
		}
		if(ids!=null){
			result = linksService.deleteByIds(ids);
		}
		return JSON;
	}
	
	/**
	 * 更新实体
	 * @return
	 */
	public String update() {
		Links dbean = linksService.getBeanById(links.getId()).getValue();
		BeanUtil.copyProperties(links,dbean);
		if (dbean.getDisplay() != null) {
			if (dbean.getDisplay() == BooleanEnum.YES) {
				dbean.setOpenedTime(new Date());
			}else {
				dbean.setOpenedTime(null);
			}
		}
		if (links.getPhoto() == null)
			dbean.setPhoto(null);
		if (links.getOldName() == null)
			dbean.setOldName(null);
		if (links.getPhoto() != null && "".equals(links.getPhoto())) {
			dbean.setPhoto(null);
		}
		if (links.getOldName() != null && "".equals(links.getOldName())) {
			dbean.setOldName(null);
		}
		result = linksService.update(dbean);
		return JSON;
	}
	
	public void setLinksService(LinksService linksService) {
		this.linksService = linksService;
	}

	public Links getLinks() {
		return links;
	}

	public void setLinks(Links links) {
		this.links = links;
	}

	public Result<Links> getResult() {
		return result;
	}

	public void setResult(Result<Links> result) {
		this.result = result;
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

	public List<Links> getLinksList() {
		return linksList;
	}

	public void setLinksList(List<Links> linksList) {
		this.linksList = linksList;
	}

	@Override
	protected List<Links> getListByFilter(Filter fitler) {
		return linksService.getListByFilter(fitler).getValue();
	}
	
}
