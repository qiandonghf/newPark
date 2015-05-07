package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Archives;
import com.wiiy.oa.entity.Position;
import com.wiiy.oa.entity.SalaryDefine;
import com.wiiy.oa.entity.SalaryDefineCfg;
import com.wiiy.oa.entity.SalaryItem;
import com.wiiy.oa.preferences.enums.PositionConditionEnum;
import com.wiiy.oa.service.ArchivesService;
import com.wiiy.oa.service.PositionService;
import com.wiiy.oa.service.SalaryDefineCfgService;
import com.wiiy.oa.service.SalaryDefineService;
import com.wiiy.oa.service.SalaryItemService;

public class ArchivesAction extends JqGridBaseAction<Archives>{
	private ArchivesService archivesService;
	private PositionService positionService;
	private SalaryDefineService salaryDefineService;
	private SalaryDefineCfgService salaryDefineCfgService;
	private SalaryItemService salaryItemService;
	private Archives archives;
	private Long id;
	private String ids;
	private Result result;
	private List<Position> positionList = new ArrayList<Position>();
	private List<SalaryDefine> salaryDefines = new ArrayList<SalaryDefine>();
	private double count = 0;//薪资标准金额
	private String excelName;
	private InputStream inputStream;
	private String columns;
	private String listIndex;
	private List<Archives> list;
	private int countExpire;

	public String list(){
		Filter filter = new Filter(Archives.class);
		if(listIndex.equals("IN")){
			filter.eq("status", PositionConditionEnum.WORK);
		}else{
			filter.eq("status", PositionConditionEnum.NOTWORK);
		}
		return refresh(filter);
	}
	public String listDesktop(){
		Filter filter = new Filter(Archives.class);
		filter.eq("status", PositionConditionEnum.WORK).le("endTime", CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 7).getTime());
		list = archivesService.getListByFilter(filter).getValue();
		return JSON;
	}
	public String countExpire(){
		Filter filter = new Filter(Archives.class);
		filter.eq("status", PositionConditionEnum.WORK).le("endTime", CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 7).getTime());
		countExpire = archivesService.getListByFilter(filter).getValue().size();
		return JSON;
	}
	public String listIn(){
		listIndex = "IN"; 
		return "list";
	}
	public String listOut(){
		listIndex = "OUT";
		return "list";
	}
	
	public String addOut(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		return "add";
	}
	public String add(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		return "add";
	}
	public String show(){
		List<SalaryDefineCfg> salaryDefineCfgs = new ArrayList<SalaryDefineCfg>();
		result = salaryDefineService.getBeanByFilter(new Filter(SalaryDefine.class).eq("id", id));
		salaryDefineCfgs = salaryDefineCfgService.getListByFilter(new Filter(SalaryDefineCfg.class).eq("salaryDefineId", id)).getValue();
		for (SalaryDefineCfg salaryDefineCfg : salaryDefineCfgs) {
			SalaryItem salaryItem = new SalaryItem();
			salaryItem = salaryItemService.getBeanById(salaryDefineCfg.getSalaryItemId()).getValue();
			count+=salaryItem.getDefaultVal();
		}
		return JSON;
	}
	public String save(){
		result = archivesService.save(archives);
		return JSON;
	}
	public String deleteOut(){
		if(id!=null){
			result = archivesService.deleteById(id);
		}
		if(ids!=null){
			result = archivesService.deleteByIds(ids);
		}
		return JSON;
	}
	public String delete(){
		if(id!=null){
			result = archivesService.deleteById(id);
		}
		if(ids!=null){
			result = archivesService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String viewOut(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		result = archivesService.getBeanById(id);
		return VIEW;
	}
	public String view(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		result = archivesService.getBeanById(id);
		return VIEW;
	}
	public String editOut(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		result = archivesService.getBeanById(id);
		return EDIT;
	}
	public String edit(){
		positionList = positionService.getList().getValue();
		salaryDefines = salaryDefineService.getList().getValue();
		result = archivesService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Archives dbBean = archivesService.getBeanById(archives.getId()).getValue();
		BeanUtil.copyProperties(archives, dbBean);
		result = archivesService.update(dbBean);
		return JSON;
	}
	
	public String export() throws UnsupportedEncodingException{
		Filter filter = new Filter(Archives.class);
		filter.createAlias("org", "org");
		page=0;//不要分页
		if(listIndex.equals("IN")){
			filter.eq("status", PositionConditionEnum.WORK);
			refresh(filter);
			excelName = StringUtil.URLEncoderToUTF8("在职人员档案列表")+".xls";
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			POIUtil.export("在职人员档案列表",generateExportColumns(columns),root,out);
			inputStream = new ByteArrayInputStream(out.toByteArray());
		}else if(listIndex.equals("OUT")){
			filter.eq("status", PositionConditionEnum.NOTWORK);
			refresh(filter);
			excelName = StringUtil.URLEncoderToUTF8("离职人员档案列表")+".xls";
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			POIUtil.export("离职人员档案列表",generateExportColumns(columns),root,out);
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
	
	public String getListIndex() {
		return listIndex;
	}

	public void setListIndex(String listIndex) {
		this.listIndex = listIndex;
	}
	
	public Archives getArchives() {
		return archives;
	}
	
	public void setArchives(Archives archives) {
		this.archives = archives;
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

	public void setArchivesService(ArchivesService archivesService) {
		this.archivesService = archivesService;
	}

	@Override
	protected List<Archives> getListByFilter(Filter fitler) {
		return archivesService.getListByFilter(fitler).getValue();
	}
	
	public List<SalaryDefine> getSalaryDefines() {
		return salaryDefines;
	}

	public void setSalaryDefines(List<SalaryDefine> salaryDefines) {
		this.salaryDefines = salaryDefines;
	}

	public void setSalaryDefineService(SalaryDefineService salaryDefineService) {
		this.salaryDefineService = salaryDefineService;
	}

	public List<Position> getPositionList() {
		return positionList;
	}

	public void setPositionList(List<Position> positionList) {
		this.positionList = positionList;
	}

	public void setPositionService(PositionService positionService) {
		this.positionService = positionService;
	}
	
	public void setSalaryDefineCfgService(
			SalaryDefineCfgService salaryDefineCfgService) {
		this.salaryDefineCfgService = salaryDefineCfgService;
	}

	public void setSalaryItemService(SalaryItemService salaryItemService) {
		this.salaryItemService = salaryItemService;
	}

	public double getCount() {
		return count;
	}

	public void setCount(double count) {
		this.count = count;
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

	public List<Archives> getList() {
		return list;
	}

	public void setList(List<Archives> list) {
		this.list = list;
	}

	public int getCountExpire() {
		return countExpire;
	}

	public void setCountExpire(int countExpire) {
		this.countExpire = countExpire;
	}
}
