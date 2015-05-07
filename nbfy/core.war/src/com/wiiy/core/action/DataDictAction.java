package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.dto.AppDto;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.service.AppService;
import com.wiiy.core.service.DataDictService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataDictAction extends JqGridBaseAction<DataDict> {
	
	private AppService appService;
	
	private DataDictService dataDictService;
	private Result<?> result;
	private DataDict dataDict;
	private String id;
	private String ids;
	private String dataValue;
	private Integer displayOrder;
//	private Long bundleId;

	private List<AppDto> appDtoList;
	
	private String simpleName;
	
	private List<DataDict> categories;
	
	private Long bundleId;
	
	public Long getBundleId() {
		return bundleId;
	}

	public void setBundleId(Long bundleId) {
		this.bundleId = bundleId;
	}

	public void setDataValue(String dataValue) {
		this.dataValue = dataValue;
	}

	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	/*	public Long getBundleId() {
		return bundleId;
	}
*/
	public List<DataDict> getCategories() {
		return categories;
	}

	public void setSimpleName(String simpleName) {
		this.simpleName = simpleName;
	}

	public String getSimpleName() {
		return simpleName;
	}

	public List<AppDto> getAppDtoList() {
		return appDtoList;
	}

	public void setAppService(AppService appService) {
		this.appService = appService;
	}
		
	public String create(){
		dataDict = new DataDict();
//		AppDto appDto = appService.getApp(bundleId).getValue();
//		dataDict.setModuleName(appDto.getName());
//		categories = dataDictService.listCategory(simpleName).getValue();
		
		return EDIT;
	}
	
	public String save(){
/*		if (dataValue == null || dataValue.trim().length() == 0) {
			result = Result.failure("数据值不能为空!");
			return JSON;
		}
		if (displayOrder == null) {
			result = Result.failure("显示序号不能为空且为数字!");
			return JSON;
		}
*/		try {
			DataDict dataDict = dataDictService.getBeanById(id).getValue();
			dataDict.setDataValue(dataValue);
			dataDict.setDisplayOrder(displayOrder);
			result = dataDictService.update(dataDict);
		} catch (Throwable t) {
			String parentId = id.substring(0, id.length() - 2);
			DataDict dataDict = new DataDict();
			dataDict.setId(id);
			dataDict.setParentId(parentId);
			dataDict.setDataValue(dataValue);
			dataDict.setDisplayOrder(displayOrder);
			result = dataDictService.save(dataDict);
		}
		return JSON;
	}
	
	public String execute() {
		appDtoList = appService.getAppList().getValue();
		return LIST;
	}
	
	public String view(){
		dataDict = dataDictService.getBeanById(id).getValue();
		return VIEW;
	}
	
	public String edit(){
		dataDict = dataDictService.getBeanById(id).getValue();
		return EDIT;
	}
	
	public String update(){
		result = dataDictService.update(dataDict);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataDictService.deleteById(id);
		} else if(ids!=null){
			result = dataDictService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DataDict.class);
		if(ids!=null){
			if(!ids.equals("pb")){
				filter.like("id", ids, Filter.START);
			} else {
				filter.or(Filter.Like("id", "pb", Filter.START),Filter.Like("id", "crm", Filter.START));
			}
		}
		if(filters==null || filters!=null && filters.indexOf("parentId")==-1){
			filter.isNull("parentId");
		}
		return refresh(filter);
	}
	
	@Override
	protected List<DataDict> getListByFilter(Filter fitler) {
		return dataDictService.getListByFilter(fitler).getValue();
	}
	
	
	public DataDict getDataDict() {
		return dataDict;
	}

	public void setDataDict(DataDict dataDict) {
		this.dataDict = dataDict;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setDataDictService(DataDictService dataDictService) {
		this.dataDictService = dataDictService;
	}
	
	public Result<?> getResult() {
		return result;
	}

/*	@Override
	public DataDict getModel() {
		String dataDictId = ServletActionContext.getRequest().getParameter("id");
		if (dataDictId != null) {
			try {
				dataDict = dataDictService.getBeanById(dataDictId).getValue();
			} catch (Throwable t) {
				dataDict = new DataDict();
			}
		} else {
			dataDict = new DataDict();
		}
		return dataDict;
	}
*/}
