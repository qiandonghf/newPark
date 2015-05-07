package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.DeviceManagement;

/**
 * <br/>class-description 维修派工单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DeviceWorkOrder extends BaseEntity implements Serializable {
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
	 * 维修部位
	 */
	@FieldDescription("维修部位")
	private String repairParts;
	/**
	 * 开始日期
	 */
	@FieldDescription("开始日期")
	private Date startDate;
	/**
	 * 结束日期
	 */
	@FieldDescription("结束日期")
	private Date endDate;
	/**
	 * 维修人员
	 */
	@FieldDescription("维修人员")
	private String repairStaff;
	/**
	 * 维修负责人
	 */
	@FieldDescription("维修负责人")
	private String head;
	/**
	 * 制单人
	 */
	@FieldDescription("制单人")
	private String tabulator;
	/**
	 * 维修内容
	 */
	@FieldDescription("维修内容")
	private String repairContent;
	/**
	 * 更换部件
	 */
	@FieldDescription("更换部件")
	private String repairComponents;
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
	 * 维修部位
	 */
	public String getRepairParts(){
		return repairParts;
	}
	public void setRepairParts(String repairParts){
		this.repairParts = repairParts;
	}
	/**
	 * 开始日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 结束日期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 维修人员
	 */
	public String getRepairStaff(){
		return repairStaff;
	}
	public void setRepairStaff(String repairStaff){
		this.repairStaff = repairStaff;
	}
	/**
	 * 维修负责人
	 */
	public String getHead(){
		return head;
	}
	public void setHead(String head){
		this.head = head;
	}
	/**
	 * 制单人
	 */
	public String getTabulator(){
		return tabulator;
	}
	public void setTabulator(String tabulator){
		this.tabulator = tabulator;
	}
	/**
	 * 维修内容
	 */
	public String getRepairContent(){
		return repairContent;
	}
	public void setRepairContent(String repairContent){
		this.repairContent = repairContent;
	}
	/**
	 * 更换部件
	 */
	public String getRepairComponents(){
		return repairComponents;
	}
	public void setRepairComponents(String repairComponents){
		this.repairComponents = repairComponents;
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