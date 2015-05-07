package com.wiiy.pb.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.core.entity.DataDict;
import com.wiiy.pb.entity.Park;

/**
 * <br/>class-description 楼宇
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Building extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	
	
	
	public Building() {
		super();
	}
	public Building(Long id,Long parkId, String name,String photos) {
		super();
		this.id = id;
		this.name = name;
		this.parkId = parkId;
		this.photos = photos;
	}
	private Long id;
	/**
	 * 园区实体
	 */
	@FieldDescription("园区实体")
	private Park park;
	/**
	 * 楼宇类型
	 */
	@FieldDescription("楼宇类型")
	private DataDict type;
	/**
	 * 楼宇性质实体
	 */
	@FieldDescription("楼宇性质实体")
	private DataDict kind;
	/**
	 * 招商方向实体
	 */
	@FieldDescription("招商方向实体")
	private DataDict investDirection;
	/**
	 * 空调设施实体
	 */
	@FieldDescription("空调设施实体")
	private DataDict airconSituation;
	/**
	 * 装修情况实体
	 */
	@FieldDescription("装修情况实体")
	private DataDict decorationSituation;
	/**
	 * 房间面积
	 */
	@FieldDescription("房间面积")
	private Double maxArea;
	/**
	 * 房间面积
	 */
	@FieldDescription("房间面积")
	private Double minArea;
	/**
	 * 楼宇名称
	 */
	@FieldDescription("楼宇名称")
	private String name;
	/**
	 * 园区外键
	 */
	@FieldDescription("园区外键")
	private Long parkId;
	/**
	 * 楼宇类型外键
	 */
	@FieldDescription("楼宇类型外键")
	private String typeId;
	/**
	 * 楼宇性质
	 */
	@FieldDescription("楼宇性质")
	private String kindId;
	/**
	 * 总建筑面积
	 */
	@FieldDescription("总建筑面积")
	private BigDecimal realArea;
	/**
	 * 商务面积
	 */
	@FieldDescription("商务面积")
	private BigDecimal commericalArea;
	/**
	 * 竣工日期
	 */
	@FieldDescription("竣工日期")
	private Date completeDate;
	/**
	 * 地址
	 */
	@FieldDescription("地址")
	private String address;
	/**
	 * 物业费区间起
	 */
	@FieldDescription("物业费区间起")
	private BigDecimal propertyBegin;
	/**
	 * 物业费区间止
	 */
	@FieldDescription("物业费区间止")
	private BigDecimal propertyEnd;
	/**
	 * 租金区间起
	 */
	@FieldDescription("租金区间起")
	private BigDecimal rentBegin;
	/**
	 * 租金区间止
	 */
	@FieldDescription("租金区间止")
	private BigDecimal rentEnd;
	/**
	 * 招商方向外键
	 */
	@FieldDescription("招商方向外键")
	private String investDirectionId;
	/**
	 * 地下停车位
	 */
	@FieldDescription("地下停车位")
	private Integer downParkingSpaces;
	/**
	 * 地下月停车费
	 */
	@FieldDescription("地下月停车费")
	private String downParkingFee;
	/**
	 * 地上停车位
	 */
	@FieldDescription("地上停车位")
	private Integer upParkingSpaces;
	/**
	 * 地上月停车费
	 */
	@FieldDescription("地上月停车费")
	private String upParkingFee;
	/**
	 * 小时停车费
	 */
	@FieldDescription("小时停车费")
	private String hourParkingFee;
	/**
	 * 客梯数
	 */
	@FieldDescription("客梯数")
	private String passengerElevator;
	/**
	 * 货梯数
	 */
	@FieldDescription("货梯数")
	private String cargoElevator;
	/**
	 * 空调设施外键
	 */
	@FieldDescription("空调设施外键")
	private String airconSituationId;
	/**
	 * 装修情况外键
	 */
	@FieldDescription("装修情况外键")
	private String decorationSituationId;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contact;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String tel;
	/**
	 * 招商热线
	 */
	@FieldDescription("招商热线")
	private String investTel;
	/**
	 * 楼宇介绍
	 */
	@FieldDescription("楼宇介绍")
	private String summary;
	/**
	 * 配套设施
	 */
	@FieldDescription("配套设施")
	private String supportSituation;
	/**
	 * 交通情况
	 */
	@FieldDescription("交通情况")
	private String trafficSituation;
	/**
	 * 楼宇照片
	 */
	@FieldDescription("楼宇照片")
	private String photos;
	/**
	 * 实体状态
	 */
	@FieldDescription("实体状态")
	private EntityStatus entityStatus;
	/**
	 * 创建时间
	 */
	@FieldDescription("创建时间")
	private Date createTime;
	/**
	 * 创建人姓名
	 */
	@FieldDescription("创建人姓名")
	private String creator;
	/**
	 * 创建人ID
	 */
	@FieldDescription("创建人ID")
	private Long creatorId;
	/**
	 * 修改时间
	 */
	@FieldDescription("修改时间")
	private Date modifyTime;
	/**
	 * 修改人姓名
	 */
	@FieldDescription("修改人姓名")
	private String modifier;
	/**
	 * 修改人ID
	 */
	@FieldDescription("修改人ID")
	private Long modifierId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 园区实体
	 */
	public Park getPark(){
		return park;
	}
	public void setPark(Park park){
		this.park = park;
	}
	/**
	 * 楼宇类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 楼宇性质实体
	 */
	public DataDict getKind(){
		return kind;
	}
	public void setKind(DataDict kind){
		this.kind = kind;
	}
	/**
	 * 招商方向实体
	 */
	public DataDict getInvestDirection(){
		return investDirection;
	}
	public void setInvestDirection(DataDict investDirection){
		this.investDirection = investDirection;
	}
	/**
	 * 空调设施实体
	 */
	public DataDict getAirconSituation(){
		return airconSituation;
	}
	public void setAirconSituation(DataDict airconSituation){
		this.airconSituation = airconSituation;
	}
	/**
	 * 装修情况实体
	 */
	public DataDict getDecorationSituation(){
		return decorationSituation;
	}
	public void setDecorationSituation(DataDict decorationSituation){
		this.decorationSituation = decorationSituation;
	}
	/**
	 * 房间面积
	 */
	public Double getMaxArea(){
		return maxArea;
	}
	public void setMaxArea(Double maxArea){
		this.maxArea = maxArea;
	}
	/**
	 * 房间面积
	 */
	public Double getMinArea(){
		return minArea;
	}
	public void setMinArea(Double minArea){
		this.minArea = minArea;
	}
	/**
	 * 楼宇名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 园区外键
	 */
	public Long getParkId(){
		return parkId;
	}
	public void setParkId(Long parkId){
		this.parkId = parkId;
	}
	/**
	 * 楼宇类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 楼宇性质
	 */
	public String getKindId(){
		return kindId;
	}
	public void setKindId(String kindId){
		this.kindId = kindId;
	}
	/**
	 * 总建筑面积
	 */
	public BigDecimal getRealArea(){
		return realArea;
	}
	public void setRealArea(BigDecimal realArea){
		this.realArea = realArea;
	}
	/**
	 * 商务面积
	 */
	public BigDecimal getCommericalArea(){
		return commericalArea;
	}
	public void setCommericalArea(BigDecimal commericalArea){
		this.commericalArea = commericalArea;
	}
	/**
	 * 竣工日期
	 */
	public Date getCompleteDate(){
		return completeDate;
	}
	public void setCompleteDate(Date completeDate){
		this.completeDate = completeDate;
	}
	/**
	 * 地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 物业费区间起
	 */
	public BigDecimal getPropertyBegin(){
		return propertyBegin;
	}
	public void setPropertyBegin(BigDecimal propertyBegin){
		this.propertyBegin = propertyBegin;
	}
	/**
	 * 物业费区间止
	 */
	public BigDecimal getPropertyEnd(){
		return propertyEnd;
	}
	public void setPropertyEnd(BigDecimal propertyEnd){
		this.propertyEnd = propertyEnd;
	}
	/**
	 * 租金区间起
	 */
	public BigDecimal getRentBegin(){
		return rentBegin;
	}
	public void setRentBegin(BigDecimal rentBegin){
		this.rentBegin = rentBegin;
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
	 * 招商方向外键
	 */
	public String getInvestDirectionId(){
		return investDirectionId;
	}
	public void setInvestDirectionId(String investDirectionId){
		this.investDirectionId = investDirectionId;
	}
	/**
	 * 地下停车位
	 */
	public Integer getDownParkingSpaces(){
		return downParkingSpaces;
	}
	public void setDownParkingSpaces(Integer downParkingSpaces){
		this.downParkingSpaces = downParkingSpaces;
	}
	/**
	 * 地下月停车费
	 */
	public String getDownParkingFee(){
		return downParkingFee;
	}
	public void setDownParkingFee(String downParkingFee){
		this.downParkingFee = downParkingFee;
	}
	/**
	 * 地上停车位
	 */
	public Integer getUpParkingSpaces(){
		return upParkingSpaces;
	}
	public void setUpParkingSpaces(Integer upParkingSpaces){
		this.upParkingSpaces = upParkingSpaces;
	}
	/**
	 * 地上月停车费
	 */
	public String getUpParkingFee(){
		return upParkingFee;
	}
	public void setUpParkingFee(String upParkingFee){
		this.upParkingFee = upParkingFee;
	}
	/**
	 * 小时停车费
	 */
	public String getHourParkingFee(){
		return hourParkingFee;
	}
	public void setHourParkingFee(String hourParkingFee){
		this.hourParkingFee = hourParkingFee;
	}
	/**
	 * 客梯数
	 */
	public String getPassengerElevator(){
		return passengerElevator;
	}
	public void setPassengerElevator(String passengerElevator){
		this.passengerElevator = passengerElevator;
	}
	/**
	 * 货梯数
	 */
	public String getCargoElevator(){
		return cargoElevator;
	}
	public void setCargoElevator(String cargoElevator){
		this.cargoElevator = cargoElevator;
	}
	/**
	 * 空调设施外键
	 */
	public String getAirconSituationId(){
		return airconSituationId;
	}
	public void setAirconSituationId(String airconSituationId){
		this.airconSituationId = airconSituationId;
	}
	/**
	 * 装修情况外键
	 */
	public String getDecorationSituationId(){
		return decorationSituationId;
	}
	public void setDecorationSituationId(String decorationSituationId){
		this.decorationSituationId = decorationSituationId;
	}
	/**
	 * 联系人
	 */
	public String getContact(){
		return contact;
	}
	public void setContact(String contact){
		this.contact = contact;
	}
	/**
	 * 联系电话
	 */
	public String getTel(){
		return tel;
	}
	public void setTel(String tel){
		this.tel = tel;
	}
	/**
	 * 招商热线
	 */
	public String getInvestTel(){
		return investTel;
	}
	public void setInvestTel(String investTel){
		this.investTel = investTel;
	}
	/**
	 * 楼宇介绍
	 */
	public String getSummary(){
		return summary;
	}
	public void setSummary(String summary){
		this.summary = summary;
	}
	/**
	 * 配套设施
	 */
	public String getSupportSituation(){
		return supportSituation;
	}
	public void setSupportSituation(String supportSituation){
		this.supportSituation = supportSituation;
	}
	/**
	 * 交通情况
	 */
	public String getTrafficSituation(){
		return trafficSituation;
	}
	public void setTrafficSituation(String trafficSituation){
		this.trafficSituation = trafficSituation;
	}
	/**
	 * 楼宇照片
	 */
	public String getPhotos(){
		return photos;
	}
	public void setPhotos(String photos){
		this.photos = photos;
	}
	/**
	 * 实体状态
	 */
	public EntityStatus getEntityStatus(){
		return entityStatus;
	}
	public void setEntityStatus(EntityStatus entityStatus){
		this.entityStatus = entityStatus;
	}
	/**
	 * 创建时间
	 */
	public Date getCreateTime(){
		return createTime;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	/**
	 * 创建人姓名
	 */
	public String getCreator(){
		return creator;
	}
	public void setCreator(String creator){
		this.creator = creator;
	}
	/**
	 * 创建人ID
	 */
	public Long getCreatorId(){
		return creatorId;
	}
	public void setCreatorId(Long creatorId){
		this.creatorId = creatorId;
	}
	/**
	 * 修改时间
	 */
	public Date getModifyTime(){
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime){
		this.modifyTime = modifyTime;
	}
	/**
	 * 修改人姓名
	 */
	public String getModifier(){
		return modifier;
	}
	public void setModifier(String modifier){
		this.modifier = modifier;
	}
	/**
	 * 修改人ID
	 */
	public Long getModifierId(){
		return modifierId;
	}
	public void setModifierId(Long modifierId){
		this.modifierId = modifierId;
	}
}