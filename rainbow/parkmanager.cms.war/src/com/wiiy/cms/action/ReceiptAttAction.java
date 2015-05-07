package com.wiiy.cms.action;

import java.io.File;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cms.entity.ReceiptAtt;
import com.wiiy.cms.service.ReceiptAttService;

/**
 * @author my
 */
public class ReceiptAttAction extends JqGridBaseAction<ReceiptAtt>{
	
	private ReceiptAttService receiptAttService;
	private Result result;
	private ReceiptAtt receiptAtt;
	private Long id;
	private String ids;
	private String rootPath;
	private String filePath;
	
	public ReceiptAttAction() {
		rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
	}
	
	public String save(){
		result = receiptAttService.save(receiptAtt);
		return JSON;
	}
	
	public String view(){
		result = receiptAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = receiptAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ReceiptAtt dbBean = receiptAttService.getBeanById(receiptAtt.getId()).getValue();
		BeanUtil.copyProperties(receiptAtt, dbBean);
		result = receiptAttService.update(dbBean);
		return JSON;
	}
	
	/**
	 * 删除附件,若本地文件存在,则同时删除本地文件
	 * @return
	 */
	public String delete(){
		if(filePath!=null){
			File file = new File(rootPath + filePath);
			if (file.exists()) {
				file.delete();
			}
		}
		if(id!=null){
			result = receiptAttService.deleteById(id);
		} else if(ids!=null){
			result = receiptAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ReceiptAtt.class));
	}
	
	@Override
	protected List<ReceiptAtt> getListByFilter(Filter fitler) {
		return receiptAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ReceiptAtt getReceiptAtt() {
		return receiptAtt;
	}

	public void setReceiptAtt(ReceiptAtt receiptAtt) {
		this.receiptAtt = receiptAtt;
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

	public void setReceiptAttService(ReceiptAttService receiptAttService) {
		this.receiptAttService = receiptAttService;
	}
	
	public Result getResult() {
		return result;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
}
