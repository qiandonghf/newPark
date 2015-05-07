package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.DeviceManagement;

/**
 * <br/>class-description 设备维护
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DeviceMaintenance extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 设备
	 */
	@FieldDescription("设备")
	private DeviceManagement deviceManagement;
	/**
	 * 设备外键
	 */
	@FieldDescription("设备外键")
	private Long deviceId;
	/**
	 * 保养档案编号
	 */
	@FieldDescription("保养档案编号")
	private String number;
	/**
	 * 上次保养时间
	 */
	@FieldDescription("上次保养时间")
	private Date lastTime;
	/**
	 * 计划保养时间
	 */
	@FieldDescription("计划保养时间")
	private Date planTime;
	/**
	 * 检查项目
	 */
	@FieldDescription("检查项目")
	private String plan;
	/**
	 * 维护工时
	 */
	@FieldDescription("维护工时")
	private String manHour;
	/**
	 * 维护方式
	 */
	@FieldDescription("维护方式")
	private String maintenanceMode;
	/**
	 * 维护日期
	 */
	@FieldDescription("维护日期")
	private Date maintenanceTime;
	/**
	 * 维护人
	 */
	@FieldDescription("维护人")
	private String maintenanceMan;
	/**
	 * 维护效果
	 */
	@FieldDescription("维护效果")
	private String maintenanceEffect;
	/**
	 * 维护过程
	 */
	@FieldDescription("维护过程")
	private String process;
	/**
	 * 维护内容
	 */
	@FieldDescription("维护内容")
	private String content;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 设备
	 */
	public DeviceManagement getDeviceManagement(){
		return deviceManagement;
	}
	public void setDeviceManagement(DeviceManagement deviceManagement){
		this.deviceManagement = deviceManagement;
	}
	/**
	 * 设备外键
	 */
	public Long getDeviceId(){
		return deviceId;
	}
	public void setDeviceId(Long deviceId){
		this.deviceId = deviceId;
	}
	/**
	 * 保养档案编号
	 */
	public String getNumber(){
		return number;
	}
	public void setNumber(String number){
		this.number = number;
	}
	/**
	 * 上次保养时间
	 */
	public Date getLastTime(){
		return lastTime;
	}
	public void setLastTime(Date lastTime){
		this.lastTime = lastTime;
	}
	/**
	 * 计划保养时间
	 */
	public Date getPlanTime(){
		return planTime;
	}
	public void setPlanTime(Date planTime){
		this.planTime = planTime;
	}
	/**
	 * 检查项目
	 */
	public String getPlan(){
		return plan;
	}
	public void setPlan(String plan){
		this.plan = plan;
	}
	/**
	 * 维护工时
	 */
	public String getManHour(){
		return manHour;
	}
	public void setManHour(String manHour){
		this.manHour = manHour;
	}
	/**
	 * 维护方式
	 */
	public String getMaintenanceMode(){
		return maintenanceMode;
	}
	public void setMaintenanceMode(String maintenanceMode){
		this.maintenanceMode = maintenanceMode;
	}
	/**
	 * 维护日期
	 */
	public Date getMaintenanceTime(){
		return maintenanceTime;
	}
	public void setMaintenanceTime(Date maintenanceTime){
		this.maintenanceTime = maintenanceTime;
	}
	/**
	 * 维护人
	 */
	public String getMaintenanceMan(){
		return maintenanceMan;
	}
	public void setMaintenanceMan(String maintenanceMan){
		this.maintenanceMan = maintenanceMan;
	}
	/**
	 * 维护效果
	 */
	public String getMaintenanceEffect(){
		return maintenanceEffect;
	}
	public void setMaintenanceEffect(String maintenanceEffect){
		this.maintenanceEffect = maintenanceEffect;
	}
	/**
	 * 维护过程
	 */
	public String getProcess(){
		return process;
	}
	public void setProcess(String process){
		this.process = process;
	}
	/**
	 * 维护内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
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
}