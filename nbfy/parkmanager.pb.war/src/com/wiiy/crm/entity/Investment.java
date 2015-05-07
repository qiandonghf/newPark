package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.BusinessPlan;
import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.entity.InvestmentRegInfo;
import com.wiiy.crm.preferences.enums.InvestmentStatusEnum;
import com.wiiy.crm.preferences.enums.PriorityEnum;

/**
 * <br/>class-description 招商项目
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Investment extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 货币类型实体
	 */
	@FieldDescription("货币类型实体")
	private DataDict currency;
	/**
	 * 投资促进部审批
	 */
	@FieldDescription("投资促进部审批")
	private Approval departmentApproval;
	/**
	 * 分管主任审批
	 */
	@FieldDescription("分管主任审批")
	private Approval chiefApproval;
	/**
	 * 主任办公室审批
	 */
	@FieldDescription("主任办公室审批")
	private Approval officeApproval;
	
	/**
	 * 经理审批
	 */
	@FieldDescription("经理审批")
	private Approval managerApproval;
	/**
	 * 入驻场所
	 */
	@FieldDescription("入驻场所")
	private DataDict incubateConfig;
	/**
	 * 行业分类
	 */
	@FieldDescription("行业分类")
	private DataDict technic;
	/**
	 * 创业者归属实体
	 */
	@FieldDescription("创业者归属实体")
	private DataDict enterpriseType;
	/**
	 * 企业帐号
	 */
	@FieldDescription("企业帐号")
	private String account;
	/**
	 * 详细信息
	 */
	@FieldDescription("详细信息")
	private InvestmentRegInfo regInfo;
	/**
	 * 商业计划书
	 */
	@FieldDescription("商业计划书")
	private BusinessPlan businessPlan;
	/**
	 * 拟注册企业名称
	 */
	@FieldDescription("拟注册企业名称")
	private String name;
	/**
	 * 企业人数
	 */
	@FieldDescription("企业人数")
	private Integer staff;
	/**
	 * 编号
	 */
	@FieldDescription("编号")
	private String code;
	/**
	 * 注册资本
	 */
	@FieldDescription("注册资本")
	private Double regCapital;
	/**
	 * 货币类型外键
	 */
	@FieldDescription("货币类型外键")
	private String currencyId;
	/**
	 * 跟踪ID
	 */
	@FieldDescription("跟踪ID")
	private Long hostId;
	/**
	 * 跟踪
	 */
	@FieldDescription("跟踪")
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
	 * 计划总投资
	 */
	@FieldDescription("计划总投资")
	private Double investCapital;
	/**
	 * 预计年产值
	 */
	@FieldDescription("预计年产值")
	private Double outputValue;
	/**
	 * 是否申请用房
	 */
	@FieldDescription("是否申请用房")
	private BooleanEnum needOffice;
	/**
	 * 申请用房面积
	 */
	@FieldDescription("申请用房面积")
	private Double officeArea;
	/**
	 * 申请用房名称
	 */
	@FieldDescription("申请用房名称")
	private String officeName;
	
	/**
	 * 经营范围
	 */
	@FieldDescription("经营范围")
	private String businessScope;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 实际办公地址
	 */
	@FieldDescription("实际办公地址")
	private String address;
	/**
	 * 招商状态
	 */
	@FieldDescription("招商状态")
	private InvestmentStatusEnum investmentStatus;
	/**
	 * 重要性
	 */
	@FieldDescription("重要性")
	private PriorityEnum priority;
	/**
	 * 业务员意见
	 */
	@FieldDescription("业务员意见")
	private String businessmanSuggestion;
	/**
	 * 经理审批ID
	 */
	@FieldDescription("经理审批ID")
	private Long managerApprovalId;
	
	/**
	 * 投资促进部审批ID
	 */
	@FieldDescription("投资促进部审批ID")
	private Long departmentApprovalId;
	/**
	 * 分管主任审批ID
	 */
	@FieldDescription("分管主任审批ID")
	private Long chiefApprovalId;
	/**
	 * 主任办公室审批ID
	 */
	@FieldDescription("主任办公室审批ID")
	private Long officeApprovalId;
	/**
	 * 项目概况
	 */
	@FieldDescription("项目概况")
	private String projectMemo;
	/**
	 * 入驻场所外键
	 */
	@FieldDescription("入驻场所外键")
	private String incubateConfigId;
	/**
	 * 行业分类外键
	 */
	@FieldDescription("行业分类外键")
	private String technicId;
	/**
	 * 创业者归属外键
	 */
	@FieldDescription("创业者归属外键")
	private String enterpriseTypeId;
	
	private Set<InvestmentProcessAtt> atts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 货币类型实体
	 */
	public DataDict getCurrency(){
		return currency;
	}
	public void setCurrency(DataDict currency){
		this.currency = currency;
	}
	/**
	 * 投资促进部审批
	 */
	public Approval getDepartmentApproval(){
		return departmentApproval;
	}
	public void setDepartmentApproval(Approval departmentApproval){
		this.departmentApproval = departmentApproval;
	}
	/**
	 * 分管主任审批
	 */
	public Approval getChiefApproval(){
		return chiefApproval;
	}
	public void setChiefApproval(Approval chiefApproval){
		this.chiefApproval = chiefApproval;
	}
	/**
	 * 主任办公室审批
	 */
	public Approval getOfficeApproval(){
		return officeApproval;
	}
	public void setOfficeApproval(Approval officeApproval){
		this.officeApproval = officeApproval;
	}
	/**
	 * 入驻场所
	 */
	public DataDict getIncubateConfig(){
		return incubateConfig;
	}
	public void setIncubateConfig(DataDict incubateConfig){
		this.incubateConfig = incubateConfig;
	}
	/**
	 * 行业分类
	 */
	public DataDict getTechnic(){
		return technic;
	}
	public void setTechnic(DataDict technic){
		this.technic = technic;
	}
	/**
	 * 企业帐号
	 */
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
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
	 * 详细信息
	 */
	public InvestmentRegInfo getRegInfo(){
		return regInfo;
	}
	public void setRegInfo(InvestmentRegInfo regInfo){
		this.regInfo = regInfo;
	}
	/**
	 * 商业计划书
	 */
	public BusinessPlan getBusinessPlan(){
		return businessPlan;
	}
	public void setBusinessPlan(BusinessPlan businessPlan){
		this.businessPlan = businessPlan;
	}
	/**
	 * 拟注册企业名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 企业人数
	 */
	public Integer getStaff(){
		return staff;
	}
	public void setStaff(Integer staff){
		this.staff = staff;
	}
	/**
	 * 编号
	 */
	public String getCode(){
		return code;
	}
	public void setCode(String code){
		this.code = code;
	}
	/**
	 * 注册资本
	 */
	public Double getRegCapital(){
		return regCapital;
	}
	public void setRegCapital(Double regCapital){
		this.regCapital = regCapital;
	}
	/**
	 * 货币类型外键
	 */
	public String getCurrencyId(){
		return currencyId;
	}
	public void setCurrencyId(String currencyId){
		this.currencyId = currencyId;
	}
	/**
	 * 跟踪ID
	 */
	public Long getHostId(){
		return hostId;
	}
	public void setHostId(Long hostId){
		this.hostId = hostId;
	}
	/**
	 * 跟踪
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
	 * 计划总投资
	 */
	public Double getInvestCapital(){
		return investCapital;
	}
	public void setInvestCapital(Double investCapital){
		this.investCapital = investCapital;
	}
	/**
	 * 预计年产值
	 */
	public Double getOutputValue(){
		return outputValue;
	}
	public void setOutputValue(Double outputValue){
		this.outputValue = outputValue;
	}
	/**
	 * 是否申请用房
	 */
	public BooleanEnum getNeedOffice(){
		return needOffice;
	}
	public void setNeedOffice(BooleanEnum needOffice){
		this.needOffice = needOffice;
	}
	/**
	 * 申请用房面积
	 */
	public Double getOfficeArea(){
		return officeArea;
	}
	public void setOfficeArea(Double officeArea){
		this.officeArea = officeArea;
	}
	/**
	 * 经营范围
	 */
	public String getBusinessScope(){
		return businessScope;
	}
	public void setBusinessScope(String businessScope){
		this.businessScope = businessScope;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	/**
	 * 实际办公地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 招商状态
	 */
	public InvestmentStatusEnum getInvestmentStatus(){
		return investmentStatus;
	}
	public void setInvestmentStatus(InvestmentStatusEnum investmentStatus){
		this.investmentStatus = investmentStatus;
	}
	/**
	 * 重要性
	 */
	public PriorityEnum getPriority(){
		return priority;
	}
	public void setPriority(PriorityEnum priority){
		this.priority = priority;
	}
	/**
	 * 业务员意见
	 */
	public String getBusinessmanSuggestion(){
		return businessmanSuggestion;
	}
	public void setBusinessmanSuggestion(String businessmanSuggestion){
		this.businessmanSuggestion = businessmanSuggestion;
	}
	/**
	 * 投资促进部审批ID
	 */
	public Long getDepartmentApprovalId(){
		return departmentApprovalId;
	}
	public void setDepartmentApprovalId(Long departmentApprovalId){
		this.departmentApprovalId = departmentApprovalId;
	}
	/**
	 * 分管主任审批ID
	 */
	public Long getChiefApprovalId(){
		return chiefApprovalId;
	}
	public void setChiefApprovalId(Long chiefApprovalId){
		this.chiefApprovalId = chiefApprovalId;
	}
	/**
	 * 主任办公室审批ID
	 */
	public Long getOfficeApprovalId(){
		return officeApprovalId;
	}
	public void setOfficeApprovalId(Long officeApprovalId){
		this.officeApprovalId = officeApprovalId;
	}
	/**
	 * 项目概况
	 */
	public String getProjectMemo(){
		return projectMemo;
	}
	public void setProjectMemo(String projectMemo){
		this.projectMemo = projectMemo;
	}
	/**
	 * 入驻场所外键
	 */
	public String getIncubateConfigId(){
		return incubateConfigId;
	}
	public void setIncubateConfigId(String incubateConfigId){
		this.incubateConfigId = incubateConfigId;
	}
	/**
	 * 行业分类外键
	 */
	public String getTechnicId(){
		return technicId;
	}
	public void setTechnicId(String technicId){
		this.technicId = technicId;
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
	public Approval getManagerApproval() {
		return managerApproval;
	}
	public void setManagerApproval(Approval managerApproval) {
		this.managerApproval = managerApproval;
	}
	public Long getManagerApprovalId() {
		return managerApprovalId;
	}
	public void setManagerApprovalId(Long managerApprovalId) {
		this.managerApprovalId = managerApprovalId;
	}
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	public Set<InvestmentProcessAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<InvestmentProcessAtt> atts){
		this.atts = atts;
	}
}