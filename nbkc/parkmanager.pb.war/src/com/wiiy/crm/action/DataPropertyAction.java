package com.wiiy.crm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.service.DataPropertyService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataPropertyAction extends JqGridBaseAction<DataProperty>{
	
	private DataPropertyService dataPropertyService;
	private Result result;
	private DataProperty dataProperty;
	private List<DataProperty> dataPropertyList;
	private Long id;
	private String ids;
	
	public String up(){
		result = dataPropertyService.up(id);
		return JSON;
	}
	
	public String down(){
		result = dataPropertyService.down(id);
		return JSON;
	}
	
	
	public String loadParentProperty(){
		if(id==null) {
			dataPropertyList = dataPropertyService.getListByFilter(new Filter(DataProperty.class).isNull("parentId")).getValue();
		} else {
			dataPropertyList = dataPropertyService.getListByFilter(new Filter(DataProperty.class).eq("parentId",id)).getValue();
		}
		for(DataProperty property : dataPropertyList){
			property.setText(property.getName());
			if(property.getLeaf()){
				property.setState(TreeEntity.STATE_OPEN);
			} else {
				property.setState(TreeEntity.STATE_CLOSED);
			}
			if(ids!=null && ids.contains(","+property.getId()+",")) property.setChecked(true);
		}
		result = Result.value(dataPropertyList);
		return "rvalue";
	}
	
	public String add(){
		return "add";
	}
	
	public String save(){
		result = dataPropertyService.save(dataProperty);
		return JSON;
	}
	
	public String view(){
		result = dataPropertyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataPropertyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataProperty dbBean = dataPropertyService.getBeanById(dataProperty.getId()).getValue();
		BeanUtil.copyProperties(dataProperty, dbBean);
		dataProperty.setParentId(dbBean.getParentId());
		result = dataPropertyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataPropertyService.deleteById(id);
		} else if(ids!=null){
			result = dataPropertyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String dataPropertyList(){
		return LIST;
	}
	
	public String list(){
		Filter filter = new Filter(DataProperty.class);
		HttpServletRequest request = ServletActionContext.getRequest();
		if(request.getParameter("nodeid")!=null){
			filter.eq("parentId", Long.parseLong(request.getParameter("nodeid")));
		} else {
			filter.isNull("parentId");
		}
		filter.orderBy("order", Filter.ASC);
		return refresh(filter);
	}
	
	@Override
	protected List<DataProperty> getListByFilter(Filter fitler) {
		return dataPropertyService.getListByFilter(fitler).getValue();
	}
	
	
	public DataProperty getDataProperty() {
		return dataProperty;
	}

	public void setDataProperty(DataProperty dataProperty) {
		this.dataProperty = dataProperty;
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

	public void setDataPropertyService(DataPropertyService dataPropertyService) {
		this.dataPropertyService = dataPropertyService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<DataProperty> getDataPropertyList() {
		return dataPropertyList;
	}

}
