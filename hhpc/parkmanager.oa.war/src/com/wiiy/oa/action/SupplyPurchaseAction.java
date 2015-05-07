package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.SupplyApply;
import com.wiiy.oa.entity.SupplyPurchase;
import com.wiiy.oa.service.SupplyPurchaseService;

/**
 * @author my
 */
public class SupplyPurchaseAction extends JqGridBaseAction<SupplyPurchase>{
	
	private SupplyPurchaseService supplyPurchaseService;
	private Result result;
	private SupplyPurchase supplyPurchase;
	private Long id;
	private String ids;
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	public String export(){
		Filter filter = new Filter(SupplyPurchase.class);
		filter.createAlias("supply", "supply");
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("办公用品采购申请")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("办公用品采购申请列表", generateExportColumns(columns), root, out);
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
		result = supplyPurchaseService.save(supplyPurchase);
		return JSON;
	}
	
	public String view(){
		result = supplyPurchaseService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = supplyPurchaseService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SupplyPurchase dbBean = supplyPurchaseService.getBeanById(supplyPurchase.getId()).getValue();
		BeanUtil.copyProperties(supplyPurchase, dbBean);
		result = supplyPurchaseService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = supplyPurchaseService.deleteById(id);
		} else if(ids!=null){
			result = supplyPurchaseService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(SupplyPurchase.class));
	}
	public String listAll(){
		Filter filter = new Filter(SupplyPurchase.class);
		return refresh(filter);
	}
	
	@Override
	protected List<SupplyPurchase> getListByFilter(Filter fitler) {
		return supplyPurchaseService.getListByFilter(fitler).getValue();
	}
	
	
	public SupplyPurchase getSupplyPurchase() {
		return supplyPurchase;
	}

	public void setSupplyPurchase(SupplyPurchase supplyPurchase) {
		this.supplyPurchase = supplyPurchase;
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

	public void setSupplyPurchaseService(SupplyPurchaseService supplyPurchaseService) {
		this.supplyPurchaseService = supplyPurchaseService;
	}
	
	public Result getResult() {
		return result;
	}

	public String getExcelName() {
		return excelName;
	}

	public void setExcelName(String excelName) {
		this.excelName = excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getColumns() {
		return columns;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}
	
}
