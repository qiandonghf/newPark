package com.wiiy.cms.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.Resource;
import com.wiiy.cms.service.ParamService;
import com.wiiy.cms.service.ResourceService;

/**
 * @author my
 */
public class ResourceAction extends JqGridBaseAction<Resource>{
	
	private ResourceService resourceService;
	private Result result;
	private Resource resource;
	private Long id;
	private String ids;
	private List<DataDict> resourcePositions;
	private ParamService paramService;
	
	public String add() {
		if (id != null) {
			Param param = paramService.getBeanById(id).getValue();
			String tempId = param.getTempleteId();
			if (tempId != null) {
				List<DataDict> list = CmsActivator.
						getDataDictInitService().getDataDictByParentId(tempId);
				resourcePositions = new ArrayList<DataDict>();
				for (DataDict dataDict : list) {
					if ("RESOURCE".equals(dataDict.getDataName())){ 
						resourcePositions.add(dataDict);
					}
				}
			}
			
		}
		return "add";
	}
	
	public String save(){
		if ("".equals(resource.getPositionId())) {
			resource.setPositionId(null);
			resource.setPosition(null);
		}
		result = resourceService.save(resource);
		return JSON;
	}
	
	public String view(){
		result = resourceService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		resource = resourceService.getBeanById(id).getValue();
		Param param = paramService.
				getBeanById(resource.getParamId()).getValue();
		String tempId = param.getTempleteId();
		resourcePositions = new ArrayList<DataDict>();
		if (tempId != null) {
			List<DataDict> list = CmsActivator.
					getDataDictInitService().getDataDictByParentId(tempId);
			for (DataDict dataDict : list) {
				if ("RESOURCE".equals(dataDict.getDataName())){ 
					resourcePositions.add(dataDict);
				}
			}
		}
		result = Result.value(resource);
		return EDIT;
	}
	
	public String update(){
		Resource dbBean = resourceService.getBeanById(resource.getId()).getValue();
		BeanUtil.copyProperties(resource, dbBean);
		if ("".equals(resource.getPositionId())) {
			dbBean.setPositionId(null);
		}
		result = resourceService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = resourceService.deleteById(id);
		} else if(ids!=null){
			result = resourceService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Resource.class).eq("paramId", id));
	}
	
	@Override
	protected List<Resource> getListByFilter(Filter fitler) {
		return resourceService.getListByFilter(fitler).getValue();
	}
	
	
	public Resource getResource() {
		return resource;
	}

	public void setResource(Resource resource) {
		this.resource = resource;
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

	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<DataDict> getResourcePositions() {
		return resourcePositions;
	}

	public void setResourcePositions(List<DataDict> resourcePositions) {
		this.resourcePositions = resourcePositions;
	}

	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}
	
}
