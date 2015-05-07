package com.wiiy.cms.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.entity.FloatingWindow;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.Resource;
import com.wiiy.cms.service.FloatingWindowService;
import com.wiiy.cms.service.ParamService;

/**
 * @author my
 */
public class FloatingWindowAction extends JqGridBaseAction<FloatingWindow>{
	
	private FloatingWindowService floatingWindowService;
	private Result result;
	private FloatingWindow floatingWindow;
	private ParamService paramService;
	private List<DataDict> floatingWindowPositions;
	private Long id;
	private String ids;
	
	public String add(){
		/**
		 * 增加图片处理逻辑
		 * */
		return "add";
	}
	
	public String save(){
		if ("".equals(floatingWindow.getType())) {
			floatingWindow.setType(null);
		}
		result = floatingWindowService.save(floatingWindow);
		return JSON;
	}
	
	public String view(){
		result = floatingWindowService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		floatingWindow = floatingWindowService.getBeanById(id).getValue();
		Param param = paramService.
				getBeanById(floatingWindow.getParamId()).getValue();
		String tempId = param.getTempleteId();
		floatingWindowPositions = new ArrayList<DataDict>();
		if (tempId != null) {
			List<DataDict> list = CmsActivator.
					getDataDictInitService().getDataDictByParentId(tempId);
			for (DataDict dataDict : list) {
				if ("RESOURCE".equals(dataDict.getDataName())){ 
					floatingWindowPositions.add(dataDict);
				}
				System.out.println("RESOURCE"+"dataDict.getDataName()");
			}
		}
		result = Result.value(floatingWindow);
		return EDIT;
//		result = floatingWindowService.getBeanById(id);
//		return EDIT;
	}
	
	public String update(){
		FloatingWindow dbBean = floatingWindowService.getBeanById(floatingWindow.getId()).getValue();
		BeanUtil.copyProperties(floatingWindow, dbBean);
		result = floatingWindowService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = floatingWindowService.deleteById(id);
		} else if(ids!=null){
			result = floatingWindowService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(FloatingWindow.class).eq("paramId", id));
	}
	
	@Override
	protected List<FloatingWindow> getListByFilter(Filter fitler) {
		return floatingWindowService.getListByFilter(fitler).getValue();
	}
	
	
	public FloatingWindow getFloatingWindow() {
		return floatingWindow;
	}

	public void setFloatingWindow(FloatingWindow floatingWindow) {
		this.floatingWindow = floatingWindow;
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

	public void setFloatingWindowService(FloatingWindowService floatingWindowService) {
		this.floatingWindowService = floatingWindowService;
	}
	
	public Result getResult() {
		return result;
	}
	
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}
}
