package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.core.activator.CoreActivator;

import com.wiiy.core.entity.Countersign;
import com.wiiy.core.preferences.enums.CountersignDoneEnum;
import com.wiiy.core.preferences.enums.CountersignTypeEnum;
import com.wiiy.core.service.export.CountersignService;

/**
 * @author my
 */
public class CountersignAction extends JqGridBaseAction<Countersign>{
	
	private CountersignService countersignService;
	
	private Result result;
	private Countersign countersign;
	private CountersignDoneEnum alreadyOrWait;
	private Long id;
	private String ids;
	private Pager pager;
	private String type;
	private String TYPE="wait";
	
	
	public String countCountersign(){
		Filter countFilter = new Filter(Countersign.class);
		countFilter.eq("userId", CoreActivator.getSessionUser().getId()).eq("countersignDone", CountersignDoneEnum.WAIT);
		int count = countersignService.getListByFilter(countFilter).getValue().size();
			result = Result.value(count);
			return JSON;
	}
	
	public String agree() {
		Filter filter = new Filter(Countersign.class).eq("countersignId",id).eq("userId", CoreActivator.getSessionUser().getId());
		if("PROCESS".equals(type)){
			filter.eq("countersignType", CountersignTypeEnum.PROCESS);
		}else if("EXPIRE".equals(type)){
			filter.eq("countersignType", CountersignTypeEnum.EXPIRE);
		}else{
			filter.eq("countersignType", CountersignTypeEnum.REVIEW);
		}
		Countersign dbBean = countersignService.getBeanByFilter(filter).getValue();
		dbBean.setCountersignDone(CountersignDoneEnum.ALREADY);
		result = countersignService.update(dbBean);
		return JSON;
	}
	
	public String save(){
		result = countersignService.save(countersign);
		return JSON;
	}
	
	public String edit(){
		result = countersignService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Countersign dbBean = countersignService.getBeanById(countersign.getId()).getValue();
		BeanUtil.copyProperties(countersign, dbBean);
		result = countersignService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = countersignService.deleteById(id);
		} else if(ids!=null){
			result = countersignService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Long thisId =CoreActivator.getSessionUser().getId();
		Filter filter = new Filter(Countersign.class).eq("userId", thisId);	
		if(alreadyOrWait==null||alreadyOrWait==CountersignDoneEnum.WAIT){
			alreadyOrWait=CountersignDoneEnum.WAIT;
			filter.eq("countersignDone", CountersignDoneEnum.WAIT);
		}else{
			filter.eq("countersignDone", CountersignDoneEnum.ALREADY);
		}
		setPager(filter);
		result = countersignService.getListByFilter(filter);
		return "list";
	}
	
	private void setPager(Filter filter){
		if(page!=0){
			pager = new Pager(page,15);
		} else {
			pager = new Pager(1,15);
		}
		filter.pager(pager);
	}
	
	@Override
	protected List<Countersign> getListByFilter(Filter fitler) {
		return countersignService.getListByFilter(fitler).getValue();
	}
	
	
	public Countersign getCountersign() {
		return countersign;
	}

	public void setCountersign(Countersign countersign) {
		this.countersign = countersign;
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

	public void setCountersignService(CountersignService countersignService) {
		this.countersignService = countersignService;
	}
	
	public Result getResult() {
		return result;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTYPE() {
		return TYPE;
	}

	public void setTYPE(String tYPE) {
		TYPE = tYPE;
	}

	public CountersignDoneEnum getAlreadyOrWait() {
		return alreadyOrWait;
	}

	public void setAlreadyOrWait(CountersignDoneEnum alreadyOrWait) {
		this.alreadyOrWait = alreadyOrWait;
	}

	
}
