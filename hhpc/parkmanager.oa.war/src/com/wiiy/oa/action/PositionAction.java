package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.external.service.OrgPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Position;
import com.wiiy.oa.service.PositionService;

public class PositionAction extends JqGridBaseAction<Position>{
	private PositionService positionService;
	private Position position;
	private Long id;
	private String ids;
	private Result result;
	private List<Org> orgList;
	private Boolean flag = false;
	
	public String list(){
		Filter filter = new Filter(Position.class);
		return refresh(filter);
	}
	
	public String add(){
		OrgPubService orgPubService = OaActivator.getService(OrgPubService.class);
		orgList = orgPubService.getOrgList();
		return "add";
	}
	
	public String save(){
		result = positionService.save(position);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = positionService.deleteById(id);
		}
		if(ids!=null){
			result = positionService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String view(){
		result = positionService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = positionService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Position dbBean = positionService.getBeanById(position.getId()).getValue();
		BeanUtil.copyProperties(position, dbBean);
		result = positionService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<Position> getListByFilter(Filter fitler) {
		return positionService.getListByFilter(fitler).getValue();
	}
	public void setPositionService(PositionService positionService) {
		this.positionService = positionService;
	}
	public Position getPosition() {
		return position;
	}
	public void setPosition(Position position) {
		this.position = position;
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

	public List<Org> getOrgList() {
		return orgList;
	}

	public void setOrgList(List<Org> orgList) {
		this.orgList = orgList;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	
}
	
