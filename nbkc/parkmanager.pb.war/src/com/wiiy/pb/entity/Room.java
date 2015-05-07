package com.wiiy.pb.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;
import com.wiiy.pb.preferences.enums.BillingMethodEnum;
import com.wiiy.pb.preferences.enums.RoomStatusEnum;

/**
 * <br/>class-description 房间
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Room extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	
	public Room() {
		super();
	}
	public Room(Long id,Long customerId) {
		super();
		this.id = id;
		this.customerId = customerId;
	}
	public Room(Long buildingId,BigDecimal buildingArea,DataDict kind, String kindId, RoomStatusEnum status) {
		super();
		this.buildingId = buildingId;
		this.kind = kind;
		this.kindId = kindId;
		this.status = status;
		this.buildingArea = buildingArea;
	}
	private Long id;
	/**
	 * 楼宇实体
	 */
	@FieldDescription("楼宇实体")
	private Building building;
	/**
	 * 楼层实体
	 */
	@FieldDescription("楼层实体")
	private Floor floor;
	/**
	 * 房间性质实体
	 */
	@FieldDescription("房间性质实体")
	private DataDict kind;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 房间用途实体
	 */
	@FieldDescription("房间用途实体")
	private DataDict type;
	/**
	 * 楼宇外键
	 */
	@FieldDescription("楼宇外键")
	private Long buildingId;
	/**
	 * 楼层外键
	 */
	@FieldDescription("楼层外键")
	private Long floorId;
	/**
	 * 房间名称
	 */
	@FieldDescription("房间名称")
	private String name;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customerName;
	/**
	 * 房间性质外键
	 */
	@FieldDescription("房间性质外键")
	private String kindId;
	/**
	 * 房间用途外键
	 */
	@FieldDescription("房间用途外键")
	private String typeId;
	/**
	 * 房间建筑面积
	 */
	@FieldDescription("房间建筑面积")
	private BigDecimal buildingArea;
	/**
	 * 房间实际面积
	 */
	@FieldDescription("房间实际面积")
	private BigDecimal realArea;
	/**
	 * 房间位置
	 */
	@FieldDescription("房间位置")
	private String location;
	/**
	 * 房间状态
	 */
	@FieldDescription("房间状态")
	private RoomStatusEnum status;
	/**
	 * 租金区间起
	 */
	@FieldDescription("租金区间起")
	private BigDecimal rentStart;
	/**
	 * 租金区间止
	 */
	@FieldDescription("租金区间止")
	private BigDecimal rentEnd;
	/**
	 * 优惠率
	 */
	@FieldDescription("优惠说明")
	private String discountRate;
	/**
	 * 优惠起始时间
	 */
	@FieldDescription("优惠起始时间")
	private Date discountBeginTime;
	/**
	 * 合同到期
	 */
	@FieldDescription("合同到期")
	private Date endDate;
	/**
	 * 房间到期
	 */
	@FieldDescription("房间到期")
	private Date roomEndDate;
	/**
	 * 水电押金
	 */
	@FieldDescription("水电押金")
	private BigDecimal electricityDeposit;
	/**
	 * 租赁价格
	 */
	@FieldDescription("租赁价格")
	private BigDecimal rentPrice;
	/**
	 * 租赁押金
	 */
	@FieldDescription("租赁押金")
	private BigDecimal rentDeposit;
	/**
	 * 房间介绍
	 */
	@FieldDescription("房间介绍")
	private String summary;
	/**
	 * 房间照片
	 */
	@FieldDescription("房间照片")
	private String photos;
	/**
	 * 计费方式
	 */
	@FieldDescription("计费方式")
	private BillingMethodEnum chargingType;
	/**
	 * 显示顺序
	 */
	@FieldDescription("显示顺序")
	private Integer displayOrder;
	/**
	 * 预订房间的公司名称
	 */
	@FieldDescription("预订房间的公司名称")
	private String reserveCompanyName;
	
	/**
	 * 预订房间的公司名称
	 */
	public String getReserveCompanyName() {
		return reserveCompanyName;
	}
	public void setReserveCompanyName(String reserveCompanyName) {
		this.reserveCompanyName = reserveCompanyName;
	}
	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 楼宇实体
	 */
	public Building getBuilding(){
		return building;
	}
	public void setBuilding(Building building){
		this.building = building;
	}
	/**
	 * 楼层实体
	 */
	public Floor getFloor(){
		return floor;
	}
	public void setFloor(Floor floor){
		this.floor = floor;
	}
	/**
	 * 房间性质实体
	 */
	public DataDict getKind(){
		return kind;
	}
	public void setKind(DataDict kind){
		this.kind = kind;
	}
	/**
	 * 房间用途实体
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 楼宇外键
	 */
	public Long getBuildingId(){
		return buildingId;
	}
	public void setBuildingId(Long buildingId){
		this.buildingId = buildingId;
	}
	/**
	 * 楼层外键
	 */
	public Long getFloorId(){
		return floorId;
	}
	public void setFloorId(Long floorId){
		this.floorId = floorId;
	}
	/**
	 * 房间名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 企业名称
	 */
	public String getCustomerName(){
		return customerName;
	}
	public void setCustomerName(String customerName){
		this.customerName = customerName;
	}
	/**
	 * 房间性质外键
	 */
	public String getKindId(){
		return kindId;
	}
	public void setKindId(String kindId){
		this.kindId = kindId;
	}
	/**
	 * 房间用途外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 房间建筑面积
	 */
	public BigDecimal getBuildingArea(){
		return buildingArea;
	}
	public void setBuildingArea(BigDecimal buildingArea){
		this.buildingArea = buildingArea;
	}
	/**
	 * 房间实际面积
	 */
	public BigDecimal getRealArea(){
		return realArea;
	}
	public void setRealArea(BigDecimal realArea){
		this.realArea = realArea;
	}
	/**
	 * 房间位置
	 */
	public String getLocation(){
		return location;
	}
	public void setLocation(String location){
		this.location = location;
	}
	/**
	 * 房间状态
	 */
	public RoomStatusEnum getStatus(){
		return status;
	}
	public void setStatus(RoomStatusEnum status){
		this.status = status;
	}
	/**
	 * 租金区间起
	 */
	public BigDecimal getRentStart(){
		return rentStart;
	}
	public void setRentStart(BigDecimal rentStart){
		this.rentStart = rentStart;
	}
	/**
	 * 租金区间止
	 */
	public BigDecimal getRentEnd(){
		return rentEnd;
	}
	public void setRentEnd(BigDecimal rentEnd){
		this.rentEnd = rentEnd;
	}
	/**
	 * 优惠说明
	 */
	public String getDiscountRate(){
		return discountRate;
	}
	public void setDiscountRate(String discountRate){
		this.discountRate = discountRate;
	}
	/**
	 * 优惠起始时间
	 */
	public Date getDiscountBeginTime(){
		return discountBeginTime;
	}
	public void setDiscountBeginTime(Date discountBeginTime){
		this.discountBeginTime = discountBeginTime;
	}
	/**
	 * 合同到期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 房间到期
	 */
	public Date getRoomEndDate() {
		return roomEndDate;
	}
	public void setRoomEndDate(Date roomEndDate) {
		this.roomEndDate = roomEndDate;
	}
	/**
	 * 水电押金
	 */
	public BigDecimal getElectricityDeposit(){
		return electricityDeposit;
	}
	public void setElectricityDeposit(BigDecimal electricityDeposit){
		this.electricityDeposit = electricityDeposit;
	}
	/**
	 * 租赁价格
	 */
	public BigDecimal getRentPrice(){
		return rentPrice;
	}
	public void setRentPrice(BigDecimal rentPrice){
		this.rentPrice = rentPrice;
	}
	/**
	 * 租赁押金
	 */
	public BigDecimal getRentDeposit(){
		return rentDeposit;
	}
	public void setRentDeposit(BigDecimal rentDeposit){
		this.rentDeposit = rentDeposit;
	}
	/**
	 * 房间介绍
	 */
	public String getSummary(){
		return summary;
	}
	public void setSummary(String summary){
		this.summary = summary;
	}
	/**
	 * 房间照片
	 */
	public String getPhotos(){
		return photos;
	}
	public void setPhotos(String photos){
		this.photos = photos;
	}
	/**
	 * 计费方式
	 */
	public BillingMethodEnum getChargingType(){
		return chargingType;
	}
	public void setChargingType(BillingMethodEnum chargingType){
		this.chargingType = chargingType;
	}
	/**
	 * 显示顺序
	 */
	public Integer getDisplayOrder(){
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder){
		this.displayOrder = displayOrder;
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
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
}