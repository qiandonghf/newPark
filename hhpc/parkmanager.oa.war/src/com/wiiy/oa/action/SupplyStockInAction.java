package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyStockIn;
import com.wiiy.oa.service.SupplyService;
import com.wiiy.oa.service.SupplyStockInService;

public class SupplyStockInAction extends JqGridBaseAction<SupplyStockIn>{

	private SupplyStockInService supplyStockInService;
	private SupplyService supplyService;
	private SupplyStockIn supplyStockIn;
	private Supply supply;
	private Result result;
	private Long id;
	private String ids;
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	public String export(){
		Filter filter = new Filter(SupplyStockIn.class);
		filter.createAlias("supply", "supply");
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("办公用品入库")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("办公用品入库列表", generateExportColumns(columns), root, out);
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
	
	public String save(){
		result = supplyStockInService.save(supplyStockIn);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = supplyStockInService.deleteById(id);
		}else if(ids!=null){
			result = supplyStockInService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String view(){
		result = supplyStockInService.getBeanById(id);
		return VIEW;
	}
	public String edit(){
		result = supplyStockInService.getBeanById(id);
		return EDIT;
	}

	public String update(){
		SupplyStockIn dbean = supplyStockInService.getBeanById(supplyStockIn.getId()).getValue();
		Double count = dbean.getAmount();
		result = supplyStockInService.updateSupply(supplyStockIn,count);
		return JSON;
	}
	
	public String list(){
		result = supplyStockInService.getList();
		return LIST;
	}

	public String listAll(){
		Filter filter = new Filter(SupplyStockIn.class);
		return refresh(filter);
	}
	
	@Override
	protected List<SupplyStockIn> getListByFilter(Filter fitler) {
		return supplyStockInService.getListByFilter(fitler).getValue();
	}
	
	public void setSupplyStockInService(SupplyStockInService supplyStockInService) {
		this.supplyStockInService = supplyStockInService;
	}


	public SupplyStockIn getSupplyStockIn() {
		return supplyStockIn;
	}

	public void setSupplyStockIn(SupplyStockIn supplyStockIn) {
		this.supplyStockIn = supplyStockIn;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
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


	public Supply getSupply() {
		return supply;
	}

	public void setSupply(Supply supply) {
		this.supply = supply;
	}

	public void setSupplyService(SupplyService supplyService) {
		this.supplyService = supplyService;
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


}
