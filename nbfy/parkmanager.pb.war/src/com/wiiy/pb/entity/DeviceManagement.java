package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.preferences.enums.DeviceStatusEnum;
import com.wiiy.pb.preferences.enums.PatrolIntervalEnum;

/**
 * <br/>class-description 设备管理
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DeviceManagement extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 设备编号
	 */
	@FieldDescription("设备编号")
	private String number;
	/**
	 * 设备名称
	 */
	@FieldDescription("设备名称")
	private String name;
	/**
	 * 设备规格
	 */
	@FieldDescription("设备规格")
	private String specifications;
	/**
	 * 设备型号
	 */
	@FieldDescription("设备型号")
	private String type;
	/**
	 * 制造厂商
	 */
	@FieldDescription("制造厂商")
	private String manufacturer;
	/**
	 * 出厂编号
	 */
	@FieldDescription("出厂编号")
	private String serialNumber;
	/**
	 * 使用部门
	 */
	@FieldDescription("使用部门")
	private String department;
	/**
	 * 部门编号
	 */
	@FieldDescription("部门编号")
	private String departmentNumber;
	/**
	 * 使用地点
	 */
	@FieldDescription("使用地点")
	private String location;
	/**
	 * 制造日期
	 */
	@FieldDescription("制造日期")
	private Date manufacturingDate;
	/**
	 * 使用日期
	 */
	@FieldDescription("使用日期")
	private Date usedDate;
	/**
	 * 设备类别
	 */
	@FieldDescription("设备类别")
	private String category;
	/**
	 * 设备状态
	 */
	@FieldDescription("设备状态")
	private DeviceStatusEnum status;
	/**
	 * 设备级别
	 */
	@FieldDescription("设备级别")
	private String level;
	/**
	 * 复杂系数
	 */
	@FieldDescription("复杂系数")
	private Double degree;
	/**
	 * 设备原值
	 */
	@FieldDescription("设备原值")
	private Double cost;
	/**
	 * 折旧年限
	 */
	@FieldDescription("折旧年限")
	private Integer depreciationYear;
	/**
	 * 外形尺寸
	 */
	@FieldDescription("外形尺寸")
	private String size;
	/**
	 * 设备重量
	 */
	@FieldDescription("设备重量")
	private String weight;
	/**
	 * 数控设备
	 */
	@FieldDescription("数控设备")
	private BooleanEnum isCNC;
	/**
	 * 进口设备
	 */
	@FieldDescription("进口设备")
	private BooleanEnum isImported;
	/**
	 * 巡检间隔
	 */
	@FieldDescription("巡检间隔")
	private String patrolInterval;
	/**
	 * 巡检间隔类型
	 */
	@FieldDescription("巡检间隔类型")
	private PatrolIntervalEnum patrolIntervalType;
	/**
	 * 巡检日期
	 */
	@FieldDescription("巡检日期")
	private Date patrolTime;
	/**
	 * 上次巡检日期
	 */
	@FieldDescription("上次巡检日期")
	private Date lastPatrolTime;
	/**
	 * 年检间隔
	 */
	@FieldDescription("年检间隔")
	private String yearlyInterval;
	/**
	 * 年检日期
	 */
	@FieldDescription("年检日期")
	private Date yearlyTime;
	/**
	 * 上次年检日期
	 */
	@FieldDescription("上次年检日期")
	private Date lastYearlyTime;
	/**
	 * 巡检提醒日期
	 */
	@FieldDescription("巡检提醒日期")
	private Date reportPatrol;
	/**
	 * 年检提醒日期
	 */
	@FieldDescription("年检提醒日期")
	private Date reportYearly;
	/**
	 * 提醒类型
	 */
	@FieldDescription("提醒类型")
	private String reportType;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String remarks;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 设备编号
	 */
	public String getNumber(){
		return number;
	}
	public void setNumber(String number){
		this.number = number;
	}
	/**
	 * 设备名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 设备规格
	 */
	public String getSpecifications(){
		return specifications;
	}
	public void setSpecifications(String specifications){
		this.specifications = specifications;
	}
	/**
	 * 设备型号
	 */
	public String getType(){
		return type;
	}
	public void setType(String type){
		this.type = type;
	}
	/**
	 * 制造厂商
	 */
	public String getManufacturer(){
		return manufacturer;
	}
	public void setManufacturer(String manufacturer){
		this.manufacturer = manufacturer;
	}
	/**
	 * 出厂编号
	 */
	public String getSerialNumber(){
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber){
		this.serialNumber = serialNumber;
	}
	/**
	 * 使用部门
	 */
	public String getDepartment(){
		return department;
	}
	public void setDepartment(String department){
		this.department = department;
	}
	/**
	 * 部门编号
	 */
	public String getDepartmentNumber(){
		return departmentNumber;
	}
	public void setDepartmentNumber(String departmentNumber){
		this.departmentNumber = departmentNumber;
	}
	/**
	 * 使用地点
	 */
	public String getLocation(){
		return location;
	}
	public void setLocation(String location){
		this.location = location;
	}
	/**
	 * 制造日期
	 */
	public Date getManufacturingDate(){
		return manufacturingDate;
	}
	public void setManufacturingDate(Date manufacturingDate){
		this.manufacturingDate = manufacturingDate;
	}
	/**
	 * 使用日期
	 */
	public Date getUsedDate(){
		return usedDate;
	}
	public void setUsedDate(Date usedDate){
		this.usedDate = usedDate;
	}
	/**
	 * 设备类别
	 */
	public String getCategory(){
		return category;
	}
	public void setCategory(String category){
		this.category = category;
	}
	/**
	 * 设备状态
	 */
	public DeviceStatusEnum getStatus(){
		return status;
	}
	public void setStatus(DeviceStatusEnum status){
		this.status = status;
	}
	/**
	 * 设备级别
	 */
	public String getLevel(){
		return level;
	}
	public void setLevel(String level){
		this.level = level;
	}
	/**
	 * 复杂系数
	 */
	public Double getDegree(){
		return degree;
	}
	public void setDegree(Double degree){
		this.degree = degree;
	}
	/**
	 * 设备原值
	 */
	public Double getCost(){
		return cost;
	}
	public void setCost(Double cost){
		this.cost = cost;
	}
	/**
	 * 折旧年限
	 */
	public Integer getDepreciationYear(){
		return depreciationYear;
	}
	public void setDepreciationYear(Integer depreciationYear){
		this.depreciationYear = depreciationYear;
	}
	/**
	 * 外形尺寸
	 */
	public String getSize(){
		return size;
	}
	public void setSize(String size){
		this.size = size;
	}
	/**
	 * 设备重量
	 */
	public String getWeight(){
		return weight;
	}
	public void setWeight(String weight){
		this.weight = weight;
	}
	/**
	 * 数控设备
	 */
	public BooleanEnum getIsCNC(){
		return isCNC;
	}
	public void setIsCNC(BooleanEnum isCNC){
		this.isCNC = isCNC;
	}
	/**
	 * 进口设备
	 */
	public BooleanEnum getIsImported(){
		return isImported;
	}
	public void setIsImported(BooleanEnum isImported){
		this.isImported = isImported;
	}
	/**
	 * 巡检间隔
	 */
	public String getPatrolInterval(){
		return patrolInterval;
	}
	public void setPatrolInterval(String patrolInterval){
		this.patrolInterval = patrolInterval;
	}
	/**
	 * 巡检间隔类型
	 */
	public PatrolIntervalEnum getPatrolIntervalType(){
		return patrolIntervalType;
	}
	public void setPatrolIntervalType(PatrolIntervalEnum patrolIntervalType){
		this.patrolIntervalType = patrolIntervalType;
	}
	/**
	 * 巡检日期
	 */
	public Date getPatrolTime(){
		return patrolTime;
	}
	public void setPatrolTime(Date patrolTime){
		this.patrolTime = patrolTime;
	}
	/**
	 * 上次巡检日期
	 */
	public Date getLastPatrolTime(){
		return lastPatrolTime;
	}
	public void setLastPatrolTime(Date lastPatrolTime){
		this.lastPatrolTime = lastPatrolTime;
	}
	/**
	 * 年检间隔
	 */
	public String getYearlyInterval(){
		return yearlyInterval;
	}
	public void setYearlyInterval(String yearlyInterval){
		this.yearlyInterval = yearlyInterval;
	}
	/**
	 * 年检日期
	 */
	public Date getYearlyTime(){
		return yearlyTime;
	}
	public void setYearlyTime(Date yearlyTime){
		this.yearlyTime = yearlyTime;
	}
	/**
	 * 上次年检日期
	 */
	public Date getLastYearlyTime(){
		return lastYearlyTime;
	}
	public void setLastYearlyTime(Date lastYearlyTime){
		this.lastYearlyTime = lastYearlyTime;
	}
	/**
	 * 巡检提醒日期
	 */
	public Date getReportPatrol() {
		return reportPatrol;
	}
	public void setReportPatrol(Date reportPatrol) {
		this.reportPatrol = reportPatrol;
	}
	/**
	 * 年检提醒日期
	 */
	public Date getReportYearly() {
		return reportYearly;
	}
	public void setReportYearly(Date reportYearly) {
		this.reportYearly = reportYearly;
	}
	public String getReportType() {
		return reportType;
	}
	public void setReportType(String reportType) {
		this.reportType = reportType;
	}
	/**
	 * 备注
	 */
	public String getRemarks(){
		return remarks;
	}
	public void setRemarks(String remarks){
		this.remarks = remarks;
	}
}