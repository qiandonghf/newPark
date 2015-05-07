package com.wiiy.pb.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
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
import com.wiiy.pb.entity.MeterLabel;
import com.wiiy.pb.entity.MeterLabelRecord;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.MeterLabelRecordService;
import com.wiiy.pb.service.MeterLabelService;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.ParkService;

public class MeterLabelRecordAction extends JqGridBaseAction<MeterLabelRecord>{
	private MeterLabelRecordService meterLabelRecordService;
	private MeterService meterService;
	private MeterLabelService meterLabelService;
	private ParkService parkService;
	private MeterLabelRecord meterLabelRecord;
	private Result result;
	private Class<?> recordClass = MeterLabelRecord.class;
	private List<MeterLabelRecord> meterLabelRecordList;
	private List<Meter> meterList = new ArrayList<Meter>();
	private Long labelId;
	private Long id;
	private String ids;
	private String existIds;
	private String labelName;
	private String lableType;
	private Date date;//修改的本期抄表时间
	private Double curReading;//修改的本期读数
	private Double fdAmount;//修改的峰电数
	private Double gdAmount;//修改的谷电数
	private Double jdAmount;//修改单尖电数
	private Double hdAmount;//修改的耗电数
	private String excelName;
	private String str;
	private String checkOut;
	private InputStream inputStream;
	private boolean option = true;
	
	public String checkWaterEleFee(){
		result = meterLabelRecordService.waterEleFee(labelId,ids);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(MeterLabelRecord.class).eq("labelId", labelId);
		
		return refresh(filter);
	}
	public String waterEleView(){
		result = meterLabelService.getBeanById(labelId);
		if(MeterTypeEnum.WATER.equals(meterLabelService.getBeanById(labelId).getValue().getType())){
			return "waterView";
		}else{
			return "EleView";
		}
	}
	public String delete(){
		if(id!=null){
			result = meterLabelRecordService.deleteById(id);
		}
		if(ids!=null){
			result = meterLabelRecordService.deleteByIds(ids);
		}
		return JSON;
	}
	public String addMeter(){
		List<String> existList = Arrays.asList(existIds.split(","));
		List<String> newList = Arrays.asList(ids.split(","));
		result = meterLabelRecordService.addMeter(labelId,existList,newList);
		return JSON;
	}
	public String update(){
		MeterLabelRecord mlr = meterLabelRecordService.getBeanById(id).getValue();

		if(date!=null){
			mlr.setCurDate(date);
		}
		if(curReading!= null&&curReading>mlr.getPreReading()){
			mlr.setCurReading(curReading);
			mlr.setAmount(curReading-mlr.getPreReading());
			mlr.setSyAmount(mlr.getMeterFactor()*(curReading-mlr.getPreReading()));
		}
		if(fdAmount != null){
			mlr.setFdAmount(fdAmount);
		}
		if(gdAmount != null){
			mlr.setGdAmount(gdAmount);
		}
		if(jdAmount != null){
			mlr.setJdAmount(jdAmount);
		}
		if(hdAmount != null){
			mlr.setHdAmount(hdAmount);
		}
		if(curReading!= null && hdAmount != null){
			mlr.setTotalAmount(mlr.getMeterFactor()*(curReading-mlr.getPreReading())+hdAmount);
		}
		result = meterLabelRecordService.update(mlr);
		if(result.isSuccess()){
			Meter dbean = meterService.getBeanById(mlr.getMeterId()).getValue();
			dbean.setReadingDate(date);
			dbean.setPreReading(curReading);
			meterService.update(dbean);
		}
		return JSON;
	}
	public String updateWGRGenaratorReport(){
		MeterLabelRecord mlr = meterLabelRecordService.getBeanById(id).getValue();
		String[] strs = str.split(":");
		double price = Double.parseDouble(strs[0]);
		double totalBill = Double.parseDouble(strs[1]);
		mlr.setPrice(price);
		mlr.setTotalBill(totalBill);
		result = meterLabelRecordService.update(mlr);
		return JSON;
	}
	public String updateGenaratorReport(){
		MeterLabelRecord mlr = meterLabelRecordService.getBeanById(id).getValue();
		String[] strs = str.split(":");
		double price = Double.parseDouble(strs[0]);
		double bill = Double.parseDouble(strs[1]);
		double capacity = Double.parseDouble(strs[2]);
		double capacityBill = Double.parseDouble(strs[3]);
		double totalBill = Double.parseDouble(strs[4]);
		mlr.setPrice(price);
		mlr.setBill(bill);
		mlr.setCapacity(capacity);
		mlr.setCapacityBill(capacityBill);
		mlr.setTotalBill(totalBill);
		result = meterLabelRecordService.update(mlr);
		return JSON;
	}
	
	public String updateWater(){
		MeterLabelRecord mlr = meterLabelRecordService.getBeanById(id).getValue();
		if(date!=null){
			mlr.setCurDate(date);
		}
		if(curReading!= null&&curReading>mlr.getPreReading()){
			mlr.setCurReading(curReading);
			mlr.setAmount(curReading-mlr.getPreReading());
			mlr.setSyAmount(mlr.getMeterFactor()*(curReading-mlr.getPreReading()));
			mlr.setTotalAmount(mlr.getMeterFactor()*(curReading-mlr.getPreReading()));
		}
		result = meterLabelRecordService.update(mlr);
		if(result.isSuccess()){
			Meter dbean = meterService.getBeanById(mlr.getMeterId()).getValue();
			dbean.setReadingDate(date);
			dbean.setPreReading(curReading);
			meterService.update(dbean);
		}
		return JSON;
	}
	public String validatGenerateReport(){
		result = meterLabelRecordService.generateReport(labelId,true);
		if(result.isSuccess()){
			option = false;
			checkOut = "GENERATED";
		}
		return JSON;
	}
	public String generateReport(){
		result = meterLabelRecordService.generateReport(labelId,false);
		MeterLabel meterLabel = meterLabelService.getBeanById(labelId).getValue();
		checkOut = meterLabel.getCheckOut().toString();
		ServletActionContext.getRequest().setAttribute("checkOut", checkOut);
		if(MeterTypeEnum.ELECTRICITY.equals(meterLabel.getType())){
			return "genarateReport";
		}else {
			return "watergenarateReport";
		}
	}
	public String print(){
		result = meterLabelRecordService.printFee(labelId);
		if(lableType.equals((MeterTypeEnum.WATER.toString()))){
			return "printWater";
		}else{
			return "printEle";
		}
	
	}
	
	public String printFee(){
		result = meterLabelRecordService.printFee(labelId);
		if(lableType.equals((MeterTypeEnum.WATER.toString()))){
			return "printWaterFee";
		}else{
			return "printEleFee";
		}
	}
	
	public String export(){
		MeterLabel meterLabel = meterLabelService.getBeanById(labelId).getValue();
		lableType = meterLabel.getType().getTitle();
		String title = meterLabel.getName()+"("+lableType+")";
		Filter filter = new Filter(MeterLabelRecord.class).eq("labelId", labelId);
		meterLabelRecordList = meterLabelRecordService.getListByFilter(filter).getValue();
		
		excelName = StringUtil.URLEncoderToUTF8(title)+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export(title,generateExportColumns(meterLabelRecordList),meterLabelRecordList,out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	protected LinkedHashMap<String, String> generateExportColumns(List<MeterLabelRecord> list) {
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		Field[] fields = recordClass.getDeclaredFields();
		for (Field field : fields) {
			if(!field.getName().equals("meterLabel") && !field.getName().equals("labelId") &&!field.getName().equals("meterId") &&
					!field.getName().equals("meterType") &&!field.getName().equals("buildingId")){
				Annotation[] annos;
				try {
					annos = MeterLabelRecord.class.getDeclaredField(field.getName()).getAnnotations();
					for(Annotation ann:annos){
			            //ann就是一个Annotation 对象
			            //判断当前ann是否是FieldDescription注解类型
			            if(ann instanceof FieldDescription){
			            	if(((FieldDescription)ann).value().equals("楼宇名称")){
			            		map.put(field.getName(),"单位名称");
			            	}else if(((FieldDescription)ann).value().equals("房间名称")){
			            		map.put(field.getName(),"单元号");
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
	protected List<MeterLabelRecord> getListByFilter(Filter filter) {
		return meterLabelRecordService.getListByFilter(filter).getValue();
	}

	public MeterLabelRecord getMeterLabelRecord() {
		return meterLabelRecord;
	}

	public void setMeterLabelRecord(MeterLabelRecord meterLabelRecord) {
		this.meterLabelRecord = meterLabelRecord;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public void setMeterLabelRecordService(
			MeterLabelRecordService meterLabelRecordService) {
		this.meterLabelRecordService = meterLabelRecordService;
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

	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}

	public List<MeterLabelRecord> getMeterLabelRecordList() {
		return meterLabelRecordList;
	}

	public void setMeterLabelRecordList(List<MeterLabelRecord> meterLabelRecordList) {
		this.meterLabelRecordList = meterLabelRecordList;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setMeterLabelService(MeterLabelService meterLabelService) {
		this.meterLabelService = meterLabelService;
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
	public Double getFdAmount() {
		return fdAmount;
	}

	public void setFdAmount(Double fdAmount) {
		this.fdAmount = fdAmount;
	}

	public Double getGdAmount() {
		return gdAmount;
	}

	public void setGdAmount(Double gdAmount) {
		this.gdAmount = gdAmount;
	}

	public Double getJdAmount() {
		return jdAmount;
	}

	public void setJdAmount(Double jdAmount) {
		this.jdAmount = jdAmount;
	}

	public Double getHdAmount() {
		return hdAmount;
	}

	public void setHdAmount(Double hdAmount) {
		this.hdAmount = hdAmount;
	}
	public List<Meter> getMeterList() {
		return meterList;
	}

	public void setMeterList(List<Meter> meterList) {
		this.meterList = meterList;
	}
	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}
	public boolean isOption() {
		return option;
	}

	public void setOption(boolean option) {
		this.option = option;
	}
	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		this.str = str;
	}
	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}


}
