package com.wiiy.cloud.capture.action;

import java.util.List;


import com.wiiy.cloud.capture.entity.Column;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.service.ColumnService;
import com.wiiy.cloud.capture.service.WebInfoService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class WebInfoAction extends JqGridBaseAction<WebInfo>{
	private WebInfoService webInfoService;
	private WebInfo webInfo;
	private List<WebInfo> webInfoList;
	private Long id;
	private Result result;
	private ColumnService columnService ;


	public void setColumnService(ColumnService columnService) {
		this.columnService = columnService;
	}
    /**
     * 列表
     * @return
     */
	public String list(){
		if(id==null) {
			webInfoList = webInfoService.getList().getValue();
		} else {
			webInfoList = webInfoService.getListByFilter(new Filter(WebInfo.class).eq("parentId",id)).getValue();
		}
		if(webInfoList!=null && webInfoList.size()>0){
			for(WebInfo w : webInfoList){
				w.setText(w.getName());
				w.setState(TreeEntity.STATE_CLOSED);
			}
		}
		result = Result.value(webInfoList);
		return "rvalue";
	}
	/**
	 * 添加
	 * @return
	 */
	public String save(){
		if(id!=null){
			 webInfo.setColumnId(id);
		}
		result = webInfoService.save(webInfo);
		return JSON;
	}
	/**
	 * 删除
	 * @return
	 */
	public String delete(){
		if(id!=null){
			result = webInfoService.deleteById(id);
		}
		return JSON;
	}
	/**
	 * 编辑
	 * @return
	 */
	public String edit(){
		result = webInfoService.getBeanById(id);
		return EDIT;
	}
	/**
	 * 更新
	 * @return
	 */
	public String update(){
		WebInfo dbean = webInfoService.getBeanById(webInfo.getId()).getValue();
		BeanUtil.copyProperties(webInfo, dbean);
		result = webInfoService.update(dbean);
		return JSON;
	}
	/**
	 * 视图
	 * @return
	 */
	public String view(){
		result = webInfoService.getBeanById(id);
		return VIEW;
	}
	/**
	 * 根据条件来获取列表
	 * 过滤后的列表
	 */
	@Override
	protected List<WebInfo> getListByFilter(Filter filter) {
		return webInfoService.getListByFilter(filter).getValue();
	}
	public String createChild() {
        WebInfo webInfos = webInfoService.getBeanById(id).getValue();
         webInfo = new WebInfo() ;
         webInfo.setParent(webInfos);
      return "add";
  }
	public void setWebInfoService(WebInfoService webInfoService) {
		this.webInfoService = webInfoService;
	}

	public WebInfo getWebInfo() {
		return webInfo;
	}

	public void setWebInfo(WebInfo webInfo) {
		this.webInfo = webInfo;
	}

	public List<WebInfo> getWebInfoList() {
		return webInfoList;
	}

	public void setWebInfoList(List<WebInfo> webInfoList) {
		this.webInfoList = webInfoList;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}
	
}
