package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;

import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyApply;
import com.wiiy.oa.entity.SupplyCategory;
import com.wiiy.oa.entity.SupplyStockIn;
import com.wiiy.oa.service.SupplyApplyService;
import com.wiiy.oa.service.SupplyCategoryService;
import com.wiiy.oa.service.SupplyService;
import com.wiiy.oa.service.SupplyStockInService;


public class SupplyAction extends JqGridBaseAction<Supply>{
	
	private SupplyService supplyService;
	private SupplyStockInService supplyStockInService;
	private SupplyApplyService supplyApplyService;
	private SupplyCategoryService supplyCategoryService;
	private Supply supply;
	private SupplyCategory supplyCategory;
	private List<SupplyCategory> supplyCategorys;
	private List<SupplyCategory> supplyCategoryLabel;
	private Result result;
	private Long id;
	private String ids;
	private List<SupplyStockIn> supplyStockIns;
	private List<SupplyApply> supplyApplies;
	
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	public String check(){
		return "check";
	}
	
	public String inList(){
		Filter filter =new Filter(SupplyStockIn.class);
		filter.eq("supplyId",id);
		return refresh(filter);
	}
	
	public String outList(){
		Filter filter =new Filter(SupplyApply.class);
		filter.eq("supplyId",id);
		return refresh(filter);
	}
	
	public String export(){
		Filter filter = new Filter(Supply.class);
		filter.createAlias("category", "category");
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("办公用品管理")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("办公用品列表", generateExportColumns(columns), root, out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	private LinkedHashMap<String, String> generateExportColumns(String columns){
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		columns = columns.replace("{", "");
		columns = columns.replace("}", "");
		String[] properties = columns.split(",");
		for (String string : properties) {
			String[] ss = string.split(":");
			String field = ss[0].replace("\"", "");
			String description = ss[1].replace("\"", "");
			map.put(field, description);
		}
		return map;
	}
	

	public String loadSupplyByCategoryId(){
		Filter filter = new Filter(Supply.class).eq("categoryId", id);
		return refresh(filter);
	}
	
	public String add(){
		supplyCategorys = supplyCategoryService.getListByFilter(new Filter(SupplyCategory.class).notNull("parentId")).getValue();
		return "add";
	}
	
	public String save(){
		if(supply.getAlarm()!=null && supply.getAlarm().equals(BooleanEnum.NO)){
			supply.setAlarmStock(0.0);
		}
		if(supply.getStock()==null){
			supply.setStock(0.0);
		}
		result = supplyService.save(supply);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = supplyService.deleteById(id);
		}else if(ids!=null){
			result = supplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		supplyCategorys = supplyCategoryService.getListByFilter(new Filter(SupplyCategory.class).notNull("parentId")).getValue();
		result = supplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if(supply.getAlarm()!=null && supply.getAlarm().equals(BooleanEnum.NO)){
			supply.setAlarmStock(0.0);
		}
		if(supply.getStock()==null){
			supply.setStock(0.0);
		}
		Supply dbBean = supplyService.getBeanById(supply.getId()).getValue();
		BeanUtil.copyProperties(supply, dbBean);
		result = supplyService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(SupplyCategory.class).isNull("parentId");
		supplyCategorys = supplyCategoryService.getListByFilter(filter).getValue();
		supplyCategoryLabel = supplyCategoryService.getListByFilter(new Filter(SupplyCategory.class).notNull("parentId")).getValue();
		result = supplyCategoryService.getList();
		return LIST;
	}
	
	public String listAll(){
		Filter filter = new Filter(Supply.class);
		return refresh(filter);
	}
	
	public String view(){
		result = supplyService.getBeanById(id);
		return VIEW;
	}
	
	public String select(){
		Filter filter = new Filter(SupplyCategory.class).isNull("parentId");
		supplyCategorys = supplyCategoryService.getListByFilter(filter).getValue();
		supplyCategoryLabel = supplyCategoryService.getListByFilter(new Filter(SupplyCategory.class).notNull("parentId")).getValue();
		result = supplyCategoryService.getList();
		return SELECT;
	}
	
	public String loadSupply(){
		Filter filter = new Filter(Supply.class);
		filter.eq("id", id);
		return refresh(filter);
	}

	@Override
	protected List<Supply> getListByFilter(Filter fitler) {
		return supplyService.getListByFilter(fitler).getValue();
	}

	
	public Supply getSupply() {
		return supply;
	}

	public void setSupply(Supply supply) {
		this.supply = supply;
	}

	public Result getResult() {
		return result;
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
	public SupplyService getSupplyService() {
		return supplyService;
	}

	public void setSupplyService(SupplyService supplyService) {
		this.supplyService = supplyService;
	}


	public SupplyCategoryService getSupplyCategoryService() {
		return supplyCategoryService;
	}


	public void setSupplyCategoryService(SupplyCategoryService supplyCategoryService) {
		this.supplyCategoryService = supplyCategoryService;
	}
	
	public List<SupplyCategory> getSupplyCategorys() {
		return supplyCategorys;
	}


	public void setSupplyCategorys(List<SupplyCategory> supplyCategorys) {
		this.supplyCategorys = supplyCategorys;
	}


	public void setResult(Result result) {
		this.result = result;
	}

	public SupplyCategory getSupplyCategory() {
		return supplyCategory;
	}

	public void setSupplyCategory(SupplyCategory supplyCategory) {
		this.supplyCategory = supplyCategory;
	}

	public List<SupplyCategory> getSupplyCategoryLabel() {
		return supplyCategoryLabel;
	}

	public void setSupplyCategoryLabel(List<SupplyCategory> supplyCategoryLabel) {
		this.supplyCategoryLabel = supplyCategoryLabel;
	}
	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

	public List<SupplyStockIn> getSupplyStockIns() {
		return supplyStockIns;
	}

	public void setSupplyStockIns(List<SupplyStockIn> supplyStockIns) {
		this.supplyStockIns = supplyStockIns;
	}

	public List<SupplyApply> getSupplyApplies() {
		return supplyApplies;
	}

	public void setSupplyApplies(List<SupplyApply> supplyApplies) {
		this.supplyApplies = supplyApplies;
	}

	public void setSupplyStockInService(SupplyStockInService supplyStockInService) {
		this.supplyStockInService = supplyStockInService;
	}

	public void setSupplyApplyService(SupplyApplyService supplyApplyService) {
		this.supplyApplyService = supplyApplyService;
	}


}
