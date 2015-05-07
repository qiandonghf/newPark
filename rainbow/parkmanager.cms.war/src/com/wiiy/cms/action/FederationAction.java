package com.wiiy.cms.action;

import java.io.File;
import java.util.Date;
import java.util.List;

import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Federation;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.service.FederationService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class FederationAction extends JqGridBaseAction<Federation>{
	
	private FederationService federationService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Federation federation;
	private Long id;
	private String ids;
	private Param param;
	private ArticleType type;
	
	private String filePath;
	private String rootPath;
	
	public FederationAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
	}
	
	/**
	 * 平台发布操作
	 * @return
	 */
	public String publish() {
		federation = federationService.getBeanById(id).getValue();
		federation.setPubed(BooleanEnum.YES);
		federation.setPubTime(new Date());
		result = federationService.update(federation);
		if(result.isSuccess()){
			result = Result.success("发布成功");
		}else{
			result = Result.failure("发布失败");
		}
		return JSON;
	}
	
	/**
	 * 平台撤回操作
	 * @return
	 */
	public String back() {
		federation = federationService.getBeanById(id).getValue();
		federation.setPubed(BooleanEnum.NO);
		federation.setPubTime(null);
		result = federationService.update(federation);
		if(result.isSuccess()){
			result = Result.success("撤回成功");
		}else{
			result = Result.failure("撤回失败");
		}
		return JSON;
	}
	
	/**
	 * 根据文件路径删除上传时的文件
	 * @return
	 */
	public String deleteByFilePath(){
		if(filePath!=null){
			File file = new File(rootPath + filePath);
			if (file.exists()) {
				file.delete();
			}
			result = Result.success("文件删除成功");
		}else {
			result = Result.failure("文件不存在");
		}
		return JSON;
	}
	
	public String save(){
		if (param != null) {federation.setParamId(param.getId());}
		if (type != null) {federation.setTypeId(type.getId());}
		if (federation.getToped() == null) {federation.setToped(BooleanEnum.NO);}
		if (federation.getRecommend() == null) {federation.setRecommend(BooleanEnum.NO);}
		if (federation.getBold() == null) {federation.setBold(BooleanEnum.NO);}
		federation.setPhoto(filePath);
		federation.setPubed(BooleanEnum.NO);
		result = federationService.save(federation);
		return JSON;
	}
	
	public String view(){
		result = federationService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = federationService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if (param != null) {federation.setParamId(param.getId());}
		if (type != null) {federation.setTypeId(type.getId());}
		if (federation.getToped() == null) {federation.setToped(BooleanEnum.NO);}
		if (federation.getRecommend() == null) {federation.setRecommend(BooleanEnum.NO);}
		if (federation.getBold() == null) {federation.setBold(BooleanEnum.NO);}
		Federation dbBean = federationService.getBeanById(federation.getId()).getValue();
		BeanUtil.copyProperties(federation, dbBean);
		dbBean.setPhoto(filePath);
		result = federationService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = federationService.deleteById(id);
		} else if(ids!=null){
			result = federationService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Federation.class));
	}
	
	@Override
	protected List<Federation> getListByFilter(Filter fitler) {
		return federationService.getListByFilter(fitler).getValue();
	}
	
	
	public Federation getFederation() {
		return federation;
	}

	public void setFederation(Federation federation) {
		this.federation = federation;
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

	public void setFederationService(FederationService federationService) {
		this.federationService = federationService;
	}
	
	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}
	
	public Param getParam() {
		return param;
	}

	public void setParam(Param param) {
		this.param = param;
	}

	public ArticleType getType() {
		return type;
	}

	public void setType(ArticleType type) {
		this.type = type;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
}
