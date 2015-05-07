package com.wiiy.cloud.capture.action;

import java.util.ArrayList;
import java.util.List;


import com.wiiy.cloud.capture.entity.Column;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.service.ColumnService;
import com.wiiy.cloud.capture.service.WebInfoService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ColumnAction extends JqGridBaseAction<Column> {
	private ColumnService columnService;
	private Column column;
	private List<Column> list = new ArrayList<Column>();
	private Result result;
	private Long id;
	private WebInfoService webInfoService;
	private List<Column> pindaoList;
	private List<WebInfo> webInfos;


	public void setWebInfos(List<WebInfo> webInfos) {
		this.webInfos = webInfos;
	}

	public void setPindaoList(List<Column> pindaoList) {
		this.pindaoList = pindaoList;
	}

	public List<Column> getPindaoList() {
		return pindaoList;
	}


	public void setWebInfoService(WebInfoService webInfoService) {
		this.webInfoService = webInfoService;
	}

	public void setWebInfoList(List<WebInfo> webInfoList) {
		this.webInfoList = webInfoList;
	}

	private List<WebInfo> webInfoList = new ArrayList<WebInfo>();

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

	public List<Column> getList() {
		return list;
	}

	public void setList(List<Column> list) {
		this.list = list;
	}

	public void setColumnService(ColumnService columnService) {
		this.columnService = columnService;
	}

	public Column getColumn() {
		return column;
	}

	public void setColumn(Column column) {
		this.column = column;
	}

	/***
	 * 获取栏目列表
	 * 
	 * @return
	 */
	public String loadPindaoLists() {
		list = columnService.getListByFilter(new Filter(Column.class)).getValue();
		if (list != null && list.size() > 0) {
			for (Column w : list) {
				w.setText(w.getName());
				w.setState(TreeEntity.STATE_CLOSED);
			}
		}
		webInfoList = webInfoService.getList().getValue();
		result = Result.value(list);
		return "rvalue";
	}

	public String view() {
		// result = columnService.getBeanById(id);
		return VIEW;
	}

	/**
	 * 添加栏目
	 * 
	 * @return
	 */
	public String save() {
		if (id != null) {
			
			column.setParentId(id);
		}else{			
			column.setParentId(id);
		}
		result = columnService.save(column);
		System.out.println(result.getMsg());
		return JSON;
	} 
	public String updateSava(){
		columnService.update(column);
		return JSON ;
	}
	public String update(){
		column = columnService.getBeanById(id).getValue();
		return "update" ;
	}

	public String smsPage() {

		list = columnService.getListByFilter(new Filter(Column.class).isNull("parentId")).getValue();
		pindaoList = new ArrayList<Column>();
		for (Column columns : list) {
			Filter filters = new Filter(Column.class);
			//获取该节点的子节点
			List<Column> chreList = columnService.getListByFilter(filters.eq("parentId", columns.getId())).getValue();
			if(chreList.size() >0){
			List<Column> nodeList = new ArrayList<Column>();
			for(int a = 0 ; a < chreList.size() ; a++){
				Column column2 = chreList.get(a);
				column2.setText(column2.getName());
				column2.setLevel(1);
				column2.setIconCls("");
				Filter filter = new Filter(WebInfo.class);
				webInfoList = webInfoService.getListByFilter(
						filter.eq("columnId", column2.getId())).getValue();
				if (webInfoList != null) {
					webInfos = new ArrayList<WebInfo>();
					for (WebInfo webs : webInfoList) {
						webs.setLevel(2);
						webs.setText(webs.getName());
						webs.setIconCls("icon-card");
						webInfos.add(webs);
					}
					column2.setChildren(webInfos);
				}
				nodeList.add(column2);
				
			}
			columns.setChildren(nodeList);
			columns.setLevel(0);
			columns.setText(columns.getName());
			columns.setState(TreeEntity.STATE_CLOSED);
			}else{			
				columns.setLevel(0);
				columns.setText(columns.getName());
				columns.setState(TreeEntity.STATE_CLOSED);
			}
			pindaoList.add(columns);
			
		}
		webInfoList = null;
		list = null;
		return JSON;
	}

	public List<WebInfo> getWebInfos() {
		return webInfos;
	}

	public List<WebInfo> getWebInfoList() {
		return webInfoList;
	}

	@Override
	protected List<Column> getListByFilter(Filter fitler) {
		return columnService.getListByFilter(new Filter(Column.class)).getValue();
	}
	
	public String delete(){
		result = columnService.deleteById(id);
		//result.setMsg("aaa");
		return JSON ;
	}

	
}
