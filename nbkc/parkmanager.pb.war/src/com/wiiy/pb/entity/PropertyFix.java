package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.pb.preferences.enums.FixDifficultyEnum;
import com.wiiy.pb.preferences.enums.PropertyFixStatusEnum;
import com.wiiy.pb.preferences.enums.SatisficingEnum;

/**
 * <br/>class-description 物业报修
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class PropertyFix extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报修类型
	 */
	@FieldDescription("报修类型")
	private DataDict type;
	/**
	 * 报修方式
	 */
	@FieldDescription("报修方式")
	private DataDict method;
	/**
	 * 报修时间
	 */
	@FieldDescription("报修时间")
	private Date reportTime;
	/**
	 * 接待人员
	 */
	@FieldDescription("接待人员")
	private String receiver;
	/**
	 * 报修人员
	 */
	@FieldDescription("报修人员")
	private String reporter;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 报修类型外键
	 */
	@FieldDescription("报修类型外键")
	private String typeId;
	/**
	 * 报修方式外键
	 */
	@FieldDescription("报修方式外键")
	private String methodId;
	/**
	 * 报修单号
	 */
	@FieldDescription("报修单号")
	private String oddNo;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 报修部门ID
	 */
	@FieldDescription("报修部门ID")
	private Long orgId;
	/**
	 * 报修部门名称
	 */
	@FieldDescription("报修部门名称")
	private String orgName;
	/**
	 * 报修地点
	 */
	@FieldDescription("报修地点")
	private String reportAddr;
	/**
	 * 报修原因
	 */
	@FieldDescription("报修原因")
	private String reportReason;
	/**
	 * 是否已处理
	 */
	@FieldDescription("是否已处理")
	private BooleanEnum finished;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private PropertyFixStatusEnum status;
	/**
	 * 难度
	 */
	@FieldDescription("难度")
	private FixDifficultyEnum difficulty;
	/**
	 * 满意度
	 */
	@FieldDescription("满意度")
	private SatisficingEnum satisficing;
	/**
	 * 完工日期
	 */
	@FieldDescription("完工日期")
	private Date finishTime;
	/**
	 * 维修人员
	 */
	@FieldDescription("维修人员")
	private String maintainer;
	/**
	 * 人工费用
	 */
	@FieldDescription("人工费用")
	private Double laborCosts;
	/**
	 * 材料费用
	 */
	@FieldDescription("材料费用")
	private Double materialCosts;
	/**
	 * 维修结果
	 */
	@FieldDescription("维修结果")
	private String result;
	/**
	 * 整改意见
	 */
	@FieldDescription("整改意见")
	private String rectification;
	/**
	 * 整改意见
	 */
	@FieldDescription("整改意见")
	private String meno;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 报修类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 报修方式
	 */
	public DataDict getMethod(){
		return method;
	}
	public void setMethod(DataDict method){
		this.method = method;
	}
	/**
	 * 报修时间
	 */
	public Date getReportTime(){
		return reportTime;
	}
	public void setReportTime(Date reportTime){
		this.reportTime = reportTime;
	}
	/**
	 * 接待人员
	 */
	public String getReceiver(){
		return receiver;
	}
	public void setReceiver(String receiver){
		this.receiver = receiver;
	}
	/**
	 * 报修人员
	 */
	public String getReporter(){
		return reporter;
	}
	public void setReporter(String reporter){
		this.reporter = reporter;
	}
	/**
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 报修类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 报修方式外键
	 */
	public String getMethodId(){
		return methodId;
	}
	public void setMethodId(String methodId){
		this.methodId = methodId;
	}
	/**
	 * 报修单号
	 */
	public String getOddNo(){
		return oddNo;
	}
	public void setOddNo(String oddNo){
		this.oddNo = oddNo;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 报修部门ID
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 报修部门名称
	 */
	public String getOrgName(){
		return orgName;
	}
	public void setOrgName(String orgName){
		this.orgName = orgName;
	}
	/**
	 * 报修地点
	 */
	public String getReportAddr(){
		return reportAddr;
	}
	public void setReportAddr(String reportAddr){
		this.reportAddr = reportAddr;
	}
	/**
	 * 报修原因
	 */
	public String getReportReason(){
		return reportReason;
	}
	public void setReportReason(String reportReason){
		this.reportReason = reportReason;
	}
	/**
	 * 是否已处理
	 */
	public BooleanEnum getFinished(){
		return finished;
	}
	public void setFinished(BooleanEnum finished){
		this.finished = finished;
	}
	/**
	 * 状态
	 */
	public PropertyFixStatusEnum getStatus(){
		return status;
	}
	public void setStatus(PropertyFixStatusEnum status){
		this.status = status;
	}
	/**
	 * 难度
	 */
	public FixDifficultyEnum getDifficulty(){
		return difficulty;
	}
	public void setDifficulty(FixDifficultyEnum difficulty){
		this.difficulty = difficulty;
	}
	/**
	 * 满意度
	 */
	public SatisficingEnum getSatisficing(){
		return satisficing;
	}
	public void setSatisficing(SatisficingEnum satisficing){
		this.satisficing = satisficing;
	}
	/**
	 * 完工日期
	 */
	public Date getFinishTime(){
		return finishTime;
	}
	public void setFinishTime(Date finishTime){
		this.finishTime = finishTime;
	}
	/**
	 * 维修人员
	 */
	public String getMaintainer(){
		return maintainer;
	}
	public void setMaintainer(String maintainer){
		this.maintainer = maintainer;
	}
	/**
	 * 人工费用
	 */
	public Double getLaborCosts(){
		return laborCosts;
	}
	public void setLaborCosts(Double laborCosts){
		this.laborCosts = laborCosts;
	}
	/**
	 * 材料费用
	 */
	public Double getMaterialCosts(){
		return materialCosts;
	}
	public void setMaterialCosts(Double materialCosts){
		this.materialCosts = materialCosts;
	}
	/**
	 * 维修结果
	 */
	public String getResult(){
		return result;
	}
	public void setResult(String result){
		this.result = result;
	}
	/**
	 * 整改意见
	 */
	public String getRectification(){
		return rectification;
	}
	public void setRectification(String rectification){
		this.rectification = rectification;
	}
	/**
	 * 整改意见
	 */
	public String getMeno(){
		return meno;
	}
	public void setMeno(String meno){
		this.meno = meno;
	}
}