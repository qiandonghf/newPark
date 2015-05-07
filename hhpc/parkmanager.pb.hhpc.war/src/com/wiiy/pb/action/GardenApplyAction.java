package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.entity.GardenApplyAtt;
import com.wiiy.pb.entity.GardenApplyEval;
import com.wiiy.pb.preferences.enums.GardenApplyAttTypeEnum;
import com.wiiy.pb.preferences.enums.GardenApplyStateEnum;
import com.wiiy.pb.preferences.enums.GardenProjectStateEnum;
import com.wiiy.pb.service.GardenApplyAttService;
import com.wiiy.pb.service.GardenApplyEvalService;
import com.wiiy.pb.service.GardenApplyService;

/**
 * @author my
 */
public class GardenApplyAction extends JqGridBaseAction<GardenApply>{
	
	private GardenApplyService gardenApplyService;
	private GardenApplyAttService gardenApplyAttService;
	private GardenApplyEvalService gardenApplyEvalService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private GardenApply gardenApply;
	private Long id;
	private Pager pager;
	private String ids;
	private String rootPath;
	
	public GardenApplyAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
		setPager(total);
	}
	
	public String save(){
		if (gardenApply.getApplyState() == null) {
			gardenApply.setApplyState(GardenApplyStateEnum.EVAL);
		}
		if (gardenApply.getProjectState() == null) {
			gardenApply.setProjectState(GardenProjectStateEnum.APPLYING);
		}
		if (gardenApply.getFinancing() == null) {
			gardenApply.setFinancing(BooleanEnum.NO);
		}
		result = gardenApplyService.save(gardenApply);
		return JSON;
	}
	
	public String view(){
		gardenApply = gardenApplyService.getBeanById(id).getValue();
		List<GardenApplyAtt> list = gardenApplyAttService.
			getListByFilter(
					new Filter(GardenApplyAtt.class).
					eq("applyId", gardenApply.getId()).
					eq("type", GardenApplyAttTypeEnum.BUSINESSPLAN)).getValue();
		gardenApply.setGardenApplyAtts(list);
		list = gardenApplyAttService.
				getListByFilter(
						new Filter(GardenApplyAtt.class).
						eq("applyId", gardenApply.getId()).
						eq("type", GardenApplyAttTypeEnum.OTHER)).getValue();
		gardenApply.setApplyAtts(list);
		List<GardenApplyEval> evals = 
				gardenApplyEvalService.
				getListByFilter(new Filter(GardenApplyEval.class).eq("applyId", gardenApply.getId())).getValue();
		gardenApply.setGardenApplyEvals(evals);
		result = Result.value(gardenApply);
		return VIEW;
	}
	
	public String edit(){
		result = gardenApplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		GardenApply dbBean = gardenApplyService.getBeanById(gardenApply.getId()).getValue();
		BeanUtil.copyProperties(gardenApply, dbBean);
		result = gardenApplyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = gardenApplyService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		rows = pager.getRows();
		refresh(new Filter(GardenApply.class));
		setPager(root.size());
		result = Result.value(root);
		return "list";
	}
	
	private void setPager(int total){
		if(page!=0){
			pager = new Pager(page,15);
			pager.setRecords(total);
		} else {
			pager = new Pager(1,15);
			pager.setRecords(total);
		}
	}
	
	@Override
	protected List<GardenApply> getListByFilter(Filter fitler) {
		return gardenApplyService.getListByFilter(fitler).getValue();
	}
	
	
	public GardenApply getGardenApply() {
		return gardenApply;
	}

	public void setGardenApply(GardenApply gardenApply) {
		this.gardenApply = gardenApply;
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

	public void setGardenApplyService(GardenApplyService gardenApplyService) {
		this.gardenApplyService = gardenApplyService;
	}
	
	public void setGardenApplyAttService(GardenApplyAttService gardenApplyAttService) {
		this.gardenApplyAttService = gardenApplyAttService;
	}

	public void setGardenApplyEvalService(
			GardenApplyEvalService gardenApplyEvalService) {
		this.gardenApplyEvalService = gardenApplyEvalService;
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
	
}
