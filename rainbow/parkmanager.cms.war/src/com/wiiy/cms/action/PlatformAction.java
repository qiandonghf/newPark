package com.wiiy.cms.action;

import java.io.File;
import java.util.Date;
import java.util.List;

import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.Platform;
import com.wiiy.cms.service.PlatformService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class PlatformAction extends JqGridBaseAction<Platform>{
	
	private PlatformService platformService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Platform platform;
	private Param param;
	private ArticleType type;
	private Long id;
	private String ids;
	
	private String filePath;
	private String rootPath;
	
	public PlatformAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
	}
	
	
	public String save(){
		if (param != null) {platform.setParamId(param.getId());}
		if (type != null) {platform.setTypeId(type.getId());}
		if (platform.getToped() == null) {platform.setToped(BooleanEnum.NO);}
		if (platform.getRecommend() == null) {platform.setRecommend(BooleanEnum.NO);}
		if (platform.getBold() == null) {platform.setBold(BooleanEnum.NO);}
		platform.setPhoto(filePath);
		platform.setPubed(BooleanEnum.NO);
		result = platformService.save(platform);
		return JSON;
	}
	
	/**
	 * 平台发布操作
	 * @return
	 */
	public String publish() {
		platform = platformService.getBeanById(id).getValue();
		platform.setPubed(BooleanEnum.YES);
		platform.setPubTime(new Date());
		result = platformService.update(platform);
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
		platform = platformService.getBeanById(id).getValue();
		platform.setPubed(BooleanEnum.NO);
		platform.setPubTime(null);
		result = platformService.update(platform);
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
	
	public String view(){
		result = platformService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = platformService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if (param != null) {
			platform.setParamId(param.getId());
		}
		if (type != null) {
			platform.setTypeId(type.getId());
		}
		if (platform.getToped() == null) {platform.setToped(BooleanEnum.NO);}
		if (platform.getRecommend() == null) {platform.setRecommend(BooleanEnum.NO);}
		if (platform.getBold() == null) {platform.setBold(BooleanEnum.NO);}
		Platform dbBean = platformService.getBeanById(platform.getId()).getValue();
		BeanUtil.copyProperties(platform, dbBean);
		dbBean.setPhoto(filePath);
		result = platformService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = platformService.deleteById(id);
		} else if(ids!=null){
			result = platformService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Platform.class));
	}
	
	@Override
	protected List<Platform> getListByFilter(Filter fitler) {
		return platformService.getListByFilter(fitler).getValue();
	}
	
	
	public Platform getPlatform() {
		return platform;
	}

	public void setPlatform(Platform platform) {
		this.platform = platform;
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

	public void setPlatformService(PlatformService platformService) {
		this.platformService = platformService;
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
