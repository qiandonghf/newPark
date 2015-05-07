package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.CustomerLabelRef;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.preferences.enums.CustomerApplyState;
import com.wiiy.crm.preferences.enums.CustomerBaseEnum;
import com.wiiy.crm.preferences.enums.CustomerRouteTypeEnum;
import com.wiiy.crm.preferences.enums.CustomerTypeEnum;
import com.wiiy.crm.preferences.enums.ParkStatusEnum;
import com.wiiy.pb.entity.GardenApply;

/**
 * <br/>class-description 企业
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Customer extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	
	public Customer() {
		super();
	}
	public Customer(Long id,String name) {
		super();
		this.id = id;
		this.name = name;
	}
	public Customer(Long id, String name, ParkStatusEnum parkStatus) {
		super();
		this.id = id;
		this.name = name;
		this.parkStatus = parkStatus;
	}
	private Long id;
	/**
	 * 苗圃项目实体
	 */
	@FieldDescription("苗圃项目实体")
	private GardenApply gardenApply;
	/**
	 * 技术领域实体
	 */
	@FieldDescription("技术领域实体")
	private DataDict technic;
	/**
	 * 企业来源实体
	 */
	@FieldDescription("企业来源实体")
	private DataDict source;
	/**
	 * 创业者归属实体
	 */
	@FieldDescription("创业者归属实体")
	private DataDict enterpriseType;
	/**
	 * 招商项目实体
	 */
	@FieldDescription("招商项目实体")
	private Investment investment;
	/**
	 * 详细信息
	 */
	@FieldDescription("详细信息")
	private CustomerInfo customerInfo;
	/**
	 * 孵化信息
	 */
	@FieldDescription("孵化信息")
	private IncubationInfo incubationInfo;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String name;
	/**
	 * 入园时间
	 */
	@FieldDescription("入园时间")
	private Date parkTime;
	/**
	 * 申请宣传时间
	 */
	@FieldDescription("申请宣传时间")
	private Date applyTime;
	/**
	 * 简称
	 */
	@FieldDescription("简称")
	private String shortName;
	/**
	 * 企业编码
	 */
	@FieldDescription("企业编码")
	private String code;
	/**
	 * 企业logo
	 */
	@FieldDescription("企业logo")
	private String logo;
	/**
	 * 账号ID
	 */
	@FieldDescription("账号ID")
	private Long userId;
	/**
	 * 企业经理ID
	 */
	@FieldDescription("企业经理ID")
	private Long hostId;
	/**
	 * 企业经理
	 */
	@FieldDescription("企业经理")
	private String hostName;
	/**
	 * 引进ID
	 */
	@FieldDescription("引进ID")
	private Long importId;
	/**
	 * 引进
	 */
	@FieldDescription("引进")
	private String importName;
	/**
	 * 入驻状态
	 */
	@FieldDescription("入驻状态")
	private ParkStatusEnum parkStatus;
	/**
	 * 状态变更时间
	 */
	@FieldDescription("状态变更时间")
	private Date time;
	/**
	 * 苗圃项目外键
	 */
	@FieldDescription("苗圃项目外键")
	private Long gardenApplyId;
	/**
	 * 申请宣传状态
	 */
	@FieldDescription("申请宣传状态")
	private CustomerApplyState pub;
	/**
	 * 企业宣传内容
	 */
	@FieldDescription("企业宣传内容")
	private String content;
	/**
	 * 所属基地
	 */
	@FieldDescription("所属基地")
	private CustomerBaseEnum base;
	/**
	 * 技术领域外键
	 */
	@FieldDescription("技术领域外键")
	private String technicId;
	/**
	 * 企业来源外键
	 */
	@FieldDescription("企业来源外键")
	private String sourceId;
	/**
	 * 创业者归属外键
	 */
	@FieldDescription("创业者归属外键")
	private String enterpriseTypeId;
	/**
	 * 是否孵化企业
	 */
	@FieldDescription("是否孵化企业")
	private BooleanEnum incubated;
	/**
	 * 企业类型
	 */
	@FieldDescription("企业类型")
	private CustomerTypeEnum type;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private Long investmentId;
	/**
	 * 上报类型
	 */
	@FieldDescription("上报类型")
	private CustomerRouteTypeEnum reportType;
	/**
	 * 标签信息
	 */
	@FieldDescription("标签信息")
	private Set<CustomerLabelRef> labelRefs;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 苗圃项目实体
	 */
	public GardenApply getGardenApply() {
		return gardenApply;
	}
	public void setGardenApply(GardenApply gardenApply) {
		this.gardenApply = gardenApply;
	}
	/**
	 * 技术领域实体
	 */
	public DataDict getTechnic(){
		return technic;
	}
	public void setTechnic(DataDict technic){
		this.technic = technic;
	}
	/**
	 * 企业来源实体
	 */
	public DataDict getSource(){
		return source;
	}
	public void setSource(DataDict source){
		this.source = source;
	}
	/**
	 * 创业者归属实体
	 */
	public DataDict getEnterpriseType(){
		return enterpriseType;
	}
	public void setEnterpriseType(DataDict enterpriseType){
		this.enterpriseType = enterpriseType;
	}
	/**
	 * 招商项目实体
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
	}
	/**
	 * 详细信息
	 */
	public CustomerInfo getCustomerInfo(){
		return customerInfo;
	}
	public void setCustomerInfo(CustomerInfo customerInfo){
		this.customerInfo = customerInfo;
	}
	/**
	 * 孵化信息
	 */
	public IncubationInfo getIncubationInfo(){
		return incubationInfo;
	}
	public void setIncubationInfo(IncubationInfo incubationInfo){
		this.incubationInfo = incubationInfo;
	}
	/**
	 * 企业名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 入园时间
	 */
	public Date getParkTime(){
		return parkTime;
	}
	public void setParkTime(Date parkTime){
		this.parkTime = parkTime;
	}
	/**
	 * 简称
	 */
	public String getShortName(){
		return shortName;
	}
	public void setShortName(String shortName){
		this.shortName = shortName;
	}
	/**
	 * 企业编码
	 */
	public String getCode(){
		return code;
	}
	public void setCode(String code){
		this.code = code;
	}
	/**
	 * 账号ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 企业经理ID
	 */
	public Long getHostId(){
		return hostId;
	}
	public void setHostId(Long hostId){
		this.hostId = hostId;
	}
	/**
	 * 企业经理
	 */
	public String getHostName(){
		return hostName;
	}
	public void setHostName(String hostName){
		this.hostName = hostName;
	}
	/**
	 * 引进ID
	 */
	public Long getImportId(){
		return importId;
	}
	public void setImportId(Long importId){
		this.importId = importId;
	}
	/**
	 * 引进
	 */
	public String getImportName(){
		return importName;
	}
	public void setImportName(String importName){
		this.importName = importName;
	}
	/**
	 * 入驻状态
	 */
	public ParkStatusEnum getParkStatus(){
		return parkStatus;
	}
	public void setParkStatus(ParkStatusEnum parkStatus){
		this.parkStatus = parkStatus;
	}
	/**
	 * 状态变更时间
	 */
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	/**
	 * 苗圃项目外键
	 */
	public Long getGardenApplyId() {
		return gardenApplyId;
	}
	public void setGardenApplyId(Long gardenApplyId) {
		this.gardenApplyId = gardenApplyId;
	}
	/**
	 * 申请宣传状态
	 */
	public CustomerApplyState getPub() {
		return pub;
	}
	public void setPub(CustomerApplyState pub) {
		this.pub = pub;
	}
	/**
	 * 企业宣传内容
	 */
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * 技术领域外键
	 */
	public String getTechnicId(){
		return technicId;
	}
	public void setTechnicId(String technicId){
		this.technicId = technicId;
	}
	/**
	 * 企业来源外键
	 */
	public String getSourceId(){
		return sourceId;
	}
	public void setSourceId(String sourceId){
		this.sourceId = sourceId;
	}
	/**
	 * 创业者归属外键
	 */
	public String getEnterpriseTypeId(){
		return enterpriseTypeId;
	}
	public void setEnterpriseTypeId(String enterpriseTypeId){
		this.enterpriseTypeId = enterpriseTypeId;
	}
	/**
	 * 是否孵化企业
	 */
	public BooleanEnum getIncubated(){
		return incubated;
	}
	public void setIncubated(BooleanEnum incubated){
		this.incubated = incubated;
	}
	/**
	 * 企业类型
	 */
	public CustomerTypeEnum getType(){
		return type;
	}
	public void setType(CustomerTypeEnum type){
		this.type = type;
	}
	/**
	 * 招商项目外键
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 上报类型
	 */
	public CustomerRouteTypeEnum getReportType(){
		return reportType;
	}
	public void setReportType(CustomerRouteTypeEnum reportType){
		this.reportType = reportType;
	}
	/**
	 * 标签信息
	 */
	public Set<CustomerLabelRef> getLabelRefs(){
		return labelRefs;
	}
	public void setLabelRefs(Set<CustomerLabelRef> labelRefs){
		this.labelRefs = labelRefs;
	}
	/**
	 * 所属基地
	 */
	public CustomerBaseEnum getBase() {
		return base;
	}
	public void setBase(CustomerBaseEnum base) {
		this.base = base;
	}
	/**
	 * 申请宣传时间
	 */
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
}