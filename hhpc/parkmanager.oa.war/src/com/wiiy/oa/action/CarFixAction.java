package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.CarFix;
import com.wiiy.oa.service.CarFixService;

public class CarFixAction extends JqGridBaseAction<CarFix>{
	private CarFixService carFixService;
	private CarFix carFix;
	private Long id;
	private String ids;
	private Result result;
	
	
	public String list(){
		Filter filter = new Filter(CarFix.class);
		return refresh(filter);
	}
	
	public String save(){
		result = carFixService.save(carFix);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = carFixService.deleteById(id);
		}
		if(ids!=null){
			result = carFixService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = carFixService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = carFixService.update(carFix);
		return JSON;
	}
	
	public String view(){
		result = carFixService.getBeanById(id);
		return VIEW;
	}
	
	public void setCarFixService(CarFixService carFixService) {
		this.carFixService = carFixService;
	}
	@Override
	protected List<CarFix> getListByFilter(Filter fitler) {
		return carFixService.getListByFilter(fitler).getValue();
	}
	public CarFix getCarFix() {
		return carFix;
	}
	public void setCarFix(CarFix carFix) {
		this.carFix = carFix;
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


}
