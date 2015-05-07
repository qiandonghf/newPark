package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.FeeShare;
import com.wiiy.pb.service.FeeShareService;

/**
 * @author my
 */
public class FeeShareAction extends JqGridBaseAction<FeeShare>{
	
	private FeeShareService feeShareService;
	private Result result;
	private FeeShare feeShare;
	private Long id;
	private String ids;
	
	public String add(){
		return "add";
	}
	
	public String save(){
		result = feeShareService.save(feeShare);
		return JSON;
	}
	
	public String view(){
		result = feeShareService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = feeShareService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		FeeShare dbBean = feeShareService.getBeanById(feeShare.getId()).getValue();
		BeanUtil.copyProperties(feeShare, dbBean);
		result = feeShareService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = feeShareService.deleteById(id);
		} else if(ids!=null){
			result = feeShareService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(FeeShare.class));
	}
	
	@Override
	protected List<FeeShare> getListByFilter(Filter fitler) {
		return feeShareService.getListByFilter(fitler).getValue();
	}
	
	
	public FeeShare getFeeShare() {
		return feeShare;
	}

	public void setFeeShare(FeeShare feeShare) {
		this.feeShare = feeShare;
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

	public void setFeeShareService(FeeShareService feeShareService) {
		this.feeShareService = feeShareService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
