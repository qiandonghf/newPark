package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.GardenApplyEval;
import com.wiiy.pb.service.GardenApplyEvalService;

/**
 * @author my
 */
public class GardenApplyEvalAction extends JqGridBaseAction<GardenApplyEval>{
	
	private GardenApplyEvalService gardenApplyEvalService;
	private Result result;
	private GardenApplyEval gardenApplyEval;
	private Long id;
	private Long applyId;
	private String ids;
	
	
	public String save(){
		String[] uids = ids.split(",");
		gardenApplyEval = new GardenApplyEval();
		gardenApplyEval.setApplyId(applyId);
		gardenApplyEval.setFinished(BooleanEnum.NO);
		for (String uid : uids) {
			gardenApplyEval.setEvalUserId(Long.parseLong(uid));
			gardenApplyEvalService.save(gardenApplyEval);
		}
		result = Result.value("分配创业导师成功");
		return JSON;
	}
	
	public String view(){
		result = gardenApplyEvalService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = gardenApplyEvalService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		GardenApplyEval dbBean = gardenApplyEvalService.getBeanById(gardenApplyEval.getId()).getValue();
		BeanUtil.copyProperties(gardenApplyEval, dbBean);
		result = gardenApplyEvalService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = gardenApplyEvalService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyEvalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(GardenApplyEval.class));
	}
	
	@Override
	protected List<GardenApplyEval> getListByFilter(Filter fitler) {
		return gardenApplyEvalService.getListByFilter(fitler).getValue();
	}
	
	
	public GardenApplyEval getGardenApplyEval() {
		return gardenApplyEval;
	}

	public void setGardenApplyEval(GardenApplyEval gardenApplyEval) {
		this.gardenApplyEval = gardenApplyEval;
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

	public void setGardenApplyEvalService(GardenApplyEvalService gardenApplyEvalService) {
		this.gardenApplyEvalService = gardenApplyEvalService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setApplyId(Long applyId) {
		this.applyId = applyId;
	}
	
}
