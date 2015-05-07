package com.wiiy.pb.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.MeterLabelRecord;
import com.wiiy.pb.entity.SelfLabelRecord;
import com.wiiy.pb.entity.SelfMeterLabel;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.SelfLabelRecordService;
import com.wiiy.pb.service.SelfMeterLabelService;

public class SelfLabelRecordAction extends JqGridBaseAction<SelfLabelRecord>{
	private SelfLabelRecordService selfLabelRecordService;
	private MeterService meterService;
	private SelfMeterLabelService selfMeterLabelService;
	
	private SelfLabelRecord selfLabelRecord;
	private Result result;
	private Class<?> recordClass = SelfLabelRecord.class;
	
	private List<SelfLabelRecord> selfLabelRecordList;
	private Long labelId;
	private Long id;
	private String ids;
	private String existIds;
	private String labelName;
	private String lableType;
	
	private Date date;//修改的本期抄表时间
	private Double curReading;//修改的本期读数
	private String excelName;
	private InputStream inputStream;
	
	public String list(){
		Filter filter = new Filter(SelfLabelRecord.class).eq("labelId", labelId);
		return refresh(filter);
	}
	
	public String delete(){
		if(id!=null){
			result = selfLabelRecordService.deleteById(id);
		}
		if(ids!=null){
			result = selfLabelRecordService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String addMeter(){
		List<String> existList = Arrays.asList(existIds.split(","));
		List<String> newList = Arrays.asList(ids.split(","));
		result = selfLabelRecordService.addMeter(labelId,existList,newList);
		return JSON;
	}
	
	public String update(){
		SelfLabelRecord mlr = selfLabelRecordService.getBeanById(id).getValue();
		if(date!=null){
			mlr.setCurDate(date);
		}
		if(curReading!=null){
			mlr.setCurReading(curReading);
		}
		result = selfLabelRecordService.update(mlr);
		if(result.isSuccess()){
			Meter dbean = meterService.getBeanById(mlr.getMeterId()).getValue();
			dbean.setReadingDate(date);
			dbean.setPreReading(curReading);
			meterService.update(dbean);
		}
		return JSON;
	}
	
	public String print(){
		Filter filter = new Filter(SelfLabelRecord.class).eq("labelId", labelId);
		SelfMeterLabel meterLabel = selfMeterLabelService.getBeanById(labelId).getValue();
		ServletActionContext.getRequest().setAttribute("lableType", lableType);
		ServletActionContext.getRequest().setAttribute("labelId", labelId);
		ServletActionContext.getRequest().setAttribute("labelName", meterLabel.getName());
		selfLabelRecordList = selfLabelRecordService.getListByFilter(filter).getValue();
		return "print";
	}
	
	public String export(){
		SelfMeterLabel meterLabel = selfMeterLabelService.getBeanById(labelId).getValue();
		lableType = meterLabel.getType().getTitle();
		String title = meterLabel.getName()+"("+lableType+")";
		Filter filter = new Filter(MeterLabelRecord.class).eq("labelId", labelId);
		selfLabelRecordList = selfLabelRecordService.getListByFilter(filter).getValue();
		
		excelName = StringUtil.URLEncoderToUTF8(title)+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export(title,generateExportColumns(selfLabelRecordList),selfLabelRecordList,out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	protected LinkedHashMap<String, String> generateExportColumns(List<SelfLabelRecord> list) {
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		Field[] fields = recordClass.getDeclaredFields();
		for (Field field : fields) {
			if(!field.getName().equals("meterLabel") && !field.getName().equals("labelId") &&!field.getName().equals("meterId") &&
					!field.getName().equals("meterType") &&!field.getName().equals("buildingId")){
				Annotation[] annos;
				try {
					annos = SelfLabelRecord.class.getDeclaredField(field.getName()).getAnnotations();
					for(Annotation ann:annos){
			            //ann就是一个Annotation 对象
			            //判断当前ann是否是FieldDescription注解类型
			            if(ann instanceof FieldDescription){
			            	if(((FieldDescription)ann).value().equals("楼宇名称")){
			            		map.put(field.getName(),"单位名称");
			            	}else if(((FieldDescription)ann).value().equals("上期读数")){
			            		map.put(field.getName(),"上期数读(度)");
			            	}else if(((FieldDescription)ann).value().equals("本期数读")){
			            		map.put(field.getName(),"本期数读(度)");
			            	}else if(((FieldDescription)ann).value().equals("本期数读")){
			            		map.put(field.getName(),"本期数读(度)");
			            	}else{
			            		map.put(field.getName(),((FieldDescription)ann).value());
			            	}
			            }
			        }
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
		}
		return map;
	}
	
	
	
	@Override
	protected List<SelfLabelRecord> getListByFilter(Filter filter) {
		return selfLabelRecordService.getListByFilter(filter).getValue();
	}
	public SelfLabelRecord getSelfLabelRecord() {
		return selfLabelRecord;
	}
	public void setSelfLabelRecord(SelfLabelRecord selfLabelRecord) {
		this.selfLabelRecord = selfLabelRecord;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public List<SelfLabelRecord> getSelfLabelRecordList() {
		return selfLabelRecordList;
	}
	public void setSelfLabelRecordList(List<SelfLabelRecord> selfLabelRecordList) {
		this.selfLabelRecordList = selfLabelRecordList;
	}
	public Long getLabelId() {
		return labelId;
	}
	public void setLabelId(Long labelId) {
		this.labelId = labelId;
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
	public String getExistIds() {
		return existIds;
	}
	public void setExistIds(String existIds) {
		this.existIds = existIds;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getLableType() {
		return lableType;
	}
	public void setLableType(String lableType) {
		this.lableType = lableType;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Double getCurReading() {
		return curReading;
	}
	public void setCurReading(Double curReading) {
		this.curReading = curReading;
	}
	public String getExcelName() {
		return excelName;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setSelfLabelRecordService(
			SelfLabelRecordService selfLabelRecordService) {
		this.selfLabelRecordService = selfLabelRecordService;
	}
	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}
	public void setSelfMeterLabelService(SelfMeterLabelService selfMeterLabelService) {
		this.selfMeterLabelService = selfMeterLabelService;
	}
}
