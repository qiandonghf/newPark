package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.FixedAssets;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.preferences.enums.FixedAssetsStatusEnum;
import com.wiiy.oa.service.FixedAssetsService;

public class FixedAssetsAction extends JqGridBaseAction<FixedAssets>{
	private FixedAssetsService fixedAssetsService;
	private FixedAssets fixedAssets;
	private Result<?> result;
	private Long id;
	private String ids;
	private String typeId;
	private List<DataDict> typeList;
	private List<FixedAssets> fixedAssetsList = new ArrayList<FixedAssets>();
	
	private String excelName;
	private InputStream inputStream;
	private String columns;
	
	private int type;

	public String export(){
		Filter filter = new Filter(FixedAssets.class);
		//filter.createAlias("org", "org");
		page=0;//不要分页
		if(type==1){
			if(typeId!=null && !"".equals(typeId)){
				filter.eq("status", FixedAssetsStatusEnum.NORMAL).eq("typeId", typeId);
			}else{
				filter.eq("status", FixedAssetsStatusEnum.NORMAL);
			}
			refresh(filter);
			excelName = StringUtil.URLEncoderToUTF8("固定资产")+".xls";
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			POIUtil.export("固定资产列表", generateExportColumns(columns), root, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		}
		if(type==2){
			filter.eq("status", FixedAssetsStatusEnum.BROKEN);
			refresh(filter);
			excelName = StringUtil.URLEncoderToUTF8("报废资产")+".xls";
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			POIUtil.export("报废资产列表", generateExportColumns(columns), root, out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		}
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
	
	//固定资产折算
	public String convert(){
		result = fixedAssetsService.convert(id);
		return JSON;
	}
	
	public String fixedAssetsTree(){
		typeList = OaActivator.getDataDictInitService().getDataDictByParentId("oa.0003");
		fixedAssetsList = fixedAssetsService.getList().getValue();
		return LIST;
	}
	public String save(){	
		fixedAssets.setStatus(FixedAssetsStatusEnum.NORMAL);
		result = fixedAssetsService.save(fixedAssets);
		return JSON;
	}
	
	public String addFixedAssets(){
		return "add";
	}
	
	public String edit(){
		result = fixedAssetsService.getBeanById(id);
		return EDIT;
	}
	
	public String view(){
		result = fixedAssetsService.getBeanById(id);
		return VIEW;
	}
	
	public String delete(){
		if(id!=null){
			result = fixedAssetsService.deleteById(id);
		}else if(ids!=null){
			result = fixedAssetsService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		FixedAssets dbBean = fixedAssetsService.getBeanById(fixedAssets.getId()).getValue();
		BeanUtil.copyProperties(fixedAssets, dbBean);
		result = fixedAssetsService.update(dbBean);
		return JSON;
	}
	
	//新建固定资产管理
	public String list(){
		Filter filter = new Filter(FixedAssets.class).eq("status", FixedAssetsStatusEnum.NORMAL);		
		return refresh(filter);
	}
	//报废资产管理
	public String list2(){
		Filter filter = new Filter(FixedAssets.class).eq("status", FixedAssetsStatusEnum.BROKEN);			
		return refresh(filter);
	}
	
	public String loadTreeById(){
		Filter filter = new Filter(FixedAssets.class).eq("id", id);
		return refresh(filter);	
	}
	public String loadTreeByTypeId(){		
		Filter filter = new Filter(FixedAssets.class).eq("typeId", typeId);		
		return refresh(filter);	
	}
	@Override
	protected List<FixedAssets> getListByFilter(Filter fitler) {
		return fixedAssetsService.getListByFilter(fitler).getValue();
	}

	public FixedAssets getFixedAssets() {
		return fixedAssets;
	}

	public void setFixedAssets(FixedAssets fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	public Result<?> getResult() {
		return result;
	}

	public void setResult(Result<?> result) {
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

	public void setFixedAssetsService(FixedAssetsService fixedAssetsService) {
		this.fixedAssetsService = fixedAssetsService;
	}
	

	public List<DataDict> getTypeList() {
		return typeList;
	}

	public void setTypeList(List<DataDict> typeList) {
		this.typeList = typeList;
	}

	public List<FixedAssets> getFixedAssetsList() {
		return fixedAssetsList;
	}

	public void setFixedAssetsList(List<FixedAssets> fixedAssetsList) {
		this.fixedAssetsList = fixedAssetsList;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
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
	
	public void setType(int type) {
		this.type = type;
	}

	public int getType() {
		return type;
	}
}
