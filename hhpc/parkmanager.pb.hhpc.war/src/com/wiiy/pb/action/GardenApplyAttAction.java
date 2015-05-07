package com.wiiy.pb.action;

import java.io.File;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.GardenApplyAtt;
import com.wiiy.pb.service.GardenApplyAttService;

/**
 * @author my
 */
public class GardenApplyAttAction extends JqGridBaseAction<GardenApplyAtt>{
	
	private GardenApplyAttService gardenApplyAttService;
	private Result result;
	private GardenApplyAtt gardenApplyAtt;
	private Long id;
	private String ids;
	private String rootPath;
	
	public GardenApplyAttAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"/upload/";
	}
	
	public String save(){
		result = gardenApplyAttService.save(gardenApplyAtt);
		return JSON;
	}
	
	public String view(){
		result = gardenApplyAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = gardenApplyAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		GardenApplyAtt dbBean = gardenApplyAttService.getBeanById(gardenApplyAtt.getId()).getValue();
		BeanUtil.copyProperties(gardenApplyAtt, dbBean);
		result = gardenApplyAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			gardenApplyAtt = gardenApplyAttService.getBeanById(id).getValue();
			File file = new File(rootPath + gardenApplyAtt.getNewName());
			if (file.exists()) {
				file.delete();
			}
			result = gardenApplyAttService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(GardenApplyAtt.class));
	}
	
	@Override
	protected List<GardenApplyAtt> getListByFilter(Filter fitler) {
		return gardenApplyAttService.getListByFilter(fitler).getValue();
	}
	
	
	public GardenApplyAtt getGardenApplyAtt() {
		return gardenApplyAtt;
	}

	public void setGardenApplyAtt(GardenApplyAtt gardenApplyAtt) {
		this.gardenApplyAtt = gardenApplyAtt;
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

	public void setGardenApplyAttService(GardenApplyAttService gardenApplyAttService) {
		this.gardenApplyAttService = gardenApplyAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
