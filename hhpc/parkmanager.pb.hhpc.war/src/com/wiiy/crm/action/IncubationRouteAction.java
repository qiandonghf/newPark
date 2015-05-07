package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.service.IncubationRouteService;

/**
 * @author my
 */
public class IncubationRouteAction extends JqGridBaseAction<IncubationRoute>{
	
	private IncubationRouteService incubationRouteService;
	private Result result;
	private IncubationRoute incubationRoute;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = incubationRouteService.save(incubationRoute);
		return JSON;
	}
	
	public String view(){
		result = incubationRouteService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = incubationRouteService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		IncubationRoute dbBean = incubationRouteService.getBeanById(incubationRoute.getId()).getValue();
		BeanUtil.copyProperties(incubationRoute, dbBean);
		result = incubationRouteService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = incubationRouteService.deleteById(id);
		} else if(ids!=null){
			result = incubationRouteService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(IncubationRoute.class));
	}
	
	@Override
	protected List<IncubationRoute> getListByFilter(Filter fitler) {
		return incubationRouteService.getListByFilter(fitler).getValue();
	}
	
	
	public IncubationRoute getIncubationRoute() {
		return incubationRoute;
	}

	public void setIncubationRoute(IncubationRoute incubationRoute) {
		this.incubationRoute = incubationRoute;
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

	public void setIncubationRouteService(IncubationRouteService incubationRouteService) {
		this.incubationRouteService = incubationRouteService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
