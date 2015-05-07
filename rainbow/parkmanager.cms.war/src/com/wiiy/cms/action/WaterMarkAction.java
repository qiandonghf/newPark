package com.wiiy.cms.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.List;

import com.wiiy.cms.entity.WaterMark;
import com.wiiy.cms.service.WaterMarkService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class WaterMarkAction extends JqGridBaseAction<WaterMark>{
	private WaterMarkService waterMarkService;
	private WaterMark waterMark;
	private Long id;
	private String ids;
	private Result result;
	private File upload;
	private String uploadFileName;
	private String uploadContentType;
	private InputStream inputStream;
	
	public String list(){
		Filter filter = new Filter(WaterMark.class);		
		return refresh(filter);
	}
	
	public String show() {
		List<WaterMark> list = waterMarkService.getList().getValue();
		if (list != null && list.size() > 0) {
			result = Result.value(list.get(0));
			waterMark = list.get(0);
		}
		return "show";
	}
	
	public String save() throws Exception{
		if(upload!=null){
			FileInputStream fin = new FileInputStream(upload);
			result = waterMarkService.save(waterMark,fin);
		}
		return JSON;
	}
	
	public String edit(){
		result = waterMarkService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = waterMarkService.deleteById(id);
		}else if(ids!=null){
			result = waterMarkService.deleteByIds(ids);
		}
		return JSON;
	}
	
	/**
	 * 更新图片水印
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception{
		WaterMark dbBean = waterMarkService.getBeanById(waterMark.getId()).getValue();
		BeanUtil.copyProperties(waterMark, dbBean);
		if (uploadFileName != null && uploadFileName.trim().length() > 0) {
			String root = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
			root += uploadFileName;
			upload = new File(root);
			if (upload.exists()) {
				FileInputStream fin = new FileInputStream(upload);
				result = waterMarkService.update(dbBean,fin);
				if (result.isSuccess()) {
					result = Result.success(result.getMsg());
				}
				fin.close();
				//删除上传的文件
				upload.delete();
			}
			
		}else {
			result = waterMarkService.update(dbBean);
		}
		return JSON;
	}
	
	@Override
	protected List<WaterMark> getListByFilter(Filter fitler) {
		return waterMarkService.getListByFilter(fitler).getValue();
	}
	
	public WaterMark getWaterMark() {
		return waterMark;
	}
	public void setWaterMark(WaterMark waterMark) {
		this.waterMark = waterMark;
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
	public void setWaterMarkService(WaterMarkService waterMarkService) {
		this.waterMarkService = waterMarkService;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

}
